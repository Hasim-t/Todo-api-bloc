// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddToDoPage extends StatefulWidget {
  final Map? todo;
  const AddToDoPage({super.key, this.todo});

  @override
  State<AddToDoPage> createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  TextEditingController tittlecontroller = TextEditingController();
  TextEditingController discreptioncontroller = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    final todo = widget.todo;
    // TODO: implement initState
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final descirption = todo['description'];
      tittlecontroller.text = title;
      discreptioncontroller.text = descirption;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'edit todo ' : 'add todo'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          TextField(
            controller: tittlecontroller,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: discreptioncontroller,
            decoration: InputDecoration(hintText: 'Discreption'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 10,
          ),
          SizedBox(
            height: 18,
          ),
          ElevatedButton(
            onPressed: isEdit ? updatedData : submitData,
            child: Text(isEdit ? 'update' : 'submit'),
          )
        ],
      ),
    );
  }

  Future<void> updatedData() async {
    final todo = widget.todo;
    if (widget.todo == null) {
      return;
    }
    final id = todo!['_id'];
   
    final title = tittlecontroller.text;
    final description = discreptioncontroller.text;

    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final responce = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (responce.statusCode == 200) {
      tittlecontroller.text = '';
      discreptioncontroller.text = '';
      showSuceesMessage('updated succes');
    }
  }

  void submitData() async {
    //get the data from form
    final title = tittlecontroller.text;
    final description = discreptioncontroller.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    //submit data to the server

    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      tittlecontroller.text = '';
      discreptioncontroller.text = '';
      showSuceesMessage('creation succes');
      print(response.body);
    } else {
      showSuceesMessage('creation field');
    }
    // show success of fail message based on status
  }

  void showSuceesMessage(String messege) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        messege,
        style: TextStyle(color: Colors.green),
      ),
    ));
  }
}
