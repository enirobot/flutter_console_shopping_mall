import 'dart:io';
import '../constants/constants.dart';

/// `InputUtil` 클래스는 사용자 입력을 처리하는 유틸리티 클래스입니다.
/// 
/// 메서드:
/// - `getInput(String prompt)`: 사용자에게 프롬프트를 출력하고 문자열 입력을 받아 반환합니다.
/// - `getIntInput(String prompt)`: 사용자에게 정수를 입력받고, 잘못된 입력 시 에러 메시지를 출력합니다.
/// - `confirmExit()`: 종료 여부를 묻는 메시지를 표시하고, 종료 확정을 위한 특정 입력을 확인합니다.

class InputUtil {
  
  /// `getInput` 메서드는 주어진 프롬프트 메시지를 출력하고, 사용자로부터 문자열 입력을 받습니다.
  ///
  /// 매개변수:
  /// - `prompt`: 사용자에게 입력을 요청하는 메시지.
  ///
  /// 반환값:
  /// - 입력된 문자열을 반환하며, 입력이 없는 경우 `null`을 반환합니다.
  static String? getInput(String prompt) {
    print(prompt);
    return stdin.readLineSync();
  }

  /// `getIntInput` 메서드는 주어진 프롬프트 메시지를 출력하고, 사용자로부터 정수 입력을 받습니다.
  ///
  /// 매개변수:
  /// - `prompt`: 사용자에게 입력을 요청하는 메시지.
  ///
  /// 반환값:
  /// - 입력된 값을 정수로 변환하여 반환하며, 변환에 실패한 경우 `null`을 반환합니다.
  /// 
  /// 예외 처리:
  /// - 잘못된 입력이 주어질 경우 `Constants.INVALID_INPUT` 메시지를 출력합니다.
  static int? getIntInput(String prompt) {
    try {
      String? input = getInput(prompt);
      return int.parse(input ?? '');
    } catch (e) {
      print(Constants.INVALID_INPUT);
      return null;
    }
  }

  /// `confirmExit` 메서드는 사용자가 애플리케이션을 종료하려는지 확인합니다.
  ///
  /// 프롬프트 메시지를 출력하고 사용자의 입력을 받아, 종료 명령으로 간주되는 값인지 확인합니다.
  ///
  /// 반환값:
  /// - 입력이 'x' 또는 'ㅌ'일 경우 `true`를 반환하여 종료를 확인하며, 그렇지 않으면 `false`를 반환합니다.
  static bool confirmExit() {
    String? input = getInput('정말 종료하시겠습니까? (종료하려면 [x/ㅌ]를 입력해주세요)');
    return input == 'x' || input == 'ㅌ';
  }
}
