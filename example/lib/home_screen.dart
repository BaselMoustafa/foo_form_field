import 'form_field_examples/bool_form_field_example.dart';
import 'form_field_examples/date_form_field_example.dart';
import 'form_field_examples/date_range_form_field_example.dart';
import 'form_field_examples/int_range_text_form_field_example.dart';
import 'form_field_examples/int_text_form_field_example.dart';
import 'form_field_examples/num_range_text_form_field_example.dart';
import 'form_field_examples/num_text_form_field_example.dart';
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
              screen: DateRangeFormFieldExample()
            ),
            _GoToExampleScreenButton(
              title: 'Int Range Form Field', 
              screen: IntRangeTextFormFieldExampleScreen()
            ),
            _GoToExampleScreenButton(
              title: 'Num Range Form Field', 
              screen: NumRangeTextFormFieldExampleScreen()
            ),
            SizedBox(height: 20),
            Text(
              "Value Form Fields",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _GoToExampleScreenButton(
              title: 'Date Form Field', 
              screen: DateFormFieldExample()
            ),
            _GoToExampleScreenButton(
              title: 'Bool Form Field', 
              screen: BoolFormFieldExample()
            ),
            _GoToExampleScreenButton(
              title: 'Int String Form Field', 
              screen: IntTextFormFormFieldExample()
            ),
            _GoToExampleScreenButton(
              title: 'Num String Form Field', 
              screen: NumTextFormFormFieldExample()
            ),
            // _GoToExampleScreenButton(
            //   title: 'String Form Field (Integer Only)', 
            //   screen: IntOnlyStringFormFieldExampleScreen()
            // ),
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