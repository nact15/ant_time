import 'package:ant_time_flutter/base_bloc/base_bloc.dart';
import 'package:ant_time_flutter/models/issue_model.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/pages/issues/projects/projects_widget.dart';
import 'package:ant_time_flutter/ui/pages/timer/issue_bloc/issue_bloc.dart';
import 'package:ant_time_flutter/ui/pages/timer/widgets/activities_widget.dart';
import 'package:ant_time_flutter/ui/pages/timer/widgets/issue_information_widget.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssueWidget extends StatefulWidget {
  final IssueModel issue;

  const IssueWidget({
    Key? key,
    required this.issue,
  }) : super(key: key);

  @override
  State<IssueWidget> createState() => _IssueWidgetState();
}

class _IssueWidgetState extends State<IssueWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<IssueBloc, IssueState>(
      listener: _issueListener,
      child: SingleChildScrollView(
        child: Container(
          color: context.theme.backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 40,
                ),
                child: Text(
                  context.localizations.kindOfActivity,
                  style: AppTextStyles.greyStyle,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: ActivitiesWidget(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: IssueInformationWidget(issue: widget.issue),
              ),
              const SizedBox(height: 20),
              // TODO
              // Padding(
              //   padding: const EdgeInsets.only(left: 40, top: 20),
              //   child: Text(
              //     context.localizations.commentary,
              //     style: AppTextStyles.issueCommentaryStyle,
              //   ),
              // ),
              // CommentaryWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void _issueListener(BuildContext context, IssueState state) {
    final status = state.status;
    if (status is SnowNotificationStatus) {
      BaseMessenger.showBaseMessenger(
        context,
        message: status.message,
        typeMessage: TypeMessage.success,
      );
    }
    if (status is ErrorStatus) {
      BaseMessenger.showErrorMessage(
        context,
        errorType: status.errorType,
      );
    }
  }
}
