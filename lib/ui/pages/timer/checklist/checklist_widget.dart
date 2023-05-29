import 'package:ant_time_flutter/ui/pages/timer/checklist/bloc/checklist_bloc.dart';
import 'package:ant_time_flutter/ui/widgets/base_checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChecklistWidget extends StatelessWidget {
  const ChecklistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistBloc, ChecklistState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.checklists
                .map(
                  (checklist) => BaseCheckbox(
                    initialValue: checklist.isDone,
                    title: checklist.subject,
                    onTap: (isDone) {
                      context.read<ChecklistBloc>().add(
                            ChecklistUpdate(checklist..isDone = isDone),
                          );
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
