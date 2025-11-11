import 'package:example/bool_form_field_example.dart';
import 'package:example/date_form_field_example.dart';
import 'package:example/int_value_form_field_example.dart';
import 'package:example/int_range_form_field_example.dart';
import 'package:flutter/material.dart';
import 'int_text_form_field_example.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example Screen'),
      ),
      body: Column(

        children: [
          _GoToExampleScreenButton(
            title: 'Date Form Field', 
            screen: DateFormFieldExample()
          ),
          _GoToExampleScreenButton(
            title: 'Bool Form Field', 
            screen: BoolFormFieldExample()
          ),
          _GoToExampleScreenButton(
            title: 'Int Range Form Field', 
            screen: IntRangeValueFormFieldExample()
          ),
          _GoToExampleScreenButton(
            title: 'Int Value Form Field', 
            screen: IntValueFormFieldExample()
          ),
          _GoToExampleScreenButton(
            title: 'Int Text Form Field', 
            screen: IntTextFormFieldExample()
          ),
        ],
      ),
    );
  }
}

class _GoToExampleScreenButton extends StatelessWidget {
  const _GoToExampleScreenButton({
    required this.title,
    required this.screen,
  });

  final String title;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Text(title),
    );
  }
}