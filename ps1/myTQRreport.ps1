#
#rough report of errors for TQR
#Set-ExecutionPolicy Unrestricted
#Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass


$cnt = (sls .\afrODSAPPSdev\afrLoanCenterTaskQueueReader.log -pattern "ERROR|FATAL" -CaseSensitive).count
$msg = "$cnt fatals and errors"

 Write-Output $msg
 write-Output $($cnt) "<br/><br/>fatals and errors <br/><br/>"
 
(sls .\afrODSAPPSdev\afrLoanCenterTaskQueueReader.log -pattern "ERROR|FATAL" -CaseSensitive) | % {"$($_.linenumber):$($_.line)"}
