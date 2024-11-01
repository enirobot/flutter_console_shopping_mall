import 'dart:io';

// 상수 정의
class Constants {
  static const String INVALID_INPUT = '입력값이 올바르지 않아요!';
  static const String NO_STOCK = '해당 상품의 재고가 없습니다!';
  static const String CART_EMPTY = '장바구니가 비어있습니다.';
  static const String PAYMENT_SUCCESS = '결제가 완료되었습니다. 이용해 주셔서 감사합니다!';
  static const String PAYMENT_CANCEL = '결제가 취소되었습니다.';
  
  static const String DIVIDER = '=====================';
  static const String PRODUCT_LIST_HEADER = '\n===== 상품 목록 =====';
  static const String CART_HEADER = '\n===== 장바구니 =====';
  static const String STOCK_HEADER = '\n===== 재고 관리 =====';
  static const String PAYMENT_HEADER = '\n##### 결제 진행 #####';
}

// 사용자 입력 처리를 위한 유틸리티 클래스
class InputUtil {
  static String? getInput(String prompt) {
    print(prompt);
    return stdin.readLineSync();
  }

  static int? getIntInput(String prompt) {
    try {
      String? input = getInput(prompt);
      return int.parse(input ?? '');
    } catch (e) {
      print(Constants.INVALID_INPUT);
      return null;
    }
  }

  static bool confirmExit() {
    String? input = getInput('정말 종료하시겠습니까? (종료하려면 [x/ㅌ]를 입력해주세요)');
    return input == 'x' || input == 'ㅌ';
  }
}

class Product {
  String name;
  int price;
  int stock;

  Product(this.name, this.price, this.stock);

  bool hasStock() => stock > 0;
  bool hasEnoughStock(int quantity) => stock >= quantity;
}

class CartItem {
  String name;
  int quantity;
  int price;

  CartItem(this.name, this.quantity, this.price);

  int get total => price * quantity;
}

class ShoppingMall {
  final List<Product> products;
  final List<CartItem> cart = [];

  ShoppingMall(this.products);

  void showProductsForCustomer() {
    print(Constants.PRODUCT_LIST_HEADER);
    products.where((product) => product.hasStock()).forEach(
      (product) => print('${product.name} / ${product.price}원 (재고: ${product.stock}개)')
    );
    print(Constants.DIVIDER);
  }

  void addToCart() {
    String? productName = InputUtil.getInput('\n장바구니에 담을 상품의 이름을 입력해주세요:');
    var product = _findProduct(productName);
    
    if (!_validateProduct(product)) return;
    
    int? count = InputUtil.getIntInput('장바구니에 담을 상품의 개수를 입력해주세요:');
    if (!_validateQuantity(product, count)) return;

    _updateCart(product, count!);
    print('장바구니에 상품이 담겼어요!');
  }

  Product _findProduct(String? name) {
    return products.firstWhere(
      (p) => p.name == name,
      orElse: () => Product('', 0, 0)
    );
  }

  bool _validateProduct(Product product) {
    if (product.name.isEmpty) {
      print(Constants.INVALID_INPUT);
      return false;
    }
    if (!product.hasStock()) {
      print(Constants.NO_STOCK);
      return false;
    }
    return true;
  }

  bool _validateQuantity(Product product, int? quantity) {
    if (quantity == null || quantity <= 0) {
      print('0개보다 많은 개수의 상품만 담을 수 있어요!');
      return false;
    }
    if (!product.hasEnoughStock(quantity)) {
      print('재고가 부족합니다! (현재 재고: ${product.stock}개)');
      return false;
    }
    return true;
  }

  void _updateCart(Product product, int quantity) {
    var existingItem = cart.firstWhere(
      (item) => item.name == product.name,
      orElse: () => CartItem('', 0, 0)
    );

    if (existingItem.name.isNotEmpty) {
      existingItem.quantity += quantity;
    } else {
      cart.add(CartItem(product.name, quantity, product.price));
    }
  }

  void showCart() {
    if (cart.isEmpty) {
      print(Constants.CART_EMPTY);
      return;
    }
    
    print(Constants.CART_HEADER);
    int total = 0;
    for (var item in cart) {
      print('${item.name} ${item.quantity}개 - ${item.total}원');
      total += item.total;
    }
    print('총액: $total원');
    print(Constants.DIVIDER);
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
      print('${Constants.CART_EMPTY} 결제할 상품이 없습니다.');
      return;
    }

