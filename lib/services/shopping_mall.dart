import 'dart:io';

import 'package:flutter_console_shopping_mall/models/cart_item.dart';
import 'package:flutter_console_shopping_mall/models/product.dart';


class ShoppingMall {
  List<Product> products;
  List<CartItem> cart = [];

  /// `ShoppingMall` 생성자는 주어진 상품 목록으로 쇼핑몰을 초기화합니다.
  ///
  /// 매개변수:
  /// - `products`: 쇼핑몰에서 판매되는 상품 리스트.
  ShoppingMall(this.products);

  /// `showProductsForCustomer` 메서드는 고객을 위한 상품 목록을 표시합니다.
  /// 재고가 있는 상품만 출력됩니다.
  void showProductsForCustomer() {
    print('\n===== 상품 목록 =====');
    for (var product in products) {
      if (product.stock > 0) {
        print('${product.name} / ${product.price}원 / 재고: ${product.stock}개');
      }
    }
    print("=====================");
  }

  /// `addToCart` 메서드는 사용자가 선택한 상품을 장바구니에 추가합니다.
  ///
  /// 프로세스:
  /// 1. 장바구니에 추가할 상품의 이름을 사용자에게 입력받습니다.
  /// 2. 해당 상품이 존재하지 않거나 재고가 없으면 오류 메시지를 출력합니다.
  /// 3. 장바구니에 추가할 수량을 입력받고, 재고를 초과하면 오류 메시지를 출력합니다.
  /// 4. 장바구니에 상품이 이미 있으면 수량을 증가시키고, 없으면 새로운 항목을 추가합니다.
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

  /// `showCart` 메서드는 현재 장바구니에 담긴 상품 목록과 총액을 출력합니다.
  /// 장바구니가 비어있으면, 알림 메시지를 출력합니다.
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

  /// `clearCart` 메서드는 장바구니의 모든 항목을 제거합니다.
  /// 장바구니가 이미 비어있다면 알림 메시지를 출력합니다.
  void clearCart() {
    if (cart.isEmpty) {
      print('이미 장바구니가 비어있습니다.');
      return;
    }

    cart.clear();
    print('장바구니를 초기화합니다.');
  }

  /// `checkout` 메서드는 장바구니에 담긴 상품의 결제를 진행합니다.
  ///
  /// 프로세스:
  /// 1. 장바구니가 비어있으면 결제를 중단하고 메시지를 출력합니다.
  /// 2. 사용자가 결제를 확인하면 재고 수량을 업데이트하고 결제를 완료합니다.
  /// 3. 결제가 완료되면 장바구니를 초기화합니다.
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

  /// `showProductsForSeller` 메서드는 판매자를 위한 재고 목록을 출력합니다.
  /// 모든 상품의 이름, 가격, 재고가 표시됩니다.
  void showProductsForSeller() {
    print('\n===== 재고 관리 =====');
    for (var product in products) {
      print('${product.name} / ${product.price}원 / 재고: ${product.stock}개');
    }
    print("=====================");
  }

  /// `addProduct` 메서드는 새로운 상품을 쇼핑몰의 상품 목록에 추가합니다.
  ///
  /// 프로세스:
  /// 1. 사용자에게 상품의 이름, 가격, 초기 재고를 입력받습니다.
  /// 2. 입력된 정보로 새 `Product` 인스턴스를 생성하여 `products` 리스트에 추가합니다.
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

  /// `updateStock` 메서드는 기존 상품의 재고를 수정합니다.
  ///
  /// 프로세스:
  /// 1. 수정할 상품의 이름을 입력받습니다.
  /// 2. 해당 상품이 존재하지 않으면 오류 메시지를 출력합니다.
  /// 3. 새로운 재고 수량을 입력받고, 상품의 `stock` 속성을 업데이트합니다.
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
