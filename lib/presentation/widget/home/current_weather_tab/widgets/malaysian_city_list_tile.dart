import 'package:core/core/model/city.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/presentation/widget/home/widgets/weather_card_utils.dart';

class MalaysianCityListTile extends StatelessWidget {
  const MalaysianCityListTile({
    Key? key,
    required this.city,
    required this.isFocus,
    required this.onTap,
  }) : super(key: key);

  final MalaysianCity city;
  final bool isFocus;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 241, 236, 216),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                city.city,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        WeatherCardHelper.getStateCountryDescription(city),
                        textAlign: TextAlign.right,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.black54),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                isFocus ? Colors.red[700] : Colors.transparent,
                            border: Border.all(
                                color: !isFocus
                                    ? Colors.brown
                                    : Colors.transparent)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
