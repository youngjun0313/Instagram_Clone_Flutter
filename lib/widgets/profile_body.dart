import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/constants/common_size.dart';
import 'package:instagram_clone_flutter/constants/screen_size.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  SelectedTap _selectedTap = SelectedTap.left;
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = size.width;

  @override
  Widget build(BuildContext context) {
    // 스크롤 안에서 리스트, 그리드 등의 여러가지 스크롤을 이용하기 위해서 Custom Scroll View 를 이용한다.
    // Expanded 로 감싸주어야지 보인다.
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
                _username(),
                _userBio(),
                _editProfileBtn(),
                _tapButtons(),
                _selectedIndicator(),
              ])
          ),
          // Sliver List 안에 일반적인 위젯을 사용하기 위해서는  SliverToBoxAdapter 를 사용해야한다.
          // shrinkWrap 을 사용하여 불필요한 공간을 사요요하지 않는다.
          _imagesPager()
        ],
      ),
    );
  }

  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
          child: Stack(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                transform: Matrix4.translationValues(_leftImagesPageMargin, 0, 0),
                curve: Curves.fastOutSlowIn,
                child: _images(),
              ), AnimatedContainer(
                duration: Duration(milliseconds: 300),
                transform: Matrix4.translationValues(_rightImagesPageMargin, 0, 0),
                curve: Curves.fastOutSlowIn,
                child: _images(),
              ),
            ],
          )
        );
  }

  GridView _images() {
    return GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                childAspectRatio: 1,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                    30,
                    (index) => CachedNetworkImage(
                      imageUrl: "https://picsum.photos/id/$index/100/100",
                      fit: BoxFit.cover,
                    )
                ),
              );
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      alignment: _selectedTap == SelectedTap.left? Alignment.centerLeft: Alignment.centerRight,
      child: Container(
        height: 3,
        width: size.width/2,
        color: Colors.black87,
      ),
      curve: Curves.fastOutSlowIn,
    );
  }

  Row _tapButtons() {
    return Row(
      children: [
        Expanded(
          child: IconButton(
              onPressed: (){
                setState(() {
                  _selectedTap = SelectedTap.left;
                  _leftImagesPageMargin = 0;
                  _rightImagesPageMargin = size.width;
                });
              },
              icon: ImageIcon(
                AssetImage("assets/images/grid.png"),
                color: _selectedTap == SelectedTap.left? Colors.black: Colors.black26,
              )
          ),
        ),
        Expanded(
          child: IconButton(
              onPressed: (){
                setState(() {
                  _selectedTap = SelectedTap.right;
                  _leftImagesPageMargin = -size.width;
                  _rightImagesPageMargin = 0;
                });
              },
              icon: ImageIcon(
                AssetImage("assets/images/saved.png"),
                color: !(_selectedTap == SelectedTap.left)? Colors.black: Colors.black26,
              )
          ),
        ),
      ],
    );
  }
}

Padding _editProfileBtn() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: common_gap, vertical: common_xxs_gap),
    child: SizedBox(
      height: 24,
      child: OutlineButton(
        onPressed: (){},
        borderSide: BorderSide(color: Colors.black45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    ),
  );
}

Widget _username () {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: common_gap),
    child: Text(
      "username",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

Widget _userBio () {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: common_gap),
    child: Text(
      "user Bio",
      style: TextStyle(fontWeight: FontWeight.w400),
    ),
  );
}

enum SelectedTap {
  left, right
}