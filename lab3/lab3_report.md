<p> University: [ITMO University](https://itmo.ru/ru/)
<p> Faculty: [FICT](https://fict.itmo.ru)
<p> Course: [Network programming](https://github.com/itmo-ict-faculty/network-programming) <p>
<p> Year: 2022/2023
<p> Group: K34212
<p> Author: Novozhilova Anna Vladimirovna
<p> Lab: Lab1
<p> Date of create: 25.10.2022
<p> Date of finished: 2.12.2022

<h4>Отчёт о выполнении лабораторной работы</h4>

Цель работы: Изучить и настроить взаимодействие междy Ansible и Netbox

Перед началом работы необходимо было установить Netbox.

1. Был установлен PostgreSQL.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/2.png?raw=true">

2. В PostgreSQL была создана новая база данных netbox и пользователь с аналогичным именем, которому были выданы максимальные права на управление этой базой.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/4.png?raw=true">

3. Был установлен Redis.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/5.png?raw=true">

4. Затем были установлены все пакеты, необходимые для работы netbox.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/1.png?raw=true">

5. Создана директория, в которую установлен и распакован репозиторий с последней версией Netbox.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/6.png?raw=true">

6. Был создан специальный системный пользователь, которому предоставлены права на все папки с файлами netbox

7. Был скопирован пример файла конфигурации configuration.example.py в файл конфигурации configuration.py, который позже был использован для настройки проекта.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/8.png?raw=true">

8. С помощью входящего в состав netbox исполнительного файла gnerate_secret_key.py был сгенерирован случайный SECRET_KEY из не менее 50 буквенно-цифровых символов.

9. Секретный ключ, разрешенные хосты и информация о базе данных были внесены в конфигурационный файл.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/9.png?raw=true">

10. Создано виртуальное окружение python
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/10.png?raw=true">

11. Внутри вирутального окружения был создан superuser для дальнейшего управления netbox.

12. Для возможности запуска netbox в режиме демона были сконфигурированы nginx и gunicorn
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/13.png?raw=true">
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/17.png?raw=true">
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/18.png?raw=true">

13. Сервисы, относящиеся к netbox были запущены и добавлены в автозагрузку.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/14.png?raw=true">

14. После завершения установки графический интерфейс Netbox открывается на 80 порту, а API - на 8001.

15. С помощью графического интерфейса вирутальные маршрутизаторы из предыдущих лабораторных работ были внесены в раздел Virtual Machines, о них были добавлены все имеющиеся сведения.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/19.png?raw=true">

16. Был создан новый инвентарный файл, который динамически получает данные из API Netbox. Подключение производилось с помощью сгенерированного в Netbox идентификационного токена.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/20.png?raw=true">
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/21.png?raw=true">

17. Был написан playbook, заносящий все переменные из раздела host_vars (туда заносились все дополнительные сведения о виртуальных машинах, помимо основного адреса и названия машины) в отдельные файлы.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/22.png?raw=true">

18. Файл был выполнен корректно, вся инеющаяся информация была занесена в файлы в формате JSON.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/23.png?raw=true">

19. В netbox была внесена информация о новом интерфейсе test, а также изменены названия виртуальных машин. Так как инвентарный файл обновляется при каждом к нему обращении, информация об этом интерфейсе была отражена в списке переменных. Был написан playbook, который вносил изменения на роутеры на основе появившейся в инвентарном файле переменной.
 <image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/24.png?raw=true">

20. После успешного выполнения команды на маршрутизаторах появился новый интерфейс, соответствующий информации из netbox, имя системы было изменено.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/25.png?raw=true">
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/26.png?raw=true">

21. Далее необходимо было получить серийный номер устройства и внести эту информацию в Netbox. Так как для вирутальных устройств серийный номер не выделяется, в качестве новой информации были выбраны сведения об архитектуре системы. Был написан playbook, который с помощью модуля получает данные об архитектуре системы и сохраняет в переменную. Затем значение этой переменной передается в заранее созданное кастомное поле для вирутальных машин.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/27.png?raw=true">

22. После успешного выполнения playbook ранее пустое кастомное поле в Netbox заполнилось соответсвующим значением.
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/15.png?raw=true">
<image src="https://github.com/anny-nov/2022_2023-network_programming-k34212-novozhilova_a_v/blob/main/lab3/img/16.png?raw=true">

Выводы: Netbox - платформа, которую удобно использовать в качестве источника правды в сети и инвентаризации. Благодаря открытому коду, полной бесплатности и большому количеству модулей и программ, с которыми интегрируется сервис, Netbox является популярным инструментом.
