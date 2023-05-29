import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/pages/issues/bloc/issues_bloc.dart';
import 'package:ant_time_flutter/ui/pages/issues/easter_egg/easter_egg_cubit.dart';
import 'package:ant_time_flutter/ui/pages/timer/activity_bloc/activity_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/bloc/timer_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/issue_bloc/issue_bloc.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CloseIssueWidget extends StatefulWidget {
  const CloseIssueWidget({Key? key}) : super(key: key);

  @override
  State<CloseIssueWidget> createState() => _CloseIssueWidgetState();
}

class _CloseIssueWidgetState extends State<CloseIssueWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20),
        child: Material(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Ink(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            width: 30,
            height: 30,
            child: BlocBuilder<IssueBloc, IssueState>(
              builder: (context, issueState) {
                return BlocBuilder<TimerBloc, TimerState>(
                  builder: (context, state) {
                    return BaseTooltip(
                      message: context.localizations.close,
                      child: InkWell(
                        customBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        onHover: (hovered) => setState(() => _hovered = hovered),
                        hoverColor: AppColors.greyButtonHoverColor,
                        splashColor: AppColors.hoverColor,
                        onTap: () {
                          context.read<IssueBloc>().add(IssuePushTime(state.duration));
                          context.read<IssueBloc>().add(IssueClearData());
                          context.read<TimerBloc>().close();
                          context.read<ActivityBloc>().add(ActivityClear());
                          context.read<EasterEggCubit>().playEasterEgg(state.duration);
                          context.read<IssuesBloc>().add(IssuesFetch(clearSearch: false, page: 0));
                          context.read<IssuesBloc>().add(IssuesAddHistory(issueState.issue));
                          context.popUntil((route) => route.isFirst);
                        },
                        child: Center(
                          child: Icon(
                            AppIcons.cancelIcon,
                            color: _hovered ? AppColors.primaryColor : AppColors.baseColor,
                            size: 18,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
