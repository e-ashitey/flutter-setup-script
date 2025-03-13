import 'package:flutter_template/shared/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T?) builder;
  final String? emptyViewMessage;
  final Widget Function(Object, StackTrace)? error;

  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.builder,
    this.error,
    this.emptyViewMessage,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnRefresh: false,
      loading: () {
        return Skeletonizer(child: builder(null));
      },
      error: (error, stackTrace) =>
          this.error?.call(error, stackTrace) ?? SizedBox.shrink(),
      data: (data) {
        if (data is List && data.isEmpty) {
          // Show empty widget if data is an empty list
          return EmptyScreen(message: emptyViewMessage);
        }
        return builder(data); // Pass actual data
      },
    );
  }
}