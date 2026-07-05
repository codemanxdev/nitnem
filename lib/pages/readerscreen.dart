import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nitnem/common/printmessage.dart';
import 'package:nitnem/constants/appconstants.dart';
import 'package:nitnem/models/language.dart';
import 'package:nitnem/models/scrollinfo.dart';
import 'package:nitnem/pages/options.dart';
import 'package:nitnem/redux/actions/actions.dart';
import 'package:nitnem/redux/selectors/selectors.dart';
import 'package:nitnem/state/appstate.dart';
import 'package:nitnem/themes/themedata.dart';
import 'package:redux/redux.dart';

class ReaderScreen extends StatefulWidget {
  ReaderScreen({required Key key}) : super(key: key);

  @override
  _MyReaderPageState createState() => _MyReaderPageState();
}

class _MyReaderPageState extends State<ReaderScreen> {
  final Battery _battery = Battery();
  ScrollController _controller = ScrollController(initialScrollOffset: 0.0);
  static final GlobalKey _optionsKey = GlobalKey();
  static final GlobalKey<ScaffoldState> _readerScreenScaffoldKey =
      GlobalKey<ScaffoldState>();
  static final GlobalKey _storeConnectorKey = GlobalKey();

  //Ephemeral State
  String _batteryLevel = '';
  String _currentTime = '';
  bool _topButtonVisible = false;
  Timer? _batteryTimer;
  Timer? _scrollPosTimer;

