import 'package:flutter/material.dart';
import 'package:clinic_patient/models/patient_model.dart';
import 'edit_patient_screen.dart';

class PersonInfoScreen extends StatefulWidget {
  final PatientModel person;
  final Function(PatientModel) onPersonEdited;

  const PersonInfoScreen({super.key, required this.person, required this.onPersonEdited});

  @override
  _PersonInfoScreenState createState() => _PersonInfoScreenState();
}

class _PersonInfoScreenState extends State<PersonInfoScreen> {
  late PatientModel person;

  @override
  void initState() {
    super.initState();
    person = widget.person;
  }

  void _editPerson(PatientModel editedPerson) {
    setState(() {
      person = editedPerson;
    });
    widget.onPersonEdited(editedPerson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person.fullName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPatientScreen(
                    person: person,
                    onPersonEdited: _editPerson,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${person.fullName}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Address: ${person.address}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Phone Number: ${person.phoneNumber}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Remarks: \n${person.remarks}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
