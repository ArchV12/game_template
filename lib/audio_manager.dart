import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  // Enabling sound will break hot restarting and you have to completely
  // kill the game and re-launch it every time; at least on desktop platforms.
  bool soundDisabled = true;

  Future<void> precacheAudio() async {
    // Precaching sounds is not required, but a good idea to avoid loading
    // stalls mid-game.

    // await FlameAudio.audioCache.load('sfx/sound1.wav');
    // await FlameAudio.audioCache.load('sfx/sound2.mp3');
    // await FlameAudio.audioCache.load('sfx/sound3.ogg');

    // Flame has a background music player
    // FlameAudio.bgm.initialize();
  }

  // Helper function to play a sound via sound name.
  // Wrapper functions should always go through this method so the
  // soundDIsabled flag is respected.
  void playSoundByName(String filename) {
    if (soundDisabled) return;
    if (filename == '') return;

    FlameAudio.play(filename);
  }

  // Example wrapper for sound playing.  Using wrappers are handy
  // for doing things like picking between multiple random sounds,
  // like between 8 varieties of footsteps or something.
  // void playSound1() {
  //   playSoundByName('sfx/sound1.wav');
  // }
}
