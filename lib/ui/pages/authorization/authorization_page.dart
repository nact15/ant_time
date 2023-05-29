import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/navigation/app_router.dart';
import 'package:ant_time_flutter/ui/pages/authorization/bloc/authorization_bloc.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showLogOutButton: false,
      body: BlocConsumer<AuthorizationBloc, AuthorizationState>(
        listener: _authorizationListener,
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //padding: const EdgeInsets.symmetric(horizontal: 144),
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 30),
                      child: Text(
                        context.localizations.authorization,
                        style: AppTextStyles.titleStyle,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 800,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 5,
                            left: 70,
                          ),
                          child: Text(
                            context.localizations.apiKey,
                            style: AppTextStyles.greyStyle.copyWith(
                              color: state.status.isValidationError ? AppColors.errorColor : null,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: BaseTextField(
                            controller: _controller,
                            hintText: AppConst.appKeyHint,
                            maxLines: 1,
                            maxLength: 50,
                            autoFocus: true,
                            errorText: state.status.isValidationError
                                ? context.localizations.emptyApiKey
                                : null,
                            onEditingComplete: _authorize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 50,
                      horizontal: 144,
                    ),
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: BaseButton(
                          width: 260,
                          onTap: _authorize,
                          loading: state.status.isLoading,
                          child: Text(
                            context.localizations.login,
                            style: AppTextStyles.buttonStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _authorize() {
    // context.unfocus();
    context.read<AuthorizationBloc>().add(
          AuthorizationEvent(_controller.text),
        );
  }

  void _authorizationListener(BuildContext context, AuthorizationState state) {
    if (state.status.isSuccess) {
      AppRouter.pushToIssues(context);
    }
    if (state.status.isError) {
      BaseMessenger.showBaseMessenger(
        context,
        message: state.errorTitle ?? context.localizations.errorSomethingWentWrong,
        typeMessage: TypeMessage.error,
      );
    }
  }
}
