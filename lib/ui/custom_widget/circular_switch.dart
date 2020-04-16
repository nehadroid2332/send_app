import 'package:flutter/material.dart';
import 'package:sendapp/utils/constants.dart';

class CircularSwitch extends StatefulWidget {
  @required
  final bool value;
  @required
  final Function(bool value) onChanged;

  CircularSwitch({this.value = false, this.onChanged});

  @override
  _CircularSwitchState createState() => _CircularSwitchState(isChecked: value);
}

class _CircularSwitchState extends State<CircularSwitch>
    with SingleTickerProviderStateMixin {
  bool isChecked;

  _CircularSwitchState({@required this.isChecked});

  Duration _duration = Duration(milliseconds: 370);
  Animation<Alignment> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: _duration);

    _animation =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
            .animate(
          CurvedAnimation(
              parent: _animationController,
              curve: Curves.bounceOut,
              reverseCurve: Curves.bounceIn),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isChecked) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: 36,
          height: 24,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: !isChecked ? mediumGreyColor2 : greenColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: _animation.value,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_animationController.isCompleted) {
                        _animationController.reverse();
                      } else {
                        _animationController.forward();
                      }
                      isChecked = !isChecked;
                      widget.onChanged(isChecked);
                    });
                  },
                  child: Container(
                    width: 22,
                    height: 24,
                    padding: EdgeInsets.all(6),
                    child: !isChecked
                        ? ImageIcon(
                      AssetImage('assets/icons/icon-close.png'),
                      color: Colors.white,
                    )
                        : ImageIcon(
                      AssetImage('assets/icons/icon-tick.png'),
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: !isChecked ? mediumGreyColor2 : greenColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
