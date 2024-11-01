import 'dart:io';

import 'package:flutter_console_shopping_mall/menu/customer_menu.dart';
import 'package:flutter_console_shopping_mall/menu/menu.dart';
import 'package:flutter_console_shopping_mall/menu/seller_menu.dart';
import 'package:flutter_console_shopping_mall/models/product.dart';
import 'package:flutter_console_shopping_mall/services/shopping_mall.dart';
import 'package:flutter_console_shopping_mall/utils/input_util.dart';


/// 프로그램의 진입점입니다.
/// 
/// `main` 함수는 쇼핑몰 애플리케이션을 초기화하고 메인 메뉴를 표시합니다.
/// 사용자가 메뉴를 선택할 수 있도록 반복적으로 대기합니다.
/// 
/// 프로세스:
/// 1. `ShoppingMall` 인스턴스를 생성하고 초기 제품 목록을 추가합니다.
/// 2. 무한 루프를 통해 메인 메뉴를 표시하고 사용자의 입력을 처리합니다.
/// 3. 사용자가 구매자 메뉴 또는 판매자 메뉴를 선택할 수 있도록 합니다.
/// 4. 사용자가 프로그램 종료를 선택하면 확인 후 종료합니다.

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
      case 'ㅌ':
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