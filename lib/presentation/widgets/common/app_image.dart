import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/presentation/widgets/common/custom_loading.dart';

class AppImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final String errorAsset;

  const AppImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorAsset = Assets.iconCoffeeCup,
  });

  bool get _isNetwork =>
      imageUrl != null &&
          imageUrl!.isNotEmpty &&
          (imageUrl!.startsWith('http://') || imageUrl!.startsWith('https://'));

  @override
  Widget build(BuildContext context) {
    final imageWidget = _isNetwork
        ? CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      fit: fit,

      /// 🔥 Placeholder dùng NeonLoading
      placeholder: (_, __) => SizedBox(
        width: width,
        height: height,
        child: Center(
          child: NeonLoading(),
        ),
      ),

      /// ❌ Error → fallback ảnh local
      errorWidget: (_, __, ___) =>
          Image.asset(errorAsset, width: width, height: height, fit: fit),
    )
        : Image.asset(
      imageUrl ?? errorAsset,
      width: width,
      height: height,
      fit: fit,
    );

    if (borderRadius == null) return imageWidget;

    return ClipRRect(
      borderRadius: borderRadius!,
      child: imageWidget,
    );
  }

  /// Tự scale NeonLoading cho đẹp
  double get _loadingSize => (width < height ? width : height) * 0.45;
}
