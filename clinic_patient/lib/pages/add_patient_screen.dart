import 'package:clinic_patient/database_helper.dart';
import 'package:clinic_patient/models/patient_model.dart';
import 'package:flutter/material.dart';

import 'patient_list_view.dart';

class AddPatientScreen extends StatefulWidget {
  final Function(PatientModel) onPatientAdded;

  const AddPatientScreen({super.key, required this.onPatientAdded});

  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _remarksController = TextEditingController();

  DatabaseHelper? dbHelper;

  @override
  void initState() {
    dbHelper = DatabaseHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the full name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the phone number';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter remarks';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final newPatient = PatientModel(
                      fullName: _fullNameController.text,
                      address: _addressController.text,
                      phoneNumber: _phoneNumberController.text,
                      remarks: _remarksController.text,
                      id: 0,
                    );
                    // widget.onPatientAdded(newPatient);
                    await dbHelper?.insertPatientInfo(newPatient);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PersonListScreen(),
                      ),
                    );
                  }
                },
                child: const Text('Add Patient'),
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
