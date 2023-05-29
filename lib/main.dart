import 'package:ant_time_flutter/di/di.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/pages/settings/bloc/settings_bloc.dart';
import 'package:ant_time_flutter/ui/pages/splash/splash_page.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setDI();

  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitleBarStyle(
      TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    await windowManager.setTitle(AppConst.appTitle);
    await windowManager.setFullScreen(false);
    await windowManager.setSkipTaskbar(false);
    // await windowManager.setAsFrameless();
  });

  doWhenWindowReady(() {
    appWindow.minSize = const Size(500, 500);
    // appWindow.maxSize = const Size(1000, 1000);
    appWindow.size = const Size(850, 700);
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });

  runApp(
    BlocProvider<SettingsBloc>(
      create: (_) => SettingsBloc(
        secureStorageRepository: injection(),
        defaultActivityUseCase: injection(),
        favoritesRepository: injection(),
      )..add(SettingsGetProperties()),
      child: const AntTimeWebant(),
    ),
  );
}

class AntTimeWebant extends StatelessWidget {
  const AntTimeWebant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (prevState, currState) => prevState.isDarkTheme != currState.isDarkTheme,
      builder: (context, state) {
        return MaterialApp(
          title: AppConst.appTitle,
          theme: AppTheme.mainTheme,
          home: const SplashPage(),
          darkTheme: AppTheme.darkTheme,
          themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
