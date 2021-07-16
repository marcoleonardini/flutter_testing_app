# Flutter Testing App
Flutter Testing App Challenge

### Flutter version 

```bash
Flutter 2.2.3 • channel stable • https://github.com/flutter/flutter.git
Tools • Dart 2.12.0
```
- It's recomended to use the same version and channel
- Null safety enabled
------
### Todo List

------
### Folder Structure

    ├── lib                             # app files
      ├── main.dart                     # entry point
        ├── config                      # app configurations files 
          ├── constants                 # app constants files 
          ├── error                     # error, failures exceptions constants
          ├── routes                    # all the app routes, for navigation 
        ├── bloc                        # All the bussiness logic base on RxDart
        ├── presentation                # All the screens and shared widgets
            ├── screens                 # All the screens 
            ├── shared                  # All shared widgets
        ├── repositories                # Contracts and implementations
        ├── services                    # Remote, Local resources (typically http requests)
    ├── pubspec.yaml                    
    ├── README.md      
    ├── tests

------
### Installation

- Clone this repository and go into the folder cloned.
- Conect a device in order to run rhe app.
```bash
flutter pub get
flutter pub run build_runner build
flutter run
```
- Run in mode release
```bash
flutter run --release
```
- For iOS target, install pods
```
flutter pub get
cd ios
pod install
flutter run
```
------
### Run Tests
```
flutter test
```
### Run Test, Test Coverage and Open Coverage 
##### (MacOS)
```
bash test.sh
```
_required genhtml installed_
_this bash removes *.g.dart *.freezed.dart files_

------
### What was used in this app:
- RxDart
  - Using this in order to learn state managment with streams. (Learning purposes)
- Mocktail
  - Using this in order to learn MockTail. (Learning purposes)
- Freezed
  - Generator for models
------
### Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
