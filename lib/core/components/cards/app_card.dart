import 'package:flutter/material.dart';
import 'package:winnapp/core/theme/app_dimensions.dart';
import 'package:winnapp/core/theme/app_spacing.dart';

class AppCard extends StatelessWidget{
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap
});
  @override
  Widget build(BuildContext context){
    final card=Card(
      margin:EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Padding(padding: padding??const EdgeInsets.all(AppSpacing.md),
      child: child,),
    );
    if(onTap==null){
      return card;
    }
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: card,
    );
  }
}