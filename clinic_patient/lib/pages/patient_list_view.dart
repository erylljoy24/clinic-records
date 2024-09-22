import 'package:clinic_patient/database_helper.dart';
import 'package:clinic_patient/models/patient_model.dart';
import 'package:clinic_patient/pages/person_info_screen.dart';
import 'package:flutter/material.dart';
import 'add_patient_screen.dart';

class PersonListScreen extends StatefulWidget {
  const PersonListScreen({super.key});

  @override
  _PersonListScreenState createState() => _PersonListScreenState();
}

class _PersonListScreenState extends State<PersonListScreen> {
  List<PatientModel> persons = [];
  List<PatientModel> _patients = [];

  String query = '';

  DatabaseHelper? dbHelper;

  void _addPatient(PatientModel newPatient) {
    setState(() {
      persons.add(newPatient);
    });
  }

  void _editPatient(int index, PatientModel editedPatient) {
    setState(() {
      persons[index] = editedPatient;
    });
  }

  @override
  void initState() {
    dbHelper = DatabaseHelper();
    _loadPatients();
    super.initState();
  }

  Future<void> _loadPatients() async {
    // Perform your async work here
    DatabaseHelper dbHelper = DatabaseHelper();
    List<PatientModel> patients = await dbHelper.fetchPatients();

    // Once data is loaded, update the state
    setState(() {
      _patients = patients;
      print('printPatientsHere ${_patients.length}');
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  query = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _patients.length,
              itemBuilder: (context, index) {

                final person = _patients[index];

                if (person.fullName.toLowerCase().contains(query) ||
                    person.address.toLowerCase().contains(query) ||
                    person.phoneNumber.toLowerCase().contains(query) ||
                    person.remarks!.toLowerCase().contains(query)) {
                  return ListTile(
                    title: Text(person.fullName),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonInfoScreen(
                            person: person,
                            onPersonEdited: (editedPerson) => _editPatient(index, editedPerson),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPatientScreen(onPatientAdded: _addPatient),
            ),
          );
        },
        tooltip: 'Add Patient',
        child: const Icon(Icons.add),
      ),
    );
  }
}
