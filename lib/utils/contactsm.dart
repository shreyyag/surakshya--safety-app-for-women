class TContact {
  int? _id;
  String? _number;
  String? _name;

  TContact(this._number, this._name);
  TContact.withId(this._id, this._number, this._name);

  //getters
  // id, name & number are private hence to access it outside the class we will get them
  int get id => _id!;
  String get number => _number!;
  String get name => _name!;

  @override
  //converting the attributed into string
  String toString() {
    return 'Contact:{id: $_id, name: $_name, number: $_number}';
  }

  //setter
  set number(String newNumber) => this._number = newNumber;
  set name(String newName) => this.name = newName;

  //to convert a contact object to a map object to send the data to the db
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = this._id;
    map['number'] = this._number;
    map['name'] = this._name;

    return map;
  }

  //To extract a contact object from a mab object
  TContact.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._number = map['number'];
    this._name = map['name'];
  }
}
