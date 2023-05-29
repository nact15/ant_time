import 'package:ant_time_flutter/di/di.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/navigation/app_router.dart';
import 'package:ant_time_flutter/ui/pages/splash/bloc/splash_bloc.dart';
import 'package:ant_time_flutter/ui/widgets/base_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (_) => SplashBloc(
        secureStorage: injection(),
      )..add(SplashEvent()),
      child: Scaffold(
        body: BlocConsumer<SplashBloc, SplashState>(
          // ignore: prefer-extracting-callbacks
          listener: (context, state) {
            if (state.status.isUnauthorized) {
              AppRouter.pushToAuthorization(context);
            }
            if (state.status.isAuthorized) {
              AppRouter.pushToIssues(context);
            }
          },
          builder: (context, state) {
            if (state.status.isLoading) {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: BaseProgressIndicator(
                      color: context.theme.primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        AppConst.appAuthor,
                        style: AppTextStyles.greySubStyle,
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
