class MedicineItem {
 late int id;
 late String name;
 late String generic;
 late String price;
 late String description;


 MedicineItem(int id, String name, String generic, String price,
     String description) {
  this.id = id;
  this.name = name;
  this.generic = generic;
  this.price = price;
  this.description = description;
 }
}