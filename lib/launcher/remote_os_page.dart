import 'package:async_value/async_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:ubuntu_widgets/ubuntu_widgets.dart';
import 'package:wizard_router/wizard_router.dart';

import '../remotes/remote_selector.dart';
import '../widgets/os_selector.dart';
import '../widgets/wizard_page.dart';
import 'remote_image_model.dart';

class RemoteOsPage extends StatelessWidget {
  const RemoteOsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<RemoteImageModel>();
    final l10n = AppLocalizations.of(context);
    return WizardPage(
      title: Text(l10n.selectOsTitle),
      content: RoundedContainer(
        child: model.images?.when(
          data: (images) => OsSelector(
            items: model.oses,
            onSelected: (os) => Wizard.of(context).next(arguments: os),
          ),
          error: (error, stackTrace) => ErrorWidget(error),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
      actions: [
        const IntrinsicWidth(
          child: RemoteSelector(),
        ),
        const Spacer(),
        OutlinedButton(
          onPressed: Wizard.of(context).done,
          child: Text(l10n.cancelButton),
        ),
      ],
    );
  }
}
