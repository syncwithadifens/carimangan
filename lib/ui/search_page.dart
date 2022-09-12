import 'package:carimangan/ui/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:carimangan/api/api_service.dart';
import 'package:carimangan/provider/search_provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestoProvider>(
      create: (_) => SearchRestoProvider(
        apiService: ApiService(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Pencarian tempat makan'),
          centerTitle: true,
          backgroundColor: Colors.brown,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.brown,
              statusBarIconBrightness: Brightness.light),
        ),
        body: const BodySearch(),
      ),
    );
  }
}

class BodySearch extends StatelessWidget {
  const BodySearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final search = Provider.of<SearchRestoProvider>(context, listen: false);
    return SafeArea(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      'Pencarian',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, right: 120),
                    child: Text(
                      'Cari tempat makan favoritmu!',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        hintText: 'Search',
                        filled: true),
                    onSubmitted: (value) {
                      search.addQueri(value);
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<SearchRestoProvider>(
            builder: (context, state, _) {
              if (state.state == SearchState.noQueri) {
                return (Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.search,
                          size: 100,
                          color: Colors.brown,
                        ),
                        Text("Ayo cari tempat makan favoritmu!")
                      ],
                    ),
                  ),
                ));
              } else if (state.state == SearchState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.state == SearchState.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.result.restaurants.length,
                    itemBuilder: (context, index) {
                      var restoData = state.result.restaurants;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 24),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  id: restoData[index].id,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://restaurant-api.dicoding.dev/images/medium/${restoData[index].pictureId}"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    height: 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 3),
                                          child: Text(
                                            restoData[index].name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                              Text(
                                                restoData[index].city,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 20,
                                              ),
                                              Text(
                                                restoData[index]
                                                    .rating
                                                    .toString(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state.state == SearchState.noData) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/errror.png',
                          width: 200,
                          height: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(state.message),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
