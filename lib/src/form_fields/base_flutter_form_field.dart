// import 'package:flutter/material.dart';
// import 'package:foo_form_field/flutter_form_fields.dart';

// abstract class BaseFooFormField<T> extends FormField<T> {
  
//   final FooFieldController<T>? fooController;

//   const BaseFooFormField({
//     super.key,
//     this.fooController,
//     required super.builder,
//     super.onSaved,
//     super.forceErrorText,
//     super.validator,
//     super.errorBuilder,
//     super.initialValue,
//     super.enabled = true,
//     super.autovalidateMode,
//     super.restorationId,
//   });

//   @override
//   FormFieldState<T> createState() => BaseFooFormFieldState<T>();
// }

// class BaseFooFormFieldState<T> extends FormFieldState<T> {

//   @override
//   BaseFooFormField<T> get widget => super.widget as BaseFooFormField<T>;

//   @override
//   void initState() {
//     super.initState();
//     widget.fooController?.setFormFieldState(this);
//   }
// }