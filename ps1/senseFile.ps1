# watch a file changes in the current directory, 
# execute all tests when a file is changed or renamed

#Set-StrictMode -Version 1.0

# like unix tail
#Get-Content -Path "C:\FxM\Downloads\mylogfile.txt" -Wait
#Get-Content "C:\FxM\Downloads\mylogfile.txt" -Tail 10
#Get-Content "C:\FxM\Downloads\mylogfile.txt" -Wait -Tail 10
#Get-Content "C:\FxM\Downloads\mylogfile.txt" -Wait -Tail 10 | find  "%message%"
#Get-Content "C:\FxM\Downloads\mylogfile.txt" -Wait -Tail 10 | Select-String -Pattern FATAL

param(
    [string[]]$dir,   
    [string[]]$fn
)

if (!(Test-Path $dir)) {
   write-host "Enter [Directory] [Filename] to watch."
   return
}
if ($fn.Length.Equals(0) ) {
   write-host "Enter [Directory] [Filename] to watch. Did you enter a filename?"
}


#write-host $dir
#write-host ----
#write-host $fn

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $dir ##'C:\FxM\Downloads\temp'
##$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $false
$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite -bor [System.IO.NotifyFilters]::FileName
$watcher.Filter = $fn ##"bob.txt";

$source = $($dir) + "\" + $($fn) ##'C:\FxM\Downloads\temp\bob.txt'
$source
write-host "Watching {file: "  $source "}"

$dt00 = [datetime](Get-ItemProperty -Path $source -Name LastWriteTime).lastwritetime 

while($TRUE){

    #
    $dt11 = [datetime](Get-ItemProperty -Path $source -Name LastWriteTime).lastwritetime 
   "filetime = " + $dt11
   #if ($dt00 -eq $d11)
   if([string]::Compare($dt00, $dt11, $True) -ne 0)
   {
        write-host "     ***** File chnaged while resting. Read it";
        "   last read: " + $dt00
        "   file time: " + $dt11
   }

   get-date -Format HH:mm:ss

    $result = $watcher.WaitForChanged([System.IO.WatcherChangeTypes]::Changed -bor [System.IO.WatcherChangeTypes]::Renamed -bOr [System.IO.WatcherChangeTypes]::Created, 1000);
    #$result = $watcher.WaitForChanged([System.IO.WatcherChangeTypes]::Changed -bor [System.IO.WatcherChangeTypes]::Renamed -bOr [System.IO.WatcherChangeTypes]::Created);
    
    
    if($result.TimedOut){
        write-host "."
        #get-date -Format HH:mm:ss
        get-date -Format mm:ss
        continue;
    }
    
    $a = Get-Date
"Date: " + $a.ToShortDateString()
"Time: " + $a.ToShortTimeString()

#get-date -Format yyyy/MM/dd hh:mm:ss
get-date -Format HH:mm:ss

    write-host "Change in "  $result.Name  $a.ToShortDateString() $a.ToShortTimeString()
    $dt00 = [datetime](Get-ItemProperty -Path $source -Name LastWriteTime).lastwritetime 
    $rest = 10
    write-host "sleeping for " + $rest +"secs"
Start-Sleep -s $rest
    $name = $result.Name
    ##$cloudSvcName,$vmname = Get-Content 'C:\ftpsites\centos\*.txt'
    $date = Get-Date -Format g
    #stop-azurevm -servicename $cloudSvcName -name $vmname -force
    #del C:\ftpsites\centos\*.txt
    #Out-File -FilePath c:\scripts\logs\filewatcher.txt -Append -InputObject "$date $name"
    write-host "lets continue."
}