import 'package:flutter/material.dart';
import 'package:mobbank/components/styles/shared_styles.dart';

/// A button that shows a busy indicator in place of title
class BusyButton extends StatefulWidget {
  final bool busy;
  final String title;
  final Function onPressed;
  final bool enabled;
  final Color color;
  final double width;
  final double height;
  final double shape;
  const BusyButton(
      {@required this.title,
      this.busy = false,
      @required this.onPressed,
      @required this.color,
      this.width = 15,
      this.height = 15,
      this.shape = 5,
      this.enabled = true});

  @override
  _BusyButtonState createState() => _BusyButtonState();
}

class _BusyButtonState extends State<BusyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: InkWell(
        child: AnimatedContainer(
          height: widget.busy ? 40 : null,
          width: widget.busy ? 40 : null,
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: widget.busy ? 5 : widget.width,
              vertical: widget.busy ? 5 : widget.height),
          decoration: BoxDecoration(
            color: widget.enabled ? widget.color : Colors.grey[300],
            borderRadius: BorderRadius.circular(widget.shape),
          ),
          child: !widget.busy
              ? Text(
                  widget.title,
                  style: buttonTitleTextStyle,
                )
              : CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        ),
      ),
    );
  }
}
