import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dalotee/bloc/locale/locale_bloc.dart';
import 'package:dalotee/bloc/locale/locale_state.dart';
import 'package:dalotee/common/mixins/after_layout.dart';
import 'package:dalotee/common/mixins/loading_view.dart';
import 'package:dalotee/configs/service_locator.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/localization/l10n.dart';
import 'package:dalotee/presentation/dialogs/ok_dialog.dart';
import 'package:dalotee/presentation/pages/demo/demo_bloc.dart';
import 'package:dalotee/presentation/pages/demo/demo_state.dart';
import 'package:dalotee/presentation/widgets/base/custom_button.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/utils/network_utils.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:dalotee/values/font_sizes.dart';

class DemoPage extends StatefulWidget {
  final String title;
  DemoPage({Key? key, required this.title}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage>
    with AfterLayoutMixin, LoadingView {
  late DemoBloc _bloc;

  @override
  void afterFirstFrame(BuildContext context) {
    // Get locale
    BlocProvider.of<LocaleBloc>(context).getLocale();

    // Get int value
    _bloc.getValue();
  }

  @override
  void initState() {
    super.initState();

    // Bloc
    _bloc = DemoBloc(appRepository: locator.get());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _bloc),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            widget.title,
            color: Colors.white,
            fontSize: FontSize.BIG,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              demoAccessResources(),
              demoBloc(),
              demoLocalization(),
              demoDialog(),
              demoNetwork()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _bloc.increaseValue();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  ///
  /// Access text, font, dimens, images,...
  ///
  Widget demoAccessResources() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimen.horizontalSpacing,
          vertical: AppDimen.verticalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomText(
            "DEMO RESOURCES ACCESS",
            fontWeight: FontWeight.bold,
            fontSize: FontSize.BIG,
          ),

          // Access text
          CustomText(S.of(context).app_name),

          // Access image
          Container(
              decoration: BoxDecoration(color: AppColor.colorPrimary),
              width: 100,
              height: 100,
              child: Assets.images.icDemo.image())
        ],
      ),
    );
  }

  ///
  /// BLOC
  ///
  Widget demoBloc() {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimen.horizontalSpacing,
            vertical: AppDimen.verticalSpacing),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          CustomText(
            "DEMO BLOC",
            fontWeight: FontWeight.bold,
            fontSize: FontSize.BIG,
          ),
          CustomText(
            'You have pushed the FLOATING button this many times:',
          ),
          BlocBuilder<DemoBloc, DemoState>(builder: (context, state) {
            if (state is DemoIntState) {
              return CustomText(
                '${state.value}',
                fontSize: FontSize.BIG_2,
              );
            }
            return Container();
          })
        ]));
  }

  ///
  /// LOCALIZATION
  ///
  Widget demoLocalization() {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimen.horizontalSpacing,
            vertical: AppDimen.verticalSpacing),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          CustomText(
            "DEMO LOCALIZATION",
            fontWeight: FontWeight.bold,
            fontSize: FontSize.BIG,
          ),
          CustomText(S.of(context).app_name),
          BlocBuilder<LocaleBloc, LocaleState>(
              // bloc: Auto lookup LocaleBloc
              builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomText(
                  'Current locale: ${state.locale}',
                ),
                CustomButton(
                  "CLICK TO CHANGE LOCALE",
                  onTap: () {
                    BlocProvider.of<LocaleBloc>(context).changeLocale(Locale(
                        state.locale.languageCode == "vi" ? "en" : "vi"));
                  },
                )
              ],
            );
          }),
        ]));
  }

  ///
  /// DIALOG
  ///
  Widget demoDialog() {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimen.horizontalSpacing,
            vertical: AppDimen.verticalSpacing),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          CustomText(
            "DEMO DIALOG",
            fontWeight: FontWeight.bold,
            fontSize: FontSize.BIG,
          ),
          CustomButton(
            "SHOW OK DIALOG",
            onTap: () {
              OkDialog(
                  context: context,
                  title: "Hello",
                  content: "Empty content",
                  buttonText: null,
                  onButtonTap: () {});
            },
          )
        ]));
  }

  ///
  /// NETWORK
  ///
  Widget demoNetwork() {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimen.horizontalSpacing,
            vertical: AppDimen.verticalSpacing),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          CustomText(
            "DEMO NETWORK & LOADING",
            fontWeight: FontWeight.bold,
            fontSize: FontSize.BIG,
          ),
          CustomButton(
            "DUMMY REQUEST",
            onTap: () async {
              _bloc.requestNetwork();
            },
          ),
          BlocConsumer<DemoBloc, DemoState>(listener: (context, state) {
            if (state is DemoLoadingState) {
              showLoading();
            } else {
              dismissLoading();
            }
          }, builder: (context, state) {
            if (state is DemoNetworkState) {
              return CustomText("Result: ${state.data}");
            }
            return Container();
          })
        ]));
  }
}
