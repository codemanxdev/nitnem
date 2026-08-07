import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:nitnem/common/printmessage.dart';
import 'package:nitnem/constants/appconstants.dart';
import 'package:nitnem/data/languagedata.dart';
import 'package:nitnem/models/language.dart';
import 'package:nitnem/models/themes.dart';
import 'package:nitnem/redux/actions/actions.dart';
import 'package:nitnem/state/appstate.dart';

import '../navigation/appnavigator.dart';
import 'about.dart';

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
      child: _FlatButton(onPressed: onTap, key: UniqueKey(), child: Text(text)),
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
          fontFamily: 'GoogleSans',
          color: theme.colorScheme.secondary,
        ),
        child: Semantics(child: Text(text), header: true),
      ),
    );
  }
}

class _BoldItem extends StatelessWidget {
  const _BoldItem();

  @override
  Widget build(BuildContext context) {
    return _BooleanItem(
      'Bold Text',
      '',
      StoreProvider.of<AppState>(context).state.options.bold == true,
      (bool value) {
        StoreProvider.of<AppState>(context).dispatch(ToggleBoldAction(value));
      },
      switchKey: const Key('bold'),
    );
  }
}

class _KeepScreenAwakeItem extends StatelessWidget {
  const _KeepScreenAwakeItem();

  @override
  Widget build(BuildContext context) {
    return _BooleanItem(
      'Keep Screen Awake',
      'Requires Wake Lock Permission',
      StoreProvider.of<AppState>(context).state.options.screenAwake == true,
      (bool value) {
        StoreProvider.of<AppState>(
          context,
        ).dispatch(ToggleScreenAwakeAction(value));
      },
      switchKey: const Key('screenAwake'),
    );
  }
}

class _SaveScrollPosItem extends StatelessWidget {
  const _SaveScrollPosItem();

  @override
  Widget build(BuildContext context) {
    return _BooleanItem(
      'Save Scroll Position',
      '',
      StoreProvider.of<AppState>(context).state.options.saveScrollPosition ==
          true,
      (bool value) {
        StoreProvider.of<AppState>(
          context,
        ).dispatch(ToggleReadingPositionSaveAction(value));
      },
      switchKey: const Key('saveScrollPosition'),
    );
  }
}

class _ShowStatusItem extends StatelessWidget {
  const _ShowStatusItem();

  @override
  Widget build(BuildContext context) {
    return _BooleanItem(
      'Show Status Bar',
      '',
      StoreProvider.of<AppState>(context).state.options.showStatus == true,
      (bool value) {
        StoreProvider.of<AppState>(context).dispatch(ToggleStatusAction(value));
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

class _ThemeChoices extends StatelessWidget {
  _ThemeChoices();

  // this function will build and return the choice list
  _buildChoiceList(BuildContext context) {
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
            selected:
                StoreProvider.of<AppState>(context).state.options.themeName ==
                item.toString(),
            onSelected: (selected) {
              StoreProvider.of<AppState>(
                context,
              ).dispatch(ChangeThemeAction(item.toString()));
            },
            selectedColor: Theme.of(context).colorScheme.surface,
          ),
        ),
      );
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50.0),
      child: Wrap(children: _buildChoiceList(context)),
    );
  }
}

class _TextScaleFactorItem extends StatelessWidget {
  const _TextScaleFactorItem();

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Text size'),
                Text(
                  '${StoreProvider.of<AppState>(context).state.options.textScaleValue.toStringAsFixed(2)}',
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
                Slider(
                  min: AppConstants.TEXTSCALE_MIN,
                  max: AppConstants.TEXTSCALE_MAX,
                  divisions: 15,
                  value:
                      StoreProvider.of<AppState>(
                        context,
                      ).state.options.textScaleValue,
                  onChanged: (double value) {
                    StoreProvider.of<AppState>(
                      context,
                    ).dispatch(TextScaleAction(value));
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

class _DailyGoalItem extends StatelessWidget {
  const _DailyGoalItem();

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Daily Goal (Minutes)'),
                Text(
                  '${StoreProvider.of<AppState>(context).state.options.dailyGoalMinutes}m',
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
                Slider(
                  min: 5,
                  max: 120,
                  divisions: 23,
                  value: StoreProvider.of<AppState>(context).state.options.dailyGoalMinutes.toDouble(),
                  onChanged: (double value) {
                    StoreProvider.of<AppState>(context).dispatch(ChangeDailyGoalAction(value.toInt()));
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

class _LanguageItem extends StatelessWidget {
  final bool readerMode;

  const _LanguageItem(this.readerMode);

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Language'),
                Text(
                  '${StoreProvider.of<AppState>(context).state.options.languageName}',
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
              ],
            ),
          ),
          PopupMenuButton<LanguageMenuItem>(
            padding: const EdgeInsetsDirectional.only(end: 16.0),
            icon: const Icon(Icons.arrow_drop_down),
            itemBuilder: (BuildContext context) {
              return languages.map((LanguageMenuItem choice) {
                return PopupMenuItem<LanguageMenuItem>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
            onSelected: (LanguageMenuItem selectedValue) {
              if (readerMode) {
                StoreProvider.of<AppState>(context).dispatch(
                  ChangeLanguageAndFetchNitnemPathAction(
                    selectedValue.title,
                    StoreProvider.of<AppState>(context).state.pathFilePrefix,
                  ),
                );
              } else {
                StoreProvider.of<AppState>(
                  context,
                ).dispatch(ChangeLanguageAction(selectedValue.title));
              }
            },
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
      _BoldItem(),
      _ShowStatusItem(),
      _TextScaleFactorItem(),
      _DailyGoalItem(),
      (defaultTargetPlatform == TargetPlatform.android)
          ? _KeepScreenAwakeItem()
          : Container(),
      const _Heading('Gurbani'),
      _ChangeBaaniOrderItem(),
      _LanguageItem(readerMode),
      _SaveScrollPosItem(),
    ];

    //define all widgets including all options widgets first.
    final aboutWidgets = <Widget>[
      const Divider(),
      const _Heading('About'),
      _ActionItem('About Nitnem', () {
        aboutNitnem(context);
      }),
      _ActionItem('Send feedback', () {
        StoreProvider.of<AppState>(context).dispatch(SendFeedbackAction());
      }),
    ];

    printInfoMessage('[BUILD] Options Completed');
    return DefaultTextStyle(
      style: theme.primaryTextTheme.bodySmall!.copyWith(
        fontSize: AppConstants.OPTIONS_LABEL_FONT_SIZE,
      ),
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
    );
  }
}
