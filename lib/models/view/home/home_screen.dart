import 'package:flutter/material.dart';
import 'package:video_payer/models/data_models/data.dart';
import 'package:video_payer/models/view/home/sliver_app_bar_widget.dart';
import 'package:video_payer/models/view/home/video_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBarWidget(size: constrain),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  ((context, index) {
                    final video = videos[index];
                    return VideoCardWidget(
                      size: constrain,
                      video: video,
                    );
                  }),
                  childCount: videos.length,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
