import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:respeto/helpers/consts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:respeto/helpers/functions_helper.dart';
import 'package:respeto/providers/dark_theme_provider.dart';
import 'package:respeto/widgets/clickables/main_button.dart';

class ResturantCard extends StatelessWidget {
  const ResturantCard({super.key, required this.resurantPlaceMode});
  final PlacesSearchResult resurantPlaceMode;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<DarkThemeProvider>(
        builder: (context, darkThemeConsumer, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color:
                lightWihteColor.withOpacity(darkThemeConsumer.isDark ? 0.1 : 1),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              if (!darkThemeConsumer.isDark)
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (resurantPlaceMode.photos.isNotEmpty &&
                    resurantPlaceMode.photos.toString() != "null")
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      width: size.width * 0.9,
                      height: size.height * 0.25,
                      "https://maps.googleapis.com/maps/api/place/photo?photoreference=${resurantPlaceMode.photos.first.photoReference}&sensor=false&maxheight=1600&maxwidth=1600&key=$gmApiKey",
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Container(
                            color: primaryColor.withOpacity(0.1),
                            width: size.width * 0.9,
                            height: size.height * 0.25,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) =>
                          Container(
                              color: primaryColor.withOpacity(0.1),
                              width: size.width * 0.9,
                              height: size.height * 0.25,
                              child: Center(child: const Icon(Icons.error))),
                    ),
                  ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        resurantPlaceMode.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxFontSize: 18,
                        minFontSize: 12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    RatingStars(
                      editable: false,
                      rating: double.parse(resurantPlaceMode.rating.toString()),
                      color: Colors.amber,
                      iconSize: 14,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: resurantPlaceMode.vicinity != null
                            ? Text(resurantPlaceMode.vicinity.toString())
                            : SizedBox()),
                    if (resurantPlaceMode.openingHours != null)
                      Container(
                        decoration: BoxDecoration(
                          color: resurantPlaceMode.openingHours!.openNow
                              ? Colors.green.withOpacity(0.2)
                              : Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          child: Text(
                            resurantPlaceMode.openingHours!.openNow
                                ? AppLocalizations.of(context)!.open
                                : AppLocalizations.of(context)!.close,
                            style: TextStyle(
                                color: resurantPlaceMode.openingHours!.openNow
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 32),
                MainButton(
                  horizontalPadding: 0,
                  widthFromScreen: 1,
                  text: AppLocalizations.of(context)!.openmap,
                  onPressed: () {
                    MapUtils.openMap(
                      resurantPlaceMode.geometry!.location.lat,
                      resurantPlaceMode.geometry!.location.lng,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
