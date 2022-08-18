import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/presentation/bloc/city_bloc/city_bloc.dart';

class CityListErrorView extends StatelessWidget {
  const CityListErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Failed to Fetch City List"),
            TextButton(
              onPressed: () {
                BlocProvider.of<CityBloc>(context).add(OnRefreshCity());
              },
              child: Text(
                "Tap to Refresh",
                style: TextStyle(color: Colors.brown[800]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
