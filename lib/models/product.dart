class Product {
  String name;
  int price;
  int stock;

  Product(this.name, this.price, this.stock);

  bool hasStock() => stock > 0;
  bool hasEnoughStock(int quantity) => stock >= quantity;
}