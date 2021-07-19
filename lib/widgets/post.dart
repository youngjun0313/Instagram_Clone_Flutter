import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/constants/common_size.dart';
import 'package:instagram_clone_flutter/constants/screen_size.dart';
import 'package:instagram_clone_flutter/widgets/comment.dart';
import 'package:instagram_clone_flutter/widgets/my_progress_indicator.dart';
import 'package:instagram_clone_flutter/widgets/rounded_avatar.dart';

class Post extends StatelessWidget {
  final int index;

  Post(this.index, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // to cache image, use CacheNetworkImage
    // Otherwise download image everytime when we change the screen
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(size),
        _postActions(),
        _postLikes(),
        _postCaption(),
      ],
    );
  }

  Widget _postCaption() {
    // 하나의 Text 안에 여러가지의 텍스트 스타일을 가지게 하기 위해 RichText 를 이용
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap, vertical: common_xxs_gap),
      child: Comment(index: index, showImage: true, username: "YoungJun", text: "Hello", dateTime: DateTime.now(),),
    );
  }

  Padding _postLikes() {
    return Padding(
        padding: const EdgeInsets.only(left: common_gap),
        child: Text("13 Likes", style: TextStyle(fontWeight: FontWeight.bold),),
      );
  }

  Row _postActions() {
    return Row(
        children: [
          IconButton(
            onPressed: null,
            icon: ImageIcon(AssetImage('assets/images/bookmark.png')),
            color: Colors.black87,
          ),
          IconButton(
            onPressed: null,
            icon: ImageIcon(AssetImage('assets/images/comment.png')),
            color: Colors.black87,
          ),
          IconButton(
            onPressed: null,
            icon: ImageIcon(AssetImage('assets/images/direct_message.png')),
            color: Colors.black87,
          ),
          // 이 사이의 공간을 spacer 가 차지하게 된다.
          Spacer(),
          IconButton(
            onPressed: null,
            icon: ImageIcon(AssetImage('assets/images/heart_selected.png')),
            color: Colors.black87,
          ),

        ],
      );
  }

  Widget _postHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(index: index),
        ),
        // Expanded 를 이용하여 Text 가 나머지 두개가 아닌 부분을 모두 차지하도록 한다.
        Expanded(child: Text("user name")),
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          )
        )
      ],
    );
  }

  CachedNetworkImage _postImage(Size size) {
    return CachedNetworkImage(
        imageUrl: "https://picsum.photos/id/$index/2000/2000",
        placeholder: (BuildContext context, String url) {
          return MyProgressIndicator(containerSize: size.width,);
        },
        // get image from imageURL and put in to imageProvider
        imageBuilder: (BuildContext context, ImageProvider imageProvider) {
          return AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            )
          );
        },
      );
  }
}