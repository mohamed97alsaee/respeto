import 'package:flutter/material.dart';
import 'package:respeto/helpers/consts.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget(
      {Key? key,
      this.width,
      this.height,
      this.child,
      this.radius = 8,
      this.horizontalPading = 0,
      this.verticalPading = 0})
      : super(key: key);
  final double? width;
  final double? height;
  final Widget? child;
  final double radius;
  final double horizontalPading;
  final double verticalPading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPading, vertical: verticalPading),
      child: Shimmer.fromColors(
          baseColor: primaryColor.withOpacity(0.5),
          highlightColor: Colors.white.withOpacity(0.5),
          enabled: true,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 0.5),
                color: Colors.white10,
                borderRadius: BorderRadius.circular(radius)),
            width: width,
            height: height,
            child: child,
          )),
    );
  }
}
