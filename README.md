Скрипт для отправки уведомлений о завершении срока действия доступа к ресурсам, ПО или лицензий. Применимо, например, если ведется таблица Excel (в ручную, или заполняется автоматически по средствам скриптов) и необходимо оповещать инициатора (можно создать в таблице столбец с email-адресами ответственных лиц, и в цикле отправлять уведомление непосредственно им), что срок действия подходит к концу и/или уже просрочен, для применения соответствующих действий.

В данном примере скрипт собирает массив, считывая 200 строк из двух столбцов C и E, и пересобирает его только из тех строк, где в столбце E присутствует дата. Задается два тригерных значения, 76 и 7 дней. Получает текущую дату, она сопоставляется с указанной в таблице (формата: 15.12.2022) и высчитывается разница в днях, которая проверяется по двум условиям: 

**Если дата уже просрочена (сообщение будет приходить постоянно):**

![Image alt](https://github.com/Lifailon/Excel-Date-Report/blob/rsa/Screen/expired.jpg)

**Тригерными значениями (всего два раза, до события завершения срока действия):**

![Image alt](https://github.com/Lifailon/Excel-Date-Report/blob/rsa/Screen/expires.jpg)
