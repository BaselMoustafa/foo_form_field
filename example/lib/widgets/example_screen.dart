import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/section.dart';
import '../models/text_button_input.dart';
import 'section_widget.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key, required this.title, required this.fieldBuilder, required this.children});

  final String title;
  final List<Widget> children;
  final Widget Function() fieldBuilder;

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.fieldBuilder(),
              SectionWidget(
                section: Section(
                  title: "Form Actions",
                  buttonsInputs: [
                    TextButtonInput(
                      title: "Save", 
                      onPressed:(){
                        log("Saving Form ....");
                        _formKey.currentState?.save();
                      } 
                    ),
                    TextButtonInput(
                      title: "Validate", 
                      onPressed:(){
                        log("Validating Form ....");
                        _formKey.currentState?.validate();
                      } 
                    ),
                  ],
                ),
              ),
              ...widget.children,
            ],
          ),
        ),
      ),
    );
  }
}