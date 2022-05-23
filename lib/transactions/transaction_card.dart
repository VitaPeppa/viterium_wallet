import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vite/vite.dart';

import '../app_icons.dart';
import '../app_providers.dart';
import '../core/vite_uri.dart';
import '../widgets/sheet_util.dart';
import 'transaction_details_sheet.dart';
import 'transaction_providers.dart';
import 'transaction_state_tag.dart';

class TransactionCard extends ConsumerWidget {
  final AccountBlock item;

  const TransactionCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final localization = ref.watch(l10nProvider);
    final styles = ref.watch(stylesProvider);

    final contacts = ref.watch(contactsProvider);
    final address = item.otherAddress.viteAddress;
    var displayName = getShortString(address);
    final contact = contacts.getContactWithAddress(
      address,
      includeLabels: true,
    );
    final isContact = contact != null;
    if (contact != null) {
      displayName = contact.name;
    }

    String text;
    IconData icon;
    Color iconColor;
    if (item.blockType.isSendType) {
      text = localization.sent;
      icon = AppIcons.sent;
      iconColor = theme.text60;
    } else {
      text = localization.received;
      icon = AppIcons.received;
      iconColor = theme.primary60;
    }
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(14, 4, 14, 4),
      decoration: BoxDecoration(
        color: theme.backgroundDark,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [theme.boxShadow],
      ),
      child: TextButton(
        style: styles.cardButtonStyle,
        onPressed: () {
          Sheets.showAppHeightEightSheet(
            context: context,
            widget: TransactionDetailsSheet(
              hash: item.hash.hex,
              address: address,
              displayContactButton: !isContact,
            ),
            theme: ref.read(themeProvider),
            animationDurationMs: 175,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(end: 12),
                      child: Icon(icon, color: iconColor, size: 20),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              text,
                              textAlign: TextAlign.start,
                              style: styles.textStyleTransactionType,
                            ),
                            const SizedBox(height: 4),
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: item.value.toStringAsFixed(
                                        item.value.isInteger ? 0 : 4),
                                    style: styles.textStyleTransactionAmount,
                                  ),
                                  TextSpan(
                                    text: ' ${item.tokenInfo.symbolLabel}',
                                    style: styles.textStyleTransactionUnit,
                                  ),
                                ],
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        displayName,
                        textAlign: TextAlign.end,
                        style: styles.textStyleTransactionAddress,
                        maxLines: 2,
                      ),
                    ),
                    //if (kDebugMode) Text(item.height.toString()),
                    Consumer(builder: (context, ref, _) {
                      final txState = ref.watch(
                        confirmationStatusProvider(item),
                      );
                      return Container(
                        margin: const EdgeInsetsDirectional.only(top: 4),
                        child: TransactionStateTag(state: txState),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
