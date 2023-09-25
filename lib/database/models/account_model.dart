class Account{
  int? id;
  String? name;
  double? initBalance = 0.0;
  String? type;
  DateTime? createdAt = DateTime.now();
  DateTime? updatedAt = DateTime.now();
  String? description;

  Account({
    this.id,
    this.name,
    this.initBalance,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.description
  });

  Account.map(Map<String, dynamic> map){
    id = map['id'];
    name = map['name'];
    initBalance = map['init_balance'];
    type = map['type'];
    createdAt = map['created_at'];
    updatedAt = map['updated_at'];
    description = map['description'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'init_balance': initBalance,
      'type': type,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'description': description
    };
  }
}
