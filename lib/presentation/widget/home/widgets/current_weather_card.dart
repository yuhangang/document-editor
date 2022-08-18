// ignore_for_file: unnecessary_const, depend_on_referenced_packages, prefer_initializing_formals

import 'package:core/core/model/city.dart';
import 'package:core/core/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:weatherapp/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';
import 'package:weatherapp/presentation/widget/home/widgets/weather_card_temp_item.dart';
import 'package:weatherapp/presentation/widget/home/widgets/weather_card_utils.dart';

class CurrentWeatherCard extends StatefulWidget {
  final WeatherForecast? weatherForecast;
  final MalaysianCity? city;
  const CurrentWeatherCard({
    Key? key,
  })  : weatherForecast = null,
        city = null,
        super(key: key);

  const CurrentWeatherCard.withForecastResult({
    Key? key,
    required WeatherForecast weatherForecast,
    required MalaysianCity city,
  })  : weatherForecast = weatherForecast,
        city = city,
        super(key: key);

  @override
  State<CurrentWeatherCard> createState() => _CurrentWeatherCardState();
}

class _CurrentWeatherCardState extends State<CurrentWeatherCard>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.weatherForecast != null && widget.city != null) {
      final mainData = widget.weatherForecast?.main;
      return AspectRatio(
        aspectRatio: 5 / 4,
        child: AnimatedContainer(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: _buildContent(
              widget.city,
              context,
              null,
              minTemp: mainData?.tempMin,
              time: DateTime.tryParse(widget.weatherForecast!.dtTxt)?.toLocal(),
              sys: null,
              maxTemp: mainData?.tempMax,
              weather: widget.weatherForecast?.weather.firstOrNull,
              feelsLike: mainData?.feelsLike,
              pressure: mainData?.pressure,
              humidity: mainData?.humidity,
            )),
      );
    }

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
          onDoubleTap: () {
            BlocProvider.of<CurrentWeatherBloc>(context)
                .add(OnRefreshCurrentWeather());
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
                child: Builder(
                  builder: (context) {
                    if (state is CurrentWeatherLoading ||
                        state is CurrentWeatherInitial) {
                      return const Center(
                        child: const CircularProgressIndicator(
                          color: const Color.fromARGB(255, 211, 204, 204),
                        ),
                      );
                    } else if (state is CurrentWeatherFailed) {
                      return Center(
                          child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      const Color.fromARGB(101, 250, 247, 247)),
                              child: const Icon(CupertinoIcons.refresh,
                                  size: 60)));
                    }

                    final CurrentWeather? currentWeather =
                        state is CurrentWeatherDoneLoad ? state.weather : null;
                    final CurrentWeatherMainData? mainData =
                        currentWeather?.main;
                    return _buildContent(
                      selectedCity,
                      context,
                      state,
                      sys: currentWeather?.sys,
                      minTemp: mainData?.tempMin,
                      maxTemp: mainData?.tempMax,
                      weather: currentWeather?.weather.firstOrNull,
                      feelsLike: mainData?.feelsLike,
                      pressure: mainData?.pressure,
                      humidity: mainData?.humidity,
                    );
                  },
                )),
          ),
        );
      },
    );
  }

  Column _buildContent(MalaysianCity? selectedCity, BuildContext context,
      CurrentWeatherState? state,
      {required Sys? sys,
      required Weather? weather,
      required double? maxTemp,
      required double? minTemp,
      required double? feelsLike,
      required int? pressure,
      required int? humidity,
      DateTime? time}) {
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
                Text(WeatherCardHelper.getTodayDescription(dateTime: time)),
                FittedBox(
                  child: Text(
                    selectedCity?.city ?? 'My Current Location',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.brown[800]),
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  selectedCity != null
                      ? WeatherCardHelper.getStateCountryDescription(
                          selectedCity)
                      : "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black54),
                ),
                FittedBox(
                  child: Text(
                    toBeginningOfSentenceCase(weather?.description ?? "") ?? '',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w300, color: Colors.brown[800]),
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                  ),
                ),
                if (widget.weatherForecast == null || widget.city == null)
                  Row(
                    children: [
                      const Icon(CupertinoIcons.sun_max),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        (sys?.sunrise == null)
                            ? ""
                            : DateFormat('HH:MM').format(
                                DateTime.fromMicrosecondsSinceEpoch(
                                        sys?.sunrise ?? 0)
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
                        (sys?.sunset == null)
                            ? ""
                            : DateFormat('HH:MM').format(
                                DateTime.fromMicrosecondsSinceEpoch(
                                        sys?.sunset ?? 0)
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
                      color: const Color.fromARGB(101, 250, 247, 247)),
                  child: const Icon(CupertinoIcons.refresh, size: 35))
            else if (state is CurrentWeatherDoneLoad &&
                state.weather.weather.firstOrNull?.getIcon != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(state.weather.weather.first.getIcon, size: 35),
              )
            else if (widget.weatherForecast != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(widget.weatherForecast?.weather.first.getIcon,
                    size: 35),
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
                  "${minTemp?.toStringAsFixed(1) ?? "-"} °C to ${maxTemp?.toStringAsFixed(1) ?? "-"} °C",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            Wrap(
              spacing: 25,
              alignment: WrapAlignment.end,
              children: [
                SmallDataItem(
                    title: "Feels Like:", data: "${feelsLike ?? ""} °C"),
                SmallDataItem(
                    title: "Pressure:",
                    data: pressure?.toStringAsFixed(0) ?? "-"),
                SmallDataItem(
                    title: "Humidity:",
                    data: humidity?.toStringAsFixed(0) ?? "-"),
              ],
            ),
          ],
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
