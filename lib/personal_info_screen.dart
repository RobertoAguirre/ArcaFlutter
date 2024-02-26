import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';



class PersonalInformationScreen extends StatefulWidget {
  @override
  _PersonalInformationScreenState createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Create controllers for text fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _rfcController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordSATController = TextEditingController();

  String? _cerFileName;
  String? _keyFileName;

    Future<void> _pickFile(String fileType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [fileType],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        fileType == 'cer' ? _cerFileName = result.files.single.name : _keyFileName = result.files.single.name;
      });
    }
  }

  Future<void> submitForm() async {
  // API endpoint
  var uri = Uri.parse('YOUR_API_ENDPOINT');

  // Create a multipart request
  var request = http.MultipartRequest('POST', uri);

  // Add text fields to the request
  request.fields['fullName'] = _fullNameController.text;
  request.fields['rfc'] = _rfcController.text;
  request.fields['passwordSAT'] = _passwordSATController.text;
  request.fields['address'] = _addressController.text;
  request.fields['postalCode'] = _postalCodeController.text;
  request.fields['phone'] = _phoneController.text;

  // Add files to the request
  if (_cerFileName != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'cerFile', // Field name for the file
        _cerFileName!, // Local file path
        contentType: MediaType('application', 'x-x509-ca-cert'), // Content type for .cer files
      ));
  }
  if (_keyFileName != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'keyFile', // Field name for the file
        _keyFileName!, // Local file path
        contentType: MediaType('application', 'octet-stream'), // Content type for .key files
      ));
  }
   // Send the request
  var response = await request.send();

  // Listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    print(value); // Handle the response from the server
  });
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Información personal'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(labelText: 'Nombre completo'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa tu nombre completo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _rfcController,
                  decoration: InputDecoration(labelText: 'RFC'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa tu RFC';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordSATController,
                  decoration: InputDecoration(labelText: 'Contraseña SAT'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa tu contraseña del SAT';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Domicilio'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa tu domicilio';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _postalCodeController,
                  decoration: InputDecoration(labelText: 'Código Postal'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa tu código postal';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Teléfono'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa tu telefono';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
             SizedBox(height: 20),
              Text('Registro Fiel', style: TextStyle(fontWeight: FontWeight.bold)),
              _buildFilePicker(title: '.cer', fileType: 'cer'),
              _buildFilePicker(title: '.key', fileType: 'key'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save information logic
                  }
                },
                child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilePicker({required String title, required String fileType}) {
    return ListTile(
      leading: Icon(Icons.insert_drive_file),
      title: Text(title),
      subtitle: Text(fileType == 'cer' ? _cerFileName ?? 'No file selected' : _keyFileName ?? 'No file selected'),
      trailing: IconButton(
        icon: Icon(Icons.upload_file),
        onPressed: () {
          _pickFile(fileType);
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _fullNameController.dispose();
    _rfcController.dispose();
    _addressController.dispose();
    _postalCodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
