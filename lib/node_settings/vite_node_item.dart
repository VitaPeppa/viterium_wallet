import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../app_providers.dart';
import '../app_styles.dart';
import '../widgets/dialog.dart';
import 'node_providers.dart';
import 'node_types.dart';

final viteNodeConfigItemProvider =
    Provider<ViteNodeConfig>((ref) => throw UnimplementedError);

class ViteNodeItem extends ConsumerWidget {
  const ViteNodeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final localization = ref.watch(l10nProvider);
    final styles = ref.watch(stylesProvider);
    final item = ref.watch(viteNodeConfigItemProvider);
    final config = ref.watch(viteNodeConfigProvider);

    void change() {
      final notifier = ref.read(viteNodeSettingsProvider.notifier);
      notifier.updateSelected(item);
    }

    void delete() {
      final notifier = ref.read(viteNodeSettingsProvider.notifier);
      notifier.removeOption(item);
    }

    void confirmDelete() {
      final title = 'Delete Vite Node Config?';
      final content = 'Are you sure you want to delete ${item.name}?';
      AppDialogs.showConfirmDialog(
        context,
        title,
        content,
        localization.YES,
        delete,
        cancelText: localization.NO,
      );
    }

    return Slidable(
      secondaryActions: [
        if (item != config)
          SlideAction(
            child: Container(
              margin: EdgeInsetsDirectional.only(start: 2, top: 1, bottom: 1),
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(color: theme.primary),
              child: Icon(Icons.delete, color: theme.backgroundDark),
            ),
            onTap: confirmDelete,
          ),
      ],
      actionExtentRatio: 0.16,
      actionPane: const SlidableStrechActionPane(),
      child: Column(
        children: [
          Divider(height: 2, color: theme.text15),
          TextButton(
            style: styles.defaultTextButtonStyle,
            onPressed: change,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<ViteNodeConfig>(
                    value: item,
                    groupValue: config,
                    activeColor: theme.primary,
                    onChanged: (_) {
                      change();
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.name,
                                style: styles.textStyleSettingItemHeader,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4, right: 4),
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(6, 2, 6, 2),
                              decoration: BoxDecoration(
                                color: theme.text10,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                item.network.name.toUpperCase(),
                                style: styles.tagText.copyWith(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          item.http.toString(),
                          style: styles.textStyleAddressText60.copyWith(
                            fontSize: AppFontSizes.smallest,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          item.ws.toString(),
                          style: styles.textStyleAddressText60.copyWith(
                            fontSize: AppFontSizes.smallest,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
