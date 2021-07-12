import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/constants/common_size.dart';

class RoundedAvatar extends StatelessWidget {
  final double size;
  const RoundedAvatar({
    Key? key,
    required this.index, this.size = avatar_size,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: "https://picsum.photos/id/$index/100",
        width: this.size,
        height: this.size,
      ),
    );
  }
}