import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:open_music/utils/Text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/Music.dart';

class AboutPage extends StatelessWidget {
  final Music music;

  AboutPage({required this.music});

  @override
  Widget build(BuildContext context) {
    const double fontSize = 20;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppText.About).tr(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                AppText.MusicCredit.tr(),
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              music.title,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${AppText.Artist.tr()}: ${music.creator}',
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
            SizedBox(height: 16.0,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                  padding: EdgeInsets.all(10),
                  shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0))
              ),
              onPressed: () async {
                await launchUrl(Uri.parse(music.creatorUrl));
              },
              child: Text(AppText.Seemoreaboutthecreator.tr()),
            ),
            SizedBox(height: 20.0),
            Text(
              AppText.License.tr(),
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '${music.license} (${music.licenseVersion})',
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                  padding: EdgeInsets.all(10),
                  shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0))
              ),
              onPressed: () async {
                await launchUrl(Uri.parse(music.licenseUrl));
              },
              child: Text(AppText.Seemoreaboutthelicense.tr()),
            ),
          ],
        ),
      ),
    );
  }
}