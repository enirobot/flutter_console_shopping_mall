import 'dart:io';

class Product {
  String name;
  int price;
  int stock;

  Product(this.name, this.price, this.stock);
}

class CartItem {
  String name;
  int quantity;
  int price;

  CartItem(this.name, this.quantity, this.price);
}

class ShoppingMall {
  List<Product> products;
  List<CartItem> cart = [];

  ShoppingMall(this.products);

  void showProductsForCustomer() {
    print('\n===== 상품 목록 =====');
    for (var product in products) {
      if (product.stock > 0) {
        print('${product.name} / ${product.price}원 (재고: ${product.stock}개)');
      }
    }
    print("=====================");
  }

  void addToCart() {
    print('\n장바구니에 담을 상품의 이름을 입력해주세요:');
    String? productName = stdin.readLineSync();
    
    var product = products.firstWhere(
      (p) => p.name == productName,
      orElse: () => Product('', 0, 0)
    );

    if (product.name.isEmpty) {
      print('입력값이 올바르지 않아요!');
      return;
    }

    if (product.stock <= 0) {
      print('해당 상품의 재고가 없습니다!');
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
      if (count > product.stock) {
        print('재고가 부족합니다! (현재 재고: ${product.stock}개)');
        return;
      }

      var existingItem = cart.firstWhere(
        (item) => item.name == product.name,
        orElse: () => CartItem('', 0, 0)
      );

      if (existingItem.name.isNotEmpty) {
        existingItem.quantity += count;
      } else {
        cart.add(CartItem(product.name, count, product.price));
      }

      print('장바구니에 상품이 담겼어요!');
    } catch (e) {
      print('입력값이 올바르지 않아요!');
    }
  }

  void showCart() {
    if (cart.isEmpty) {
      print('장바구니에 담긴 상품이 없습니다.');
      return;
    }
    
    print('\n===== 장바구니 =====');
    int total = 0;
    for (var item in cart) {
      print('${item.name} ${item.quantity}개 - ${item.price * item.quantity}원');
      total += item.price * item.quantity;
    }
    print('총액: $total원');
    print("====================");
  }

  void clearCart() {
    if (cart.isEmpty) {
      print('이미 장바구니가 비어있습니다.');
      return;
    }

    cart.clear();
    print('장바구니를 초기화합니다.');
  }

  void checkout() {
    if (cart.isEmpty) {
      print('장바구니가 비어있습니다. 결제할 상품이 없습니다.');
      return;
    }

    print('\n##### 결제 진행 #####');
    showCart();
    print('\n결제를 진행하시겠습니까? (y/n)');
    String? input = stdin.readLineSync();

    if (input?.toLowerCase() == 'y') {
      for (var item in cart) {
        var product = products.firstWhere((p) => p.name == item.name);
        if (product.stock < item.quantity) {
          print('${product.name}의 재고가 부족합니다. 결제를 취소합니다.');
          return;
        }
        product.stock -= item.quantity;
      }
      print('결제가 완료되었습니다. 이용해 주셔서 감사합니다!');
      cart.clear();
    } else {
      print('결제가 취소되었습니다.');
    }
  }

  void showProductsForSeller() {
    print('\n===== 재고 관리 =====');
    for (var product in products) {
      print('${product.name} / ${product.price}원 / 재고: ${product.stock}개');
    }
    print("=====================");
  }

  void addProduct() {
    print('\n추가할 상품의 이름을 입력해주세요:');
    String? name = stdin.readLineSync();
    
    print('상품의 가격을 입력해주세요:');
    int price = int.parse(stdin.readLineSync() ?? '0');
    
    print('상품의 초기 재고를 입력해주세요:');
    int stock = int.parse(stdin.readLineSync() ?? '0');
    
    products.add(Product(name!, price, stock));
    print('상품이 추가되었습니다.');
  }

