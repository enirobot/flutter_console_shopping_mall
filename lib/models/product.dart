/// `Product` 클래스는 제품의 이름, 가격, 재고를 나타냅니다.
/// 
/// 속성:
/// - `name`: 제품의 이름을 나타내는 문자열.
/// - `price`: 제품의 가격을 나타내는 정수.
/// - `stock`: 제품의 재고를 나타내는 정수.
/// 
/// 생성자:
/// - `Product(String name, int price, int stock)`: 제품의 이름, 가격, 재고를 초기화합니다.
/// 
/// 메서드:
/// - `bool hasStock()`: 재고가 있는지 여부를 반환합니다.
/// - `bool hasEnoughStock(int quantity)`: 주어진 수량만큼의 재고가 있는지 여부를 반환합니다.
class Product {
  String name;
  int price;
  int stock;

  Product(this.name, this.price, this.stock);

  bool hasStock() => stock > 0;
  bool hasEnoughStock(int quantity) => stock >= quantity;
}