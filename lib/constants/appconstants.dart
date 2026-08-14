import 'package:flutter/foundation.dart';

class AppConstants {
  //Splash Screen
  static const double SPLASH_WAIT_SECONDS = 3.5;
  static const String SPLASH_TITLE_TEXT = 'NITNEM';
  static const double SPLASH_TITLE_TEXT_SIZE = 42.0;
  static const double SPLASH_SUBTITLE_TEXT_SIZE = 16.0;
  static const double SPLASH_MESSAGE_FONT_SIZE = 14.0;
  static const String ROBOTO_SLAB_FONT = 'RobotoSlab';
  static const String KINGTHINGS_FONT = 'Kingthings';
  static const String GURAKHAR_FONT = 'Gurakhar';
  static const String GURBANI_HINDI_FONT = 'Gurbanihindi';
  static const String SPLASH_TITLE_FONT = KINGTHINGS_FONT;
  static const String SPLASH_MESSAGE_FONT = ROBOTO_SLAB_FONT;
  static const double SPLASH_ICON_SIZE = 256.0;
  static const double SPLASH_ICON_SIZE_SMALL = 128.0;
  static const double SPLASH_ICON_RADIUS = 140.0;
  static const double SPLASH_ICON_RADIUS_SMALL = 80.0;
  static const String SPLASH_MESSAGE =
      """Waheguruji ka khalsa, Waheguruji ki fateh. 
  Sangat ji. Please respectfully cover 
  your head and remove your shoes.""";
  static const String SPLASH_SUBTITLE_TEXT =
      'Nitnem (ਨਿਤਨੇਮ) means "daily discipline." It combines Nit (daily) and Nem (discipline or practice).';

  //Home Screen
  static const String HOME_TITLE_TEXT = 'ੴ ਸਤਿ ਗੁਰ ਪ੍ਰਸਾਦਿ';
  static const String HOME_TITLE_FONT = 'Roboto';
  static const double HOME_TITLE_FONT_SIZE = 18.0;
  static const double HOME_TITLE_FONT_SIZE_SMALL = 12.0;
  static const String HOME_LISTITEM_FONT = KINGTHINGS_FONT;
  static const double HOME_LISTITEM_FONT_SIZE = 26.0;
  static const String HOME_LISTSUBITEM_FONT = GURAKHAR_FONT;
  static const double HOME_LISTSUBITEM_FONT_SIZE = 20.0;
  static const double HOME_FLORAL_WIDTH = 56;
  static const double HOME_BOOK_ICON_SIZE = 48.0;

  //Reader Screen
  static const double READER_PADDING = 15.0;
  static const double TEXTSCALE_MIN = 0.5;
  static const double TEXTSCALE_MAX = 3.0;
  static const double EXPANDED_APP_BAR = 600.0;
  static const double COLLAPSED_APP_BAR = 20.0;
  static const String EMPTY_STRING = '';

  //Reader Screen - Status Bar Component
  static const double STATUSBAR_PADDING = 2.0;
  static const double STATUSBAR_FONT_SIZE = 11.0;
  static const double STATUSBAR_FONT_SIZE_SMALL = 9.0;
  static const String STATUSBAR_FONT_FAMILY = 'Roboto';
  static const int STATUS_TIME_UPDATE_INTERVAL_SECONDS = 60;

  //Reader Screen - Theme Background Opacity
  static const double READERTHEME_BACK_OPACITY = 0.40;

  //Others
  static const String FEEDBACK_URL =
      'https://github.com/codemanxdev/nitnem/issues/new';
  static const String CONTACT_EMAIL = 'codemanxdev@gmail.com';
  static const String OPTIONS_SHAREDPREF_KEY = 'OPTIONS';
  static const double OPTIONS_LABEL_FONT_SIZE = 15.0;
  static const double OPTIONS_SUBTITLE_FONT_SIZE = 12.0;
  static const int DEVICE_SMALL_RES = 320;
  static const bool LOGGING_ENABLED = !kReleaseMode;
}
