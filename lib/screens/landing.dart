import 'package:flutter/material.dart';

class LandingScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Column(
      children: <Widget>[
        Image(
            image: const AssetImage('images/ding-liren.jpg'),
            height: screenHeight * 0.38,
            width: double.infinity,
            fit: BoxFit.cover),
        Expanded(
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            width: double.infinity,
            child: Center(
              child: Transform.rotate(
                  angle: -0.27,
                  child: Text(
                    'Ding Liren',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
        )
      ],
    )
        // ),
        );
  }
}
