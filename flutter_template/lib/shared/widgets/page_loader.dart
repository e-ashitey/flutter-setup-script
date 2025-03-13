import 'package:flutter_template/shared/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';

class PageLoader extends StatelessWidget {
  const PageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomProgressIndicator(),
    );
  }
}