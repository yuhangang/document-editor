// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/presentation/bloc/city_bloc/city_bloc.dart';
import 'package:weatherapp/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';
import 'package:weatherapp/presentation/widget/home/current_weather_tab/widgets/malaysian_city_list_tile.dart';
import 'package:weatherapp/presentation/widget/home/widgets/current_weather_card.dart';

class HomePageCurrentWeatherTab extends StatefulWidget {
  const HomePageCurrentWeatherTab({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageCurrentWeatherTab> createState() =>
      _HomePageCurrentWeatherTabState();
}

class _HomePageCurrentWeatherTabState extends State<HomePageCurrentWeatherTab> {
  bool isStart = true;

  @override
  void initState() {
    BlocProvider.of<CurrentWeatherBloc>(context).add(OnLoadCurrentWeather());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: CurrentWeatherCard(),
        ),
        Expanded(
          child: RefreshIndicator(
            color: const Color.fromARGB(255, 129, 92, 12),
            onRefresh: () async {
              BlocProvider.of<CityBloc>(context).add(OnLoadCity());
            },
            child: BlocBuilder<CityBloc, CityState>(
              builder: (context, cityState) {
                if (cityState is CityDoneLoad) {
                  return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
                    builder: (context, currentWeatherState) {
                      return ListView.separated(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 12, bottom: 100),
                        itemCount: cityState.cities.length,
                        itemBuilder: (context, index) {
                          final city = cityState.cities[index];
                          final bool isFocus = city ==
                              currentWeatherState.location?.fold((l) => null, (r) => r);
                          return MalaysianCityListTile(onTap: (){
                                BlocProvider.of<CurrentWeatherBloc>(context)
          .add(OnChangeCurrentWeatherCity(city: city));
                          },city: city,isFocus: isFocus,);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                      );
                    },
                  );
                } else if (cityState is CityLoading) {
                  return const Center(
                      child: CircularProgressIndicator(color: Color.fromARGB(255, 129, 92, 12),),
                  );
                }

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Failed to Fetch City List"),
                        TextButton(onPressed: (){
                          BlocProvider.of<CityBloc>(context).add(OnRefreshCity());
                        },child:  Text("Tap to Refresh",style: TextStyle(color: Colors.brown[800]),),)
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
