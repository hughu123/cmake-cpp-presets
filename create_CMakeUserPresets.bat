@echo off


:: MIT License
:: Copyright (c) [2025] [John Hugo Humble]
:: LICENSE file for full license text.

:: Description: Creates a CMakeUserPresets.json for (hopefully) an smooth and easy setup.

set /p preset_name=Enter the name of the preset (e.g., hugo-dev):

set /p inherits=Enter the name of the specific preset you what your CMakeUserPresets to inherit (e.g., tncg15-libs):

set /p vcpkg_root=Enter the path to the VCPKG_ROOT (e.g., C:/vcpkg.) BEAWARE: NEEDS FULLPATH + FORWARD SLASHES:


:: Create or overwrite the CMakeUserPresets.txt file with the desired content
(
echo {
echo   "version": 2,
echo   "configurePresets": [
echo     {
echo       "name": "%preset_name%",
echo       "inherits": "%inherits%",
echo       "environment": {
echo         "VCPKG_ROOT": "%vcpkg_root%"
echo       }
echo     }
echo   ]
echo }
) > CMakeUserPresets.json

echo CMakeUserPresets.json has been created with the preset "%preset_name%" and VCPKG_ROOT at "%vcpkg_root%".

:: Read the content of CMakeUserPresets.json, replace double backslashes with forward slashes, and write back to the file
for /f "delims=" %%i in ('type CMakeUserPresets.json') do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    set "line=!line:\=/!"
    echo !line!>> temp.json
    endlocal
)
move /y temp.json CMakeUserPresets.json > nul
echo All double backslashes in CMakeUserPresets.json have been replaced with forward slashes.
endlocal
