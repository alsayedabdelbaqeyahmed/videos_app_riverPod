// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:video_payer/models/data_models/data.dart';

import 'package:video_payer/models/view/home/naviagtion_bar.dart';
import 'package:video_payer/models/view/home/video_card_info_widget.dart';

class VideoCardWidget extends StatelessWidget {
  final Video? video;
  final VoidCallback? onTap;
  final BoxConstraints? size;
  const VideoCardWidget({super.key, this.size, this.video, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return GestureDetector(
        onTap: () {
          ref.read(selectedVideoProvider.notifier).state = video;
          ref
              .read(miniVideoPlayerControllerProvider.notifier)
              .state
              .animateToHeight(state: PanelState.MAX);

          // context
          //     .read(miniVideoPlayerControllerProvider)
          //     .state
          //     .animateToHeight(state: PanelState.MIN);
          if (onTap != null) {
            onTap!();
          }
        },
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  video!.thumbnailUrl,
                  width: double.infinity,
                  height: size!.maxHeight * 0.3,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: size!.maxHeight * 0.06,
                  right: size!.maxWidth * 0.025,
                  child: Container(
                    color: Colors.black,
                    child: Text(
                      video!.duration,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: size!.maxHeight * 0.02),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: VideoInfoWidget(
                video: video,
                size: size,
              ),
            ),
          ],
        ),
      );
    });
  }
}
