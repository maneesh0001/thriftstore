import 'package:flutter/material.dart';
import 'package:thrift_store/app/app.dart';
import 'package:thrift_store/app/service_locator/service_locator.dart';
import 'package:thrift_store/core/network/hive_service.dart';
// import 'package:thrift_store/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  await HiveService.init();

  runApp(App());
}
