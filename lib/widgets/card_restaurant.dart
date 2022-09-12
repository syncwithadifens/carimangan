import 'package:flutter/material.dart';
import '../common/navigation.dart';
import '../data/model/restaurant.dart';
import '../ui/detail_screen.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  static const String _baseUrlImage =
      'https://restaurant-api.dicoding.dev/images/small/';

  const CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation.intentWithData(DetailScreen.routeName, restaurant);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(_baseUrlImage + restaurant.pictureId),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      restaurant.city,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rate,
                              color: Colors.orange,
                              size: 16,
                            ),
                            Text(restaurant.rating)
                          ],
                        ),
                      ],
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
