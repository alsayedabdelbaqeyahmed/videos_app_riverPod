import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:video_payer/models/data_models/data.dart';
import 'package:video_payer/models/view/home/naviagtion_bar.dart';
import 'package:video_payer/models/view/home/video_card_info_widget.dart';
import 'package:video_payer/models/view/home/video_card_widget.dart';

class VideoScreen extends StatefulWidget {
  final BoxConstraints? size;
  const VideoScreen({super.key, this.size});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ScrollController? _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final selectedVideo = ref.watch(selectedVideoProvider);
      return GestureDetector(
        onTap: () => ref
            .read(miniVideoPlayerControllerProvider.notifier)
            .state
            .animateToHeight(state: PanelState.MAX),
        child: Scaffold(
          body: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomScrollView(
              controller: _scrollController,
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: SafeArea(
                    child: Column(
                      children: [
                        GestureDetector(
                          onHorizontalDragDown: (details) {
                            ref
                                .read(
                                    miniVideoPlayerControllerProvider.notifier)
                                .state
                                .animateToHeight(
                                    state: PanelState.MIN,
                                    duration: const Duration(seconds: 1));
                          },
                          child: Stack(
                            children: [
                              Image.network(
                                selectedVideo!.thumbnailUrl,
                                height: widget.size!.maxHeight * 0.27,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              IconButton(
                                iconSize: 30.0,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                onPressed: () => ref
                                    .read(miniVideoPlayerControllerProvider
                                        .notifier)
                                    .state
                                    .animateToHeight(state: PanelState.MIN),
                              ),
                            ],
                          ),
                        ),
                        LinearProgressIndicator(
                          value: 0.4,
                          minHeight: widget.size!.maxHeight * 0.007,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.red,
                          ),
                        ),
                        // const Divider(),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: widget.size!.maxWidth * 0.02,
                            top: widget.size!.maxHeight * 0.02,
                          ),
                          child: VideoText(
                            video: selectedVideo,
                            isMiniPlayer: false,
                            size: widget.size,
                            isVideoScreen: true,
                          ),
                        ),
                        const Divider(),
                        _ActionsRow(
                          video: selectedVideo,
                          size: widget.size,
                        ),
                        const Divider(),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: widget.size!.maxWidth * 0.02,
                            end: widget.size!.maxWidth * 0.02,
                          ),
                          child: _AuthorInfo(
                            size: widget.size,
                            video: selectedVideo,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final suggestedVideo = suggestedVideos[index];
                    return VideoCardWidget(
                      size: widget.size,
                      video: suggestedVideo,
                      onTap: () => _scrollController!.animateTo(
                        0,
                        duration: const Duration(microseconds: 10),
                        curve: Curves.easeIn,
                      ),
                    );
                  }, childCount: suggestedVideos.length),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _ActionsRow extends StatelessWidget {
  final Video video;
  final BoxConstraints? size;

  const _ActionsRow({
    Key? key,
    required this.video,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildAction(context, Icons.thumb_up_outlined, video.likes),
        _buildAction(context, Icons.thumb_down_outlined, video.dislikes),
        _buildAction(context, Icons.reply_outlined, 'Share'),
        _buildAction(context, Icons.download_outlined, 'Download'),
        _buildAction(context, Icons.library_add_outlined, 'Save'),
      ],
    );
  }

  Widget _buildAction(BuildContext context, IconData icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(height: size!.maxWidth * 0.01),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _AuthorInfo extends StatelessWidget {
  // final User user;
  final BoxConstraints? size;
  final Video? video;

  const _AuthorInfo({Key? key, this.size, this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Navigate to profile'),
      child: Row(
        children: [
          CircleAvatar(
            foregroundImage: NetworkImage(video!.author.profileImageUrl),
          ),
          SizedBox(width: size!.maxHeight * 0.02),
          Expanded(
            child: VideoText(
              size: size,
              isVideoScreen: true,
              isMiniPlayer: false,
              video: video,
              isUserInfo: true,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'SUBSCRIBE',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.red,
                    fontSize: size!.maxWidth * 0.05,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
