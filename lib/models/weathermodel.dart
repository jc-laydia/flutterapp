class WeatherModel {
  final String temp;
  final String city;
  final String desc;
  final String icon;
  final String tempmin;
  final String tempmax;
  final String humidity;

  WeatherModel(
      {required this.temp,
      required this.city,
      required this.desc,
      required this.icon,
      required this.tempmin,
      required this.tempmax,
      required this.humidity});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final temp = json['main']['temp'].toString();
    final tempmin = json['main']['temp_min'].toString();
    final tempmax = json['main']['temp_max'].toString();
    final humidity = json['main']['humidity'].toString();
    final city = json['name'];
    final desc = json['weather'][0]['description'].toString();
    final icon = json['weather'][0]['icon'].toString();

    return WeatherModel(
        temp: temp,
        city: city,
        desc: desc,
        icon: icon,
        tempmin: tempmin,
        tempmax: tempmax,
        humidity: humidity);
  }
}
