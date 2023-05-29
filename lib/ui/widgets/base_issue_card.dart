import 'package:ant_time_flutter/models/issue_model.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/pages/issues/bloc/issues_bloc.dart';
import 'package:ant_time_flutter/ui/widgets/base_hovered_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'base_icon.dart';

class BaseIssueCard extends StatelessWidget {
  final IssueModel issue;
  final bool isDark;
  final Function(IssueModel) onIssueTap;

  const BaseIssueCard({
    Key? key,
    required this.issue,
    required this.isDark,
    required this.onIssueTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: isDark ? context.theme.backgroundColor : context.theme.cardColor,
        ),
        child: InkWell(
          onTap: () => onIssueTap(issue),
          splashColor: AppColors.hoverColor,
          hoverColor: context.theme.hoverColor,
          // highlightColor: AppColors.hoverColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        BaseHoveredWidget(
                          onTap: () => context.read<IssuesBloc>().add(IssuesChangeFavorite(issue)),
                          svgIcon: issue.favorite ? AppAssets.starIcon : AppAssets.emptyStarIcon,
                          width: 18,
                          height: 18,
                          color: issue.favorite
                              ? context.theme.primaryColor
                              : context.theme.switcherCheckedColor,
                        ),
                        const SizedBox(width: 17),
                        Text(
                          '${issue.id}',
                          style: context.theme.textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        issue.project.name,
                        textAlign: TextAlign.left,
                        style: context.theme.textTheme.headline4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 5),
                        child: Text(
                          issue.subject,
                          style: AppTextStyles.descriptionIssueStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    issue.status.name,
                    style: context.theme.textTheme.headline5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
