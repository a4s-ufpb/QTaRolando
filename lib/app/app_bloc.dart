import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:local_events/models/event.dart';
import 'package:rxdart/subjects.dart';

class AppBloc extends BlocBase {
  var userController = BehaviorSubject<Evento>();

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    userController.close();
    super.dispose();
  }
}
