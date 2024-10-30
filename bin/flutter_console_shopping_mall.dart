import 'dart:io';

class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

class ShoppingMall {
  List<Product> products;
  List<String> cartItems = [];
  int total = 0;

  ShoppingMall(this.products);

  void showProducts() {
    for (var product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  void addToCart() {
    print('장바구니에 담을 상품의 이름을 입력해주세요:');
    String? productName = stdin.readLineSync();
    
    if (productName == null || !products.any((p) => p.name == productName)) {
      print('입력값이 올바르지 않아요!');
      return;
    }

    print('장바구니에 담을 상품의 개수를 입력해주세요:');
    String? countInput = stdin.readLineSync();
    
    try {
      int count = int.parse(countInput!);
      if (count <= 0) {
        print('0개보다 많은 개수의 상품만 담을 수 있어요!');
        return;
      }

      var product = products.firstWhere((p) => p.name == productName);
      total += product.price * count;
      cartItems.add(productName); // 장바구니에 상품 이름 추가
      print('장바구니에 상품이 담겼어요!');
    } catch (e) {
      print('입력값이 올바르지 않아요!');
    }
  }

  void showTotal() {
    if (total == 0) {
      print('장바구니에 담긴 상품이 없습니다.');
      return;
    }
    
    String itemsList = cartItems.join(', ');
    print('장바구니에 $itemsList가 담겨있네요. 총 ${total}원 입니다!');
  }

  void clearCart() {
    if (total == 0) {
      print('이미 장바구니가 비어있습니다.');
      return;
    }
    total = 0;
    cartItems.clear();
    print('장바구니를 초기화합니다.');
  }
}

void main() {
  var shoppingMall = ShoppingMall([
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ]);

  bool isRunning = true;

  while (isRunning) {
    print("\n----------------------------------------------------------------------------------------------------------------------------");
    print('[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료 / [6] 장바구니 초기화');
    print("----------------------------------------------------------------------------------------------------------------------------");
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        shoppingMall.showProducts();
        break;
      case '2':
        shoppingMall.addToCart();
        break;
      case '3':
        shoppingMall.showTotal();
        break;
      case '4':
        print('정말 종료하시겠습니까? (종료하려면 5를 입력해주세요)');
        String? confirmInput = stdin.readLineSync();
        if (confirmInput == '5') {
          print('이용해 주셔서 감사합니다 ~ 안녕히 가세요!');
          isRunning = false;
        } else {
          print('종료하지 않습니다.');
        }
        break;
      case '6':
        shoppingMall.clearCart();
        break;
      default:
        print('지원하지 않는 기능입니다! 다시 시도해 주세요..');
    }
  }
}