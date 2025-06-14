import 'package:flutter/material.dart';
import 'package:sozlyuk/ui/ui.dart';

class SettingsMenuCard extends StatelessWidget {
  const SettingsMenuCard({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
      child: BaseContainer(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: MenuAnchor(
                builder: (context, controller, child) {
                  return FilledButton.tonal(
                    onPressed: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    child: const Text('Show menu'),
                  );
                },
                menuChildren: [
                  MenuItemButton(
                    leadingIcon: const Icon(Icons.people_alt_outlined),
                    child: const Text('Item 1'),
                    onPressed: () {},
                  ),
                  MenuItemButton(
                    leadingIcon: const Icon(Icons.remove_red_eye_outlined),
                    child: const Text('Item 2'),
                    onPressed: () {},
                  ),
                  MenuItemButton(
                    leadingIcon: const Icon(Icons.refresh),
                    onPressed: () {},
                    child: const Text('Item 3'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
