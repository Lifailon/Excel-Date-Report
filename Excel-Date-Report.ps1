$xls = "$home\desktop\Access-List.xlsx"
$excel = New-Object -ComObject Excel.Application
$excel.DisplayAlerts = 0
$ExcelBook = $excel.Workbooks.Open($xls)
#$ExcelBook.Sheets| fl Name,index
$ExcelList = $ExcelBook.Sheets.Item("Access")

$excel_mass = @()
foreach ($Range in 0..200) {
$Link_Column = "C"+"$Range"
$Date_Column = "E"+"$Range"
$C = ($ExcelList.Range("$Link_Column").Text)
$E = ($ExcelList.Range("$Date_Column").Text)
$excel_mass += [PSCustomObject]@{Link = $C; Date = $E}
}

$excel_mass_out = @()
foreach ($int in 0..200) {
if ($excel_mass[$int].Date -match "\d{1,2}\.\d{1,2}\.\d\d\d\d") {
$excel_mass_out += $excel_mass[$int]
}}

$emailSenderAddr = "scripts@domain.ru"
$emailTo = "login@domain.ru"
$emailSmtpServer = 'domain.ru'
$emailPassword = ConvertTo-SecureString -String "password" -AsPlainText -Force
$emailCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $emailSenderAddr, $emailPassword

[int32]$trigger_day_75 = 75
[int32]$trigger_day_15 = 15
$date = Get-Date -f "dd/MM/yyyy"
[DateTime]$gDate = Get-Date "$date"
foreach ($dates in $excel_mass_out) {
$mass_date = [string]$dates.Date
$mass_link = [string]$dates.Link
[DateTime]$fDate = Get-Date "$mass_date"
[int32]$days=($fDate-$gDate).Days
if ($days -match "-") {
$day = $days -replace "-"
$text_out = "Задача: $mass_link 
Срок доступа закончился: $mass_date ($day дней назад)
"
#Write-Host "$text_out"
Send-MailMessage -From $emailSenderAddr -To $emailTo -Subject "Access" -Body $text_out –SmtpServer $emailSmtpServer -Encoding 'UTF8' -Credential $emailCred
} elseif (($days -eq $trigger_day_75) -or ($days -eq $trigger_day_15)) {
$text_out = "Задача: $mass_link 
Срок доступа истекает: $mass_date (через $days дней)
"
#Write-Host "$text_out"
Send-MailMessage -From $emailSenderAddr -To $emailTo -Subject "Access" -Body $text_out –SmtpServer $emailSmtpServer -Encoding 'UTF8' -Credential $emailCred
}}

$ExcelBook.Close(0)
$excel.Application.Quit()
$excel.Quit()