// ignore_for_file: unnecessary_const, depend_on_referenced_packages

import 'package:collection/collection.dart';
import 'package:core/core/di/service_locator.dart';
import 'package:core/core/model/city.dart';
import 'package:core/core/model/model.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/presentation/bloc/weather_forecast_bloc/weather_forecast_bloc.dart';
import 'package:weatherapp/presentation/widget/home/widgets/weather_card_temp_item.dart';
import 'package:weatherapp/presentation/widget/home/widgets/weather_card_utils.dart';

class WeatherForecastCard extends StatefulWidget {
  final MalaysianCity city;
  const WeatherForecastCard({Key? key, required this.city}) : super(key: key);

  @override
  State<WeatherForecastCard> createState() => _WeatherForecastCardState();
}

class _WeatherForecastCardState extends State<WeatherForecastCard> {
  late final WeatherForecastBloc _weatherForecastBloc;

  @override
  void initState() {
    _weatherForecastBloc =
        WeatherForecastBloc(widget.city.coord, sl.get<IForecastRepository>());
    _weatherForecastBloc.add(OnLoadWeatherForecast());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherForecastBloc, WeatherForecastState>(
      builder: (context, state) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (state is WeatherForecastFailed) {
              _weatherForecastBloc.add(OnRefreshWeatherForecast());
            }
          },
          child: AnimatedContainer(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: state is WeatherForecastFailed
                      ? Colors.pink[100]
                      : Colors.yellow[700]!.withOpacity(0.7),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: BlocBuilder<WeatherForecastBloc, WeatherForecastState>(
                bloc: _weatherForecastBloc,
                builder: (context, state) {
                  if (state is WeatherForecastLoading ||
                      state is WeatherForecastInitial) {
                    return const Center(
                      child: const CircularProgressIndicator(
                        color: const Color.fromARGB(255, 211, 204, 204),
                      ),
                    );
                  } else if (state is WeatherForecastFailed) {
                    return Center(
                        child: Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    const Color.fromARGB(101, 250, 247, 247)),
                            child:
                                const Icon(CupertinoIcons.refresh, size: 60)));
                  }

                  final WeatherForecastFiveDay? weatherForecast =
                      state is WeatherForecastDoneLoad ? state.forecast : null;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildForecastCardTopSession(
                          state, context, weatherForecast),
                      if (weatherForecast != null)
                        Wrap(
                            spacing: 10,
                            children: weatherForecast.list
                                .map((e) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 2.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(e.weather.firstOrNull?.getIcon),
                                          Text("${e.main.tempMin.round()}"),
                                          Text("${e.main.tempMax.round()}")
                                        ],
                                      ),
                                    ))
                                .toList()),
                      _buildForecastCardBottomSession(weatherForecast, context)
                    ],
                  );
                },
              )),
        );
      },
    );
  }

  Column _buildForecastCardTopSession(WeatherForecastState state,
      BuildContext context, WeatherForecastFiveDay? weatherForecast) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.city.city,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.brown[800]),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
            
          
          ],
        ),
        Text(
          WeatherCardHelper.getStateCountryDescription(widget.city),
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }

  Column _buildForecastCardBottomSession(
      WeatherForecastFiveDay? weatherForecast, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Current weather is ${toBeginningOfSentenceCase(weatherForecast?.list.firstOrNull?.weather.firstOrNull?.description ?? "") ?? ''}",
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${weatherForecast?.list.firstOrNull?.main.tempMin.toStringAsFixed(1) ?? "-"} °C to ${weatherForecast?.list.firstOrNull?.main.tempMax.toStringAsFixed(1) ?? "-"} °C",
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
        Wrap(
          spacing: 25,
          alignment: WrapAlignment.end,
          children: [
            SmallDataItem(
                title: "Feels Like:",
                data:
                    "${weatherForecast?.list.firstOrNull?.main.feelsLike ?? ""} °C"),
            SmallDataItem(
                title: "Pressure:",
                data: weatherForecast?.list.firstOrNull?.main.pressure
                        .toStringAsFixed(0) ??
                    "-"),
            SmallDataItem(
                title: "Humidity:",
                data: weatherForecast?.list.firstOrNull?.main.humidity
                        .toStringAsFixed(0) ??
                    "-"),
          ],
        ),
      ],
    );
  }
}
