import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/models/weathermodel.dart';
import 'package:weather_app/repo/api_repo.dart';
import 'package:weather_app/screens/homescreen.dart';

class ShowWeather extends StatelessWidget {
  WeatherModel weather;
  final city;
  ShowWeather(this.weather, this.city);

  @override
  Widget build(BuildContext context) {
    var cityController = TextEditingController();
    String icon = weather.icon;
    String iconUrl = 'https://openweathermap.org/img/wn/$icon.png';
    return BlocProvider(
      create: (context) => WeatherBloc(WeatherRepo()),
      child: Column(
        children: [
          Container(
            width: 400,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.deepOrangeAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    city.toString(),
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 120,
                    width: 130,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          image: NetworkImage(iconUrl),
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${weather.temp.toString()}',
                        style: GoogleFonts.montserrat(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(66, 28, 27, 27)),
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              '°C',
                              style: GoogleFonts.montserrat(
                                  textStyle:
                                      Theme.of(context).textTheme.headline4,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(66, 28, 27, 27)),
                            ),
                          ),
                          Text(''),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    weather.desc.toString(),
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          microDetails(
              context, weather.tempmin, weather.tempmax, weather.humidity),
          TextButton(
              onPressed: () {
                BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
              },
              child: Text('Search again'))
        ],
      ),
    );
  }
}

// Widget test() {
//   return Container(
//     height: 200,
//     width: 600,
//     color: Colors.orangeAccent,
//   );
// }
Widget microDetails(
    BuildContext context, String tempmin, String tempmax, String humidity) {
  final List items = [tempmin, tempmax, humidity];
  final List itemName = [
    'Minimum Temperature',
    'Maximun Temperature',
    'Humidity'
  ];
  return Container(
    height: 200,
    width: 600,
    child: ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        final itemValue = itemName[index];
        return Column(
          children: [
            ListTile(
              title: Text(
                itemValue,
                style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.deepOrangeAccent),
              ),
              trailing: Text(
                '$item  °C',
                style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.deepOrangeAccent),
              ),
            ),
            Divider(
              height: 2,
              color: Colors.deepOrangeAccent,
            ),
          ],
        );
      },
    ),
  );
}
