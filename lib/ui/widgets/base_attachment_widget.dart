import 'package:ant_time_flutter/models/attachment_model.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

class BaseAttachmentWidget extends StatelessWidget {
  final AttachmentModel attachment;

  const BaseAttachmentWidget({
    Key? key,
    required this.attachment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 180,
        ),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: context.theme.backgroundColor,
          ),
          child: InkWell(
            onTap: () => launch(attachment.contentUrl),
            customBorder: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            hoverColor: context.theme.hoverColor,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      _attachmentIcon,
                      size: 14,
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Text(
                      attachment.filename,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData get _attachmentIcon {
    switch (attachment.contentType) {
      case FileType.video:
        return AppIcons.videoIcon;

      case FileType.txt:
        return AppIcons.textIcon;

      default:
        return AppIcons.attachmentIcon;
    }
  }
}
