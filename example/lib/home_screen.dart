import 'form_field_examples/bool_form_field_example.dart';
import 'form_field_examples/date_form_field_example.dart';
import 'form_field_examples/date_range_form_field_example.dart';
import 'form_field_examples/date_only_form_field_example.dart';
import 'form_field_examples/date_only_range_form_field_example.dart';
import 'form_field_examples/int_only_string_form_field_example_screen.dart';
import 'form_field_examples/int_range_text_form_field_example.dart';
import 'form_field_examples/int_text_form_field_example.dart';
import 'form_field_examples/num_range_text_form_field_example.dart';
import 'form_field_examples/num_text_form_field_example.dart';
import 'package:flutter/material.dart';

import 'form_field_examples/single_selection_form_field_example.dart';
import 'form_field_examples/get_once_single_selection_form_field_example.dart';
import 'form_field_examples/get_paginated_single_selection_form_field_example.dart';
import 'form_field_examples/multi_selection_form_field_example.dart';
import 'form_field_examples/get_once_multi_selection_form_field_example.dart';
import 'form_field_examples/get_paginated_multi_selection_form_field_example.dart';
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
              title: 'Date Only Range Form Field', 
              screen: DateOnlyRangeFormFieldExample()
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
              title: 'Date Only Form Field', 
              screen: DateOnlyFormFieldExample()
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
            _GoToExampleScreenButton(
              title: 'String Form Field (Integer Only)', 
              screen: IntOnlyStringFormFieldExample()
            ),
            _GoToExampleScreenButton(
              title: 'Single Selection Form Field', 
              screen: SingleSelectionFormFieldExample()
            ),
            _GoToExampleScreenButton(
              title: 'Get Once Single Selection Form Field', 
              screen: GetOnceSingleSelectionFormFieldExample()
            ),
            _GoToExampleScreenButton(
              title: 'Get Paginated Single Selection Form Field', 
              screen: GetPaginatedSingleSelectionFormFieldExample()
            ),
            _GoToExampleScreenButton(
              title: 'Multi Selection Form Field', 
              screen: MultiSelectionFormFieldExample()
            ),
            _GoToExampleScreenButton(
              title: 'Get Once Multi Selection Form Field', 
              screen: GetOnceMultiSelectionFormFieldExample()
            ),
            _GoToExampleScreenButton(
              title: 'Get Paginated Multi Selection Form Field', 
              screen: GetPaginatedMultiSelectionFormFieldExample()
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