<p> University: [ITMO University](https://itmo.ru/ru/)
<p> Faculty: [FICT](https://fict.itmo.ru)
<p> Course: [Network programming](https://github.com/itmo-ict-faculty/network-programming) <p>
<p> Year: 2022/2023
<p> Group: K34212
<p> Author: Novozhilova Anna Vladimirovna
<p> Lab: Lab1
<p> Date of create: 16.10.2022
<p> Date of finished: 1.11.2022

<h4>Отчёт о выполнении лабораторной работы</h4>

1. В VirtualBox была создана вторая виртуальная машина на базе RouterOS 6. Важно, чтобы на виртуальных машинах были установлены операционные системы одного поколения, потому что команды на RouterOs 6 и RouterOS 7 значительно отличаются. Процесс создания виртуальной машины из образа диска аналогичен тому, что описан в первой лабораторной работе.  

2. После настройки пароля для пользователя admin есть возможность зайти на веб-интерфейс по динамически выделенному для роутера IP-адресу. Адрес был определен с помощью консольной команды ip address print.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/4.png?raw=true">

3. Прежде чем настраивать OpenVPN Client на новом маршрутизаторе необходимо сгенерировать для него сертификат и ключ к нему на удаленном сервере. Для этого были использованы команды sudo ./easyrsa gen-req (создание запроса на подпись сертификата в центре сертификации) и sudo ./easyrsa sign-req client (подпись сертификата для клиентской машины).  
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/6.png?raw=true">

4. Затем созданные ключ и сертификат были подгружены в раздел файлов на маршрутизаторе.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/7.png?raw=true">

5. Сертификат был проинициализирован в разделе System -> Certificates и подтвержден ключом. Об этом сигнализируют символы КТ в первой ячейке.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/8.png?raw=true">

6. В разделе РРР был создан новый OpenVPN клиент. Указан публичный IP-адрес удаленного сервера, используемый сертификат, алгоритмы аутентификации и шифрования.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/5.png?raw=true">
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/9.png?raw=true">

7. С помощью записей в разделе логов была проведена проверка подключения: соединение с сервером успешно установлено, ошибки не обнаружены.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/10.png?raw=true">

8. OpenVPN сервер при подключении  присвоил маршрутизатору еще один IP-адрес, через который устанавливается защищенное соединение между клиентом и сервером.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/11.png?raw=true">

9. С помощью команды ping были отправлены ICMP пакеты как с сервера на клиенты, так и с клиентов на сервер. Как видно из рисунокв ниже, IP-связность клиентов с сервером была установлена. Связь между клиентами будет настроена в последующих пунктах лабораторной работы.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/21.png?raw=true">
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/22.png?raw=true">

10. Все хосты, с которыми будет работать Ansible были указаны в файле /ansible/etc/hosts в корневой папке пользователя. Хосты были объединены в группу routers, для которой задавались общие переменные: тип подключения, логин и пароль пользователя, от имени которого будет работать Ansible, а также установленная на хостах операционная система. Также каждому из хостов было присвоено инвентарное имя (для упрощенного обращения к ним) и переменная rid, которая понадобится для настройки OSPF.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/12.png?raw=true">

11. Для проверки была выполнена команда, выводящая информацию о хостах, которые содержатся в инвентарном файле.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/13.png?raw=true">

12. Также, если подключение настроено правильно, Ansible сможет успешно выполнить команду ping на всех указанных хостах.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/14.png?raw=true">

13. Был создан плейбук - файл с указаниями для работы Ansible. В него было добавлено два плея для логически разделенных задач: настройка роутеров и получение с них информации. В каждом из плеев расположено несколько тасок, каждая из которых отвечает за конкретную задачу. Большая часть из них выполняется с помощью routeros_command - указания для непосредственного выполнения консольных команд на роутере. Так, с помощью routeros_command создавался новый пользователь, настраивались параметры для NTP клиента, производилась настройка OSPF маршрутизации в сети между двумя роутерами. Информация о конфигурации устройств была собрана с помощью команды routeros_facts, которая позволяет получить с роутеров практически любые данные. Так как результаты выполнения команд не сохраняются автоматически после выполнения таски, с помощью команды register они были занесены в переменные. Команда copy помещает заданный текст в указанный файл.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/17.png?raw=true">

14. Плейбук был запущен командой ansible-playbook и выполнен без сообщений об ошибке.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/15.png?raw=true">

15. В результате работы плейбука в корневой папке пользователя были созданы два файла, содержащих собранную с роутеров информацию о конфигурации устройств. Эти файлы доступны в текущем репозитории.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/16.png?raw=true">

16. На роутерах также были произведены изменения. Из рисунка ниже видно, что помимо стандартного пользователя был также создан пользователь anna.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/18.png?raw=true">

17. Был активирован NTP клиент, для которого указаны первичный и вторичный сервера для настройки точного времени. IP-адреса серверов были получены из DNS-имен 1.ru.pool.ntp.org и 2.ru.pool.ntp.org.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/19.png?raw=true">

18. Доказательством того, что OSPF маршрутизация была настроена правильно служит то, что роутеры видят друг друга в качестве соседей в одной сети, а также то, что между ними установлена связность адресов.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/25.png?raw=true">
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/26.png?raw=true">
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/24.png?raw=true">
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/23.png?raw=true">

19. Таким образом, итоговая схема сети между двумя роутерами и удаленным сервером в облаке выглядит следующим образом.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab2/img/27.png?raw=true">
