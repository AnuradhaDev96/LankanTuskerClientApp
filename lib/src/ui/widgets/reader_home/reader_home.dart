import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rh_reader/src/ui/widgets/reader_home/home_content.dart';

import '../../../config/assets.dart';
import '../../../models/change_notifiers/side_drawer_notifier.dart';
import '../../../models/enums/screen_bucket_enum.dart';
import '../../../widgets/side_drawer.dart';

class ReaderHome extends StatefulWidget {
  const ReaderHome({Key? key}) : super(key: key);

  @override
  State<ReaderHome> createState() => _ReaderHomeState();
}

class _ReaderHomeState extends State<ReaderHome> {
  late final SideDrawerNotifier _sideDrawerNotifier;
  final PageStorageBucket screenBucket = PageStorageBucket();
  ScreenBuckets _selectedPageIndex = ScreenBuckets.home;

  @override
  void initState() {
    _sideDrawerNotifier = GetIt.I<SideDrawerNotifier>();

    _sideDrawerNotifier.addListener(() {
      if(mounted) {
        setState(() {
          _selectedPageIndex = _sideDrawerNotifier.selectedPageType ?? ScreenBuckets.home;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sideDrawerNotifier.mainScaffoldKey,
      drawer: SideDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO: Check for desktop and remove side menu for mobile
          Expanded(
            flex: 1,
            child: SideDrawer()
          ),
          Expanded(
            flex: 4,
            child: Container(
              // margin: const EdgeInsets.only(left: 350),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          Assets.hotelCoverPhoto,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    PageStorage(
                        bucket: screenBucket,
                        child: buildPages(),
                      ),
                      // Padding(
                    //   padding: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
                    //   child: Material(
                    //     borderRadius: BorderRadius.circular(15.0),
                    //     color: Colors.white,
                    //     elevation: 5.0,
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(5.0),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             ''
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 10.0,
                    //   color: Colors.blue,
                    // )
                  ],
                ),
              ),
            )
          ),
          // Expanded(
          //   flex: 1,
          //   child: Container(
          //     height: 250.0,
          //     color: Colors.yellow,
          //   ),
          // )
        ],
      ),
    );
  }

  Widget buildPages() {
    switch (_selectedPageIndex) {
      case ScreenBuckets.home:
        return HomeContent();
      case ScreenBuckets.booking:
        return HomeContent();
      default:
        return const SizedBox(width: 0, height: 0);
    }
  }
}
