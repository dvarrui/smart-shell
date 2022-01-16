@echo off

echo Enables PowerShell scripts execution:
rem Info: https://codelucidate.wordpress.com/powershell/change-execution-policy-in-the-registry/
reg add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v ExecutionPolicy /t REG_SZ /d "Unrestricted" /f > nul 
