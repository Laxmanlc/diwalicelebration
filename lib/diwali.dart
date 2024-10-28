import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:typethis/typethis.dart';

class DiwaliCelebration extends StatefulWidget {
  const DiwaliCelebration({super.key});

  @override
  State<DiwaliCelebration> createState() => _DiwaliCelebrationState();
}

class _DiwaliCelebrationState extends State<DiwaliCelebration>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettieController;
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _confettieController =
        ConfettiController(duration: const Duration(seconds: 1));
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();
    // initialize floating animation
    _floatingController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _floatingAnimation = Tween<double>(begin: 0, end: 20).animate(
        CurvedAnimation(parent: _floatingController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _confettieController.dispose();
    _audioPlayer.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  void _playBackgroundMusic() async {
    try {
      await _audioPlayer.setSource(AssetSource('sound/firework.mp3'));
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.resume();
    } catch (e) {
      print("Error playing audio : $e");
    }
  }

  void _showconfettie(TapUpDetails details) {
    _confettieController.play();
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTapUp: _showconfettie,
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "assets/image/bg.png",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            constantRow(
                assetName: "assets/json/f1.json",
                height: screenheight * 0.4,
                width: screenwidth * 0.9),
            constantRow(
                assetName: "assets/json/f3.json",
                height: screenheight * 0.4,
                width: screenwidth * 0.9),
            constantRow(
                assetName: "assets/json/f3.json",
                height: screenheight * 0.4,
                width: screenwidth * 0.9),
            constantRow(
                assetName: "assets/json/f3.json",
                height: screenheight * 0.4,
                width: screenwidth * 0.9),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Lottie.asset("assets/json/f2.json",
                      height: screenheight * 0.3,
                      width: screenwidth * 0.3,
                      repeat: true,
                      animate: true),
                ),
                Expanded(
                  child: Lottie.asset("assets/json/f2.json",
                      height: screenheight * 0.3,
                      width: screenwidth * 0.3,
                      repeat: true,
                      animate: true),
                ),
                Expanded(
                  child: Lottie.asset("assets/json/f2.json",
                      height: screenheight * 0.3,
                      width: screenwidth * 0.3,
                      repeat: true,
                      animate: true),
                )
              ],
            ),
            Center(
              child: happyDiwaliText(screenwidth: screenwidth),
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _confettieController,
                blastDirectionality: BlastDirectionality.explosive,
                particleDrag: 0.05,
                emissionFrequency: 0.02,
                numberOfParticles: 20,
                minBlastForce: 9,
                maxBlastForce: 15,
                colors: const [
                  Colors.blue,
                  Colors.pink,
                  Colors.amber,
                  Colors.lightGreen,
                  Colors.red,
                  Colors.purpleAccent,
                  Colors.orange
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row constantRow(
      {required double height,
      required double width,
      required String assetName}) {
    return Row(
      children: [
        Expanded(
          child: Lottie.asset(assetName,
              height: height, width: width, repeat: true, animate: true),
        ),
        Expanded(
          child: Lottie.asset(assetName,
              height: height, width: width, repeat: true, animate: true),
        ),
        Expanded(
          child: Lottie.asset(assetName,
              height: height, width: width, repeat: true, animate: true),
        )
      ],
    );
  }

  // ! happy diwali text
  Widget happyDiwaliText({required double screenwidth}) {
    double textSize = screenwidth * 0.055;
    return Padding(
      padding: const EdgeInsets.all(
        15,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedBuilder(
            animation: _floatingAnimation,
            child: Text(
              " 🪔 Happy \t\t\t\t\t",
              style: TextStyle(
                  fontSize: textSize,
                  color: const Color.fromARGB(255, 7, 255, 36),
                  fontFamily: 'Satisfy'),
            ),
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  _floatingAnimation.value,
                ),
                child: child,
              );
            },
          ),
          AnimatedBuilder(
              animation: _floatingAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatingAnimation.value),
                  child: child,
                );
              },
              child: Text(
                " \t\t\t\t Diwali 🪔",
                style: TextStyle(
                    fontSize: textSize,
                    color: const Color.fromARGB(255, 234, 7, 255),
                    fontFamily: 'Satisfy'),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TypeThis(
                string:
                    "Wishing you a joyful Diwali\nFilled with light and prosperity. May this festival\nbting peace and happinedd to your life!",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.04,
                    color: const Color.fromARGB(255, 250, 138, 0),
                    fontFamily: 'Merienda'),
              )
            ],
          )
        ],
      ),
    );
  }
}
