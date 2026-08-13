import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitnem/common/printmessage.dart';
import 'package:nitnem/constants/appconstants.dart';
import 'package:nitnem/data/languagedata.dart';
import 'package:nitnem/models/language.dart';
import 'package:nitnem/models/themes.dart';
import 'package:nitnem/providers/settings_provider.dart';

import '../navigation/appnavigator.dart';

const double _kItemHeight = 4.0;
const EdgeInsetsDirectional _kItemPadding = EdgeInsetsDirectional.only(
  start: 45.0,
);

class _OptionsItem extends StatelessWidget {
  const _OptionsItem({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double textScaleFactor = MediaQuery.textScalerOf(context).scale(10);

    return MergeSemantics(
      child: Container(
        constraints: BoxConstraints(minHeight: _kItemHeight * textScaleFactor),
        padding: _kItemPadding,
        alignment: AlignmentDirectional.centerStart,
        child: DefaultTextStyle(
          style: DefaultTextStyle.of(context).style,
          maxLines: 2,
          overflow: TextOverflow.fade,
          child: IconTheme(
            data: Theme.of(context).primaryIconTheme,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _BooleanItem extends StatelessWidget {
  const _BooleanItem(
    this.title,
    this.subtitle,
    this.value,
    this.onChanged, {
    required this.switchKey,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  // [switchKey] is used for accessing the switch from driver tests.
  final Key switchKey;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(child: Text(title)),
          Expanded(
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: AppConstants.OPTIONS_SUBTITLE_FONT_SIZE,
              ),
            ),
          ),
          Switch(
            key: switchKey,
            value: value,
            onChanged: onChanged,
            activeTrackColor: isDark ? Colors.white30 : Colors.black26,
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem(this.text, this.onTap);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child:
          _FlatButton(onPressed: onTap, key: ValueKey(text), child: Text(text)),
    );
  }
}

class _FlatButton extends StatelessWidget {
  const _FlatButton({
    required Key key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var borderColor = Theme.of(context).highlightColor;

    return TextButton(
      onPressed: onPressed,
      child: DefaultTextStyle(
        style: Theme.of(context).primaryTextTheme.titleMedium!,
        child: child,
      ),
      style: TextButton.styleFrom(
        side: BorderSide(color: borderColor, width: 1),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return _OptionsItem(
      child: DefaultTextStyle(
        style: theme.textTheme.bodyMedium!.copyWith(
          fontFamily: AppConstants.ROBOTO_SLAB_FONT,
          color: theme.colorScheme.secondary,
        ),
        child: Semantics(child: Text(text), header: true),
      ),
    );
  }
}

class _BoldItem extends ConsumerWidget {
  const _BoldItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).value;
    if (settings == null) return const SizedBox.shrink();

    return _BooleanItem(
      'Bold Text',
      '',
      settings.bold,
      (bool value) {
        ref.read(settingsProvider.notifier).toggleBold(value);
      },
      switchKey: const Key('bold'),
    );
  }
}

class _KeepScreenAwakeItem extends ConsumerWidget {
  const _KeepScreenAwakeItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).value;
    if (settings == null) return const SizedBox.shrink();

    return _BooleanItem(
      'Keep Screen Awake',
      'Requires Wake Lock Permission',
      settings.screenAwake,
      (bool value) {
        ref.read(settingsProvider.notifier).toggleScreenAwake(value);
      },
      switchKey: const Key('screenAwake'),
    );
  }
}

class _SaveScrollPosItem extends ConsumerWidget {
  const _SaveScrollPosItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).value;
    if (settings == null) return const SizedBox.shrink();

    return _BooleanItem(
      'Save Scroll Position',
      '',
      settings.saveScrollPosition,
      (bool value) {
        ref.read(settingsProvider.notifier).toggleReadingPositionSave(value);
      },
      switchKey: const Key('saveScrollPosition'),
    );
  }
}

class _ShowStatusItem extends ConsumerWidget {
  const _ShowStatusItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).value;
    if (settings == null) return const SizedBox.shrink();

    return _BooleanItem(
      'Show Status Bar',
      '',
      settings.showStatus,
      (bool value) {
        ref.read(settingsProvider.notifier).toggleStatus(value);
      },
      switchKey: const Key('showStatus'),
    );
  }
}

class _ChangeBaaniOrderItem extends StatelessWidget {
  const _ChangeBaaniOrderItem();

  @override
  Widget build(BuildContext context) {
    return _ActionItem('Change Baani Order', () {
      AppNavigator.goToBaaniOrder(context);
    });
  }
}

class _ThemeChoices extends ConsumerWidget {
  _ThemeChoices();

  // this function will build and return the choice list
  _buildChoiceList(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).value;
    if (settings == null) return <Widget>[];

