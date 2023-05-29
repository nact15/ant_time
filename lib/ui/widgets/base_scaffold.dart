import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final bool showLogOutButton;
  final Widget? drawer;
  final Widget? endDrawer;

  const BaseScaffold({
    Key? key,
    required this.body,
    this.showLogOutButton = true,
    this.drawer,
    this.endDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.unfocus();
        BaseDropdownForm.closeDropdown();
      },
      child: Scaffold(
        appBar: BaseAppBar(showMenu: showLogOutButton),
        body: body,
        backgroundColor: context.theme.backgroundColor,
        drawerScrimColor: Colors.transparent,
        drawer: drawer,
        endDrawer: endDrawer,
      ),
    );
  }
}
