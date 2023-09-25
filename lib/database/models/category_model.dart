class Category {
  int? id;
  String? name;
  String? icon;
  double? budget;
  int? parentId;

  Category(this.name, this.icon, this.budget, this.parentId);

  Category.map(Map<String, dynamic> map){
    id = map['id'];
    name = map['name'];
    icon = map['icon'];
    budget = map['budget'];
    parentId = map['parent_id'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'budget': budget,
      'parent_id': parentId
    };
  }
}