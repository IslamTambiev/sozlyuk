import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({
    super.key,
    required this.child,
    this.width,
    this.margin,
    this.padding = const EdgeInsets.only(left: 12),
  });

  final double? width;
  final EdgeInsets? margin;
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 3.0,
      shadowColor: Colors.transparent,
      surfaceTintColor: theme.colorScheme.primary,
      type: MaterialType.card,
      child: Container(
        width: width,
        margin: margin,
        padding: padding,
        child: child,
      ),
    );
  }
}
