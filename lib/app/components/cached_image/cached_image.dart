import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/utils/utils.dart';

/////////////////////////////////////////////////////////////////////////
///
/// All rights reserved.
///
/// author: Spicely
///
/// Summary: 缓存图片组件
///
/// Date: 2024年12月17日 11:19:56 Tuesday
///
//////////////////////////////////////////////////////////////////////////

Widget _errorBuilder(BuildContext context, String url, Object error, {double? width, double? height}) => SizedBox(
      width: width,
      height: height,
      child: const Center(
        child: Icon(Icons.error),
      ),
    );

Widget _cachePlaceholder(BuildContext context, String url, {double? width, double? height}) => Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Container(width: width, height: height, color: Colors.grey),
    );

class CachedConfig {
  final Widget Function(BuildContext context, String url, Object error, {double? width, double? height}) errorBuilder;

  /// 占位图
  final Widget Function(BuildContext context, String url, {double? width, double? height}) placeholder;

  const CachedConfig({
    this.errorBuilder = _errorBuilder,
    this.placeholder = _cachePlaceholder,
  });
}

class CachedImage extends StatelessWidget {
  final String? imageUrl;

  final String? assetUrl;

  final File? file;

  final double? width;

  final double? height;

  final double circular;

  final BoxFit? fit;

  final Color? imageColor;

  /// 内存图片
  final Uint8List? memory;

  final CachedConfig? config;

  final String? package;

  final FilterQuality filterQuality;

  const CachedImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.circular = 0,
    this.fit,
    this.assetUrl,
    this.imageColor,
    this.file,
    this.config,
    this.package,
    this.memory,
    this.filterQuality = FilterQuality.low,
  });

  @override
  Widget build(BuildContext context) {
    if (file != null) {
      if (width != null && height != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(circular),
          child: Image(
            image: FileImage(File(file!.path), scale: 2.0),
            fit: fit,
            color: imageColor,
            filterQuality: filterQuality,
            width: width,
            height: height,
          ),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(circular),
          child: Image(
            image: FileImage(File(file!.path)),
            fit: fit,
            color: imageColor,
            filterQuality: filterQuality,
            width: width,
            height: height,
          ),
        );
      }
    }

    if (utils.tools.isNotEmpty(assetUrl)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(circular),
        child: Image(
          image: AssetImage(assetUrl!, package: package),
          fit: fit,
          color: imageColor,
          filterQuality: filterQuality,
          width: width,
          height: height,
        ),
      );
    }

    if (memory != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(circular),
        child: Image(
          image: MemoryImage(memory!),
          fit: fit,
          color: imageColor,
          filterQuality: filterQuality,
          width: width,
          height: height,
        ),
      );
    }
    if (utils.tools.isNotEmpty(imageUrl)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(circular),
        child: CachedNetworkImage(
          width: width,
          height: height,
          imageUrl: imageUrl!,
          filterQuality: filterQuality,
          fit: fit,
          placeholder: (BuildContext context, String url) => config?.placeholder(context, url, width: width, height: height) ?? _cachePlaceholder(context, url, width: width, height: height),
          errorWidget: (BuildContext context, String url, Object error) => config?.errorBuilder(context, url, error, width: width, height: height) ?? _errorBuilder(context, url, error, width: width, height: height),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(circular),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade100,
        child: Container(width: width, height: height, color: Colors.grey),
      ),
    );
  }
}
