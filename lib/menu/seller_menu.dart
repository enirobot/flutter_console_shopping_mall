import 'dart:io';

import 'package:flutter_console_shopping_mall/menu/menu.dart';
import 'package:flutter_console_shopping_mall/services/shopping_mall.dart';
import 'package:flutter_console_shopping_mall/utils/input_util.dart';

/// `sellerMenu` 함수는 판매자 메뉴를 관리합니다.
/// 
/// 매개변수:
/// - `mall`: `ShoppingMall` 인스턴스, 판매자가 재고를 관리할 수 있는 쇼핑몰.
///
/// 이 함수는 반복문을 사용하여 판매자 메뉴를 지속적으로 표시하고,
/// 사용자의 입력에 따라 다양한 기능을 수행합니다.
///
/// 기능 목록:
/// - [1] 재고 현황 보기: 현재 상품의 재고 현황을 출력합니다.
/// - [2] 새 상품 추가: 새로운 상품을 쇼핑몰에 추가합니다.
/// - [3] 재고 수정: 기존 상품의 재고 수량을 수정합니다.
/// - [z/ㅋ] 뒤로 가기: 메인 메뉴로 돌아갑니다.
/// - [x/ㅌ] 프로그램 종료: 프로그램 종료를 확인 후 종료합니다.

void sellerMenu(ShoppingMall mall) {
  bool isRunning = true;

  while (isRunning) {
    // 판매자 메뉴를 출력
    Menu.showSellerMenu();
    
    // 사용자에게 메뉴 선택 입력을 받음
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
        print('정말 종료하시겠습니까? (종료하려면 x를 입력해주세요)');
        String? confirmInput = stdin.readLineSync();
        
        if (confirmInput == 'x' || confirmInput == 'ㅌ') {
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
