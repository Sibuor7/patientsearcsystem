import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DatabaseConfig {
  static const String host = '127.0.0.1'; // Replace with your database host
  static const String username = 'root'; // Replace with your database username
  static const String password = 'Martosibuor12!..'; // Replace with your database password
}

class PatientSearchScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController patientNumberController = TextEditingController();
  final GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  List<Patient> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Patient Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a patient name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: patientNumberController,
                decoration: InputDecoration(labelText: 'Patient Number'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a patient number';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey?.currentState?.validate() ?? false) {
                    final name = nameController.text;
                    final patientNumber = patientNumberController.text;

                    // Construct the API endpoint with query parameters
                    final apiUrl = Uri.parse('http://${DatabaseConfig.host}/your_actual_api_endpoint?name=$name&patientNumber=$patientNumber');

                    final response = await http.get(apiUrl);

                    if (response.statusCode == 200) {
                      // Parse and process the response
                      final List<Patient> results = []; // Parse your results here
                      // Populate results from response data

                      // Update the searchResults list with the retrieved data
                      searchResults = results;
                    } else {
                      // Handle errors
                    }
                  }
                },
                child: Text('Search'),
              ),
              if (searchResults.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(searchResults[index].fullName),
                        subtitle: Text(searchResults[index].patientNumber),
                        // You can add more patient details here
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Patient {
  final String fullName;
  final String patientNumber;

  Patient(this.fullName, this.patientNumber);
}
