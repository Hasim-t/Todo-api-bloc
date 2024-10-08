import 'dart:convert';

import 'package:http/http.dart' as http;

  class AddTodo {
  final String titile;
  final String description;

  AddTodo({required this.titile, required this.description});
  Future<int> submitData() async {
    final title = titile;
    final descriptions = description;

    final body = {
      "title": title,
      "desciption": descriptions,
      "is_completed": false,
    };

    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    return response.statusCode;
  }
}
// class AddTodo{



//   void submitData() async {
//     //get the data from form
//     final title = tittlecontroller.text;
//     final description = discreptioncontroller.text;
//  final body = {
//       "title": title,
//       "description": description,
//       "is_completed": false,
//     };
//     //submit data to the server

//     final url = 'https://api.nstack.in/v1/todos';
//     final uri = Uri.parse(url);
//     final response = await http.post(uri,
//         body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

//     if (response.statusCode == 201) {
//       tittlecontroller.text = '';
//       discreptioncontroller.text = '';
//       showSuceesMessage('creation succes');
//       print(response.body);
//     } else {
//       showSuceesMessage('creation field');
//     }
//     // show success of fail message based on status
//   }

// }