import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/screens/show_weather.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    var cityController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                  if (state is WeatherInitial) {
                    return searchCity(context, cityController);
                  } else if (state is WeatherLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is WeatherLoaded)
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => ShowWeather(
                    //           state.getWeather, cityController.text)),
                    // );
                    return ShowWeather(state.getWeather, cityController.text);
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Invalid City Found',
                        style: GoogleFonts.montserrat(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrangeAccent),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            BlocProvider.of<WeatherBloc>(context)
                                .add(ResetWeather());
                          },
                          child: Text('Seach again'))
                    ],
                  ));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container searchCity(
      BuildContext context, TextEditingController cityController) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Container(
            height: 170,
            width: 180,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/weather.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Weather App',
            style: GoogleFonts.montserrat(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            textCapitalization: TextCapitalization.characters,
            controller: cityController,
            decoration: InputDecoration(
                hintText: 'Enter city name',
                hintStyle: GoogleFonts.montserrat(
                    //textStyle: TextStyle(color: Colors.white),
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white)),
                focusColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.home,
                  color: Colors.white,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(250, 50), primary: Colors.deepOrangeAccent),
              onPressed: () {
                // context
                //     .read<WeatherBloc>().
                // .add(LoadWeather(cityController.text));
                BlocProvider.of<WeatherBloc>(context)
                    .add(LoadWeather(cityController.text));
              },
              child: Text(
                'Search',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(color: Colors.white),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              )),
        ],
      ),
    );
  }
}
