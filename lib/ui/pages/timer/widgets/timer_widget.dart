import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/pages/timer/activity_bloc/activity_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/bloc/timer_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/widgets/close_issue_widget.dart';
import 'package:ant_time_flutter/ui/pages/timer/widgets/timer_controls_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:ant_time_flutter/ui/pages/issues/bloc/issues_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/issue_bloc/issue_bloc.dart';

class TimerWidget extends StatelessWidget {
  TimerWidget({Key? key}) : super(key: key);

  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.baseColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const SizedBox(width: 23),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: BlocBuilder<IssueBloc, IssueState>(
                  builder: (context, state) {
                    return StatefulBuilder(
                      builder: (_, setState) {
                        return BaseHoveredWidget(
                          onTap: () {
                            context.read<IssuesBloc>().add(IssuesChangeFavorite(state.issue!));
                            setState(() => _isFavorite = !_isFavorite);
                          },
                          svgIcon: ((state.issue?.favorite ?? false) || _isFavorite)
                              ? AppAssets.starIcon
                              : AppAssets.emptyStarIcon,
                          width: 23,
                          height: 23,
                          color: (state.issue?.favorite ?? false)
                              ? context.theme.primaryColor
                              : context.theme.switcherCheckedColor,
                        );
                      },
                    );
                  },
                ),
              ),
              const Spacer(),
              const CloseIssueWidget(),
            ],
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(22),
            child: BlocBuilder<TimerBloc, TimerState>(
              builder: (context, state) {
                return Text(
                  state.duration.formatDuration,
                  style: AppTextStyles.timerStyle.copyWith(
                    color: state.status.isRunning ? Colors.white : null,
                    fontSize: context.calculateTimerFontSize,
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 22),
            child: TimerControlsWidget(),
          ),
          BlocBuilder<ActivityBloc, ActivityState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 30,
                  child: (state.status.notSelected)
                      ? Center(
                          child: Text(
                            context.localizations.selectActivity,
                            style: AppTextStyles.greySubStyle,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : const SizedBox(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
