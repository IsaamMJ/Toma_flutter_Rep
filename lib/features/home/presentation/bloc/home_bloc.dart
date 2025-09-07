import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  void _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());

    try {
      // Simulate loading data
      await Future.delayed(const Duration(milliseconds: 500));
      emit(const HomeLoaded());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}