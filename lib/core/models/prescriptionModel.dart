
class Product {
  String id;
  String name;
  String img;
  String catid;
  String ingredients;
  String description;
  String searchKey;

  Product({this.id,this.catid, this.name,this.img,this.ingredients, this.description,this.searchKey});

  Product.fromMap(Map snapshot,String id) :
        id = id ?? '',
        name = snapshot['name'] ?? '',
        img = snapshot['img'] ?? '',
        catid = snapshot['catid'] ?? '',
        description = snapshot['description'] ?? '',
        ingredients = snapshot['ingredients'] ?? '',
        searchKey = snapshot['searchKey'] ?? '';
  toJson() {
    return {

      "name": name,
      "img": img,
      "catid":catid,
      "ingredients":ingredients,
      "description":description,
      "searchKey":searchKey,
    };
  }
}