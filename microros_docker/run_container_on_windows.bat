@echo off
setlocal EnableDelayedExpansion

:: Задаем имя образа по умолчанию
set "IMAGE_NAME=%~1"

:: Определяем IPv4-адрес хоста
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /i "IPv4"') do (
    set "IP=%%i"
    goto :found_ip
)
:found_ip
set "IP=!IP:~1!"
echo IP-address: !IP!

:: Указываем путь к локальной папке ros2_ws в текущей директории
set "LOCAL_PATH=%CD%\ros2_ws"

:: Проверяем, существует ли папка, и создаем её, если нет
if not exist "%LOCAL_PATH%" (
    echo Папка %LOCAL_PATH% не существует. Создаю...
    mkdir "%LOCAL_PATH%"
    if errorlevel 1 (
        echo Ошибка при создании папки. Проверьте права доступа.
        pause
        exit /b 1
    )
    echo Папка создана.
)

:: Запускаем контейнер с указанным именем образа
echo Starting Docker container with image: %IMAGE_NAME%
docker run -it --rm -e DISPLAY=host.docker.internal:0 -v "%LOCAL_PATH%:/ros2_ws" -p 8888:8888/udp %IMAGE_NAME%

pause