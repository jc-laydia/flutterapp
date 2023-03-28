import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_bus_plus/res/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/repo/api_repo.dart';

import '../models/weathermodel.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo weatherRepo;
  WeatherBloc(this.weatherRepo) : super(WeatherInitial());

  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is LoadWeather) {
      print('weather loaded');
      yield WeatherLoading();
      try {
        final weather = await weatherRepo.getWeather(event._query);
        yield WeatherLoaded(weather);
      } catch (e) {
        yield const WeatherError('Weather not loaded');
      }
    } else if (event is ResetWeather) {
      yield WeatherInitial();
    }
  }
}
