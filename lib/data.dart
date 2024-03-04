import 'dart:convert';

class Document {
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
      throw const FormatException('Unexpected JSON');
    }
  }
}

class HeaderBlock extends Block {
  final String text;
  HeaderBlock(this.text);
}

class ParagraphBlock extends Block {
  final String text;
  ParagraphBlock(this.text);
}

class CheckboxBlock extends Block {
  final String text;
  final bool isChecked;
  CheckboxBlock(this.text, this.isChecked);
}

class Block {
  final String type;
  final String text;
  Block(this.type, this.text);

  factory Block.fromJson(Map<String, dynamic> json) {
    if (json case {'type': var type, 'text': var text}) {
      return Block(type, text);
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }
}

const documentJson = '''
{
  "metadata": {
    // ...
  },
  "blocks": [
    {
      "type": "h1",
      "text": "Chapter 1"
    },
    // ...
  ]
}
    {
      "type": "p",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
    {
      "type": "checkbox",
      "checked": false,
      "text": "Learn Dart 3"
    }
  ]
}
''';
