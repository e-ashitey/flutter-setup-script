import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class EmptyScreen extends StatelessWidget {
  final IconData? iconData;
  final String? message;
  const EmptyScreen({
    super.key,
    this.iconData,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(LucideIcons.badgeAlert, size: 50.sp),
        5.verticalSpace,
        Text(
          message ?? "Nothing to show here!",
          style: ShadTheme.of(context).textTheme.large,
        ),
      ],
    );
  }
}