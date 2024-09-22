import 'package:clinic_patient/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:clinic_patient/models/patient_model.dart';

import 'patient_list_view.dart';

class EditPatientScreen extends StatefulWidget {
  final PatientModel person;
  final Function(PatientModel) onPersonEdited;

  const EditPatientScreen({super.key, required this.person, required this.onPersonEdited});

  @override
  _EditPatientScreenState createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _remarksController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.person.fullName);
    _addressController = TextEditingController(text: widget.person.address);
    _phoneNumberController = TextEditingController(text: widget.person.phoneNumber);
    _remarksController = TextEditingController(text: widget.person.remarks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _remarksController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  labelText: 'Remarks',
                  labelStyle: const TextStyle(
                    fontSize: 18.0, // Increase label font size
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0, // Adjust vertical padding
                    horizontal: 20.0, // Adjust horizontal padding
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  DatabaseHelper dbHelper = DatabaseHelper();
                  PatientModel editedPerson = PatientModel(
                      fullName: _fullNameController.text,
                      address: _addressController.text,
                      phoneNumber: _phoneNumberController.text,
                      remarks: _remarksController.text,
                      id: widget.person.id
                  );
                  await dbHelper.updatePatientInfo(editedPerson);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonListScreen(),
                    ),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _remarksController.dispose();
    super.dispose();
  }
}
