import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Services/PlayerManager.dart';

class SpeedButton extends StatelessWidget {
  const SpeedButton({
    required PlayerManager playerManager,
  }) : _playerManager = playerManager;

  final PlayerManager _playerManager;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
        valueListenable: _playerManager.speedNotifier,
        builder: (BuildContext context, double value, Widget? child) {
          return PopupMenuButton<double>(
            icon: Icon(Icons.speed),
            initialValue: value,
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<double>>[
                PopupMenuItem<double>(
                  value: 0.5,
                  child: Text('0.5x'),
                ),
                PopupMenuItem<double>(
                  value: 1.0,
                  child: Text('1.0x'),
                ),
                PopupMenuItem<double>(
                  value: 1.5,
                  child: Text('1.5x'),
                ),
                PopupMenuItem<double>(
                  value: 2.0,
                  child: Text('2.0x'),
                ),
              ];
            },
            onSelected: (double newSpeed) {
              _playerManager.setSpeed(newSpeed);
            },
          );
        }
    );
  }
}