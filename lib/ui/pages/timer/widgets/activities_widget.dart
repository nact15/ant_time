import 'package:ant_time_flutter/models/value_model.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/pages/timer/activity_bloc/activity_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/bloc/timer_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/issue_bloc/issue_bloc.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivitiesWidget extends StatefulWidget {
  const ActivitiesWidget({Key? key}) : super(key: key);

  @override
  State<ActivitiesWidget> createState() => _ActivitiesWidgetState();
}

class _ActivitiesWidgetState extends State<ActivitiesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prevState, currState) => prevState.status != currState.status,
      builder: (context, timerState) {
        return BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, activityState) {
            return BaseDropdown<ValueModel>(
              disabled: timerState.status.isRunning,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              hint: activityState.status.getDropdownHint(context.localizations),
              textColor: timerState.status.isRunning ? context.theme.arrowDisabledColor : null,
              items: activityState.activities,
              value: activityState.selectedActivity,
              text: (activity) => activity.name,
              onChanged: timerState.status.isRunning
                  ? null
                  : (activity) {
                      if (activity != null) {
                        context.read<TimerBloc>().add(TimerRestart());
                        context.read<ActivityBloc>().add(ActivitySelectActivity(activity));
                        context.read<IssueBloc>().add(IssueSetActivity(activity));
                      }
                    },
            );
          },
        );
      },
    );
  }
}