    print(Constants.PAYMENT_HEADER);
    showCart();
    
    String? input = InputUtil.getInput('\n결제를 진행하시겠습니까? (y/n)');

    if (input?.toLowerCase() == 'y') {
      if (_processPayment()) {
        print(Constants.PAYMENT_SUCCESS);
        cart.clear();
      }
    } else {
      print(Constants.PAYMENT_CANCEL);
    }
  }

  bool _processPayment() {
    for (var item in cart) {
      var product = products.firstWhere((p) => p.name == item.name);
      if (!product.hasEnoughStock(item.quantity)) {
        print('${product.name}의 재고가 부족합니다. 결제를 취소합니다.');
        return false;
      }
      product.stock -= item.quantity;
    }
    return true;
  }

  void showProductsForSeller() {
    print(Constants.STOCK_HEADER);
    for (var product in products) {
      print('${product.name} / ${product.price}원 / 재고: ${product.stock}개');
    }
    print(Constants.DIVIDER);
  }

  void addProduct() {
    String? name = InputUtil.getInput('\n추가할 상품의 이름을 입력해주세요:');
    int? price = InputUtil.getIntInput('상품의 가격을 입력해주세요:');
    int? stock = InputUtil.getIntInput('상품의 초기 재고를 입력해주세요:');
    
    if (name != null && price != null && stock != null) {
      products.add(Product(name, price, stock));
      print('상품이 추가되었습니다.');
    } else {
      print(Constants.INVALID_INPUT);
    }
  }

  void updateStock() {
    String? name = InputUtil.getInput('\n재고를 수정할 상품의 이름을 입력해주세요:');
    var product = _findProduct(name);

    if (product.name.isEmpty) {
      print('해당 상품이 존재하지 않습니다.');
      return;
    }

    int? newStock = InputUtil.getIntInput('새로운 재고 수량을 입력해주세요:');
    if (newStock != null) {
      product.stock = newStock;
      print('재고가 수정되었습니다.');
    }
  }
}

class Menu {
  static void showMainMenu() {
    print('\n=== 쇼핑몰 프로그램 ===');
    print('[1] 구매자 메뉴');
    print('[2] 판매자 메뉴');
    print('[x/ㅌ] 프로그램 종료');
    print(Constants.DIVIDER);
  }

  static void showCustomerMenu() {
    print('\n==== 구매자 메뉴 ====');
    print('[1] 상품 목록 보기');
    print('[2] 장바구니에 담기');
    print('[3] 장바구니 확인');
    print('[4] 장바구니 초기화');
    print('[5] 결제하기');
    print('[z/ㅋ] 뒤로 가기');
    print('[x/ㅌ] 프로그램 종료');
    print(Constants.DIVIDER);
  }

  static void showSellerMenu() {
    print('\n===== 판매자 메뉴 =====');
    print('[1] 재고 현황 보기');
    print('[2] 새 상품 추가');
    print('[3] 재고 수정');
    print('[z/ㅋ] 뒤로 가기');
    print('[x/ㅌ] 프로그램 종료');
    print(Constants.DIVIDER);
  }
}

void customerMenu(ShoppingMall mall) {
  bool isRunning = true;

  while (isRunning) {
    Menu.showCustomerMenu();
    String? input = InputUtil.getInput('메뉴를 선택하세요:');

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
      case 'ㅋ':
        print('메인 메뉴로 돌아갑니다.');
        isRunning = false;
        break;
      case 'x':
      case 'ㅌ':
        if (InputUtil.confirmExit()) {
          print('이용해 주셔서 감사합니다 ~ 안녕히 가세요!');
          exit(0);
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
    Menu.showSellerMenu();
    String? input = InputUtil.getInput('메뉴를 선택하세요:');

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
      case 'ㅋ':
        print('메인 메뉴로 돌아갑니다.');
        isRunning = false;
        break;
      case 'x':
      case 'ㅌ':
        if (InputUtil.confirmExit()) {
          print('프로그램을 종료합니다.');
          exit(0);
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
    Menu.showMainMenu();
    String? input = InputUtil.getInput('메뉴를 선택하세요:');
    
    switch (input) {
      case '1':
        customerMenu(shoppingMall);
        break;
      case '2':
        sellerMenu(shoppingMall);
        break;
      case 'x':
        if (InputUtil.confirmExit()) {
          print('프로그램을 종료합니다.');
          exit(0);
        }
        break;
      default:
        print('잘못된 입력입니다.');
    }
  }
}