import 'package:flutter/services.dart';

abstract class FlutterTextInputFormatter extends TextInputFormatter {

  const FlutterTextInputFormatter();

  String? matches(String value);
}