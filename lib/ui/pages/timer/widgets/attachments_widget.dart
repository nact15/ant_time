import 'package:ant_time_flutter/extensions/iterable_extension.dart';
import 'package:ant_time_flutter/models/attachment_model.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/navigation/app_router.dart';
import 'package:ant_time_flutter/ui/widgets/base_attachment_widget.dart';
import 'package:ant_time_flutter/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AttachmentsWidget extends StatefulWidget {
  final List<AttachmentModel> attachments;

  const AttachmentsWidget({
    Key? key,
    required this.attachments,
  }) : super(key: key);

  @override
  State<AttachmentsWidget> createState() => _AttachmentsWidgetState();
}

class _AttachmentsWidgetState extends State<AttachmentsWidget> {
  bool _isVisible = false;
  late List<AttachmentModel> _attachments;

  @override
  void initState() {
    _attachments = widget.attachments
      ..sort(
        (a, _) => a.contentType.isImage ? 1 : 0,
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isVisible = !_isVisible),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        color: context.theme.secondaryDarkColor,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () => setState(() => _isVisible = !_isVisible),
                child: Row(
                  children: [
                    Text(
                      context.localizations.attachments,
                      style: AppTextStyles.greyStyle,
                    ),
                    const SizedBox(width: 11),
                    Icon(
                      _isVisible ? AppIcons.arrowUpIcon : AppIcons.arrowDownIcon,
                      color: AppColors.greyTextColor,
                      size: 8,
                    ),
                  ],
                ),
              ),
              if (_isVisible)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        runSpacing: 10,
                        spacing: 15,
                        children: _attachments
                            .where((attachment) => !attachment.contentType.isImage)
                            .map((attachment) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: BaseAttachmentWidget(
                              attachment: attachment,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        runSpacing: 20,
                        spacing: 20,
                        children: _attachments
                            .where((attachment) => attachment.contentType.isImage)
                            .map((attachment) {
                          return BaseImage(
                            fit: BoxFit.cover,
                            builder: (image) => InkWell(
                              onTap: () => AppRouter.pushToFullImage(
                                context,
                                imageUrl: attachment.contentUrl,
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 250,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5.0,
                                      offset: const Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: image,
                                ),
                              ),
                            ),
                            imageUrl: attachment.contentUrl,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
