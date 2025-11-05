import 'package:flutter/material.dart';
import 'package:foo_form_field/src/core/controllers/foo_field_controller.dart';
import 'package:foo_form_field/src/core/widgets/field_with_error_text_widget.dart';
import 'package:foo_form_field/src/form_fields/base/foo_form_field.dart';

class BooleanFormField extends StatefulWidget {
  const BooleanFormField({
    super.key,
    this.controller,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.errorBuilder,
    this.forceErrorText,
    this.restorationId,
    this.onChanged,
    this.builder,
  });

  final FooFieldController<bool>? controller;
  final Widget Function(BuildContext context, bool enabled, bool? value , String? errorText)? builder;
  final void Function(bool? value)? onSaved;
  final String? Function(bool? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final FormFieldErrorBuilder? errorBuilder;
  final String? forceErrorText;
  final String? restorationId;
  final void Function(bool? value)? onChanged;

  @override
  State<BooleanFormField> createState() => _BooleanFormFieldState();
}

class _BooleanFormFieldState extends State<BooleanFormField> {

  late final FooFieldController<bool> _controller;
  bool _controllerLocallyInitialized = false;

  @override
  void initState() {
    super.initState();
    if(widget.controller != null){
      _controller = widget.controller!;
    } else {
      _controller = FooFieldController<bool>();
      _controllerLocallyInitialized = true;
    }
  }

  @override
  void dispose() {
    if (_controllerLocallyInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FooFormField<bool>(
      controller:_controller,
      onSaved: widget.onSaved,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      errorBuilder: widget.errorBuilder,
      forceErrorText: widget.forceErrorText,
      restorationId: widget.restorationId,
      onChanged: widget.onChanged,
      builder: widget.builder ?? (BuildContext context, bool enabled, bool? value, String? errorText){
        if(!enabled){
          return Container(
            width: 100,
            height: 20,
            color: Colors.grey,
            child: Text("Disabled Now"),
          );
        }
        return FieldWithErrorTextWidget(
          errorText: errorText,
          fieldWidget: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (_controller.value == true) {
                      _controller.value = null;
                    }else{
                      _controller.value = true;
                    }
                    widget.onChanged?.call(_controller.value);
                  },
                  child: Container(
                    width: 100,
                    height: 20,
                    color: value==null|| !_controller.value!? Colors.grey:Colors.green,
                    child: Text("Yes"),
                  ),
                ),
            
                GestureDetector(
                  onTap: () {
                    if (_controller.value == false) {
                      _controller.value = null;
                    }else{
                      _controller.value = false;
                    }
                    widget.onChanged?.call(_controller.value);
                  },
                  child: Container(
                    width: 100,
                    height: 20,
                    color: value==null|| _controller.value!? Colors.grey:Colors.green,
                    child: Text("No"),
                  ),
                ),
              ],
            ), 
          
        );
      },
    );
  }
}