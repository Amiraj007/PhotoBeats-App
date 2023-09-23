import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class AudioPlayerBackground extends StatefulWidget {
  const AudioPlayerBackground({Key? key}) : super(key: key);

  @override
  State<AudioPlayerBackground> createState() => _AudioPlayerBackgroundState();
}

class _AudioPlayerBackgroundState extends State<AudioPlayerBackground> {
  int currentIndex = 1;

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  final SwiperController swiperController = SwiperController();
  List<Audio> audioList = [
    Audio.network('https://dl.sndup.net/p5gf/death%20bed.mp3',
        metas: Metas(
            title: 'Death Bed',
            artist: 'Powfu',
            image: const MetasImage.network(
                'https://i.scdn.co/image/ab67616d0000b273f46c300faaf2220909c11028'))),
    Audio.network('https://dl.sndup.net/vz95/Iraaday.mp3',
        metas: Metas(
            artist: 'Abdul Hannan',
            title: 'Iraaday',
            image: const MetasImage.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvuACx6jkounPd5P3vua6thWM37NrJm9puvAtBbk6D-vZ61Qb1cQGq3z21mQYk7BMHMh4&usqp=CAU'))),
    Audio.network(
        'https://www.pagalworld.com.se/siteuploads/files/sfd134/66622/Cheques(PagalWorld.com.se).mp3',
        metas: Metas(
            artist: 'Shubh',
            title: 'Cheques',
            image: const MetasImage.network(
                'https://p16.resso.me/img/tos-alisg-v-2102/31dd1c9693d74b40893b4e89f1ff3c02~c5_500x500.jpg'))),
    Audio.network('https://dl.sndup.net/t586/Har%20Har%20Gange.mp3',
        metas: Metas(
            artist: 'Arijit Sign',
            title: 'Har Har Gange',
            image: const MetasImage.network(
                'https://pagalsong.in/uploads//thumbnails/300x300/id3Picture_841173500.jpg'))),
    Audio.network('https://dl.sndup.net/rsk5/song.mp3',
        metas: Metas(
            title: 'Dilon Ki Doriyan',
            artist: 'Vishal Mishra',
            image: const MetasImage.network(
                'https://www.lyricsgoal.com/wp-content/uploads/2023/07/dilon-ki-doriyan-bawaal.jpg'))),
    Audio.network('https://dl.sndup.net/kxp6/Malang%20Sajna%20Mp3%20Song.mp3',
        metas: Metas(
            title: 'Malang sajana',
            artist: 'Sachet-Parampara',
            image: const MetasImage.network(
                'https://pagalsong.in/uploads//thumbnails/300x300/id3Picture_782231041.jpg')))
  ];

  @override
  void initState() {
    super.initState();
    setUpPlaylist();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
    swiperController.dispose();
  }

  playMusic() async {
    await audioPlayer.playOrPause();
  }

  skipPrevious() async {
    await audioPlayer.previous();
    await swiperController.previous();
  }

  skipNext() async {
    await audioPlayer.next();
    await swiperController.next();
  }

  void setUpPlaylist() async {
    audioPlayer.open(Playlist(audios: audioList),
        autoStart: false,
        notificationSettings: const NotificationSettings(stopEnabled: false),
        loopMode: LoopMode.playlist,
        respectSilentMode: true,
        playInBackground: PlayInBackground.enabled,
        showNotification: true);
  }

  Widget slider(RealtimePlayingInfos realtimePlayingInfos) {
    return SizedBox(
      width: 280,
      child: SliderTheme(
          data: const SliderThemeData(
              activeTrackColor: Color(0xff5D4037),
              inactiveTrackColor:Color(0xffD7CCC8),
              thumbColor: Color(0xffa8cab0)),
          child: Slider.adaptive(
            value: realtimePlayingInfos.currentPosition.inSeconds.toDouble(),
            max: realtimePlayingInfos.duration.inSeconds.toDouble(),
            min: 0,
            onChanged: (value) {
              if (value <= 0) {
                audioPlayer.seek(const Duration(seconds: 0));
              } else if (value >= realtimePlayingInfos.duration.inSeconds) {
                audioPlayer.seek(realtimePlayingInfos.duration);
              } else {
                audioPlayer.seek(Duration(seconds: value.toInt()));
              }
            },
          )),
    );
  }

  Widget timeStamp(RealtimePlayingInfos realtimePlayingInfos) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(transformString(realtimePlayingInfos.currentPosition.inSeconds),
            textScaleFactor: 0.9),
        const SizedBox(width: 180),
        Text(transformString(realtimePlayingInfos.duration.inSeconds),
            textScaleFactor: 0.9),
      ],
    );
  }

  String transformString(int seconds) {
    String minuteString =
        "${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}";
    String secondsString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondsString';
  }

  Widget circularAudioPlayer(
      RealtimePlayingInfos realTimePlayingInfos, double screenWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularPercentIndicator(
          circularStrokeCap: CircularStrokeCap.round,
          maskFilter: const MaskFilter.blur(BlurStyle.inner, 5),
          radius: screenWidth / 2.5,
          arcType: ArcType.HALF,
          lineWidth: 15,
          backgroundColor: Colors.black54,
          arcBackgroundColor: const Color(0xff5d4157),
          progressColor: const Color(0xffa8caba),
          percent: realTimePlayingInfos.playingPercent,
          addAutomaticKeepAlive: true,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${realTimePlayingInfos.current!.audio.audio.metas.title}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text('${realTimePlayingInfos.current!.audio.audio.metas.artist}',
                  style: const TextStyle(fontSize: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => skipPrevious(),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: const Icon(
                        Icons.skip_previous_rounded,
                      ),
                      iconSize: 50),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () => playMusic(),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Icon(realTimePlayingInfos.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded),
                      iconSize: 50),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () => skipNext(),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: const Icon(Icons.skip_next_rounded),
                      iconSize: 50),
                ],
              ),
              Column(children: [
                slider(realTimePlayingInfos),
                timeStamp(realTimePlayingInfos),
              ]),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget swiper(RealtimePlayingInfos realtimePlayingInfos) {
    return Container(
        height: 250,
        width: 300,
        child: Swiper(
          itemCount: audioList.length,
          controller: swiperController,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(audioList[index].metas.image!.path,
                  fit: BoxFit.fill),
            );
          },
          onIndexChanged: (newIndex) {
            audioPlayer.playlistPlayAtIndex(newIndex);
          },
          autoplay: false,
          fade: 0.1,
          viewportFraction: 0.75,
          scale: 0.7,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: audioPlayer.builderRealtimePlayingInfos(
        builder: (context, realTimePlayingInfos) {
          if (realTimePlayingInfos != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 19),
                swiper(realTimePlayingInfos),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  child: circularAudioPlayer(
                      realTimePlayingInfos, MediaQuery.of(context).size.width),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
