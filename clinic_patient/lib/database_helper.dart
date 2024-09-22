import 'package:clinic_patient/models/patient_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  // Use a nullable variable for the database
  Database? _database;

  // Method to initialize the database
  Future<Database> _initDatabase() async {
    var databaseFactory = databaseFactoryFfi;
    final db = await databaseFactory.openDatabase('my_database.db');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Patient (
          id INTEGER PRIMARY KEY,
          full_name TEXT,
          address TEXT,
          phone_number TEXT,
          remarks TEXT
      )
    ''');
    return db;
  }

  // Getter to access the database, initializing it if necessary
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  // Method to insert a patient record
  Future<void> insertPatientInfo(PatientModel model) async {
    try {
      final db = await database;
      int id = await db.insert('Patient', {
        'full_name': model.fullName,
        'address': model.address,
        'phone_number': model.phoneNumber,
        'remarks': model.remarks,
      });

      // Debugging
      print('Inserted patient with id: $id');

      // Fetching the inserted data to verify
      var result = await db.query('Patient');

      print('Current patients: $result');
      await closeDatabase();
    } catch (e) {
      print('Error inserting patient: $e');
    }
  }

  Future<void> updatePatientInfo(PatientModel model) async {
    try {
      final db = await database;
      int count = await db.update(
        'Patient',
        {
          'full_name': model.fullName,
          'address': model.address,
          'phone_number': model.phoneNumber,
          'remarks': model.remarks,
        },
        where: 'id = ?',
        whereArgs: [model.id],
      );

      print('Updated $count patient(s)');

      await closeDatabase();
    } catch (e) {
      print('Error updating patient: $e');
    }
  }

  Future<List<PatientModel>> fetchPatients() async {
    final db = await database;
    var result = await db.query('Patient');

    // Map the query result to a list of PatientModel instances
    List<PatientModel> patients = result.map((patientMap) {
      return PatientModel(
        id: patientMap['id'] as int,
        fullName: patientMap['full_name'] as String,
        address: patientMap['address'] as String,
        phoneNumber: patientMap['phone_number'] as String,
        remarks: patientMap['remarks'] as String?,
      );
    }).toList();

    return patients;
  }

  // Close the database when done (if needed)
  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
