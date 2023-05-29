import 'package:ant_time_flutter/resources/resources.dart';

class TextileUseCase {
  String text;

  TextileUseCase(this.text);

  final _boldPattern = RegExp(r'\*[^*]+\*');
  final _linkPattern = RegExp(r'\".*\":[^ ]*');

  @override
  String toString() {
    text = text.replaceAllMapped(
      _boldPattern,
      (match) => '*${match.group(0)}*',
    );
    text = text.replaceAllMapped(
      _linkPattern,
      (match) => '[${_getLinkText(match.group(0) ?? '')}]'
          '(${_getLink(match.group(0) ?? '')})',
    );

    return text;
  }

  String _getLinkText(String link) {
    return link.substring(
      link.indexOf('"') + 1,
      link.lastIndexOf('"'),
    );
  }

  String _getLink(String link) {
    return link.substring(link.indexOf(':') + 1);
  }
}
