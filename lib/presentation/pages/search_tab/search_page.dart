import 'package:dalotee/common/mixins/after_layout.dart';
import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/configs/service_locator.dart';
import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/data/model/response/get_card_category_response.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/pages/search_tab/search_bloc.dart';
import 'package:dalotee/presentation/pages/search_tab/search_state.dart';
import 'package:dalotee/presentation/widgets/base/custom_appbar.dart';
import 'package:dalotee/presentation/widgets/base/custom_text.dart';
import 'package:dalotee/values/colors.dart';
import 'package:dalotee/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CategoryCardID {
  static const String MajorArcana = "61b6f29a131b1d0eee3cea91";
  static const String Cups = "61b6f29d131b1d0eee3cea94";
  static const String Swords = "61b6f2a9131b1d0eee3cea97";
  static const String Wands = "61b6f2ad131b1d0eee3cea9a";
  static const String Pentacles = "61b6f2b1131b1d0eee3cea9d";
}

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage>
    with AfterLayoutMixin, AutomaticKeepAliveClientMixin {
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
  List<String> categoryIds = [
    CategoryCardID.MajorArcana,
    CategoryCardID.Wands,
    CategoryCardID.Swords,
    CategoryCardID.Cups,
    CategoryCardID.Pentacles,
  ];
  ValueNotifier<List<CardData>?> listCardSearch =
      ValueNotifier<List<CardData>?>(null);

  // Size of Animated
  ValueNotifier<double> sizeAnimatedContainer = ValueNotifier<double>(0);

  ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  bool get wantKeepAlive => true;

  @override
  void afterFirstFrame(BuildContext context) {
    _bloc.getCardWithCategories(categoryIds[0]);
  }

  _blocListener(BuildContext context, SearchPageState state) async {
    print("State: $state");
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
    super.build(context);
    return BlocProvider(
      create: (context) => _bloc,
      child: DefaultTabController(
        length: categories.length,
        child: Builder(
          builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context)!;
            tabController.addListener(() {
              if (!tabController.indexIsChanging) {
                _currentIndex.value = tabController.index;

                _bloc.getCardWithCategories(categoryIds[tabController.index]);
              }
            });
            return Scaffold(
              backgroundColor: AppColor.colorPrimary,
              appBar: _buildAppBar(),
              body: Container(
                child: ValueListenableBuilder<double>(
                    valueListenable: sizeAnimatedContainer,
                    builder:
                        (BuildContext context, double size, Widget? child) {
                      // if (size != 0) {
                      //   return AnimatedContainer(
                      //       curve: Curves.linear,
                      //       duration: Duration(seconds: 10),
                      //       height: size,
                      //       width: size,
                      //       child: ValueListenableBuilder<List<CardData>?>(
                      //           valueListenable: listCardSearch,
                      //           builder: (BuildContext context,
                      //               List<CardData>? listCard, Widget? child) {
                      //             return _buildGridView([]);
                      //           }));
                      // }
                      {
                        return TabBarView(
                          children: [
                            for (int i = 0; i < 5; i++)
                              _buildListCard(categoryIds[i])
                          ],
                        );
                      }
                    }),
              ),
            );
          },
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: CustomText("Tra cứu lá bài",
          fontFamily: FontFamily.gelasio, fontSize: AppDimen.sizeAppBarText),
      leading: SizedBox(),
      bottom: PreferredSize(
        preferredSize: Size(0, 50),
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
            SizedBox(height: 16.0)
            // _buildSearchBar()
          ],
        ),
      ),
    );
  }

//   _buildSearchBar() {
//     return Container(
//       margin: EdgeInsets.symmetric(
//           vertical: AppDimen.spacing_2, horizontal: AppDimen.spacing_3),
//       padding: EdgeInsets.symmetric(vertical: AppDimen.spacing_1),
//       decoration: BoxDecoration(
//           color: AppColor.colorButton,
//           borderRadius: BorderRadius.circular(AppDimen.spacing_2)),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                   flex: 1, child: Icon(Icons.search, size: AppDimen.spacing_3)),
//               Expanded(
//                 flex: 8,
//                 child: CustomTextField(
//                   textController: _controllerSearch,
//                   hintText: 'Tìm kiếm...',
//                   onSubmittedListener: (text) {
//                     text = convertToTitleCase(text);
//                     List<CardData>? list = _bloc.getCardWithName(text);
//                     if (list!.isNotEmpty) {
//                       listCardSearch.value = list;
//                       sizeAnimatedContainer.value =
//                           MediaQuery.of(context).size.height;
//                     } else {
//                       sizeAnimatedContainer.value = 0;
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

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

  Widget _buildListCard(String category) {
    List<CardResponseModel>? list;

    return BlocListener<SearchPageBloc, SearchPageState>(
      listener: _blocListener,
      child: BlocBuilder<SearchPageBloc, SearchPageState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is SearchPageGetDataSuccessState) {
            list = state.data;
            return _buildGridView(list ?? []);
          }
          return Container();
        },
      ),
    );
  }

  _buildGridView(List<CardResponseModel>? list) {
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
            CardResponseModel item = list[index];
            return InkWell(
              onTap: () => Navigator.pushNamed(context, RoutePaths.CARD_DETAIL,
                  arguments: [item, 'search']),
              child: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                              image:
                                  NetworkImage(item.images?[0].imageUrl ?? ''),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: AppDimen.spacing_2),
                        child: Center(
                          child: CustomText(
                            item.name ?? "",
                            fontSize: 16.0,
                            fontFamily: FontFamily.poppins,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
