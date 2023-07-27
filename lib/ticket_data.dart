import 'package:flutter/material.dart';

class DialogInsetDefeat extends StatelessWidget {
  final BuildContext context;
  final Widget child;
  final deInset = EdgeInsets.symmetric(horizontal: -40, vertical: -24);
  final EdgeInsets edgeInsets;

  DialogInsetDefeat(
      {required this.context, required this.child, required this.edgeInsets});

  @override
  Widget build(BuildContext context) {
    var netEdgeInsets = deInset + (edgeInsets ?? EdgeInsets.zero);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(viewInsets: netEdgeInsets),
      child: child,
    );
  }
}

/// Displays a Material dialog using the above DialogInsetDefeat class.
/// Meant to be a drop-in replacement for showDialog().
///
/// See also:
///
///  * [Dialog], on which [SimpleDialog] and [AlertDialog] are based.
///  * [showDialog], which allows for customization of the dialog popup.
///  * <https://material.io/design/components/dialogs.html>
Future showDialogWithInsets<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  required WidgetBuilder builder,
  required EdgeInsets edgeInsets,
}) {
  return showDialog(
    context: context,
    builder: (_) => DialogInsetDefeat(
      context: context,
      edgeInsets: edgeInsets,
      child: Builder(builder: builder),
    ),
    // Edited! barrierDismissible: barrierDismissible = true,
    barrierDismissible: barrierDismissible,
  );
}
