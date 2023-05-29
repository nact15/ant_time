import 'package:ant_time_flutter/extensions/extensions.dart';
import 'package:ant_time_flutter/ui/widgets/base_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullImagePage extends StatefulWidget {
  final String imageUrl;

  const FullImagePage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<FullImagePage> createState() => _FullImagePageState();
}

class _FullImagePageState extends State<FullImagePage> {
  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: _onKey,
      child: GestureDetector(
        onTap: context.pop,
        behavior: HitTestBehavior.opaque,
        child: InteractiveViewer(
          constrained: true,
          child: Center(
            child: GestureDetector(
              onTap: () { },
              child: BaseImage(
                fit: BoxFit.contain,
                imageUrl: widget.imageUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onKey(RawKeyEvent event) {
    if (event.physicalKey == PhysicalKeyboardKey.escape) {
      context.pop();
    }
  }
}
