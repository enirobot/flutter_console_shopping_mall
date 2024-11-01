# 다트 쇼핑몰 프로그램

이 프로젝트는 다트(Dart)로 작성된 간단한 콘솔 기반 쇼핑몰 프로그램입니다.

## 기능

### 구매자 기능
- 상품 목록 조회
- 장바구니 담기
- 장바구니 확인
- 장바구니 초기화
- 결제하기

### 판매자 기능
- 재고 현황 조회
- 새 상품 추가
- 재고 수정

## 프로젝트 구조
```
shopping_mall/
├── bin/
│   └── flutter_console_shopping_mall.dart # 프로그램 진입점
└── lib/
    ├── constants/
    │   └── constants.dart  # 상수 정의
    ├── models/
    │   ├── product.dart    # 상품 모델
    │   └── cart_item.dart  # 장바구니 아이템 모델
    ├── services/
    │   └── shopping_mall.dart  # 쇼핑몰 핵심 비즈니스 로직
    ├── utils/
    │   └── input_util.dart     # 입력 처리 유틸리티
    └── menu/
        ├── menu.dart           # 메뉴 UI
        ├── customer_menu.dart  # 구매자 메뉴 처리
        └── seller_menu.dart    # 판매자 메뉴 처리
```

## 시작하기

### 필요 조건
- Dart SDK >= 3.5.4

### 설치
```bash
# 터미널에서 프로젝트를 두고 싶은 폴더로 이동
cd {특정 폴더}

# 저장소 클론
git clone https://github.com/enirobot/flutter_console_shopping_mall.git

# 프로젝트 디렉토리로 이동
cd flutter_console_shopping_mall

# 의존성 설치
dart pub get
```

### 실행
```bash
dart run
```

## 사용 방법

1. 메인 메뉴에서 구매자(1) 또는 판매자(2) 모드 선택
2. 각 모드별 제공되는 기능 이용
3. 'z' 또는 'ㅋ'를 입력하여 이전 메뉴로 이동
4. 'x' 또는 'ㅌ'를 입력하여 프로그램 종료

## 기본 제공 상품
- 셔츠 (45,000원)
- 원피스 (30,000원)
- 반팔티 (35,000원)
- 반바지 (38,000원)
- 양말 (5,000원)

각 상품의 초기 재고는 10개씩 제공됩니다.