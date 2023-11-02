import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatefulWidget {
  @override
  _CustomLoadingIndicatorState createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipOval(
          child: Image.asset(
            'assets/images/logo.png',
            width: 100,
            height: 100,
          ),
        ),
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            int dots = (_controller.value * 3).floor() % 4;
            String loadingText = 'Loading' + '.' * dots;
            return Text(
              loadingText,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 220, 104, 145),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
