import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent', event!);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('onError', error);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(
        'onTransition',
        '\tcurrentState=${transition.currentState}\n' +
            '\tnextState=${transition.nextState}');
  }

  void log(String name, Object msg) {
    log("message", msg);
    log(
        '===== ${DateFormat("HH:mm:ss-dd MMM, yyyy").format(DateTime.now())}: $name\n'
        '$msg');
  }
}
