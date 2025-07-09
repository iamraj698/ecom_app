import 'package:flutter_bloc/flutter_bloc.dart';
import 'demo.dart';

class DemoBloc extends Bloc<DemoEvent, DemoState> {
  DemoBloc() : super(InitialState()) {
    on<InitEvent>(initFunction);
  }
  void initFunction(InitEvent event, Emitter<DemoState> emit) {
    // demo function and the demostate and events for the reference of how to use the bloc
  }
}
