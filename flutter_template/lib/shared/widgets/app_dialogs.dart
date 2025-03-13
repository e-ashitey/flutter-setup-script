import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'page_loader.dart';

class AppDialog {
  // BuildContext get context => navigatorStateKey.currentContext!;
  static Future<void> showModal({
    required BuildContext context,
    // required String title,
    required Widget content,
    List<Widget> actions = const [],
  }) {
    ScaffoldMessenger.of(context).clearSnackBars(); // clear snackbar
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true, // Allow the sheet to take up more space
      backgroundColor: Colors.transparent, // Remove default background color
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 33.h,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  20.h, // Adjust for keyboard
            ),
            child: SingleChildScrollView(
              child: content,
            ),
          ),
        );
        // return Wrap(
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.only(
        //         bottom: MediaQuery.of(context)
        //             .viewInsets
        //             .bottom, // Adjust for keyboard
        //       ),
        //       child: FractionallySizedBox(
        //         heightFactor: height != null ? null : 0.9,
        //         child: Container(
        //           width: double.infinity,
        //           padding: const EdgeInsets.symmetric(horizontal: 20),
        //           height: height,
        //           child: body,
        //         ),
        //       ),
        //     ),
        //   ],
        // );
      },
    );
  }

  static Future<void> _showAlertDialog({
    required BuildContext context,
    required String content,
    required IconData iconData,
    Color? iconColor,
    List<Widget>? actions,
  }) async {
    ScaffoldMessenger.of(context).clearSnackBars(); // clear snackbar
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Icon(
            iconData,
            size: 40.sp,
            color: iconColor,
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
            style: ShadTheme.of(context).textTheme.p,
          ),
          actionsPadding: EdgeInsets.zero,
          actionsOverflowButtonSpacing: 0,
          actions: actions,
        );
      },
    );
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: isError ? Colors.red : Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
  }

// Loader Dialog //
  static void showLoader({
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      routeSettings: RouteSettings(name: "loader"),
      builder: (_) => const PageLoader(),
    );
  }

  // Dismiss Loader Dialog //
  static void dismissLoader({
    required BuildContext context,
  }) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(); // close loader
    }
  }

  // Info Dialog //
  static Future<void> showInfoDialog({
    required BuildContext context,
    required String message,
    IconData? iconData,
    VoidCallback? onDismiss,
    Widget? extraActionBtn,
  }) async {
    return await _showAlertDialog(
      context: context,
      // iconColor: ColorName.black,
      iconData: iconData ?? LucideIcons.info,
      content: message,
      actions: [
        ShadButton.ghost(
          onPressed: onDismiss ?? context.pop,
          child: Text("Dismiss"),
        ),
        if (extraActionBtn != null) extraActionBtn,
      ],
    );
  }

  //
  static void showErrorDialog({
    required BuildContext context,
    required String message,
    IconData? iconData,
    VoidCallback? onDismiss,
  }) async {
    return await _showAlertDialog(
      context: context,
      // iconColor: ColorName.crimsonRed,
      iconData: iconData ?? LucideIcons.circleX,
      content: message,
      actions: [
        ShadButton.ghost(
          onPressed: onDismiss ?? context.pop,
          child: Text("Dismiss"),
        ),
      ],
    );
  }
}
