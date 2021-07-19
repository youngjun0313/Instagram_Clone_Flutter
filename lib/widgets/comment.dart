import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/constants/common_size.dart';
import 'package:instagram_clone_flutter/widgets/rounded_avatar.dart';

class Comment extends StatelessWidget {
  // 나중에 사진만 없는 comment 위젯을 사용하기 위한 변수 설정
  final bool showImage;
  final String username;
  final String text;
  final DateTime dateTime;

  const Comment({
    Key? key,
    required this.index,
    this.showImage = true,
    required this.username,
    required this.text,
    required this.dateTime,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(showImage)
          RoundedAvatar(index: index, size: 24),
        if(showImage)
          SizedBox(width: common_xxs_gap,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                        text: this.username,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      TextSpan(text: "  "),
                      TextSpan(
                        text: this.text,
                        style: TextStyle(color: Colors.black87),
                      ),
                    ]
                )
            ),
            Text(
              dateTime.toIso8601String(),
              style: TextStyle(color: Colors.grey[400], fontSize: 10,),
            )
          ],
        ),
      ],
    );
  }
}