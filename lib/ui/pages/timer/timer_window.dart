import 'package:ant_time_flutter/ui/pages/timer/issue_bloc/issue_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/widgets/issue_widget.dart';
import 'package:ant_time_flutter/ui/pages/timer/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerWindow extends StatefulWidget {
  const TimerWindow({Key? key}) : super(key: key);

  @override
  _TimerWindowState createState() => _TimerWindowState();
}

class _TimerWindowState extends State<TimerWindow> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      scrollable: false,
      clipBehavior: Clip.antiAlias,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: TimerWidget(),
      content: BlocBuilder<IssueBloc, IssueState>(
        builder: (context, state) {
          if (state.issue != null) {
            return ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 450,
                maxWidth: 1000,
              ),
              child: IssueWidget(issue: state.issue!),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
