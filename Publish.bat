@echo off
:: Keeps the window open so you can see errors
cd /d "%~dp0"

echo Scanning git history for last dispatch number...

:: 1. Find the last commit message that contains "Added dispatch"
set "LAST_NUM=0"
for /f "delims=" %%i in ('git log --grep^="Added dispatch" -n 1 --pretty^=format:"%%s"') do set LAST_MSG=%%i

:: 2. Extract the number using PowerShell (handles text cleaning and math)
if not "%LAST_MSG%"=="" (
    for /f %%n in ('powershell -command "$n = '%LAST_MSG%' -replace '[^0-9]', ''; [int]$n"') do set LAST_NUM=%%n
)

:: 3. Add 1 to the number
set /a NEW_NUM=%LAST_NUM%+1

echo Last found: %LAST_MSG% (Number: %LAST_NUM%)
echo Publishing: Added dispatch %NEW_NUM%
echo ------------------------------------------

:: 4. Execute Git commands
git add .
git commit -m "Added dispatch %NEW_NUM%"
git push

echo ------------------------------------------
echo Success! Dispatch %NEW_NUM% is live.
pause