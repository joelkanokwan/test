import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:joelfindtechnician/widgets/show_image.dart';
import 'package:joelfindtechnician/widgets/show_progress.dart';

class ShowImageNetWork extends StatelessWidget {
  final String urlPath;
  final double? width;
  final Function() tapFunc;
  const ShowImageNetWork({
    Key? key,
    required this.urlPath,
    this.width,
    required this.tapFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 200,
      child: InkWell(
        onTap: tapFunc,
        
        child: CachedNetworkImage(
          imageUrl: urlPath,
          placeholder: (context, url) => Center(
            child: ShowProgress(),
          ),
          errorWidget: (context, url, error) => SizedBox(),
        ),
      ),
    );
  }
}
