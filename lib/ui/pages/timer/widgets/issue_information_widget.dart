import 'package:ant_time_flutter/models/issue_model.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/pages/timer/checklist/checklist_widget.dart';
import 'package:ant_time_flutter/ui/pages/timer/widgets/attachments_widget.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class IssueInformationWidget extends StatefulWidget {
  final IssueModel issue;

  const IssueInformationWidget({Key? key, required this.issue}) : super(key: key);

  @override
  State<IssueInformationWidget> createState() => _IssueInformationWidgetState();
}

class _IssueInformationWidgetState extends State<IssueInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: Text(
              widget.issue.subject,
              style: AppTextStyles.issueSubjectStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 20),
            child: Row(
              children: [
                BaseLink(
                  link: '${AppConst.issuesLink}${widget.issue.id}',
                  text: '#${widget.issue.id}',
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.issue.author.name,
                    style: AppTextStyles.issueAuthorStyle,
                  ),
                ),
              ],
            ),
          ),
          if (widget.issue.attachments.isNotEmpty)
            AttachmentsWidget(
              attachments: widget.issue.attachments,
            ),
          if (widget.issue.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 17,
              ),
              child: MarkdownBody(
                data: widget.issue.description,
                listItemCrossAxisAlignment: MarkdownListItemCrossAxisAlignment.start,
                shrinkWrap: true,
                softLineBreak: true,
                selectable: true,
                onTapLink: _onTapLink,
                styleSheet: MarkdownStyleSheet.fromTheme(
                  Theme.of(context).copyWith(
                    textTheme: TextTheme(
                      bodyText2: AppTextStyles.issueDescriptionStyle,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 20),
          const ChecklistWidget(),
        ],
      ),
    );
  }

  void _onTapLink(_, String? url, __) {
    if (url != null) {
      launch(url);
    }
  }
}
