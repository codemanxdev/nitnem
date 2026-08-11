import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nitnem/common/printmessage.dart';
import 'package:nitnem/constants/appconstants.dart';
import 'package:nitnem/navigation/appnavigator.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _splashTimer;
  String _versionName = ' ';

  @override
  void initState() {
    super.initState();
    _splashTimer = Timer(
      Duration(milliseconds: (AppConstants.SPLASH_WAIT_SECONDS * 1000).toInt()),
      () => AppNavigator.goToHome(context),
    );
    _initGetPackageInfo();
  }

  @override
  void dispose() {
    _splashTimer.cancel();
    super.dispose();
  }

  _initGetPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionName = packageInfo.version;

    setState(() {
      _versionName = versionName;
    });
  }

  double getRadius() {
    double width = MediaQuery.of(context).size.width;
    if (width <= AppConstants.DEVICE_SMALL_RES) {
      return AppConstants.SPLASH_ICON_RADIUS_SMALL;
    } else {
      return AppConstants.SPLASH_ICON_RADIUS;
    }
  }

  @override
  Widget build(BuildContext context) {
    printInfoMessage('[BUILD] SplashScreen');
    final theme = Theme.of(context);
    final onPrimary = theme.colorScheme.onPrimary;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(decoration: BoxDecoration(color: theme.primaryColor)),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: getRadius() * 2,
                          maxWidth: getRadius() * 2,
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: getRadius(),
                            child: const SplashIcon(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppConstants.SPLASH_TITLE_TEXT,
                        style: TextStyle(
                          color: onPrimary,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppConstants.SPLASH_TITLE_FONT,
                          fontSize: AppConstants.SPLASH_TITLE_TEXT_SIZE,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          AppConstants.SPLASH_SUBTITLE_TEXT,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: onPrimary.withValues(alpha: 0.9),
                            fontSize: AppConstants.SPLASH_SUBTITLE_TEXT_SIZE,
                            fontFamily: AppConstants.SPLASH_MESSAGE_FONT,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          AppConstants.SPLASH_MESSAGE,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: AppConstants.SPLASH_MESSAGE_FONT_SIZE,
                            fontFamily: AppConstants.SPLASH_MESSAGE_FONT,
                            color: onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(onPrimary),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'v' + _versionName,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: AppConstants.SPLASH_MESSAGE_FONT_SIZE,
                            fontFamily: AppConstants.SPLASH_MESSAGE_FONT,
                            color: onPrimary,
                          ),
                        ),
                      ),
                    ],
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

class SplashIcon extends StatelessWidget {
  const SplashIcon({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double size;
    if (width <= AppConstants.DEVICE_SMALL_RES) {
      size = AppConstants.SPLASH_ICON_SIZE_SMALL;
    } else {
      size = AppConstants.SPLASH_ICON_SIZE;
    }

    var assetImage = new AssetImage('assets/images/khanda.png');
    var image = new Image(image: assetImage, width: size, height: size);
    return new Container(child: image);
  }
}
