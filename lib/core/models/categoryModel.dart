
class Categorys {
  String id;
  String name;
  String img;

  Categorys({this.id,  this.name,this.img});

  Categorys.fromMap(Map snapshot,String id) :
        id = id ?? '',
        name = snapshot['name'] ?? '',
        img = snapshot['img'] ?? '';

  toJson() {
    return {
      "name": name,
      "img": img,
    };
  }
}