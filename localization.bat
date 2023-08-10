@echo off

set ROOT=%cd%
set SHARED_STRINGS_PATH=%ROOT%\lib\shared\strings
set AUTHENTICATION_STRINGS_PATH=%ROOT%\lib\modules\authentication\shared\strings
set CARDS_STRINGS_PATH=%ROOT%\lib\modules\cards\shared\strings
set COMMON_STRINGS_PATH=%ROOT%\lib\modules\common\shared\strings
set EXPENSES_STRINGS_PATH=%ROOT%\lib\modules\expenses\shared\strings
set MOBILITY_STRINGS_PATH=%ROOT%\lib\modules\mobility\shared\strings

cd %SHARED_STRINGS_PATH% && flutter gen-l10n
cd %AUTHENTICATION_STRINGS_PATH% && flutter gen-l10n
cd %CARDS_STRINGS_PATH% && flutter gen-l10n
cd %COMMON_STRINGS_PATH% && flutter gen-l10n
cd %EXPENSES_STRINGS_PATH% && flutter gen-l10n
cd %MOBILITY_STRINGS_PATH% && flutter gen-l10n
cd %ROOT%