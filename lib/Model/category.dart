class CategoryDrop{
  static const String groupId = 'group' ;
  static const String personId = 'person';
  String? id ;
  String? name;
  String? image = '' ;
  CategoryDrop({ this.id ,  this.image,  this.name});
  CategoryDrop.fromId(this.id){
    if(id == groupId){
      name = 'Group' ;
      image = 'assets/images/group_chat.png' ;
    }
    else if(id == personId){
      name = 'Person' ;
      image = 'assets/images/person_chat.png' ;
    }
  }
  static List<CategoryDrop> getCategory(){
    return [
      CategoryDrop.fromId(groupId),
      CategoryDrop.fromId(personId),
    ];
  }
}