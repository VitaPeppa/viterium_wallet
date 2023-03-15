import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vite/vite.dart';

import '../app_icons.dart';
import '../app_providers.dart';
import '../tokens/token_icon_widget.dart';
import '../util/formatters.dart';
import '../util/numberutil.dart';
import '../widgets/app_simpledialog.dart';
import '../widgets/app_text_field.dart';
import '../widgets/fiat_value_container.dart';
import '../widgets/warning_widget.dart';
import 'viva_staking_providers.dart';
import 'viva_staking_types.dart';

class VivaStakingStakeDialog extends HookConsumerWidget {
  final VivaPoolInfoAll poolInfo;

  const VivaStakingStakeDialog({
    Key? key,
    required this.poolInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final styles = ref.watch(stylesProvider);
    final l10n = ref.watch(l10nProvider);

    final balance = ref.watch(balanceForTokenProvider(poolInfo.stakingTokenId));
    final tokenBalance =
        ref.watch(formatedTokenBalanceProvider(poolInfo.stakingTokenId));

    final userInfo = ref.watch(vivaUserInfoProvider(poolInfo.poolId));

    final amountRaw = useState(BigInt.zero);

    final controller = useTextEditingController();
    final isFirstStakeWithTimeLock = useMemoized(() {
      return userInfo.stakingBalance == BigInt.zero &&
          poolInfo.lockTime > BigInt.zero;
    }, [userInfo]);

    final formatter = useMemoized(() {
      final format = NumberFormat.currency(name: '');
      return CurrencyFormatter(
        groupSeparator: format.symbols.GROUP_SEP,
        decimalSeparator: format.symbols.DECIMAL_SEP,
        maxDecimalDigits: poolInfo.stakingTokenInfo.decimals,
      );
    });

    void onMax() {
      var maxStake =
          poolInfo.maximumTotalStakingBalance - poolInfo.totalStakingBalance;

      if (balance < maxStake || maxStake < BigInt.zero) {
        maxStake = balance;
      }

      final amount = Amount.raw(
        maxStake,
        tokenInfo: poolInfo.stakingTokenInfo,
      );
      final text = NumberUtil.textFieldFormatedAmount(amount);
      controller.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );

      amountRaw.value = maxStake;
    }

    void onAmountChanged(String text) {
      text = text
          .replaceAll(formatter.groupSeparator, '')
          .replaceAll(formatter.decimalSeparator, '.');
      final value = Decimal.tryParse(text) ?? Decimal.zero;
      final amount = Amount.value(value, tokenInfo: poolInfo.stakingTokenInfo);

      amountRaw.value = amount.raw;
    }

    void onStake() {
      final amount = Amount.raw(
        amountRaw.value,
        tokenInfo: poolInfo.stakingTokenInfo,
      );
      Navigator.of(context).pop(amount);
    }

    return LayoutBuilder(builder: (context, constraints) {
      return AppSimpleDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Stake Amount',
            style: styles.textStyleDialogHeader,
          ),
        ),
        children: [
          Container(
            alignment: Alignment.center,
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '(',
                    style: styles.textStyleTransactionUnitSmall,
                  ),
                  TextSpan(
                    text: tokenBalance,
                    style: styles.textStyleBalanceAmountSmall,
                  ),
                  TextSpan(
                    text: ' ${poolInfo.stakingTokenInfo.symbolLabel})',
                    style: styles.textStyleTransactionUnitSmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: constraints.maxWidth * 0.7,
            child: FiatValueContainer(
              amount: Amount.raw(
                amountRaw.value,
                tokenInfo: poolInfo.stakingTokenInfo,
              ),
              child: AppTextField(
                leftMargin: 0,
                rightMargin: 0,
                controller: controller,
                cursorColor: theme.primary,
                style: styles.textStyleParagraphPrimary,
                textInputAction: TextInputAction.done,
                maxLines: null,
                autocorrect: false,
                hintText: l10n.enterAmount,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.center,
                inputFormatters: [formatter],
                prefixButton: TextFieldButton(
                  icon: AppIcons.swapcurrency,
                  widget: TokenIconWidget(tokenId: poolInfo.stakingTokenId),
                ),
                suffixButton: TextFieldButton(
                  icon: AppIcons.max,
                  onPressed: onMax,
                ),
                onChanged: onAmountChanged,
                onSubmitted: (_) => onStake(),
              ),
            ),
          ),
          if (isFirstStakeWithTimeLock) ...[
            const SizedBox(height: 8),
            WarningWidget(text: 'This pool has a time lock'),
          ] else if (poolInfo.hasShortLockTime) ...[
            const SizedBox(height: 8),
            WarningWidget(text: 'Staking will reset time lock'),
          ],
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: styles.dialogButtonStyle,
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'CLOSE',
                  style: styles.textStyleDialogButtonText,
                ),
              ),
              TextButton(
                style: styles.dialogButtonStyle,
                child: Text(
                  'STAKE',
                  style: styles.textStyleDialogButtonText,
                ),
                onPressed: onStake,
              ),
            ],
          ),
        ],
      );
    });
  }
}