  @override
  void initState() {
    super.initState();
    _startBatteryUpdateTimer();
    _updateBatteryLevel();
    _updateCurrentTime();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _startBatteryUpdateTimer() {
    _batteryTimer = Timer.periodic(
      Duration(seconds: AppConstants.STATUS_TIME_UPDATE_INTERVAL_SECONDS),
      (Timer t) => _updateCurrentTime(),
    );
  }

  void _startScrollPosUpdateTimer() {
    _scrollPosTimer = Timer(Duration(milliseconds: 500), () {
      _navigateToScrollPositionOnLoad();
    });
  }

  void _updateBatteryLevel() {
    _battery.batteryLevel.then((level) {
      setState(() {
        _batteryLevel = level.toString();
      });
    });
  }

  /*
   *
  Sets the state for current time.
  This is called first from within initState in order to set the state
  at the time of initialization and then called again periodically based
  on a timer that updates the time on this screen.
  */
  void _updateCurrentTime() {
    DateTime dateTime = DateTime.now();
    final timeFormatter = DateFormat('HH:mm a');
    final formattedTime = timeFormatter.format(dateTime);

    setState(() {
      _currentTime = formattedTime.toString();
    });
  }

  void _updateTopButtonVisibility() {
    if (_controller.hasClients && _controller.position.maxScrollExtent > 0.0) {
      setState(() {
        _topButtonVisible =
            _controller.offset == _controller.position.maxScrollExtent;
      });
    }
  }

  String _calculateScrollPerc(double offset, double maxoffset) {
    final double scrollPerc =
        (offset != 0.0) ? (offset / maxoffset) * 100 : 0.0;
    return scrollPerc.toStringAsFixed(2);
  }

  void initReaderScreen(Store<AppState> store) {
    _startScrollPosUpdateTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCurrentTime();
    });
  }

  /*
   *
  Navigate to the scroll position on first load
  This is called from the init state in order to wait for a set time
  before applying and animating the scroll position to the saved value
  */
  _navigateToScrollPositionOnLoad() {
    final int id = StoreProvider.of<AppState>(context).state.pathId;
    final bool savePos =
        StoreProvider.of<AppState>(context).state.options.saveScrollPosition;
    final double loadedScrollOffset =
        StoreProvider.of<AppState>(
          context,
        ).state.options.scrollOffset[id.toString()]!.scrollOffset;
    final double offset = savePos ? loadedScrollOffset : 0.0;
    _controller.animateTo(
      offset,
      duration: new Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    _updateScrollPositionInStatusBar();
  }

  _updateScrollPositionInStatusBar() {
    final int id = StoreProvider.of<AppState>(context).state.pathId;
    //dispatch action to update scroll position indicator
    final double maxOffset = _controller.position.maxScrollExtent;
    final double offset = _controller.offset;
    StoreProvider.of<AppState>(context).dispatch(
      UpdateStatusScrollPercentageAction(ScrollInfo(id, offset, maxOffset)),
    );
  }

  _onEndScroll(ScrollMetrics metrics) {
    _updateTopButtonVisibility();
    _updateScrollPositionInStatusBar();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    printInfoMessage('[BUILD] ReaderScreen');
    printInfoMessage('[STATE] Battery: $_batteryLevel, Time: $_currentTime');
    //Only the bottom UI overlay is enabled, hiding the system status bar when in reading pane
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );

    var result = PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          StoreProvider.of<AppState>(
            context,
          ).dispatch(ClearReaderOptionsToggleAction());
        }
      },
      child: StoreConnector<AppState, _ViewModel>(
        key: _storeConnectorKey,
        converter: _ViewModel.fromStore,
        onInit: (store) => initReaderScreen(store),
        builder: (context, vm) {
          return Scaffold(
            key: _readerScreenScaffoldKey,
            body: Container(
              decoration: BoxDecoration(
                image: new DecorationImage(
                  colorFilter: new ColorFilter.mode(
                    Colors.amber.withValues(
                      alpha: AppConstants.READERTHEME_BACK_OPACITY,
                    ),
                    BlendMode.dstATop,
                  ),
                  image: new AssetImage(
                    "assets/themes/" +
                        StoreProvider.of<AppState>(
                          context,
                        ).state.options.themeName +
                        ".jpg",
                  ),
                  repeat: ImageRepeat.repeat,
                ),
              ),
              child: Scrollbar(
                child: NotificationListener<ScrollNotification>(
                  child: CustomScrollView(
                    controller: _controller,
                    slivers: <Widget>[
                      SliverAppBar(
                        backgroundColor:
                            isDark ? kFlutterBlue : theme.primaryColor,
                        actions: <Widget>[
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.sliders),

                            onPressed: vm.onToggleReaderOptions,
                          ),
                        ],
                        pinned: false,
                        snap: false,
                        floating: true,
                        expandedHeight:
                            vm.showReaderOptions
                                ? AppConstants.EXPANDED_APP_BAR
                                : AppConstants.COLLAPSED_APP_BAR,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(
                            (vm.showReaderOptions)
                                ? AppConstants.EMPTY_STRING
                                : vm.nitnemPathTitle,
                          ),
                          background:
                              vm.showReaderOptions
                                  ? OptionsPage(
                                    readerMode: true,
                                    key: _optionsKey,
                                  )
                                  : Container(),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Scrollbar(
                          child: Padding(
                            padding: const EdgeInsets.all(
                              AppConstants.READER_PADDING,
                            ),
                            child: MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                textScaler: TextScaler.linear(
                                  vm.textScaleValue,
                                ),
                              ),
                              child: Text(
                                vm.pathData,
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  height: 2.0,
                                  fontFamily:
                                      getLanguageMenuItemValueByName(
                                        vm.languageName,
                                      ).fontName,
                                  fontSize:
                                      getLanguageMenuItemValueByName(
                                        vm.languageName,
                                      ).fontSize,
                                  fontWeight:
                                      (vm.isBold)
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollEndNotification) {
                      _onEndScroll(scrollNotification.metrics);
                    }
                    return false;
                  },
                ),
              ),
            ),
            bottomNavigationBar:
                vm.showStatus
                    ? MediaQuery(
                      data: MediaQuery.of(
                        context,
                      ).copyWith(textScaler: TextScaler.linear(1.0)),
                      child: new Container(
                        height:
                            (defaultTargetPlatform == TargetPlatform.android)
                                ? 20.0
                                : 50.0,
                        child: Padding(
                          padding: const EdgeInsets.all(
                            AppConstants.STATUSBAR_PADDING,
                          ),
                          child: new Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: new Row(
                                  children: <Widget>[
                                    (defaultTargetPlatform ==
                                            TargetPlatform.android)
                                        ? Icon(Icons.battery_std, size: 12)
                                        : Container(),
                                    Text(
                                      _batteryLevel + "%",
                                      textAlign: TextAlign.left,
                                      style: new TextStyle(
                                        fontFamily:
                                            AppConstants.STATUSBAR_FONT_FAMILY,
                                        fontSize:
                                            AppConstants.STATUSBAR_FONT_SIZE,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  _currentTime,
                                  textAlign: TextAlign.left,
                                  style: new TextStyle(
                                    fontFamily:
                                        AppConstants.STATUSBAR_FONT_FAMILY,
                                    fontSize: AppConstants.STATUSBAR_FONT_SIZE,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  vm.nitnemPathTitle,
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                    fontFamily:
                                        AppConstants.STATUSBAR_FONT_FAMILY,
                                    fontSize: AppConstants.STATUSBAR_FONT_SIZE,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:
                                    (defaultTargetPlatform ==
                                            TargetPlatform.android)
                                        ? 1
                                        : 2,
                                child: Text(
                                  _calculateScrollPerc(
                                        vm.scrollOffset,
                                        vm.maxOffset,
                                      ) +
                                      "%",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                    fontFamily:
                                        AppConstants.STATUSBAR_FONT_FAMILY,
                                    fontSize: AppConstants.STATUSBAR_FONT_SIZE,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        color: AppConstants.STATUSBAR_BACK_COLOR,
                      ),
                    )
                    : null,
            floatingActionButton: Visibility(
              visible: _topButtonVisible,
              child: SizedBox(
                width: 50,
                height: 50,
                child: FloatingActionButton(
                  onPressed: () {
                    _controller.animateTo(
                      0.0,
                      duration: new Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  child: Icon(Icons.vertical_align_top_rounded),
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          );
        },
      ),
    );
    return result;
  }

  @protected
  @override
  @mustCallSuper
  void dispose() {
    //All overlays are enabled with the system status bar when in home screen
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    _controller.dispose();
    _batteryTimer?.cancel();
    _scrollPosTimer?.cancel();
    super.dispose();
  }
}

class _ViewModel {
  final void Function() onToggleReaderOptions;
  final String languageName;
  final bool showReaderOptions;
  final double textScaleValue;
  final bool isBold;
  final bool showStatus;
  final String pathData;
  final String nitnemPathTitle;
  final double scrollOffset;
  final double maxOffset;
  final bool saveScrollPosition;

  _ViewModel({
    required this.onToggleReaderOptions,
    required this.languageName,
    required this.showReaderOptions,
    required this.textScaleValue,
    required this.isBold,
    required this.showStatus,
    required this.pathData,
    required this.nitnemPathTitle,
    required this.scrollOffset,
    required this.maxOffset,
    required this.saveScrollPosition,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      onToggleReaderOptions: () {
        store.dispatch(ToggleReaderOptionsAction());
      },
      languageName: languageSelector(store.state),
      showReaderOptions: showReaderOptionSelector(store.state),
      textScaleValue: textScaleValueSelector(store.state),
      isBold: isBoldSelector(store.state),
      showStatus: showStatusSelector(store.state),
      pathData: pathDataSelector(store.state),
      nitnemPathTitle: pathTitleSelector(store.state),
      scrollOffset: scrollOffsetSelector(store.state),
      maxOffset: maxOffsetSelector(store.state),
      saveScrollPosition: saveScrollPositionSelector(store.state),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          languageName == other.languageName &&
          showReaderOptions == other.showReaderOptions &&
          textScaleValue == other.textScaleValue &&
          isBold == other.isBold &&
          showStatus == other.showStatus &&
          pathData == other.pathData &&
          nitnemPathTitle == other.nitnemPathTitle &&
          scrollOffset == other.scrollOffset &&
          saveScrollPosition == other.saveScrollPosition;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      languageName.hashCode ^
      showReaderOptions.hashCode ^
      textScaleValue.hashCode ^
      isBold.hashCode ^
      showStatus.hashCode ^
      pathData.hashCode ^
      nitnemPathTitle.hashCode ^
      scrollOffset.hashCode ^
      saveScrollPosition.hashCode;
}
