import 'dart:io';

import 'package:ant_time_flutter/base_bloc/base_bloc.dart';
import 'package:ant_time_flutter/helpers/easter_egg.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/navigation/app_router.dart';
import 'package:ant_time_flutter/ui/pages/issues/bloc/issues_bloc.dart';
import 'package:ant_time_flutter/ui/pages/issues/easter_egg/easter_egg_cubit.dart';
import 'package:ant_time_flutter/ui/pages/issues/issues_list.dart';
import 'package:ant_time_flutter/ui/pages/issues/projects/bloc/projects_bloc.dart';
import 'package:ant_time_flutter/ui/pages/issues/projects/projects_widget.dart';
import 'package:ant_time_flutter/ui/pages/issues/widgets/search_issue_widget.dart';
import 'package:ant_time_flutter/ui/pages/settings/settings_widget.dart';
import 'package:ant_time_flutter/ui/pages/timer/issue_bloc/issue_bloc.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ant_time_flutter/ui/pages/timer/activity_bloc/activity_bloc.dart';

class IssuesPage extends StatefulWidget {
  const IssuesPage({Key? key}) : super(key: key);

  @override
  _IssuesPageState createState() => _IssuesPageState();
}

class _IssuesPageState extends State<IssuesPage> {
  late ConfettiController _controller;
  late ScrollController _scrollController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    _controller = ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        if (Platform.isMacOS)
          const SingleActivator(LogicalKeyboardKey.keyR, meta: true): _refreshScreen
        else
          const SingleActivator(LogicalKeyboardKey.keyR, control: true): _refreshScreen,
      },
      child: RawKeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKey: _onKey,
        child: MultiBlocListener(
          listeners: [
            BlocListener<EasterEggCubit, EasterEggState>(
              listener: _easterEggListener,
            ),
            BlocListener<IssueBloc, IssueState>(
              listener: _issuesListener,
            ),
          ],
          child: GestureDetector(
            onTap: () => _focusNode.requestFocus(),
            child: BaseScaffold(
              body: _buildBody(),
              drawer: Platform.isMacOS ? null : (const SettingsWidget()),
              endDrawer: Platform.isMacOS ? (const SettingsWidget()) : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        EasterEgg(controller: _controller),
        Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: Align(
            alignment: Alignment.center,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(50),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1000,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchIssueWidget(easterController: _controller),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                        ),
                        child: Text(
                          context.localizations.selectProject,
                          style: AppTextStyles.greyStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: context.screenSize.width - 70,
                          child: ProjectsWidget(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: IssuesList(),
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<IssuesBloc, IssuesState>(
                        builder: (context, state) {
                          if (!state.lastPage && state.status != InitialStatus()) {
                            return Center(
                              child: BaseButton(
                                onTap: () => context.read<IssuesBloc>().add(
                                      IssuesFetch(clearSearch: false),
                                    ),
                                height: 45,
                                width: 150,
                                color: context.theme.cardColor,
                                child: Text(
                                  context.localizations.loadMore,
                                  style: AppTextStyles.textButton.copyWith(
                                    color: context.theme.reversedColor,
                                  ),
                                ),
                                disabled: (state.status == LoadingStatus()),
                              ),
                            );
                          }

                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _refreshScreen() {
    context.read<IssuesBloc>().add(IssuesFetch(page: 0, clearSearch: true));
    context.read<ProjectsBloc>().add(ProjectsFetch());
    context.read<ActivityBloc>().add(ActivityFetchActivities());
  }

  void _issuesListener(BuildContext context, IssueState state) {
    final status = state.status;
    if (status is ErrorStatus) {
      BaseMessenger.showErrorMessage(
        context,
        errorType: status.errorType,
      );
    }

    if (status is SnowNotificationStatus) {
      BaseMessenger.showBaseMessenger(
        context,
        message: status.message,
        typeMessage: TypeMessage.success,
      );
    }

    if (state.status.isData) {
      if (state.issue != null) {
        AppRouter.pushToTimer(
          context,
          issueId: state.issue!.id,
        );
      }
    }
  }

  void _easterEggListener(_, EasterEggState state) {
    if (state is EasterEggPlay) {
      _controller.play();
    }
  }

  void _onKey(RawKeyEvent event) {
    if (event.runtimeType == RawKeyDownEvent) {
      if (event.physicalKey == PhysicalKeyboardKey.f5) {
        _refreshScreen();
      }
    }
  }
}
