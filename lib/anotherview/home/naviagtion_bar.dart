import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:video_payer/controller/bottom_navigation_bar_controller.dart';
import 'package:video_payer/anotherview/data.dart';
import 'package:video_payer/anotherview/home/home_screen.dart';
import 'package:video_payer/anotherview/home/video_card_info_widget.dart';
import 'package:video_payer/anotherview/home/video_card_widget.dart';
import 'package:video_payer/anotherview/home/video_screen.dart';

///global ref to be called at any place
///saved at locat storage and then inject at ProviderScope at main finction
///so it coud be called at any part of the app
///state provider mean i have state will change
///ref => mean refere to that value wich will be called by calling StateProvider
final selectedVideoProvider = StateProvider<Video?>((ref) => null);
final miniVideoPlayerControllerProvider =
    StateProvider.autoDispose<MiniplayerController>(
  (ref) => MiniplayerController(),
);
final bottomNaviBarController =
    ChangeNotifierProvider<BottomNavigationBarController>((ref) {
  return BottomNavigationBarController();
});

class NavigationBarScreen extends ConsumerWidget {
  const NavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return LayoutBuilder(builder: (context, constrain) {
      final selectedVideo = ref.watch(selectedVideoProvider);
      final miniVideoPlayerController =
          ref.watch(miniVideoPlayerControllerProvider);
      final botNavController = ref.watch(bottomNaviBarController);
      return Scaffold(
        /**
         * الهدف من النقطه ده اني لما ابني واحده من الاسكرين 
         * وبعدين اتنقل للثانيه هتفضل الي تحت منها شغاله 
         * بس هتكون مختفيه مش هتظهر ولا هتستهلك موارد بس هتفضل شغاله 
         * علي عكس لو استخدمت الانتقال التلقائي هتختفي تمام لاني هظهر صفحه واحده بس
         * stack build screen over each other
         * every single screen will rendered and build but the only one visible every time is 
         * where  _currentIndex != i, so we can preserve our navigation stack for every screen
         */
        /**
           * consumer is used to rebuild tha Stack widget every time
           * the user chose the video
           */

        body: Stack(
          children: botNavController.screens!
              .asMap()
              .map(
                (i, screen) => MapEntry(
                  i,
                  Offstage(
                    offstage: botNavController.currentIndex != i,
                    child: screen,
                  ),
                ),
              )
              .values
              .toList()
            ..add(
              Offstage(
                offstage: selectedVideo == null,
                child: Miniplayer(
                  controller: miniVideoPlayerController,
                  maxHeight: constrain.maxHeight,
                  minHeight: constrain.maxHeight * 0.12,
                  builder: (height, percentage) {
                    /**
                       * if cobdition is required so not to build the all container and hide it with 
                       * OffStage
                       */
                    if (selectedVideo == null) {
                      return const SizedBox.shrink();
                    }
                    if (height <= constrain.maxHeight * 0.5) {
                      return Container(
                        //  height: constrain.maxHeight * 0.5,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: constrain.maxWidth * 0.002,
                              ),
                              child: VideoInfoWidget(
                                video: selectedVideo,
                                size: constrain,
                                isMiniPlayer: true,
                                press: () => ref
                                    .read(selectedVideoProvider.notifier)
                                    .state = null,
                                minihight: constrain.maxHeight * 0.1 - 0.4,
                              ),
                            ),
                            LinearProgressIndicator(
                              value: 0.4,
                              minHeight: constrain.maxHeight * 0.007,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return VideoScreen(size: constrain);
                    }
                  },
                ),
              ),
            ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: botNavController.currentIndex,
          onTap: (value) => botNavController.changeIndex(value),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: 'add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions_outlined),
              activeIcon: Icon(Icons.subscriptions),
              label: 'subscriptions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library_outlined),
              activeIcon: Icon(Icons.video_library),
              label: 'library',
            ),
          ],
        ),
      );
    });
  }
}
