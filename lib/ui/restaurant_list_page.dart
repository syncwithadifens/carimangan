import 'package:flutter/material.dart';
import 'package:carimangan/ui/search_screen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../provider/restaurant_provider.dart';
import '../utils/result_state.dart';
import '../widgets/card_restaurant.dart';
import '../widgets/platform_widget.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildAndroid,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.brown,
            ),
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
          ),
        ],
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'CariMangan',
              style: TextStyle(fontSize: 24),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 15, left: 8, right: 8),
            child: Text('Berikut rekomendasi tempat makan buatmu!'),
          ),
          Consumer<RestaurantProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (state.state == ResultState.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.result.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = state.result.restaurants[index];
                        return CardRestaurant(restaurant: restaurant);
                      },
                    ),
                  );
                } else if (state.state == ResultState.noData) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state.state == ResultState.error) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: Text(''),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
