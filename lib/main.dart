import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/injections.dart';
import 'app/up_todo_app.dart';
void main() async {

 WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  await setupGetIt();

  runApp( UpTodoApp());
}
