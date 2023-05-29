Создание dmg MacOS:
    1. security find-identity -p codesigning
    2. codesign --deep --force --verbose --sign "<identity>" ant_time_flutter.app
    3. codesign --verify -vvvv ant_time_flutter.app
    4. flutter build macos --release
    5. cd installers/dmg_creator 
    6. appdmg config.json AntTime.dmg

Создания Snap Linux:
    1. sudo snapcraft --use-lxd
    2. snapcraft upload --release=stable ant-time-flutter_0.1.0_amd64.snap

    Установка локального пакета:
        sudo snap install ant-time-flutter_0.1.0_amd64.snap --dangerous
    Установка пакета из snapcraft:
        sudo snap install ant-time-flutter

Создание exe Windows:
    1. https://jrsoftware.org/isdl.php#stable
    2. Create a new script
    3. App Name - Ant Time; Publisher - LTD WebAnt
    4. Указать путь к исполняемому файлу ant_time_flutter/build/