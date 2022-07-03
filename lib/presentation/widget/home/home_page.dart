import 'package:auto_route/auto_route.dart';
import 'package:core/core/commons/app_env.dart';
import 'package:core/core/di/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/core/navigation/router/app_router.dart';
import 'package:weatherapp/presentation/bloc/city_bloc/city_bloc.dart';
import 'package:weatherapp/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';
import 'package:weatherapp/presentation/bloc/weather_forecast_bloc/weather_forecast_bloc.dart';
import 'package:weatherapp/presentation/widget/home/current_weather_tab/home_page_current_weather_tab.dart';
import 'package:weatherapp/presentation/widget/home/forecast_tab/home_page_forecast_tab.dart';

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
      ),
      BlocProvider<CurrentWeatherBloc>(
        create: (_) => sl.get<CurrentWeatherBloc>(),
      )
    ], child: this);
  }
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  final PageController _pageController = PageController();
  @override
  void initState() {
    BlocProvider.of<CityBloc>(context).add(OnRefreshCity());
    BlocProvider.of<WeatherForecastBloc>(context).add(OnLoadWeatherForecast());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        
        appBar: AppBar(
          title: Text(
            "Weather App",
            style: Theme.of(context).textTheme.headline6,
          ),
          centerTitle: true,
            iconTheme: const IconThemeData(color: Color.fromARGB(255, 85, 76, 76)),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            if (pageIndex == 0)
              Tooltip(
                message: "Use Current Location",
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<CurrentWeatherBloc>(context)
                        .add(OnChangeCurrentWeatherToUserCurrentLocation());
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 238, 233, 233), shape: BoxShape.circle),
                    child: const Center(
                        child: Icon(
                      CupertinoIcons.location_fill,
             
                    )),
                  ),
                ),
              ),
            if (pageIndex == 1)
              Tooltip(
                message: "City Selection Settings",
                child: GestureDetector(
                  onTap: () {
                    AutoRouter.of(context)
                        .push(const ForecastCitySelectionPageRoute());
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 238, 233, 233), shape: BoxShape.circle),
                    child: const Center(
                        child: Icon(
                      CupertinoIcons.add,
                   
                    )),
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: pageIndex,
            backgroundColor: Colors.white.withOpacity(0.8),
            onTap: (index) => _pageController.jumpToPage(index),
            selectedItemColor: Colors.brown[900],
            unselectedItemColor: Colors.grey[500],
            selectedFontSize: 14,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.today), label: "Current Weather"),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.calendar,
                  ),
                  label: "Forecast")
            ]),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          children: const [
            HomePageCurrentWeatherTab(),
            HomePageForecastTab()
          ],
        ));
  }
}

