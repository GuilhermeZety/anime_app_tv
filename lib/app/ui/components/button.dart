import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:anime_app_tv/app/core/common/errors/failures.dart';
import 'package:anime_app_tv/app/core/common/extensions/color_extension.dart';
import 'package:anime_app_tv/app/core/common/utils/toasting.dart';
import 'package:anime_app_tv/app/core/common/utils/vibrate.dart';
import 'package:anime_app_tv/app/ui/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Custom buttons are created by extending the MaterialButton class
class Button extends StatefulWidget {
  final Future<void> Function()? onPressed;
  final Widget? child;
  final ButtonStyle? style;
  final bool autofocus;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final ValueChanged<bool>? onHover;
  final VoidCallback? onLongPress;
  final bool secondary;
  final bool disabled;
  final Size? size;
  final Color? color;

  // The constructor made all Primary Custom Button
  Button({
    super.key,
    required this.onPressed,
    required this.child,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.onFocusChange,
    this.onHover,
    this.onLongPress,
    this.size,
    this.color,
    this.disabled = false,
  })  : secondary = false,
        style = ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(5),
          backgroundColor: (disabled ? AppColors.pink_400.withOpacity(0.6) : color ?? AppColors.pink_400).toMaterialStateProperty(),
          foregroundColor: (disabled ? AppColors.grey_200 : AppColors.white).toMaterialStateProperty(),
          textStyle: MaterialStateProperty.all<TextStyle?>(
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          ),
        );

  // The constructor made all Secondary Custom Button
  Button.secondary({
    super.key,
    required this.onPressed,
    required this.child,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.onFocusChange,
    this.onHover,
    this.onLongPress,
    this.size,
    this.color,
    this.disabled = false,
  })  : secondary = false,
        style = ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(5),
          backgroundColor: (disabled ? AppColors.grey_400.withOpacity(0.6) : color ?? AppColors.grey_400).toMaterialStateProperty(),
          foregroundColor: (disabled ? AppColors.grey_200 : AppColors.white).toMaterialStateProperty(),
          textStyle: MaterialStateProperty.all<TextStyle?>(
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          ),
        );

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isLoading = false;
  late Future<void> Function() action;

  @override
  void initState() {
    action = () async {
      if (!mounted) return;
      try {
        if (widget.onPressed == null) return;

        isLoading = true;
        if (!mounted) return;
        setState(() {});

        vibrate(FeedbackType.light);
        await widget.onPressed!();

        isLoading = false;
        if (!mounted) return;
        setState(() {});
      } catch (err) {
        if (!mounted) return;
        if (err is TypeError) {
          Toasting.error(context, message: 'Erro: $err', stackTrace: err.stackTrace);
          return;
        }
        if (err is Failure) {
          Toasting.error(context, message: 'Erro: $err', stackTrace: err.stackTrace);
          return;
        }
        if (err is Exception) {
          Toasting.error(context, message: 'Erro: $err');
          return;
        }
        Toasting.error(context, message: 'Erro: $err');
      }
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var newChild = widget.child;
    if (widget.child is Text) {
      Text text = widget.child as Text;
      newChild = Text(text.data!.toUpperCase(), style: text.style);
    }

    return FilledButton(
      onPressed: widget.disabled ? null : action,
      autofocus: widget.autofocus,
      clipBehavior: widget.clipBehavior,
      focusNode: widget.focusNode,
      onFocusChange: widget.onFocusChange,
      onHover: widget.onHover,
      onLongPress: widget.disabled
          ? null
          : () {
              if (widget.onLongPress != null) {
                vibrate(FeedbackType.light);
                widget.onLongPress!();
              }
            },
      style: widget.style?.copyWith(
        fixedSize: widget.size != null ? MaterialStateProperty.all<Size>(widget.size!) : null,
      ),
      child: isLoading ? const Loader(size: 16, inverted: true) : newChild,
    );
  }
}
