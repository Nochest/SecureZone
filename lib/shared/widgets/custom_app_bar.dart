import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget leading;
  const CustomAppBar({
    super.key,
    this.height = 20.0,
    this.leading = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + height),
        child: ClipPath(
          clipper: RoundShape(),
          child: AppBar(
            backgroundColor: Colors.lightGreen,
            leading: leading,
          ),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.maxFinite, height);
}

class RoundShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    double curveHeight = size.height / 2;
    var p = Path();
    p.lineTo(0, height - curveHeight);
    p.quadraticBezierTo(width / 6, height, width, height - curveHeight);
    p.lineTo(width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
