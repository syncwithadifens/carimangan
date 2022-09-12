import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../data/api_service/api_service.dart';
import '../data/model/restaurant.dart';
import '../provider/detail_provider.dart';
import '../utils/result_state.dart';
import '../widgets/platform_widget.dart';
import 'detail_page.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail_screen';

  const DetailScreen({super.key, required this.restaurant});
  final Restaurant restaurant;

  Widget _buildList(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: ChangeNotifierProvider<DetailProvider>(
        create: (_) => DetailProvider(
            apiService: ApiService(Client()), resto: restaurant.id),
        child: Scaffold(
          body: Consumer<DetailProvider>(
            builder: (context, data, _) {
              if (data.state == ResultState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.state == ResultState.hasData) {
                return Scaffold(
                  body: DetailPage(restaurant: data.detailResult.restaurants),
                );
              } else if (data.state == ResultState.noData) {
                return Center(child: Text(data.message));
              } else if (data.state == ResultState.error) {
                return Center(child: Text(data.message));
              } else {
                return const Center(child: Text(''));
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildList,
      iosBuilder: _buildList,
    );
  }
}
