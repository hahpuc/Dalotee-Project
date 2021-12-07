import 'package:dalotee/common/mixins/after_layout.dart';
import 'package:dalotee/configs/routes.dart';
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

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> with AfterLayoutMixin {
  SearchPageBloc _bloc = SearchPageBloc(appRepository: locator.get());
  TextEditingController _controllerSearch = TextEditingController();
  // int _currentIndex = 1;
  List<String> categories = [
    Assets.images.icKingPng.path,
    Assets.images.imgWands.path,
    Assets.images.imgSword.path,
    Assets.images.imgCups.path,
    Assets.images.imgCoin.path,
  ];
  List<String> categoriesName = [
    'Major Arcana',
    'Cup',
    'Pentacles',
    'Swords',
    'Wands'
  ];
  ValueNotifier<List<CardData>?> listCardSearch =
      ValueNotifier<List<CardData>?>(null);

  // Size of Animated
  ValueNotifier<double> sizeAnimatedContainer = ValueNotifier<double>(0);

  ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controllerSearch.dispose();
    sizeAnimatedContainer.dispose();
    listCardSearch.dispose();
    super.dispose();
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
              _currentIndex.value = tabController.index;
            }
          });
          return Scaffold(
            backgroundColor: AppColor.colorPrimary,
            appBar: _buildAppBar(),
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
                            _buildListCard(categoriesName[i])
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
      title: CustomText("Tra cứu lá bài",
          fontFamily: FontFamily.gelasio, fontSize: AppDimen.sizeAppBarText),
      leading: SizedBox(),
      bottom: PreferredSize(
        preferredSize: Size(0, 125),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppDimen.spacing_1, horizontal: AppDimen.spacing_4),
              decoration: BoxDecoration(
                  color: AppColor.colorButton,
                  borderRadius: BorderRadius.circular(AppDimen.spacing_2)),
              child: TabBar(
                  isScrollable: true,
                  indicator: BoxDecoration(color: Colors.transparent),
                  tabs: [
                    for (int i = 0; i < categories.length; i++)
                      ValueListenableBuilder<int>(
                          valueListenable: _currentIndex,
                          builder:
                              (BuildContext context, int value, Widget? child) {
                            return Center(
                              child: Image.asset(
                                categories[i],
                                width: AppDimen.spacing_4,
                                height: AppDimen.spacing_4,
                                color: value == i
                                    ? AppColor.colorSelected
                                    : AppColor.colorUnselected,
                              ),
                            );
                          })
                  ]),
            ),
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
      padding: EdgeInsets.symmetric(vertical: AppDimen.spacing_1),
      decoration: BoxDecoration(
          color: AppColor.colorButton,
          borderRadius: BorderRadius.circular(AppDimen.spacing_2)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1, child: Icon(Icons.search, size: AppDimen.spacing_3)),
              Expanded(
                flex: 8,
                child: CustomTextField(
                  textController: _controllerSearch,
                  hintText: 'Tìm kiếm...',
                  onSubmittedListener: (text) {
                    text = convertToTitleCase(text);
                    List<CardData>? list = _bloc.getCardWithName(text);
                    if (list!.isNotEmpty) {
                      listCardSearch.value = list;
                      sizeAnimatedContainer.value =
                          MediaQuery.of(context).size.height;
                    } else {
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
              return InkWell(
                onTap: () => Navigator.pushNamed(
                    context, RoutePaths.CARD_DETAIL,
                    arguments: [item, 'Ý nghĩa lá bài']),
                child: Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          item.front,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: AppDimen.spacing_2),
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
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
