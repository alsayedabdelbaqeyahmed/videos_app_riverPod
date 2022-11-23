import 'package:flutter/material.dart';
import 'package:video_payer/models/data_models/data.dart';
import 'package:timeago/timeago.dart' as timeago;

class VideoInfoWidget extends StatelessWidget {
  const VideoInfoWidget({
    Key? key,
    required this.video,
    required this.size,
    this.isMiniPlayer = false,
    this.press,
    this.minihight = 0,
  }) : super(key: key);

  final Video? video;
  final BoxConstraints? size;
  final bool? isMiniPlayer;
  final VoidCallback? press;
  final double? minihight;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !isMiniPlayer!
            ? CircleAvatar(
                foregroundImage: NetworkImage(video!.author.profileImageUrl),
              )
            : SizedBox(
                width: size!.maxWidth * 0.4,
                height: minihight,
                child: Image.network(
                  video!.thumbnailUrl,
                  fit: BoxFit.cover,
                ),
              ),
        SizedBox(width: size!.maxWidth * 0.05),
        Expanded(
          child:
              VideoText(video: video, isMiniPlayer: isMiniPlayer, size: size),
        ),
        !isMiniPlayer!
            ? GestureDetector(
                onTap: () {},
                child: Icon(Icons.more_vert, size: size!.maxWidth * 0.055),
              )
            : IconButton(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
              ),
        isMiniPlayer!
            ? IconButton(
                onPressed: press,
                icon: const Icon(Icons.close),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class VideoText extends StatelessWidget {
  const VideoText({
    Key? key,
    required this.video,
    required this.isMiniPlayer,
    this.isVideoScreen = false,
    this.isUserInfo = false,
    required this.size,
  }) : super(key: key);

  final Video? video;
  final bool? isMiniPlayer;
  final bool? isVideoScreen;
  final bool? isUserInfo;
  final BoxConstraints? size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            isVideoScreen! && isUserInfo!
                ? video!.author.username
                : video!.title,
            maxLines: !isMiniPlayer! ? 2 : null,
            overflow: TextOverflow.ellipsis,
            style: !isMiniPlayer! || isUserInfo!
                ? Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: size!.maxWidth * 0.045)
                : Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
          ),
        ),
        isVideoScreen!
            ? SizedBox(
                height: size!.maxHeight * 0.01,
              )
            : const SizedBox.shrink(),
        Flexible(
          child: Text(
            isVideoScreen! && isUserInfo!
                ? "${video!.author.subscribers} subscribers"
                : '${video!.author.username} . ${video!.viewCount} views . ${timeago.format(video!.timestamp)}',
            maxLines: !isMiniPlayer! ? 2 : null,
            overflow: TextOverflow.ellipsis,
            style: !isMiniPlayer! || isUserInfo!
                ? Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(fontSize: size!.maxWidth * 0.04)
                : Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
          ),
        ),
      ],
    );
  }
}
