import 'package:flutter/material.dart';
import 'package:carimangan/widgets/card_restaurant.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../provider/database_provider.dart';
import '../utils/result_state.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tempat Disukai'),
        backgroundColor: Colors.brown,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.brown,
        ),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.restaurant.length,
              itemBuilder: (context, index) {
                return CardRestaurant(restaurant: provider.restaurant[index]);
              },
            );
          } else {
            return Center(
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}
