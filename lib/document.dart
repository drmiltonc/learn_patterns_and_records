import 'dart:convert';
import 'package:learn_patterns_and_records/typedef.dart';
import 'block.dart';
import 'json_data.dart';

class Document {
  Document(): _json = jsonDecode(documentJson);

  final Json _json;

  (String, {DateTime modified}) getMetadata() {
    if (_json
        case {
          'metadata': {
            'title': String title,
            'modified': String localModified
          }
        }
    ) {
      return (title, modified: DateTime.parse(localModified));
    } else {
      throw const FormatException('Unexpected exception');
    }
  }

  List<Block> getBlocks() {
    if (_json case {'blocks': List blockJson}) {
      return <Block>[
        for (final blockJson in blockJson) Block.fromJson(blockJson)
      ];
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }
}
