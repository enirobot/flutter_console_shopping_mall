/// `CartItem` 클래스는 장바구니 항목의 이름, 수량, 가격을 나타냅니다.
/// 
/// 속성:
/// - `name`: 장바구니 항목의 이름을 나타내는 문자열.
/// - `quantity`: 장바구니 항목의 수량을 나타내는 정수.
/// - `price`: 장바구니 항목의 가격을 나타내는 정수.
/// 
/// 생성자:
/// - `CartItem(String name, int quantity, int price)`: 장바구니 항목의 이름, 수량, 가격을 초기화합니다.
/// 
/// 게터:
/// - `int get total`: 장바구니 항목의 총 가격을 반환합니다 (가격 * 수량).
class CartItem {
  String name;
  int quantity;
  int price;

  CartItem(this.name, this.quantity, this.price);

  int get total => price * quantity;
}