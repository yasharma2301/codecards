import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final bool isCollapsed;
  final double screenWidth;
  final Duration duration;
  final AnimationController anim;
  final Animation<double> scaleAnimation;
  final Animation<double> borderAnimation;
  final bool setRadius;
  final Function onMenuTap;
  final Widget child;
  const Dashboard(
      {Key key, this.isCollapsed, this.screenWidth, this.duration, this.scaleAnimation, this.onMenuTap,
      this.child,this.borderAnimation,this.anim,this.setRadius})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.4 * screenWidth,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Material(
     //     shadowColor: Colors.orange,
          color: Colors.transparent,
          animationDuration: duration,
          borderRadius: isCollapsed ? BorderRadius.circular(0) : BorderRadius.circular(40),
          elevation: 10.0,
          child: child,
        ),
      ),
    );
  }
}