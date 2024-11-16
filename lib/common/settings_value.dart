import 'package:flutter/material.dart';
import '../theme.dart';

class SettingsValue extends StatelessWidget {
  final String name;
  final IconData icon;
  final Widget? child;
  final void Function()? onTap2;

  const SettingsValue({
    super.key,
    required this.name,
    required this.icon,
    required this.child,
    required this.onTap2,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.ltr,
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(name,
                    style: TextStyle(
                      color: ThemeColor.white,
                    )),
                const SizedBox(width: 8),
                Icon(
                  icon,
                  color: ThemeColor.white,
                ),
              ],
            ),
            InkWell(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
