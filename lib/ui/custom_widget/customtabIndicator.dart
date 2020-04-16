import 'package:flutter/material.dart';
import 'package:sendapp/utils/constants.dart';

class PageSelectorIndicatr extends StatelessWidget {
  const PageSelectorIndicatr({
    Key key,
    @required this.backgroundColor,
  }) : super(key: key);

  /// The indicator circle's background color.
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 40,
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(12)),
    );
  }
}

class CustomPageSelector extends StatelessWidget {
  const CustomPageSelector({
    Key key,
    this.controller,
    this.color,
    this.selectedColor,
  }) : super(key: key);

  final TabController controller;

  final Color color;

  final Color selectedColor;



  Widget _buildTabIndicator(
    int tabIndex,
    TabController tabController,
    ColorTween selectedColorTween,
    ColorTween previousColorTween,
  ) {
    Color background;

    final double offset = tabController.offset;
    if (tabController.index == tabIndex) {
      background = selectedColorTween.lerp(1.0 - offset.abs());
    } else if (tabController.index == tabIndex - 1 && offset > 0.0) {
      background = selectedColorTween.lerp(offset);
    } else if (tabController.index == tabIndex + 1 && offset < 0.0) {
      background = selectedColorTween.lerp(-offset);
    } else {
      background = selectedColorTween.begin;
    }

    return GestureDetector(
      //handle on tap
      onTap: ()=>controller.animateTo(tabIndex),
      child: PageSelectorIndicatr(
        backgroundColor: background,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color fixColor = color ?? Colors.transparent;
    final Color fixSelectedColor =
        selectedColor ?? Colors.green;
    final ColorTween selectedColorTween =
        ColorTween(begin: fixColor, end: fixSelectedColor);
    final ColorTween previousColorTween =
        ColorTween(begin: fixSelectedColor, end: fixColor);
    final TabController tabController =
        controller ?? DefaultTabController.of(context);

    final Animation<double> animation = CurvedAnimation(
      parent: tabController.animation,
      curve: Curves.fastOutSlowIn,
    );
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List<Widget>.generate(tabController.length, (int tabIndex) {
            return _buildTabIndicator(tabIndex, tabController,
                selectedColorTween, previousColorTween);
          }).toList(),
        );
      },
    );
  }
}
