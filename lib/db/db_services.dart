import 'package:sqflite/sqflite.dart';

import '../utils/contactsm.dart';

class DbHelper {
  String contactTable = 'contact_table';
  String colId = 'id';
  String colContactName = 'name';
  String colContactNumber = 'number';

  //private constructor -> used to create an instance of a singleton class
  DbHelper._createInstance();

  //instance of the database:
  static DbHelper? _databaseHelper;
  factory DbHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DbHelper._createInstance();
    }
    return _databaseHelper!;
  }
  //initializing the database
  static Database? _database;
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String directoryPath = await getDatabasesPath();
    String dbLocation = directoryPath + 'contact.db';
    var contactDatabase =
        await openDatabase(dbLocation, version: 1, onCreate: _createDbTable);
    return contactDatabase;
  }

  void _createDbTable(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $contactTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colContactName TEXT, $colContactNumber TEXT)');
  }

  // Fetch operation: get contact object from db
  Future<List<Map<String, dynamic>>> getContactMapList() async {
    Database db = await this.database;
    List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM $contactTable order by $colId ASC');

    return result;
  }

  //Insert a contact object
  Future<int> insertContact(TContact contact) async {
    Database db = await this.database;
    var result = await db.insert(contactTable, contact.toMap());

    return result;
  }

  //Update a contact object
  Future<int> updateContact(TContact contact) async {
    Database db = await this.database;
    var result = await db.update(contactTable, contact.toMap(),
        where: '$colId = ?', whereArgs: [contact.id]);
    return result;
  }

  //Delete a contact object
  Future<int> deleteContact(int id) async {
    Database db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $contactTable WHERE $colId = $id');
    //print(await db.query(contactTable));
    return result;
  }

  //Get number of contact object
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $contactTable');
    int result = Sqflite.firstIntValue(x)!;
    return result;
  }

  // Get the 'Map List' [List<Map>] and convert it to 'Contact List' [List<Contact]
  Future<List<TContact>> getContactList() async {
    var contactMapList =
        await getContactMapList(); // Get 'Map List' from the database
    int count = contactMapList
        .length; //count the number of ma-p entries in the db table

    List<TContact> contactList = <TContact>[];
    // For Loop to create a 'Contact List' from  a 'Map List'
    for (int i = 0; i < count; i++) {
      contactList.add(TContact.fromMapObject(contactMapList[i]));
    }
    return contactList;
  }
}
