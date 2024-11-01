import 'dart:io';

import 'package:flutter_console_shopping_mall/menu/menu.dart';
import 'package:flutter_console_shopping_mall/services/shopping_mall.dart';
import 'package:flutter_console_shopping_mall/utils/input_util.dart';
/// `customerMenu` 함수는 구매자 메뉴를 관리합니다.
/// 
/// 매개변수:
/// - `mall`: `ShoppingMall` 인스턴스, 구매자가 이용할 수 있는 쇼핑몰.
///
/// 이 함수는 반복문을 사용하여 구매자 메뉴를 지속적으로 표시하고,
/// 사용자의 입력에 따라 다양한 기능을 수행합니다.
///
/// 기능 목록:
/// - [1] 상품 목록 보기: 쇼핑몰에 등록된 상품 목록을 출력합니다.
/// - [2] 장바구니에 담기: 장바구니에 상품을 추가합니다.
/// - [3] 장바구니 확인: 현재 장바구니 상태를 확인합니다.
/// - [4] 장바구니 초기화: 장바구니에 있는 모든 항목을 삭제합니다.
/// - [5] 결제하기: 장바구니에 담긴 상품을 결제합니다.
/// - [z/ㅋ] 뒤로 가기: 메인 메뉴로 돌아갑니다.
/// - [x/ㅌ] 프로그램 종료: 프로그램 종료를 확인 후 종료합니다.

void customerMenu(ShoppingMall mall) {
  bool isRunning = true;

  while (isRunning) {
    // 구매자 메뉴를 출력
    Menu.showCustomerMenu();
    
    // 사용자에게 메뉴 선택 입력을 받음
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
        print('정말 종료하시겠습니까? (종료하려면 [x/ㅌ]를 입력해주세요)');
        String? confirmInput = stdin.readLineSync();
        
        if (confirmInput == 'x' || confirmInput == 'ㅌ') {
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
