import 'package:auto_route/auto_route.dart';
import 'package:core/core/commons/app_env.dart';
import 'package:core/core/di/service_locator.dart';
import 'package:core/core/model/city.dart';
import 'package:core/core/model/model.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/presentation/bloc/city_bloc/city_bloc.dart';
import 'package:weatherapp/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';
import 'package:weatherapp/presentation/bloc/weather_forecast_bloc/weather_forecast_bloc.dart';

class HomePage extends StatefulWidget implements AutoRouteWrapper {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<WeatherForecastBloc>(
        create: (_) => sl.get<WeatherForecastBloc>(
            param1: sl.get<AppEnv>().defaultLocation),
      ),
      BlocProvider<CityBloc>(
        create: (_) => sl.get<CityBloc>(),
      )
    ], child: this);
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<CityBloc>(context).add(OnRefreshCity());
    BlocProvider.of<WeatherForecastBloc>(context).add(OnLoadWeatherForecast());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          
          title: Text(
            "Weather App",
            style: Theme.of(context).textTheme.headline6,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(5),
              decoration:
                  BoxDecoration(color: Colors.grey[350], shape: BoxShape.circle),
                  child: const Center(child: Icon(true?Icons.location_city_outlined:CupertinoIcons.location_fill)),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<CityBloc>(context).add(OnLoadCity());
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                BlocBuilder<CityBloc, CityState>(
                  builder: (context, cityState) {
                    if (cityState is CityDoneLoad) {
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          final city = cityState.cities[index];
                          return WeatherCard(city: city);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                      );
                    } else if (cityState is CityLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class WeatherCard extends StatefulWidget {
  const WeatherCard({
    Key? key,
    required this.city,
  }) : super(key: key);

  final MalaysianCity city;

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  late final CurrentWeatherBloc currentWeatherBloc;

  @override
  void initState() {
    currentWeatherBloc =
        CurrentWeatherBloc(widget.city.coord, sl.get<IForecastRepository>());
    currentWeatherBloc.add(OnLoadCurrentWeather());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.yellow[700]!.withOpacity(0.7),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
            bloc: currentWeatherBloc,
            builder: (context, state) {
              final CurrentWeather? currentWeather =
                  state is CurrentWeatherDoneLoad ? state.weather : null;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_getTodayDescription),
                          Text(
                            widget.city.city,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            _getStateCountryDescription(widget.city),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.black54),
                          ),
                        ],
                      )),
                      const Icon(CupertinoIcons.sun_max)
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${currentWeather?.main.tempMax.toString() ?? "-"} °C to ${currentWeather?.main.tempMax.toString() ?? "-"} °C",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  )
                ],
              );
            },
          )),
    );
  }

  String get _getTodayDescription {
    final time = DateTime.now();
    return "";
  }

  String _getStateCountryDescription(MalaysianCity city) {
    if (city.capital == 'primary') {
      return "Capital of ${city.country}";
    }
    return "${city.adminName}, ${city.country}";
  }
}
