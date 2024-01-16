import 'package:learn_patterns_and_records/typedef.dart';

class Block {
  Block(this.type, this.text);

  final String type, text;

  factory Block.fromJson(Json json) {
    if (json
        case {
          'type': String type,
          'text': String text,
        }) {
      return Block(type, text);
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }
}