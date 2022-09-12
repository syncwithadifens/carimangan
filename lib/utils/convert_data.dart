import '../data/model/detail_restaurant.dart';
import '../data/model/restaurant.dart';

Restaurant convertData(DetailRestaurant detailRestaurant) {
  return Restaurant(
    id: detailRestaurant.id,
    name: detailRestaurant.name,
    description: detailRestaurant.description,
    pictureId: detailRestaurant.pictureId,
    city: detailRestaurant.city,
    rating: detailRestaurant.rating.toString(),
  );
}
