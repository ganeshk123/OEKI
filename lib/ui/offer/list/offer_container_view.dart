

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterbuyandsell/config/ps_colors.dart';
import 'package:flutterbuyandsell/config/ps_config.dart';
import 'package:flutterbuyandsell/ui/offer/list/offer_list_view.dart';
import 'package:flutterbuyandsell/utils/utils.dart';


class OfferContainerView extends StatefulWidget {
  @override
  _OfferContainerViewState createState() => _OfferContainerViewState();
}

class _OfferContainerViewState extends State<OfferContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Future<bool> _requestPop() {
      animationController!.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    print(
        '............................Build UI Again ............................');
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
            systemOverlayStyle:  SystemUiOverlayStyle(
           statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
         ),  
          iconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: PsColors.backArrowColor),
          title: Text(
            Utils.getString(context, 'more__offer_title'),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleLarge! 
              //  .copyWith(color: Utils.isLightMode(context) ? PsColors.primary500 : PsColors.primaryDarkWhite, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        body: Container(
           color: PsColors.baseColor,
          height: double.infinity,
          child: OfferListView(
            animationController: animationController,
          ),
        ),
      ),
    );
  }
}
