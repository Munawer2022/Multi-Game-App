import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

snackbar(text, context) {
  var snackBar = SnackBar(
    backgroundColor: Colors.green.shade300,
    content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.04,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

errorsnackBar(text, context) {
  var errorsnackBar = SnackBar(
    backgroundColor: Colors.red.shade300,
    content: SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(errorsnackBar);
}

class Button extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const Button(
      {Key? key,
      required this.title,
      required this.onTap,
      this.loading = false})
      : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //     RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(12.0),
            // )),
            backgroundColor: widget.loading
                ? MaterialStateProperty.all(
                    // Colors.grey.shade300,
                    Colors.transparent)
                : MaterialStateProperty.all(Colors.blue.shade300)

            // elevation: MaterialStateProperty.all(2)
            ),
        onPressed: widget.loading ? null : widget.onTap,
        child: Center(
            child: widget.loading
                ? CircularProgressIndicator(
                    valueColor: animationController.drive(
                        ColorTween(begin: Colors.blueAccent, end: Colors.red)),
                    strokeWidth: 7,
                    // color: Colors.white,
                  )
                : Text(
                    widget.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
      ),
    );
  }
}
