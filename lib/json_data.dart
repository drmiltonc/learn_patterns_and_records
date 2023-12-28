import 'dart:convert';

class Document {
  final Map<String, Object?> _json;

  Document() : _json = jsonDecode(documentJson);

  (String, {DateTime modified}) getMetadata() {
    if (_json
        case {
          'metadata': {
            'title': String title,
            'modified': String localModified,
          }
        }) {
      return (title, modified: DateTime.parse(localModified));
    } else {
      throw const FormatException('Unexpected Exception');
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

const documentJson = '''

  {

    "metadata": {
      "title": "My Document",
      "modified": "2023-05-10"
    },

    "blocks": [

      {
        "type": "h1",
        "text": "Chapter 1"
      },

      {
        "type": "p",
        "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
      },

      {
        "type": "checkbox",
        "checked": "false",
        "text": "Learn Dart 3"
      }

    ]
  }

''';

class Block {
  Block(this.type, this.text);

  final String type, text;

  factory Block.fromJson(Map<String, dynamic> json) {
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
