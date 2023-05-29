import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/usecases/textile_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class BaseCheckbox extends StatefulWidget {
  final bool initialValue;
  final Function(bool) onTap;
  final String title;

  const BaseCheckbox({
    Key? key,
    required this.initialValue,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  State<BaseCheckbox> createState() => _BaseCheckboxState();
}

class _BaseCheckboxState extends State<BaseCheckbox> {
  late bool _checkbox;

  @override
  void initState() {
    _checkbox = widget.initialValue;
    super.initState();
  }

  @override
  void didUpdateWidget(BaseCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _checkbox = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SizedBox(
            height: 20,
            width: 20,
            child: Checkbox(
              value: _checkbox,
              side: const BorderSide(color: AppColors.iconColor),
              onChanged: (_) => _onChanged(),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.white;
                }
                if (states.contains(MaterialState.selected)) {
                  return context.theme.primaryColor;
                }

                return null;
              }),
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, top: 13),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: _onChanged,
                      behavior: HitTestBehavior.translucent,
                      child: MarkdownBody(
                        data: TextileUseCase(widget.title).toString(),
                        listItemCrossAxisAlignment: MarkdownListItemCrossAxisAlignment.start,
                        shrinkWrap: true,
                        softLineBreak: true,
                        selectable: true,
                        onTapLink: _onTapLink,
                        styleSheet: MarkdownStyleSheet.fromTheme(
                          Theme.of(context).copyWith(
                            textTheme: TextTheme(
                              bodyText2: AppTextStyles.greyStyle.copyWith(
                                decoration: _checkbox ? TextDecoration.lineThrough : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onTapLink(_, String? url, __) {
    if (url != null) {
      launch(url);
    }
  }

  void _onChanged() {
    setState(() {
      _checkbox = !_checkbox;
    });
    widget.onTap.call(_checkbox);
  }
}
