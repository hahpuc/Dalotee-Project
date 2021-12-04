import 'dart:developer';

import 'package:dalotee/common/mixins/after_layout.dart';
import 'package:dalotee/configs/service_locator.dart';
import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/search_tab/search_bloc.dart';
import 'package:dalotee/presentation/pages/search_tab/search_state.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/presentation/widgets/base/custom_textfield.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> with AfterLayoutMixin {
  SearchPageBloc _bloc = SearchPageBloc(appRepository: locator.get());
  TextEditingController _controllerSearch = TextEditingController();
  int _currentIndex = 1;
  List<String> categories = [
    'Major Arcana',
    'Cup',
    'Pentacles',
    'Swords',
    'Wands'
  ];
  ValueNotifier<List<CardData>?> listCardSearch =
      ValueNotifier<List<CardData>?>(null);

  // Size of Animated Photo
  ValueNotifier<double> sizeAnimatedContainer = ValueNotifier<double>(0);

  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getData();
  }

  _blocListener(BuildContext context, SearchPageState state) async {
    if (state is SearchPageLoadingState) {
      EasyLoading.show(status: 'loading', maskType: EasyLoadingMaskType.black);
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              setState(() {
                _currentIndex = tabController.index;
              });
            }
          });
          return Scaffold(
            backgroundColor: AppColor.colorPrimary,
            appBar: _buildAppBar(),
            // body: TabBarView(
            //   children: [
            //     for (int i = 0; i < 5; i++) _buildListCard(categories[i])
            //   ],
            // ),
            body: Container(
              child: ValueListenableBuilder<double>(
                  valueListenable: sizeAnimatedContainer,
                  builder: (BuildContext context, double size, Widget? child) {
                    if (size != 0) {
                      return AnimatedContainer(
                          curve: Curves.linear,
                          duration: Duration(seconds: 10),
                          height: size,
                          width: size,
                          child: ValueListenableBuilder<List<CardData>?>(
                              valueListenable: listCardSearch,
                              builder: (BuildContext context,
                                  List<CardData>? listCard, Widget? child) {
                                return _buildGridView(listCardSearch.value);
                              }));
                    }
                    {
                      return TabBarView(
                        children: [
                          for (int i = 0; i < 5; i++)
                            _buildListCard(categories[i])
                        ],
                      );
                    }
                  }),
            ),
          );
        },
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: Text("Tra cứu lá bài"),
      leading: SizedBox(),
      bottom: PreferredSize(
        preferredSize: Size(0, 84),
        child: Column(
          children: [
            TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                tabs: [
                  for (final item in categories)
                    Center(
                      child: CustomText(
                        item,
                        color: Colors.black,
                      ),
                    )
                ]),
            _buildSearchBar()
          ],
        ),
      ),
    );
  }

  _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: AppDimen.spacing_2, horizontal: AppDimen.spacing_3),
      decoration: BoxDecoration(
          color: AppColor.colorButton,
          borderRadius: BorderRadius.circular(AppDimen.spacing_2)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: SvgPicture.asset(Assets.images.icSearch.path)),
              Expanded(
                flex: 8,
                child: CustomTextField(
                  textController: _controllerSearch,
                  hintText: 'Tìm kiếm...',
                  onSubmittedListener: (text) {
                    text = convertToTitleCase(text);
                    List<CardData>? list = _bloc.getCardWithName(text);
                    if (list!.isNotEmpty) {
                      log(list.toString());
                      listCardSearch.value = list;
                      sizeAnimatedContainer.value =
                          MediaQuery.of(context).size.height;
                    } else {
                      log('sssssssssssssssssssssssssssssss');
                      sizeAnimatedContainer.value = 0;
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? convertToTitleCase(String? text) {
    if (text == null) {
      return null;
    }

    if (text.length <= 1) {
      return text.toUpperCase();
    }

    // Split string into multiple words
    final List<String> words = text.split(' ');

    // Capitalize first letter of each words
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });

    // Join/Merge all words back to one String
    return capitalizedWords.join(' ');
  }

  _buildListCard(String category) {
    List<CardData>? list = _bloc.getCardWithCategories(category);
    return _buildGridView(list);
  }

  _buildGridView(List<CardData>? list) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimen.spacing_2),
      child: GridView.builder(
          itemCount: list?.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppDimen.spacing_4,
              mainAxisSpacing: AppDimen.spacing_5,
              mainAxisExtent: 280),
          itemBuilder: (BuildContext context, int index) {
            if (list != null) {
              final item = list[index];
              return Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        item.front,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: AppDimen.spacing_2),
                        child: Center(
                            child: CustomText(
                          item.name ?? "",
                          fontSize: 16.0,
                          fontFamily: FontFamily.poppins,
                          fontWeight: FontWeight.bold,
                        )),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
