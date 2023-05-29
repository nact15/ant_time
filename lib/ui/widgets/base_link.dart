import 'package:ant_time_flutter/resources/resources.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class BaseLink extends StatefulWidget {
  final String link;
  final String? text;
  final Function()? onTap;
  final Widget Function(bool)? child;

  const BaseLink({
    Key? key,
    required this.link,
    this.text,
    this.onTap,
    this.child,
  }) : super(key: key);

  @override
  _BaseLinkState createState() => _BaseLinkState();
}

class _BaseLinkState extends State<BaseLink> {
  bool _linkHovered = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      child: Ink(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            widget.onTap?.call() ?? launch(widget.link);
          },
          hoverColor: Colors.transparent,
          onHover: (hovered) => setState(() => _linkHovered = hovered),
          child: widget.child?.call(_linkHovered) ??
              Text(
                widget.text ?? widget.link,
                style: AppTextStyles.linkStyle.copyWith(
                  color: _linkHovered ? AppColors.hoverLinkColor : context.theme.primaryColor,
                ),
              ),
        ),
      ),
    );
  }

  void _onPointerDown(PointerDownEvent event) {
    if (event.kind == PointerDeviceKind.mouse) {
      if (event.buttons == kMiddleMouseButton) {
        launchUrl(Uri.dataFromString(widget.link));
      }
      if (event.buttons == kSecondaryMouseButton) {
        Clipboard.setData(ClipboardData(text: widget.link));
      }
    }
  }
}
