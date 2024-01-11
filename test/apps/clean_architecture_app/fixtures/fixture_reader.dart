import 'dart:io';

String fixture(String name) =>
    File('test/apps/clean_architecture_app/fixtures/$name').readAsStringSync();
