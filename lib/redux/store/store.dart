import 'package:nitnem/redux/middleware/middleware.dart';
import 'package:nitnem/redux/reducers/app_state_reducer.dart';
import 'package:nitnem/state/appoptions.dart';
import 'package:nitnem/state/appstate.dart';
import 'package:redux/redux.dart';

Store<AppState> createStore(AppOptions initialOptions) {
  return Store(
    appReducer,
    initialState: AppState(
      options: initialOptions,
      showReaderOptions: false,
      pathData: '',
      pathFilePrefix: '',
      pathTitle: '',
      pathId: 1,
    ),
    middleware: [storeOptionsMiddleware],
  );
}
