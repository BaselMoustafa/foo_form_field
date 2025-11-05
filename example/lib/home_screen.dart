import 'package:example/int_value_form_field_example.dart';
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