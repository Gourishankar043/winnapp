import 'package:flutter/material.dart';
import 'package:winnapp/core/theme/app_dimensions.dart';

import '../../theme/app_spacing.dart';

class PrimaryButton extends StatelessWidget{
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading=false,
    this.icon,
});
  @override
  Widget build(BuildContext context){
    if(isLoading){
      return SizedBox(
        height: AppDimensions.buttonHeight,
        width: double.infinity,
        child:ElevatedButton(onPressed: null, child: const SizedBox(
          width:AppDimensions.iconSmall,
          height: AppDimensions.iconSmall,
          child: CircularProgressIndicator(strokeWidth: 2,),
        ),),
      );
    }
    return SizedBox(
      height: AppDimensions.buttonHeight,
        width: double.infinity,
      child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: icon==null?const SizedBox.shrink():Icon(icon),
          label: Text(label),
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
          horizontal:AppSpacing.lg
      )),),
    );
  }
}