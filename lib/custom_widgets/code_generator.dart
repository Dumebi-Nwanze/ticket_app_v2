import 'dart:math';

String generateCode() {
  String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String numbers = "1234567890";
  String code = "";
  code += '${letters}${numbers}';
  return List.generate(10, (index) {
    final indexRandom = Random.secure().nextInt(code.length);
    return code[indexRandom];
  }).join("");
}
