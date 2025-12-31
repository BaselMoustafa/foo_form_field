
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:foo_form_field/foo_form_field.dart';

// import '../widgets/controller_test_buttons.dart';
// import '../widgets/example_screen.dart';

// class IntOnlyStringFormFieldExampleScreen extends StatefulWidget {
//   const IntOnlyStringFormFieldExampleScreen({super.key});

//   @override
//   State<IntOnlyStringFormFieldExampleScreen> createState() => _IntOnlyStringFormFieldExampleScreenState();
// }

// class _IntOnlyStringFormFieldExampleScreenState extends State<IntOnlyStringFormFieldExampleScreen> {
//   final _controller = StringFieldController(
//     initialValue: "83489283",
//     enabled: false,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return ExampleScreen(
//       title: "Int Only String Form Field",
//       fieldBuilder: () => StringFormField.integer(
//         controller: _controller,
//         formatter: IntegerTextInputFormatter(
//           maxLength: 10,
//           allowNegative: true
//         ),
//         properties: TextFormFieldProperties(
//           onSaved: (value) => log("Saved: $value"),
//           onChanged: (value) => log("Changed: $value"),
//           validator: (value) {
//             if (value == null) {
//               return 'This field is required';
//             }
//             return null;
//           },
//         ),
//       ),
//       children: [
//         ControllerTestButtons(  
//           title: "Int Only String Controller Test Buttons",
//           controller: _controller,
//           firstDummyValue: "2321",
//           secondDummyValue: "948978",
//           valueToString: (value) => value,
//         ),
//       ],
//     );
//   }
// }