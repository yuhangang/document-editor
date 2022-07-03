import 'package:auto_route/auto_route.dart';
import 'package:core/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/presentation/bloc/city_bloc/city_bloc.dart';
import 'package:weatherapp/presentation/widget/home/current_weather_tab/widgets/city_list_error_view.dart';
import 'package:weatherapp/presentation/widget/home/current_weather_tab/widgets/malaysian_city_list_tile.dart';

class ForecastCitySelectionPage extends StatefulWidget
    implements AutoRouteWrapper {
  const ForecastCitySelectionPage({Key? key}) : super(key: key);

  @override
  State<ForecastCitySelectionPage> createState() =>
      _ForecastCitySelectionPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CityBloc>(
      create: (context) => sl.get<CityBloc>(),
      child: this,
    );
  }
}

class _ForecastCitySelectionPageState extends State<ForecastCitySelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 85, 76, 76)),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
           centerTitle: true,
        title: Text(
          "Managing Selected Cities",
          style: Theme.of(context).textTheme.headline6,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      body: RefreshIndicator(
        color: const Color.fromARGB(255, 129, 92, 12),
        onRefresh: () async {
          BlocProvider.of<CityBloc>(context).add(OnLoadCity());
        },
        child: BlocBuilder<CityBloc, CityState>(
          bloc: sl.get<CityBloc>(),
          builder: (context, cityState) {
            if (cityState is CityDoneLoad) {
              return ListView.separated(
                   physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 12, bottom: 100),
                itemCount: cityState.cities.length,
                itemBuilder: (context, index) {
                  final city = cityState.cities[index];

                  return MalaysianCityListTile(
                    onTap: () {
                      if (cityState.selectedCities.contains(city)) {
                        sl.get<CityBloc>().add(OnRemoveSelectedCity(city: city));
                      } else {
                   sl.get<CityBloc>().add(OnAddSelectedCity(city: city));
                      }
                    },
                    city: city,
                    isFocus: cityState.selectedCities.contains(city),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
              );
            } else if (cityState is CityLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 129, 92, 12),
                ),
              );
            }

            return  const CityListErrorView();
          },
        ),
      ),
    );
  }
}
