import 'dart:io';

import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/pages/settings/bloc/settings_bloc.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:window_manager/window_manager.dart';

import '../pages/issues/bloc/issues_bloc.dart';
import '../pages/issues/projects/bloc/projects_bloc.dart';
import '../pages/timer/activity_bloc/activity_bloc.dart';

class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool implyLeading;
  final bool showMenu;

  const BaseAppBar({
    Key? key,
    this.implyLeading = false,
    this.showMenu = true,
  }) : super(key: key);

  @override
  State<BaseAppBar> createState() => _BaseAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BaseAppBarState extends State<BaseAppBar> with WindowListener {
  bool _isFullScreen = false;
  bool _showMinimize = true;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _isFullScreen = await windowManager.isFullScreen();
      if (Platform.isMacOS) {
        _showMinimize = !_isFullScreen;
      }
    });
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowUnmaximize() {
    if (_isFullScreen) {
      _changeFullScreen(isFullScreen: false);
    }
    super.onWindowUnmaximize();
  }

  @override
  void onWindowMinimize() {
    if (_isFullScreen) {
      _changeFullScreen(isFullScreen: false);
    }
    super.onWindowMinimize();
  }

  @override
  void onWindowEnterFullScreen() {
    if (!_isFullScreen) {
      _changeFullScreen(isFullScreen: true);
    }
    super.onWindowEnterFullScreen();
  }

  @override
  void onWindowLeaveFullScreen() {
    if (_isFullScreen) {
      _changeFullScreen(isFullScreen: false);
    }
    super.onWindowLeaveFullScreen();
  }

  @override
  void onWindowMaximize() {
    if (!_isFullScreen) {
      _changeFullScreen(isFullScreen: true);
    }
    super.onWindowMaximize();
  }

  @override
  void onWindowMoved() {
    if (_isFullScreen) {
      _changeFullScreen();
    }
    super.onWindowMoved();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: context.theme.isDark ? AppColors.secondaryDarkColor : AppColors.baseColor,
      elevation: 0,
      title: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (_) => appWindow.startDragging(),
        onDoubleTap: appWindow.maximizeOrRestore,
        child: Row(
          textDirection: Platform.isMacOS ? TextDirection.rtl : TextDirection.ltr,
          children: [
            if (widget.showMenu)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: BaseIcon(
                    onTap: context.openDrawer,
                    icon: Icons.menu,
                    size: 22,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SvgPicture.asset(
                AppAssets.logo,
                width: 40,
                height: 40,
              ),
            ),
            Row(
              children: [
                Text(
                  AppConst.appTitle,
                  style: AppTextStyles.logoStyle,
                ),
                if (widget.showMenu) ...[
                  const SizedBox(width: 23.5),
                  BaseHoveredWidget(
                    svgIcon: AppAssets.refreshIcon,
                    width: 17,
                    height: 20,
                    onTap: () {
                      context.read<IssuesBloc>().add(IssuesFetch(page: 0, clearSearch: true));
                      context.read<ProjectsBloc>().add(ProjectsFetch());
                      context.read<ActivityBloc>().add(ActivityFetchActivities());
                    },
                  ),
                ],
              ],
            ),
            const Spacer(),
            // ignore: avoid-returning-widgets
            Platform.isMacOS ? _buildMaximize() : _buildMinimize(),
            // ignore: avoid-returning-widgets
            if (_showMinimize) Platform.isMacOS ? _buildMinimize() : _buildMaximize(),
            Padding(
              padding: EdgeInsets.only(
                right: Platform.isMacOS ? 0 : 18,
                left: Platform.isMacOS ? 18 : 0,
              ),
              child: BaseTooltip(
                message: context.localizations.close,
                child: BaseIcon(
                  onTap: () => appWindow.close(),
                  icon: AppIcons.cancelIcon,
                  size: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMinimize() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BaseIcon(
        padding: EdgeInsets.zero,
        icon: AppIcons.hideIcon,
        size: 22,
        onTap: appWindow.minimize,
      ),
    );
  }

  Widget _buildMaximize() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BaseIcon(
        icon: _isFullScreen ? AppIcons.minimizeIcon : AppIcons.maximizeIcon,
        size: 10,
        onTap: () {
          _isFullScreen ? windowManager.unmaximize() : windowManager.maximize();
          _changeFullScreen();
        },
      ),
    );
  }

  Future<void> _changeFullScreen({bool? isFullScreen}) async {
    setState(() {
      _isFullScreen = isFullScreen ?? !_isFullScreen;
      if (Platform.isMacOS) {
        _showMinimize = !_isFullScreen;
      }
    });
  }
}
