import 'package:anime_app_tv/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app_tv/app/core/common/utils/custom_dialog_utils.dart';
import 'package:anime_app_tv/app/ui/components/button.dart';
import 'package:anime_app_tv/app/ui/components/coming_soon.dart';
import 'package:anime_app_tv/app/ui/dialogs/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ComingSoonModal extends StatelessWidget {
  const ComingSoonModal({
    super.key,
  });

  static Future show(
    BuildContext context,
  ) {
    return showCustomDialog(
      context,
      child: CustomDialog(
        top: const SizedBox(
          height: 0,
        ),
        bottom: Button(
          onPressed: () async => Modular.to.maybePop(),
          child: const Text('Fechar'),
        ).expandedH(),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: ComingSoonModal(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ComingSoon();
  }
}
