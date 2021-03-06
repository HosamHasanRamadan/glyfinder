import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:jovial_svg/jovial_svg.dart';

import '../../data/font_icon.dart';

typedef _OnLike = void Function(bool);

typedef _OnDownload = void Function();

class IconTile extends StatelessWidget {
  final FontIcon fontIcon;
  final bool isLiked;
  final _OnDownload onDownload;
  final _OnLike onLike;
  const IconTile({
    required this.fontIcon,
    required this.isLiked,
    required this.onDownload,
    required this.onLike,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: GestureDetector(
            onTap: () => onLike(isLiked),
            child: Icon(
              Icons.favorite,
              color: isLiked ? Colors.red : Colors.black,
            ),
          ),
        ),
        GestureDetector(
          onTap: onDownload,
          child: const Align(
            alignment: AlignmentDirectional.topStart,
            child: Icon(Icons.download),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: ScalableImageWidget.fromSISource(
                    scale: 1,
                    si: ScalableImageSource.fromSvgHttpUrl(fontIcon.svgUrl),
                  ),
                ),
                Text(
                  fontIcon.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Gap(5),
                Text(fontIcon.fontFamily),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
