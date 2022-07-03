// ignore_for_file: unnecessary_const, depend_on_referenced_packages

import 'package:core/core/model/city.dart';
import 'package:core/core/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:weatherapp/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';

class CurrentWeatherCard extends StatefulWidget {
  const CurrentWeatherCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CurrentWeatherCard> createState() => _CurrentWeatherCardState();
}

class _CurrentWeatherCardState extends State<CurrentWeatherCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
      builder: (context, state) {
        final MalaysianCity? selectedCity =
            state.location?.fold((l) => null, (r) => r);

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (state is CurrentWeatherFailed) {
              BlocProvider.of<CurrentWeatherBloc>(context)
                  .add(OnRefreshCurrentWeather());
            }
          },
          child: AspectRatio(
            aspectRatio: 5 / 4,
            child: AnimatedContainer(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: state is CurrentWeatherFailed
                        ? Colors.pink[100]
                        : Colors.yellow[700]!.withOpacity(0.7),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
                  builder: (context, state) {
                    if (state is CurrentWeatherLoading || state is CurrentWeatherInitial) {
                      return const Center(
                        child: const CircularProgressIndicator(
                          color: const Color.fromARGB(255, 211, 204, 204),
                        ),
                      );
                    }else if (state is CurrentWeatherFailed){
                      return Center(child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color.fromARGB(
                                          101, 250, 247, 247)),
                                  child: const Icon(CupertinoIcons.refresh,
                                      size: 60)));
                    }

                    final CurrentWeather? currentWeather =
                        state is CurrentWeatherDoneLoad ? state.weather : null;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                FittedBox(
                                  child: Text(
                                    selectedCity?.city ?? 'My Current Location',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.brown[800]),
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                             
                                Text(
                                  selectedCity != null
                                      ? MalaysianCityDescriptionHelper
                                          .getStateCountryDescription(
                                              selectedCity)
                                      : "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: Colors.black54),
                                ),
                                   FittedBox(
                                  child: Text(
                                 toBeginningOfSentenceCase(currentWeather?.weather.firstOrNull?.description??"")??'',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.brown[800]),
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(CupertinoIcons.sun_max),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      (currentWeather?.sys.sunrise == null)
                                          ? ""
                                          : DateFormat('HH:MM').format(DateTime
                                                  .fromMicrosecondsSinceEpoch(
                                                      currentWeather
                                                              ?.sys.sunrise ??
                                                          0)
                                              .toLocal()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const Icon(CupertinoIcons.moon_stars),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      (currentWeather?.sys.sunset == null)
                                          ? ""
                                          : DateFormat('HH:MM').format(DateTime
                                                  .fromMicrosecondsSinceEpoch(
                                                      currentWeather
                                                              ?.sys.sunset ??
                                                          0)
                                              .toLocal()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.black54),
                                    )
                                  ],
                                ),
                              ],
                            )),
                            if (state is CurrentWeatherFailed)
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color.fromARGB(
                                          101, 250, 247, 247)),
                                  child: const Icon(CupertinoIcons.refresh,
                                      size: 35))
                            else if (state is CurrentWeatherDoneLoad && state.weather.weather.firstOrNull?.getIcon !=null)
Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(state.weather.weather.first.getIcon, size: 35),
                              )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "${currentWeather?.main.tempMin.toStringAsFixed(1) ?? "-"} °C to ${currentWeather?.main.tempMax.toStringAsFixed(1) ?? "-"} °C",
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
                                        "${currentWeather?.main.feelsLike ?? ""} °C"),
                                SmallDataItem(
                                    title: "Pressure:",
                                    data: currentWeather?.main.pressure
                                            .toStringAsFixed(0) ??
                                        "-"),
                                SmallDataItem(
                                    title: "Humidity:",
                                    data: currentWeather?.main.humidity
                                            .toStringAsFixed(0) ??
                                        "-"),
                              ],
                            ),
                          ],
                        )
                      ],
                    );
                  },
                )),
          ),
        );
      },
    );
  }

  String get _getTodayDescription {
    final time = DateTime.now();
    return DateFormat('EEEE ,yyyy-MM-dd').format(time);
  }

  String _getStateCountryDescription(MalaysianCity? city) {
    if (city?.capital == 'primary') {
      return "Capital of ${city?.country}";
    }
    return "${city?.adminName}, ${city?.country}";
  }
}

class SmallDataItem extends StatelessWidget {
  final String title;
  final String data;
  const SmallDataItem({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          data,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}

abstract class MalaysianCityDescriptionHelper {
  static String getStateCountryDescription(MalaysianCity city) {
    if (city.capital == 'primary') {
      return "Capital of ${city.country}";
    }
    return "${city.adminName}, ${city.country}";
  }
}

extension on Weather {
  IconData? get getIcon{
    switch(description){
      case "clear sky":
         return CupertinoIcons.sun_max;
      case "few clouds":
        return CupertinoIcons.cloud_sun;
      case "scattered clouds":
       return CupertinoIcons.cloud_sun;
      case "broken clouds":
       return CupertinoIcons.cloud;
      case "overcast clouds":
       return CupertinoIcons.cloud;
      case "shower rain":
            return CupertinoIcons.cloud_rain;
      case "rain":
                return CupertinoIcons.cloud_rain_fill;
      case "thunderstorm":
         return CupertinoIcons.cloud_bolt_fill;
      case "snow":
         return CupertinoIcons.snow;
      case "mist":
             return CupertinoIcons.sun_dust;
      default:
       return null;
    }
  }
}