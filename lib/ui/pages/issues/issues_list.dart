import 'package:ant_time_flutter/base_bloc/base_bloc.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/pages/issues/bloc/issues_bloc.dart';
import 'package:ant_time_flutter/ui/pages/issues/easter_egg/easter_egg_cubit.dart';
import 'package:ant_time_flutter/ui/pages/timer/issue_bloc/issue_bloc.dart';
import 'package:ant_time_flutter/ui/widgets/base_tab.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssuesList extends StatefulWidget {
  const IssuesList({Key? key}) : super(key: key);

  @override
  State<IssuesList> createState() => _IssuesListState();
}

class _IssuesListState extends State<IssuesList> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<EasterEggCubit, EasterEggState>(
      builder: (context, state) {
        return Container(
          foregroundDecoration: BoxDecoration(
            border: Border.all(color: context.theme.borderColor, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            image: (state is EasterEggBulling)
                ? const DecorationImage(
                    image: AssetImage(
                      AppAssets.bulling,
                    ),
                    opacity: 0.3,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          decoration: BoxDecoration(
            color: context.theme.cardColor,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<IssuesBloc, IssuesState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            BaseTab(
                              onTap: () => context.read<IssuesBloc>().add(IssuesFetch(
                                    clearSearch: true,
                                    typeIssues: TypeIssues.all,
                                    page: 0,
                                  )),
                              selected: state.typeIssues == TypeIssues.all,
                              text: context.localizations.tasks,
                            ),
                            const SizedBox(width: 8),
                            BaseTab(
                              onTap: () => context.read<IssuesBloc>().add(IssuesFetch(
                                    clearSearch: true,
                                    typeIssues: TypeIssues.favorites,
                                    page: 0,
                                  )),
                              selected: state.typeIssues == TypeIssues.favorites,
                              text: context.localizations.favorites,
                            ),
                            const SizedBox(width: 8),
                            BaseTab(
                              onTap: () => context.read<IssuesBloc>().add(IssuesFetch(
                                    clearSearch: true,
                                    typeIssues: TypeIssues.history,
                                    page: 0,
                                  )),
                              selected: state.typeIssues == TypeIssues.history,
                              text: context.localizations.history,
                            ),
                          ],
                        );
                      },
                    ),
                    BlocBuilder<IssuesBloc, IssuesState>(
                      builder: (context, state) {
                        return Visibility(
                          maintainState: true,
                          visible: state.typeIssues == TypeIssues.all,
                          child: SizedBox(
                            width: 250,
                            height: 40,
                            child: BaseTextField(
                              maxLines: 1,
                              onEditingComplete: () => context.read<IssuesBloc>().add(IssuesFetch(
                                    searchSubject: _searchController.text,
                                    page: 0,
                                    clearSearch: false,
                                  )),
                              suffix: Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: BaseIcon(
                                  size: 8,
                                  width: 8,
                                  height: 8,
                                  padding: EdgeInsets.zero,
                                  icon: AppIcons.cancelIcon,
                                  onTap: () {
                                    _searchController.clear();
                                    context.read<IssuesBloc>().add(IssuesFetch(
                                          page: 0,
                                          clearSearch: true,
                                        ));
                                  },
                                ),
                              ),
                              controller: _searchController,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(left: 23, right: 13),
                                child: Icon(
                                  AppIcons.searchIcon,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 75),
                        child: Text(
                          context.localizations.id.toUpperCase(),
                          style: AppTextStyles.titleRowStyle,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        context.localizations.title.toUpperCase(),
                        style: AppTextStyles.titleRowStyle,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        context.localizations.status.toUpperCase(),
                        style: AppTextStyles.titleRowStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1.5,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                constraints: const BoxConstraints(
                  minHeight: 350,
                ),
                child: BlocBuilder<IssuesBloc, IssuesState>(builder: (context, state) {
                  final status = state.status;

                  if (status is EmptyStatus) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        context.localizations.emptyTasks,
                        style: AppTextStyles.greyStyle,
                      ),
                    );
                  }

                  if (status is InitialStatus) {
                    return Container(
                      constraints: const BoxConstraints(
                        minHeight: 355,
                      ),
                      alignment: Alignment.center,
                      child: BaseProgressIndicator(
                        color: context.theme.primaryColor,
                      ),
                    );
                  }

                  if (status is ErrorStatus) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        status.errorType.getMessage(
                          context.localizations,
                        ),
                        style: AppTextStyles.greyStyle,
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.issues.length,
                    itemBuilder: (_, index) => BaseIssueCard(
                      issue: state.issues[index],
                      isDark: index.isOdd,
                      onIssueTap: (issue) => context.read<IssueBloc>().add(IssueAdd(issue)),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