  void updateStock() {
    print('\n재고를 수정할 상품의 이름을 입력해주세요:');
    String? name = stdin.readLineSync();
    
    var product = products.firstWhere(
      (p) => p.name == name,
      orElse: () => Product('', 0, 0)
    );

    if (product.name.isEmpty) {
      print('해당 상품이 존재하지 않습니다.');
      return;
    }

    print('새로운 재고 수량을 입력해주세요:');
    int newStock = int.parse(stdin.readLineSync() ?? '0');
    product.stock = newStock;
    print('재고가 수정되었습니다.');
  }
}

void customerMenu(ShoppingMall mall) {
  bool isRunning = true;

  while (isRunning) {
    print('\n==== 구매자 메뉴 ====');
    print('[1] 상품 목록 보기');
    print('[2] 장바구니에 담기');
    print('[3] 장바구니 확인');
    print('[4] 장바구니 초기화');
    print('[5] 결제하기');
    print('[z] 뒤로 가기');
    print('[x] 프로그램 종료');
    print("=====================");
    
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        mall.showProductsForCustomer();
        break;
      case '2':
        mall.addToCart();
        break;
      case '3':
        mall.showCart();
        break;
      case '4':
        mall.clearCart();
        break;
      case '5':
        mall.checkout();
        break;
      case 'z':
        print('메인 메뉴로 돌아갑니다.');
        isRunning = false;
        break;
      case 'x':
        print('정말 종료하시겠습니까? (종료하려면 x를 입력해주세요)');
        String? confirmInput = stdin.readLineSync();
        if (confirmInput == 'x') {
          print('이용해 주셔서 감사합니다 ~ 안녕히 가세요!');
          exit(0);
        } else {
          print('종료하지 않습니다.');
        }
        break;
      default:
        print('지원하지 않는 기능입니다! 다시 시도해 주세요..');
    }
  }
}

void sellerMenu(ShoppingMall mall) {
  bool isRunning = true;

  while (isRunning) {
    print('\n===== 판매자 메뉴 =====');
    print('[1] 재고 현황 보기');
    print('[2] 새 상품 추가');
    print('[3] 재고 수정');
    print('[z] 뒤로 가기');
    print('[x] 프로그램 종료');
    print("=====================");
    
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        mall.showProductsForSeller();
        break;
      case '2':
        mall.addProduct();
        break;
      case '3':
        mall.updateStock();
        break;
      case 'z':
        print('메인 메뉴로 돌아갑니다.');
        isRunning = false;
        break;
      case 'x':
        print('정말 종료하시겠습니까? (종료하려면 x를 입력해주세요)');
        String? confirmInput = stdin.readLineSync();
        if (confirmInput == 'x') {
          print('프로그램을 종료합니다.');
          exit(0);
        } else {
          print('종료하지 않습니다.');
        }
        break;
      default:
        print('지원하지 않는 기능입니다! 다시 시도해 주세요..');
    }
  }
}

void main() {
  var shoppingMall = ShoppingMall([
    Product('셔츠', 45000, 10),
    Product('원피스', 30000, 10),
    Product('반팔티', 35000, 10),
    Product('반바지', 38000, 10),
    Product('양말', 5000, 10),
  ]);

  while (true) {
    print('\n=== 쇼핑몰 프로그램 ===');
    print('[1] 구매자 메뉴');
    print('[2] 판매자 메뉴');
    print('[x] 프로그램 종료');
    print("=======================");

    
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        customerMenu(shoppingMall);
        break;
      case '2':
        sellerMenu(shoppingMall);
        break;
      case 'x':
        print('정말 종료하시겠습니까? (종료하려면 x를 입력해주세요)');
        String? confirmInput = stdin.readLineSync();
        if (confirmInput == 'x') {
          print('프로그램을 종료합니다.');
          exit(0);
        } else {
          print('종료하지 않습니다.');
        }
        break;
      default:
        print('잘못된 입력입니다.');
    }
  }
}