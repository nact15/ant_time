import 'dart:io';

import 'package:ant_time_flutter/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool autoFocus;
  final Function()? onEditingComplete;
  final Widget? prefixIcon;
  final int? minLines;
  final int? maxLines;
  final double? minHeight;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextInputType? keyboardType;
  final ScrollPhysics physics;
  final bool scrollbars;
  final Function()? onTap;
  final FocusNode? node;
  final Function(String)? onChanged;
  final InputDecoration? decoration;
  final bool? enabled;
  final Function()? onClearTap;

  BaseTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.errorText,
    this.labelText,
    this.autoFocus = false,
    this.onEditingComplete,
    this.prefixIcon,
    this.maxLines,
    this.minLines,
    this.minHeight,
    this.suffix,
    this.inputFormatters,
    this.maxLength,
    this.keyboardType,
    this.physics = const NeverScrollableScrollPhysics(),
    this.scrollbars = false,
    this.onTap,
    this.node,
    this.onChanged,
    this.decoration,
    this.enabled,
    this.onClearTap,
  }) : super(key: key);

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  bool _canClear = false;
  late Map<ShortcutActivator, Intent> _shortcuts;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(widget.node);
    });

    _shortcuts = {};
    // widget.controller.addListener(_controllerListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_controllerListener);
    widget.controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // WidgetsBinding.instance?.addPostFrameCallback((_){
    //   FocusScope.of(context).requestFocus(widget.node);
    // });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: context.theme.colorScheme.copyWith(
          primary: AppColors.primaryColor,
        ),
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: TextFormField(
          toolbarOptions: const ToolbarOptions(
            copy: true,
            cut: true,
            paste: true,
            selectAll: true,
          ),
          focusNode: widget.node,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          scrollPhysics: widget.physics,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.maxLines,
          controller: widget.controller,
          autofocus: widget.autoFocus,
          enabled: widget.enabled,
          onEditingComplete: widget.onEditingComplete,
          textAlign: TextAlign.left,
          style: AppTextStyles.textFieldStyle,
          cursorColor: AppColors.primaryColor,
          keyboardType: widget.keyboardType,
          decoration: (widget.decoration ?? AppDecoration.textFieldDecoration).copyWith(
            hintText: widget.hintText,
            errorText: widget.errorText,
            focusColor: context.theme.focusColor,
            focusedBorder: AppDecoration.textFieldFocusedBorder.copyWith(
              borderSide: BorderSide(color: context.theme.focusColor),
            ),
            border: AppDecoration.textFieldBorder.copyWith(
              borderSide: BorderSide(color: context.theme.borderColor),
            ),
            enabledBorder: AppDecoration.textFieldBorder.copyWith(
              borderSide: BorderSide(color: context.theme.borderColor),
            ),
            disabledBorder: AppDecoration.textFieldDisabledBorder.copyWith(
              borderSide: BorderSide(color: context.theme.borderColor),
            ),
            labelText: widget.labelText,
            fillColor: context.theme.cardColor,
            prefixIcon: widget.prefixIcon,
            counterText: '',
            constraints: BoxConstraints(
              minHeight: widget.minHeight ?? 50,
            ),
            suffixIcon: widget.suffix ??
                (_canClear
                    ? IconButton(
                        focusNode: FocusNode(
                          skipTraversal: false,
                          canRequestFocus: false,
                        ),
                        focusColor: Colors.transparent,
                        enableFeedback: false,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: _onClear,
                        icon: const Icon(
                          AppIcons.cancelIcon,
                          color: Colors.black,
                          size: 8,
                        ),
                      )
                    : null),
          ),
        ),
      ),
    );
  }

  void _controllerListener() {
    if (!_canClear && widget.controller.text.isNotEmpty) {
      setState(() {
        _canClear = true;
      });
    } else if (_canClear && widget.controller.text.isEmpty) {
      setState(() {
        _canClear = false;
      });
    }
  }

  void _onClear() {
    widget.onClearTap?.call();
    widget.controller.clear();
  }
}
