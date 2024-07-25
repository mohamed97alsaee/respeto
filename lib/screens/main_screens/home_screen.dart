import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:respeto/helpers/consts.dart';
import 'package:respeto/helpers/functions_helper.dart';
import 'package:respeto/providers/places_provider.dart';
import 'package:respeto/widgets/cards/resturant_card.dart';
import 'package:respeto/widgets/static/custom_drawer.dart';
import 'package:respeto/widgets/static/shimmer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    setBoolToPrefs("firstLaunch", false);
    Provider.of<PlacesProvider>(context, listen: false)
        .searchPlaces("resturants");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<PlacesProvider>(builder: (context, placesConsumer, child) {
      return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Image.asset(
            "assets/shapes/carrotShape.png",
            width: 40,
            height: 40,
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount:
              placesConsumer.busy ? 10 : placesConsumer.placesList.length,
          itemBuilder: (context, index) {
            return AnimatedSwitcher(
              duration: animationDuration,
              child: placesConsumer.busy
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ShimmerWidget(
                        height: size.height * 0.33,
                      ),
                    )
                  : ResturantCard(
                      resurantPlaceMode: placesConsumer.placesList[index]),
            );
          },
        ),
      );
    });
  }
}
