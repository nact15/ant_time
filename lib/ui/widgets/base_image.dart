import 'package:ant_time_flutter/di/image_header.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:ant_time_flutter/ui/widgets/base_progress_indicator.dart';
import 'package:flutter/material.dart';

class BaseImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final Function(Widget)? builder;
  final double? height;

  const BaseImage({
    Key? key,
    required this.imageUrl,
    this.builder,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      height: height,
      fit: fit,
      headers: ImageHeaders.headers,
      loadingBuilder: (_, image, chunk) {
        return (chunk == null)
            ? (builder != null ? builder!(image) : image)
            : Container(
                height: height,
                constraints: const BoxConstraints(
                  maxWidth: 300,
                ),
                padding: const EdgeInsets.all(8.0),
                child: BaseProgressIndicator(
                  color: context.theme.primaryColor,
                ),
              );
      },
    );
  }
}
