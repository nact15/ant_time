import 'dart:convert';

import 'package:ant_time_flutter/base_bloc/base_bloc.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/pages/timer/issue_bloc/issue_bloc.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchIssueWidget extends StatefulWidget {
  final ConfettiController easterController;

  const SearchIssueWidget({
    Key? key,
    required this.easterController,
  }) : super(key: key);

  @override
  State<SearchIssueWidget> createState() => _SearchIssueWidgetState();
}

class _SearchIssueWidgetState extends State<SearchIssueWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 20,),
          child: Text(
            context.localizations.pushingByTaskId,
            style: AppTextStyles.greyStyle,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 48,
                margin: const EdgeInsets.only(right: 20),
                child: BaseTextField(
                  controller: _controller,
                  maxLines: 1,
                  onEditingComplete: _searchTask,
                  hintText: context.localizations.taskId,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
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
                ),
              ),
            ),
            BlocBuilder<IssueBloc, IssueState>(
              builder: (context, state) {
                return BaseButton(
                  onTap: _searchTask,
                  width: 190,
                  child: state.status.isLoading
                      ? const BaseProgressIndicator()
                      : Text(
                          context.localizations.find,
                          style: AppTextStyles.buttonStyle,
                        ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  void _searchTask() {
    if (base64.encode(utf8.encode(_controller.text)) == AppConst.easterEgg) {
      widget.easterController.play();
    } else if (_controller.text.isNotEmpty) {
      context.read<IssueBloc>().add(IssueFindById(
            _controller.text,
          ));
    }
  }
}
