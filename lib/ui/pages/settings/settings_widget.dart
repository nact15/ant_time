import 'dart:ui';

import 'package:ant_time_flutter/base_bloc/base_bloc.dart';
import 'package:ant_time_flutter/models/value_model.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/navigation/app_router.dart';
import 'package:ant_time_flutter/ui/pages/settings/bloc/settings_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/activity_bloc/activity_bloc.dart';
import 'package:ant_time_flutter/ui/widgets/base_switcher.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: _settingsListener,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600,
          minWidth: 300,
        ),
        width: context.screenSize.width / 2.3,
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: Drawer(
          backgroundColor: context.theme.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.localizations.settings,
                  style: AppTextStyles.titleStyle,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 40,
                      ),
                      child: Text(
                        context.localizations.defaultActivity,
                        style: AppTextStyles.greyStyle,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: context.screenSize.width,
                      child: BlocBuilder<ActivityBloc, ActivityState>(
                        builder: (context, activityState) {
                          return BaseDropdown<ValueModel>(
                            disabled:
                                (activityState.status.isLoading || activityState.status.isError),
                            hint: activityState.status.getDropdownHint(context.localizations),
                            items: activityState.activities,
                            value: activityState.selectedActivity,
                            text: (activity) => activity.name,
                            onChanged: (activity) {
                              if (activity != null) {
                                context.read<ActivityBloc>().add(ActivitySelectDefault(activity));
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                BlocBuilder<SettingsBloc, SettingsState>(
                  buildWhen: (prevState, currState) =>
                      prevState.isDarkTheme != currState.isDarkTheme,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Row(
                        children: [
                          BaseSwitcher(
                            initValue: state.isDarkTheme,
                            callBack: (isDark) {
                              context.read<SettingsBloc>().add(
                                    SettingsChangeThemeMode(isDark),
                                  );
                            },
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Text(
                                context.localizations.darkTheme,
                                style: AppTextStyles.titleRowStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                BlocBuilder<SettingsBloc, SettingsState>(
                  buildWhen: (prevState, currState) =>
                      prevState.isActiveEaster != currState.isActiveEaster,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          BaseSwitcher(
                            initValue: state.isActiveEaster,
                            callBack: (isActive) => context.read<SettingsBloc>().add(
                                  SettingsChangeEasterEgg(isActive),
                                ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Text(
                                context.localizations.additionalMotivation,
                                style: AppTextStyles.titleRowStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BaseIcon(
                      onTap: () => context.read<SettingsBloc>().add(SettingsLogout()),
                      child: (color) => Row(
                        children: [
                          Icon(
                            AppIcons.logoutIcon,
                            size: 32,
                            color: color,
                          ),
                          Text(
                            context.localizations.logout,
                            style: AppTextStyles.linkStyle.copyWith(
                              color: color,
                            ),
                          ),
                        ],
                      ),
                      iconColor: AppColors.primaryColor,
                      padding: EdgeInsets.zero,
                      hoverColor: AppColors.hoverLinkColor,
                      icon: AppIcons.logoutIcon,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void _settingsListener(BuildContext context, SettingsState state) {
    if (state.status.isLogout) {
      AppRouter.pushToAuthorization(context);
    }
  }
}
