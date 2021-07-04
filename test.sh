#!/bin/bash      tells the terminal that you are using bash shell

flutter test
flutter test --coverage
flutter pub run remove_from_coverage -f coverage/lcov.info -r '\.g\.dart$'
flutter pub run remove_from_coverage -f coverage/lcov.info -r '\.freezed\.dart$'
genhtml coverage/lcov.info -o coverage/html  
open coverage/lcov.info