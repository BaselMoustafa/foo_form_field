import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class DateRangeValueFormFieldExample extends StatefulWidget {
  const DateRangeValueFormFieldExample({super.key});

  @override
  State<DateRangeValueFormFieldExample> createState() => _DateRangeValueFormFieldExampleState();
}

class _DateRangeValueFormFieldExampleState extends State<DateRangeValueFormFieldExample> {
  final  _controller = DateRangeFieldController(
    initialValue: DateRange(min: DateTime(2024, 1, 1), max: DateTime(2024, 1, 10)),
    enabled: false,
  );
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              DateRangeFormField(
                
                controller: _controller,
                rangeValidator: RangeValidator(
                  firstIsBiggerThanSecond: (x, y) {
                    return x.year > y.year || x.month > y.month || x.day > y.day;
                  },
                  allowEqual: true,
                  minBiggerThanMaxMessage: "Min Date is bigger than max date",
                  equalMinAndMaxMessage: "Min Date is equal to max date",

                ),
                validator: (value) {
                  if (value == null || value.min == null || value.max == null) {
                    return 'This field is required This f  ';
                  }
                  return null;
                },
                onSaved: (value) {
                  log("onSaved: $value");
                },
                onChanged: (value) {
                  log("onChanged: $value");
                },
              ),
              TextButton(
                onPressed: () {
                  _controller.clear();
                }, 
                child: Text('Clear')
              ),
          
              TextButton(
                onPressed: () {
                  _controller.validate();
                },
                child: Text('Validate')
              ),
          
              TextButton(
                onPressed: () {
                  _controller.value = DateRange(min: DateTime(2024, 1, 1), max: DateTime(2024, 1, 10));
                },
                child: Text('Mark As 2024-1-1 2024-1-10')
              ),
          
              TextButton(
                onPressed: () {
                  _controller.value = DateRange(min: DateTime(2024, 1, 1), max: DateTime(2024, 1, 10));
                },
                child: Text('Mark As 2024-1-1 2024-1-10')
              ),
          
              TextButton(
                onPressed: () {
                  _controller.enabled = false;
                },
                child: Text('Disable')
              ),
          
              TextButton(
                onPressed: () {
                  _controller.enabled = true;
                },
                child: Text('Enable')
              ),
          
              TextButton(
                onPressed: () {
                  _formKey.currentState?.save();
                },
                child: Text('Svae From Form')
              ),

              TextButton(
                onPressed: () {
                  _formKey.currentState?.validate();
                },
                child: Text('Validate Form')
              )
          
            ],
          ),
        ),
      ),
    );

    
  }
}
