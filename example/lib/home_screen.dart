import 'form_field_examples/bool_form_field_example_screen.dart';
import 'form_field_examples/date_form_field_example_screen.dart';
import 'form_field_examples/date_range_form_field_example_screen.dart';
import 'form_field_examples/int_only_string_form_field_example_screen.dart';
import 'form_field_examples/int_string_range_form_field_example_screen.dart';
import 'form_field_examples/int_string_form_field_example_screen.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Fields Examples'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              "Range Form Fields",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _GoToExampleScreenButton(
              title: 'Date Range Form Field', 
              screen: DateRangeFormFieldExampleScreen()
            ),
            _GoToExampleScreenButton(
              title: 'Int Range Form Field', 
              screen: IntStringRangeFormFieldExampleScreen()
            ),
            SizedBox(height: 20),
            Text(
              "Value Form Fields",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _GoToExampleScreenButton(
              title: 'Date Form Field', 
              screen: DateFormFieldExampleScreen()
            ),
            _GoToExampleScreenButton(
              title: 'Bool Form Field', 
              screen: BoolFormFieldExampleScreen()
            ),
            _GoToExampleScreenButton(
              title: 'Int String Form Field', 
              screen: IntStringFormFieldExampleScreen()
            ),
            _GoToExampleScreenButton(
              title: 'String Form Field (Integer Only)', 
              screen: IntOnlyStringFormFieldExampleScreen()
            ),
          ],
        ),
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