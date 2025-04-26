import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  bool switchController;
  final String label;
  CustomSwitch({super.key, required this.switchController, required this.label});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.label,
          style: TextStyle(color: Color(0xff2b4612), fontSize: 16),
        ),
        Transform.scale(
          scale: 0.6,
          child: Switch(
            value: widget.switchController,
            activeColor: Color(0xff2b4612),
            onChanged: (bool value) {
              setState(() {
                widget.switchController = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
