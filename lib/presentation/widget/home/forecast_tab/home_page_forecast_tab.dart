import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/presentation/bloc/city_bloc/city_bloc.dart';
import 'package:weatherapp/presentation/widget/home/widgets/weather_forecast_card.dart';

class HomePageForecastTab extends StatefulWidget {
  const HomePageForecastTab({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageForecastTab> createState() => _HomePageForecastTabState();
}

class _HomePageForecastTabState extends State<HomePageForecastTab> {
  ValueNotifier<int> carousselIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityBloc, CityState>(
      builder: (context, cityState) {
        final selectedCityList = cityState.selectedCities;
        if (carousselIndex.value > selectedCityList.length - 1) {
          carousselIndex.value = selectedCityList.length - 1;
        }
        if (selectedCityList.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: cityState.selectedCities.length,
                  itemBuilder: (context, index, realIndex) {
                    return WeatherForecastCard(
                        city: cityState.selectedCities[index]);
                  },
                  options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        carousselIndex.value = index;
                      },
                      aspectRatio: 2 / 3,
                      viewportFraction: 0.85,
                      enableInfiniteScroll: false),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.075 + 15),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ValueListenableBuilder<int>(
                            valueListenable: carousselIndex,
                            builder: (context, value, child) {
                              return Text(
                                '${value + 1} /',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(fontWeight: FontWeight.w300),
                              );
                            }),
                        Text(
                          "${cityState.selectedCities.length}",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(fontWeight: FontWeight.w300),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          );
        }

        return const Center(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text("U haven't choose any city yet"),
          ),
        );
      },
    );
  }
}
