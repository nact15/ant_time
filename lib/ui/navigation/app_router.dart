import 'dart:ui';

import 'package:ant_time_flutter/di/di.dart';
import 'package:ant_time_flutter/extensions/extensions.dart';
import 'package:ant_time_flutter/ui/pages/authorization/authorization_page.dart';
import 'package:ant_time_flutter/ui/pages/authorization/bloc/authorization_bloc.dart';
import 'package:ant_time_flutter/ui/pages/issues/bloc/issues_bloc.dart';
import 'package:ant_time_flutter/ui/pages/issues/easter_egg/easter_egg_cubit.dart';
import 'package:ant_time_flutter/ui/pages/issues/issues_page.dart';
import 'package:ant_time_flutter/ui/pages/issues/projects/bloc/projects_bloc.dart';
import 'package:ant_time_flutter/ui/pages/settings/bloc/settings_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/activity_bloc/activity_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/bloc/timer_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/checklist/bloc/checklist_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/issue_bloc/issue_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/timer_window.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Future<dynamic> pushToAuthorization(
    BuildContext context,
  ) async {
    return await _pushAndRemoveUntil(
      context,
      MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>.value(
            value: context.read<SettingsBloc>(),
          ),
          BlocProvider(
            create: (_) => AuthorizationBloc(
              issuesRepository: injection(),
              localization: context.localizations,
              secureStorageRepository: injection(),
            ),
          ),
        ],
        child: const AuthorizationPage(),
      ),
    );
  }

  static Future<dynamic> pushToIssues(BuildContext context) async {
    return await _pushAndRemoveUntil(
      context,
      MultiBlocProvider(
        providers: [
          BlocProvider<IssuesBloc>(
            create: (_) => IssuesBloc(
              issuesRepository: injection(),
              favoritesRepository: injection(),
              favoriteUseCase: injection(),
            )..add(IssuesFetch(clearSearch: true)),
          ),
          BlocProvider<ActivityBloc>(
            create: (_) => ActivityBloc(
              issuesRepository: injection(),
              defaultActivityUseCase: injection(),
            )..add(ActivityFetchActivities()),
          ),
          BlocProvider<SettingsBloc>.value(
            value: context.read<SettingsBloc>(),
          ),
          BlocProvider<IssueBloc>(
            create: (_) => IssueBloc(
              issuesRepository: injection(),
              localization: context.localizations,
              defaultActivityUseCase: injection(),
            ),
          ),
          BlocProvider<ProjectsBloc>(
            create: (_) => ProjectsBloc(
              projectsRepository: injection(),
            )..add(ProjectsFetch()),
          ),
          BlocProvider<EasterEggCubit>(
            create: (_) => EasterEggCubit(
              sharedPreferencesRepository: injection(),
            ),
          ),
        ],
        child: const IssuesPage(),
      ),
    );
  }

  static Future<dynamic> pushToTimer(
    BuildContext context, {
    required int issueId,
  }) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black38,
      transitionDuration: const Duration(milliseconds: 150),
      pageBuilder: (_, anim1, anim2) => MultiBlocProvider(
        providers: [
          BlocProvider<IssueBloc>.value(
            value: context.read<IssueBloc>(),
          ),
          BlocProvider<ActivityBloc>.value(
            value: context.read<ActivityBloc>(),
          ),
          BlocProvider<EasterEggCubit>.value(
            value: context.read<EasterEggCubit>(),
          ),
          BlocProvider<TimerBloc>(
            create: (_) => TimerBloc(
              issueBloc: context.read<IssueBloc>(),
            ),
          ),
          BlocProvider<IssuesBloc>.value(
            value: context.read<IssuesBloc>(),
          ),
          BlocProvider<ChecklistBloc>(
            create: (_) => ChecklistBloc(
              checklistRepository: injection(),
            )..add(ChecklistFetch(issueId)),
          ),
        ],
        child: const TimerWindow(),
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => Stack(
        children: [
          MoveWindow(),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: anim1.value * 4, sigmaY: anim1.value * 4),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: FadeTransition(
                child: child,
                opacity: anim1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<dynamic> pushToFullImage(
    BuildContext context, {
    required String imageUrl,
  }) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black38,
      transitionDuration: const Duration(milliseconds: 150),
      pageBuilder: (_, anim1, anim2) => FullImagePage(
        imageUrl: imageUrl,
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: anim1.value * 4, sigmaY: anim1.value * 4),
        child: FadeTransition(
          child: child,
          opacity: anim1,
        ),
      ),
    );
  }

  static Future<dynamic> _pushToPage(
    BuildContext context,
    Widget page, {
    bool closeTabs = false,
    RouteSettings? routeSettings,
  }) async {
    return await Navigator.of(context, rootNavigator: closeTabs).push(
      MaterialPageRoute<dynamic>(
        builder: (context) => page,
        settings: routeSettings,
      ),
    );
  }

  static Future<dynamic> _pushAndRemoveUntil(
    BuildContext context,
    Widget page, {
    bool rootNavigator = false,
    RouteSettings? routeSettings,
  }) async {
    return await Navigator.of(context, rootNavigator: rootNavigator).pushAndRemoveUntil(
      MaterialPageRoute<dynamic>(
        builder: (context) => page,
        settings: routeSettings,
      ),
      (_) => false,
    );
  }
}
