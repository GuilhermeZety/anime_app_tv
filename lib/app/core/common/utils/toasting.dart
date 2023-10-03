import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:gap/gap.dart';
import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:anime_app_tv/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app_tv/app/core/common/utils/vibrate.dart';

class Toasting {
  static void error(
    BuildContext context, {
    String? message,
    Duration? duration,
    StackTrace? stackTrace,
  }) {
    vibrate(FeedbackType.error);
    showNotification(
      context,
      color: AppColors.red_400,
      message: message ?? 'Erro',
      icon: const Icon(
        Icons.error_outline,
        color: AppColors.red_400,
      ),
      duration: duration,
    );
  }

  static void success(
    BuildContext context, {
    String? message,
    Duration? duration,
  }) {
    vibrate(FeedbackType.success);
    showNotification(
      context,
      color: AppColors.green_400,
      message: message ?? 'Sucesso',
      icon: const Icon(
        Icons.check_rounded,
        color: AppColors.green_400,
      ),
      duration: duration,
    );
  }

  static void noConnection(
    BuildContext context, {
    String? message,
    Duration? duration,
  }) {
    vibrate(FeedbackType.error);
    showNotification(
      context,
      color: AppColors.red_400,
      message: message ?? 'Sem conexão com a internet',
      icon: const Icon(
        Icons.wifi_off_rounded,
        color: AppColors.white,
      ),
      duration: duration,
    );
  }

  static void warning(
    BuildContext context, {
    String? message,
    Duration? duration,
  }) {
    vibrate(FeedbackType.warning);
    showNotification(
      context,
      color: Colors.yellow.shade800,
      message: message ?? 'Aviso',
      icon: const Icon(
        Icons.warning,
        color: AppColors.white,
      ),
      duration: duration,
    );
  }

  static void showNotification(
    BuildContext context, {
    required Color color,
    required String message,
    required Widget icon,
    Duration? duration,
  }) {
    BotToast.showCustomNotification(
      backButtonBehavior: BackButtonBehavior.close,
      duration: duration ?? const Duration(seconds: 5),
      toastBuilder: (close) {
        return _CustomWidget(
          cancelFunc: close,
          message: message,
          color: color,
          icon: icon,
        );
      },
    );
  }
}

class _CustomWidget extends StatefulWidget {
  const _CustomWidget({
    required this.cancelFunc,
    required this.message,
    required this.color,
    required this.icon,
  });

  final CancelFunc cancelFunc;
  final String message;
  final Widget icon;
  final Color color;

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<_CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.grey_600,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Gap(10),
                widget.icon,
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: AutoSizeText(
                    widget.message,
                    maxLines: 1,
                    style: const TextStyle(
                      color: AppColors.grey_100,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ).expanded(),
                GestureDetector(
                  onTap: widget.cancelFunc,
                  child: const Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
