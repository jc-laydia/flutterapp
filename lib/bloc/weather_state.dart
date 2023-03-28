part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final _weather;
  WeatherLoaded(this._weather);

  WeatherModel get getWeather => _weather;
  @override
  List<Object> get props => [_weather];
}

class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);
}

class ResetWeatherState extends WeatherState {
  @override
  String toString() => 'InitializePageState';
}
