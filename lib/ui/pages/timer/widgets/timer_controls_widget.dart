import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/pages/timer/activity_bloc/activity_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/bloc/timer_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/issue_bloc/issue_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/widgets/player_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerControlsWidget extends StatelessWidget {
  const TimerControlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, timerState) {
        return BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, activityState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlayerIcon(
                  icon: AppIcons.playIcon,
                  disabled: timerState.status.isRunning || activityState.status.notSelected,
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                    left: 18,
                    right: 14,
                  ),
                  callBack: () => context.read<TimerBloc>().add(TimerStart()),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: PlayerIcon(
                    icon: AppIcons.stopIcon,
                    disabled: !timerState.status.isRunning || activityState.status.notSelected,
                    padding: const EdgeInsets.all(15),
                    callBack: () {
                      context.read<TimerBloc>().add(TimerPause());
                      context.read<IssueBloc>().add(IssuePushTime(timerState.duration));
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
