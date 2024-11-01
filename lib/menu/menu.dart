import 'package:flutter_console_shopping_mall/constants/constants.dart';

class Menu {
  
  /// `showMainMenu` 메서드는 프로그램의 메인 메뉴를 출력합니다.
  static void showMainMenu() {
    print('\n=== 쇼핑몰 프로그램 ===');
    print('[1] 구매자 메뉴');
    print('[2] 판매자 메뉴');
    print('[x/ㅌ] 프로그램 종료');
    print(Constants.DIVIDER);
  }

  /// `showCustomerMenu` 메서드는 구매자용 메뉴를 출력합니다.
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

  /// `showSellerMenu` 메서드는 판매자용 메뉴를 출력합니다.
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