    List<Widget> choices = [];
    ThemeName.values.forEach((item) {
      choices.add(
        Container(
          padding: const EdgeInsets.all(2.0),
          child: ChoiceChip(
            label: Text(
              item.toString().replaceAll(
                item.runtimeType.toString() + ".",
                AppConstants.EMPTY_STRING,
              ),
            ),
            selected: settings.themeName == item.toString(),
            onSelected: (selected) {
              if (selected) {
                ref.read(settingsProvider.notifier).changeTheme(item.toString());
              }
            },
            selectedColor: Theme.of(context).colorScheme.surface,
          ),
        ),
      );
    });
    return choices;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(left: 50.0),
      child: Wrap(children: _buildChoiceList(context, ref)),
    );
  }
}

class _TextScaleFactorItem extends ConsumerWidget {
  const _TextScaleFactorItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).value;
    if (settings == null) return const SizedBox.shrink();

    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Text size'),
                Text(
                  '${settings.textScaleValue.toStringAsFixed(2)}',
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
                Slider(
                  min: AppConstants.TEXTSCALE_MIN,
                  max: AppConstants.TEXTSCALE_MAX,
                  divisions: 15,
                  value: settings.textScaleValue,
                  onChanged: (double value) {
                    ref.read(settingsProvider.notifier).updateTextScale(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyGoalItem extends ConsumerWidget {
  const _DailyGoalItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).value;
    if (settings == null) return const SizedBox.shrink();

    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Daily Goal (Minutes)'),
                Text(
                  '${settings.dailyGoalMinutes}m',
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
                Slider(
                  min: 5,
                  max: 120,
                  divisions: 23,
                  value: settings.dailyGoalMinutes.toDouble(),
                  onChanged: (double value) {
                    ref
                        .read(settingsProvider.notifier)
                        .changeDailyGoal(value.toInt());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageItem extends ConsumerWidget {
  final bool readerMode;

  const _LanguageItem(this.readerMode);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).value;
    if (settings == null) return const SizedBox.shrink();

    return _OptionsItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Language'),
          Wrap(
            spacing: 8.0,
            children:
                languages.map((LanguageMenuItem choice) {
                  return ChoiceChip(
                    label: Text(choice.title),
                    selected: settings.languageName == choice.title,
                    onSelected: (bool selected) {
                      if (selected) {
                        ref
                            .read(settingsProvider.notifier)
                            .changeLanguage(choice.title);
                      }
                    },
                    selectedColor: Theme.of(context).colorScheme.surface,
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}

class OptionsPage extends StatelessWidget {
  const OptionsPage({required Key key, required this.readerMode})
    : super(key: key);

  final bool readerMode;

  @override
  Widget build(BuildContext context) {
    printInfoMessage('[BUILD] Options');

    final ThemeData theme = Theme.of(context);

    //a blank heading is needed to fix display overlap
    final blankWidgets = <Widget>[const _Heading('')];
    //define options widgets.
    final optWidgets = <Widget>[
      const _Heading('Themes'),
      _ThemeChoices(),
      const _Heading('Display'),
      const _BoldItem(),
      const _ShowStatusItem(),
      const _TextScaleFactorItem(),
      const _DailyGoalItem(),
      (defaultTargetPlatform == TargetPlatform.android)
          ? const _KeepScreenAwakeItem()
          : Container(),
      const _Heading('Gurbani'),
      const _ChangeBaaniOrderItem(),
      _LanguageItem(readerMode),
      const _SaveScrollPosItem(),
    ];

    //define all widgets including all options widgets first.
    final aboutWidgets = <Widget>[
      const Divider(),
      const _Heading('About'),
      _OptionsItem(
        child: Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            _FlatButton(
              onPressed: () => AppNavigator.goToAbout(context),
              key: const ValueKey('about_nitnem'),
              child: const Text('About Nitnem'),
            ),
            _FlatButton(
              onPressed: () {
                // Handle feedback
                // Replaced SendFeedbackAction with direct call or another provider
              },
              key: const ValueKey('send_feedback'),
              child: const Text('Send feedback'),
            ),
          ],
        ),
      ),
    ];

    printInfoMessage('[BUILD] Options Completed');
    return DefaultTextStyle(
      style: theme.primaryTextTheme.bodySmall!.copyWith(
        fontSize: AppConstants.OPTIONS_LABEL_FONT_SIZE,
      ),
      child: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.only(
            top: this.readerMode ? kToolbarHeight + 10.0 : 0.0,
            bottom: 124.0,
          ),
          children:
              this.readerMode
                  ? blankWidgets + optWidgets
                  : optWidgets + aboutWidgets,
        ),
      ),
    );
  }
}
