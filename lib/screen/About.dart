import 'package:flutter/material.dart';

class About extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('About Open Music'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Open Music - Online Music Platform',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Version: 1.0.0',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16.0),
            Text(
              'Thank you for using Open Music! We strive to provide you with the best music streaming experience. Please read the following terms carefully:',
            ),
            SizedBox(height: 16.0),
            Text(
              '1. OpenVerse API Terms of Use',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'By using the OpenVerse API, you agree to the API Terms of Use. Make sure to adhere to rate limits, registration requirements, and all other documented conditions.',
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Use of OpenVerse API',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Open Music utilizes the OpenVerse API to aggregate metadata about openly licensed content from third-party websites. Open Music does not own or control the content or data available through the API. Make sure to independently verify the rights to use the content and data and the applicable terms and conditions.',
            ),
            SizedBox(height: 16.0),
            Text(
              '3. Copyright Compliance',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Respect copyright of the content accessible via the OpenVerse API. You must provide proper attribution to CC-licensed works and comply with the terms and conditions of platforms hosting those works.',
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}