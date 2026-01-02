@echo off
cd /d "%~dp0"

echo Starting local server...
:: Opens your default browser to the localhost URL automatically
start http://localhost:1313

:: Starts Hugo. The window must stay open for the site to work.
:: Press Ctrl+C in this window to stop the server when done.
hugo server