import 'dart:convert';
import 'dart:developer';

void printJson(String input) {
  const decoder = JsonDecoder();
  const encoder = JsonEncoder.withIndent('  ');

  var object = decoder.convert(input);
  var prettyString = encoder.convert(object);
  prettyString.split('\n').forEach((element) => log(element));
}
