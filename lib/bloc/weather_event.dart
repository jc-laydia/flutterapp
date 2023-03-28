part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class LoadWeather extends WeatherEvent {
  final _query;
  LoadWeather(this._query);
  @override
  List<Object> get props => [_query];
}

class ResetWeather extends WeatherEvent {}
