import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CommentaryWidget extends StatefulWidget {
  CommentaryWidget({Key? key}) : super(key: key);

  @override
  State<CommentaryWidget> createState() => _CommentaryWidgetState();
}

class _CommentaryWidgetState extends State<CommentaryWidget> {
  late TextEditingController _controller;
  bool _disable = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_controllerListener);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        left: 20,
        bottom: 20,
        right: 20,
      ),
      child: Stack(
        children: [
          BaseTextField(
            minLines: 2,
            keyboardType: TextInputType.multiline,
            physics: const AlwaysScrollableScrollPhysics(),
            scrollbars: true,
            maxLines: 10,
            controller: _controller,
            hintText: context.localizations.commentaryHint,
            suffix: Padding(
              padding: const EdgeInsets.only(
                right: 20,
                top: 15,
                bottom: 15,
              ),
              child: BaseButton(
                onTap: () {},
                disabled: _disable,
                child: Text(
                  context.localizations.send,
                  style: AppTextStyles.buttonStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _controllerListener() {
    if (_disable && _controller.text.trim().isNotEmpty) {
      setState(() {
        _disable = false;
      });
    } else if (!_disable && _controller.text.trim().isEmpty) {
      setState(() {
        _disable = true;
      });
    }
  }
}
