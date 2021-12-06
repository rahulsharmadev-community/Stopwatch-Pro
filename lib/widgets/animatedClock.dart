// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/service/stopwatchService.dart';
import 'package:provider/provider.dart';

class AnimatedClock extends StatefulWidget {
  final Widget child;
  const AnimatedClock({Key? key, required this.child}) : super(key: key);

  @override
  State<AnimatedClock> createState() => _AnimatedClockState();
}

class _AnimatedClockState extends State<AnimatedClock>
    with SingleTickerProviderStateMixin {
  late final AnimationController lotteController;
  late StopwatchService stopwatchService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lotteController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    lotteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    stopwatchService = Provider.of<StopwatchService>(context);
    Future.delayed(const Duration(milliseconds: 120), () async {
      stopwatchService.isRunning
          ? await lotteController.repeat()
          : lotteController.stop();
    });
    return Stack(
      alignment: Alignment.center,
      children: [
        !stopwatchService.isReset
            ? LottieBuilder.asset(
                'assets/lottieJson/dark.json',
                controller: lotteController,
                repeat: true,
                fit: BoxFit.fill,
                onLoaded: (value) {
                  lotteController.duration = value.duration;
                },
              )
            : Offstage(),
        Align(
            alignment: Alignment.center,
            child: FittedBox(fit: BoxFit.fitWidth, child: widget.child)),
      ],
    );
  }
}
