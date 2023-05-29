import 'package:ant_time_flutter/models/project_model.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/pages/issues/projects/bloc/projects_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseDropdownForm {
  const BaseDropdownForm._();

  static OverlayEntry? _overlayEntry;
  static bool _isOpen = false;

  static Future<void> closeDropdown() async {
    await Future.delayed(const Duration(milliseconds: 250));
    if (_overlayEntry != null && (_overlayEntry?.mounted ?? false)) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    _isOpen = false;
  }

  static showProjectsDropDown(
    BuildContext context, {
    required Offset offset,
    required Function(ProjectModel) onTap,
  }) {
    _overlayEntry = OverlayEntry(
      builder: (_) {
        return Positioned(
          top: offset.dy + 60,
          left: offset.dx,
          right: offset.dx + 210,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 350,
              maxWidth: 1000,
            ),
            child: Material(
              elevation: 5,
              color: context.theme.backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: BlocBuilder<ProjectsBloc, ProjectsState>(
                bloc: context.read<ProjectsBloc>(),
                builder: (_, state) {
                  if ((state.searchingProjects ?? state.projects).isNotEmpty) {
                    return FocusScope(
                      node: FocusScopeNode(),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: 350,
                            minHeight: 30,
                            maxWidth: 1000,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          width: context.screenSize.width,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: (state.searchingProjects ?? state.projects).length,
                              itemBuilder: (_, index) => _buildItem(
                                context,
                                project: (state.searchingProjects ?? state.projects)[index],
                                onTap: onTap,
                                selected: state.selectedProject ==
                                    (state.searchingProjects ?? state.projects)[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
        );
      },
    );
    if (!_isOpen) {
      Overlay.of(context)?.insert(_overlayEntry!);
      _isOpen = true;
    }
  }

  static Widget _buildItem(
    BuildContext context, {
    required ProjectModel project,
    required Function(ProjectModel) onTap,
    bool selected = false,
  }) {
    return InkWell(
      hoverColor: context.theme.hoverColor,
      focusColor: context.theme.hoverColor,
      onTap: () => onTap(project),
      child: Container(
        height: 50,
        color: selected ? context.theme.switcherCheckedColor : null,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8),
        child: Text(
          project.name,
          style: AppTextStyles.dropdownStyle,
        ),
      ),
    );
  }
}
