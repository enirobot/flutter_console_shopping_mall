
/// `Constants` 클래스는 애플리케이션 전역에서 사용되는 상수들을 정의합니다.
/// 
/// 이 클래스는 사용자에게 표시될 메시지와 형식을 저장하여 코드의 일관성을 높이고,
/// 중복을 줄이는 데 도움을 줍니다.
/// 
/// 각 상수의 역할:
/// - 사용자에게 제공되는 피드백 메시지 (예: 오류 메시지, 결제 성공 메시지 등).
/// - UI 요소 간의 구분을 위한 문자열 (예: 구분선 등).
/// 
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