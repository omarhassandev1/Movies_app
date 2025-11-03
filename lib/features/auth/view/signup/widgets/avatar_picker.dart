import 'package:flutter/material.dart';

class AvatarPicker extends StatefulWidget {
  const AvatarPicker({super.key, this.onAvatarSelected});

  final Function(int index)? onAvatarSelected;

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {

  late PageController _pageController;

  int _selectedIndex = 0;
  final int _initialPage = 5;

  final List<String> _avatarAssets = [
    'assets/common/avaters/avater1.png',
    'assets/common/avaters/avater2.png',
    'assets/common/avaters/avater3.png',
    'assets/common/avaters/avater4.png',
    'assets/common/avaters/avater5.png',
    'assets/common/avaters/avater6.png',
    'assets/common/avaters/avater7.png',
    'assets/common/avaters/avater8.png',
    'assets/common/avaters/avater9.png',
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = _initialPage;

    _pageController = PageController(
      viewportFraction: 0.4,
      initialPage: _initialPage.round(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _avatarAssets.length,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
                if (widget.onAvatarSelected != null) {
                  widget.onAvatarSelected!(index);
                }
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: index==_selectedIndex?0: 34.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(_avatarAssets[index],fit: BoxFit.fitHeight,),
                ),
              );
            },
          ),
        ),
        const Text('Avatar')
      ],
    );
  }
}
