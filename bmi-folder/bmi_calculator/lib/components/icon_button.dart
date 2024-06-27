import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoundIconButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  const RoundIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: const BoxConstraints(
        minHeight: 56.0,
        minWidth: 56.0,
      ),
      shape: const CircleBorder(),
      fillColor: const Color(0xFF4c4f5e),
      child: FaIcon(
        icon,
      ),
    );
  }
}
