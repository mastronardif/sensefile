# copy aaaa from Azure

#Set-StrictMode -Version 1.0

# like unix tail
#Get-Content -Path "C:\FxM\Downloads\mylogfile.txt" -Wait
#Get-Content "C:\FxM\Downloads\mylogfile.txt" -Tail 10
#Get-Content "C:\FxM\Downloads\mylogfile.txt" -Wait -Tail 10
#Get-Content "C:\FxM\Downloads\mylogfile.txt" -Wait -Tail 10 | find  "%message%"
#Get-Content "C:\FxM\Downloads\mylogfile.txt" -Wait -Tail 10 | Select-String -Pattern FATAL

$AzCopy = "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe"

$sourceKey = "ViXtOpgj9MuZuzx5YkV/cIBv4aXZNKCiY6zX5KBLUpP/RqXDM41yJUrBueK8u3ULJeFKBldxLw2uw/2qC+5lmg=="
$source = "https://fxmystorage.blob.core.windows.net/persons"
$dest = "C:\fxm\downloads\myfolder"


#AzCopy /Source:https://myaccount.blob.core.windows.net/mycontainer /Dest:C:\myfolder /SourceKey:key /Pattern:"abc.txt"
& $AzCopy /Source:$source /Dest:C:\fxm\downloads\myfolder /SourceKey:$sourceKey /Pattern:"MathewBlobIBinder"
#powershell.exe -file itunersforward.ps1 15
$dir=$args[0]
$fn=$args[1]

#write-host $dir
