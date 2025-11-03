import 'package:flutter/material.dart';
import 'package:flutter_form_fields/src/core/controllers/flutter_field_controller.dart';

abstract class BaseFlutterFormField<T> extends StatefulWidget {
  final FlutterFieldController<T>? controller;

  const BaseFlutterFormField({
    super.key,
    this.controller,
  });

}