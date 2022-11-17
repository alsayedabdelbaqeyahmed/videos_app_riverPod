import 'package:flutter/material.dart';
import 'package:video_payer/models/data_models/data.dart';

class SliverAppBarWidget extends StatelessWidget {
  final BoxConstraints? size;
  const SliverAppBarWidget({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // floating mean when the user scrool up the app bar will appear
      floating: true,
      leadingWidth: size!.maxWidth * 0.4,
      leading: Padding(
        padding: EdgeInsetsDirectional.only(start: size!.maxWidth * 0.04),
        child: Image.asset(
          'assets/images/yt_logo_dark.png',
        ),
      ),

      actions: [
        IconButton(
          onPressed: () {},
          iconSize: size!.maxWidth * 0.07,
          icon: const Icon(
            Icons.cast,
          ),
        ),
        IconButton(
          onPressed: () {},
          iconSize: size!.maxWidth * 0.07,
          icon: const Icon(
            Icons.notifications_outlined,
          ),
        ),
        IconButton(
          iconSize: size!.maxWidth * 0.07,
          onPressed: () {},
          icon: const Icon(
            Icons.search,
          ),
        ),
        IconButton(
          padding: EdgeInsetsDirectional.only(
              end: size!.maxWidth * 0.03, start: size!.maxWidth * 0.02),
          iconSize: size!.maxWidth * 0.1,
          onPressed: () {},
          icon: CircleAvatar(
            foregroundImage: NetworkImage(
              currentUser.profileImageUrl,
            ),
          ),
        ),
      ],
    );
  }
}
