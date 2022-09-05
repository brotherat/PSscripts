$wc = New-Object System.Net.WebClient
$wc.DownloadFile('https://notepad-plus-plus.org/update/getDownloadUrl.php','d:\temp\trtr.xml')
$dlUrl = select-xml //Location d:\temp\trtr.xml | foreach-object { $_.Node.'innertext'}
invoke-webrequest $dlUrl -outfile d:\temp\nppinstall.exe
Start-Process D:\Temp\nppinstall.exe /S -NoNewWindow -Wait -PassThru
