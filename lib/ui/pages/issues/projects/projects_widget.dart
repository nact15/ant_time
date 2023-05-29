import 'package:ant_time_flutter/base_bloc/base_bloc.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/pages/issues/bloc/issues_bloc.dart';
import 'package:ant_time_flutter/ui/pages/issues/projects/bloc/projects_bloc.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsWidget extends StatefulWidget {
  ProjectsWidget({Key? key}) : super(key: key);

  @override
  State<ProjectsWidget> createState() => _ProjectsWidgetState();
}

class _ProjectsWidgetState extends State<ProjectsWidget> {
  late GlobalKey _textFieldKey;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _textFieldKey = GlobalKey();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) => hasFocus ? null : BaseDropdownForm.closeDropdown(),
      child: Padding(
        padding: const EdgeInsets.only(right: 210),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<ProjectsBloc, ProjectsState>(
              builder: (context, state) {
                return BaseTextField(
                  key: _textFieldKey,
                  controller: _controller,
                  onChanged: (value) => context.read<ProjectsBloc>().add(
                        ProjectsSearchProject(value),
                      ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      left: 22,
                      right: 8.0,
                    ),
                    child: Icon(
                      AppIcons.searchIcon,
                      size: 18,
                    ),
                  ),
                  onClearTap: _onClearTap,
                  decoration: AppDecoration.textFieldDecoration.copyWith(
                    fillColor: state.status.isData ? Colors.white : AppColors.borderColor,
                  ),
                  enabled: state.status.isData,
                  onEditingComplete: () {
                    context.read<ProjectsBloc>().add(
                          ProjectsSelectProject(state.searchingProjects?.first),
                        );
                    // todo: предложить добавить крестик
                    if (_controller.text.isEmpty) {
                      context.read<IssuesBloc>().add(IssuesFetch(
                            page: 0,
                            clearSearch: true,
                          ));
                    }
                    _controller.text = state.searchingProjects?.firstOrNull?.name ?? '';
                    BaseDropdownForm.closeDropdown();
                    FocusScope.of(context).unfocus();
                  },
                  maxLines: 1,
                  autoFocus: true,
                  hintText: state.status.getSearchProjectHint(context.localizations),
                  onTap: () {
                    if (state.status.isData) {
                      RenderBox box = _textFieldKey.currentContext?.findRenderObject() as RenderBox;
                      Offset offset = box.localToGlobal(Offset.zero); //this is global position
                      BlocProvider<ProjectsBloc>.value(
                        value: context.read<ProjectsBloc>(),
                        child: BaseDropdownForm.showProjectsDropDown(
                          context,
                          offset: offset,
                          onTap: (project) {
                            _controller.text = project.name;
                            context.read<ProjectsBloc>().add(
                                  ProjectsSelectProject(project),
                                );
                            context.read<IssuesBloc>().add(IssuesFetch(
                                  page: 0,
                                  projectId: project.id,
                                  clearSearch: true,
                                ));
                            BaseDropdownForm.closeDropdown();
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onClearTap() {
    context.read<IssuesBloc>().add(IssuesFetch(
          page: 0,
          projectId: -1,
          clearSearch: true,
        ));
    context.read<ProjectsBloc>().add(ProjectsSelectProject(null));
  }

  void _onKey(RawKeyEvent event) {
    if (event.runtimeType == RawKeyDownEvent) {
      if (event.physicalKey == PhysicalKeyboardKey.escape) {
        FocusScope.of(context).unfocus();
        BaseDropdownForm.closeDropdown();
      }
    }
  }

  void _onEditingComplete() {
    BaseDropdownForm.closeDropdown();
    FocusScope.of(context).unfocus();
  }
}
