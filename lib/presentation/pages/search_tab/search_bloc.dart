import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/presentation/pages/daily_tab/data.dart';
import 'package:dalotee/presentation/pages/search_tab/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPageBloc extends BlocBase<SearchPageState> {
  final AppRepository appRepository;

  SearchPageBloc({required this.appRepository}) : super(SearchPageState());

//   List<CardData> listAllCard = [
//     CardData(
//         name: "The Fool",
//         front: Assets.images.imgTheFoolCard.path,
//         back: Assets.images.imgBackCard.path,
//         description: description,
//         meaning: meaning,
//         category: "Major Arcana"),
//     CardData(
//         name: "The Fool",
//         front: Assets.images.imgTheFoolCard.path,
//         back: Assets.images.imgBackCard.path,
//         description: description,
//         meaning: meaning,
//         category: "Pentacles"),
//     CardData(
//         name: "The Fool",
//         front: Assets.images.imgTheFoolCard.path,
//         back: Assets.images.imgBackCard.path,
//         description: description,
//         meaning: meaning,
//         category: "Cup"),
//     CardData(
//         name: "The Fool",
//         front: Assets.images.imgTheFoolCard.path,
//         back: Assets.images.imgBackCard.path,
//         description: description,
//         meaning: meaning,
//         category: "Pentacles"),
//     CardData(
//         name: "The Fool",
//         front: Assets.images.imgTheFoolCard.path,
//         back: Assets.images.imgBackCard.path,
//         description: description,
//         meaning: meaning,
//         category: "Swords"),
//     CardData(
//         name: "The Fool",
//         front: Assets.images.imgTheFoolCard.path,
//         back: Assets.images.imgBackCard.path,
//         description: description,
//         meaning: meaning,
//         category: "Pentacles"),
//     CardData(
//         name: "The Fool",
//         front: Assets.images.imgTheFoolCard.path,
//         back: Assets.images.imgBackCard.path,
//         description: description,
//         meaning: meaning,
//         category: "Pentacles"),
//     CardData(
//         name: "The Fool",
//         front: Assets.images.imgTheFoolCard.path,
//         back: Assets.images.imgBackCard.path,
//         description: description,
//         meaning: meaning,
//         category: "Pentacles"),
//     CardData(
//         name: "The Fool",
//         front: Assets.images.imgTheFoolCard.path,
//         back: Assets.images.imgBackCard.path,
//         description: description,
//         meaning: meaning,
//         category: "Wands"),
//     CardData(
//         name: "The Fool",
//         front: Assets.images.imgTheFoolCard.path,
//         back: Assets.images.imgBackCard.path,
//         description: description,
//         meaning: meaning,
//         category: "Wands"),
//   ];
//   Future<void> getData() async {
//     emit(SearchPageLoadingState());
//     emit(SearchPageGetDataSuccessState());
//     // emit(SearchPageGetDataFailState());
//   }

  Future<void> getCardWithCategories(String category) async {
    var response = await appRepository.apiService.getCardByCategory(category);

    if (response.isSuccessful()) {
      final resultData = response.response?.data;

      emit(SearchPageGetDataSuccessState(resultData!.data!));
    } else {
      emit(SearchPageGetDataFailState('Failed to get data'));
    }

    // List<CardData> listCard = [];
    // listAllCard.forEach((element) {
    //   if (element.category == category) {
    //     listCard.add(element);
    //   }
    // });
    // return listCard;
  }

//   List<CardData>? getCardWithName(String name) {
//     List<CardData> listCard = [];
//     listAllCard.forEach((element) {
//       if (element.name == name) {
//         listCard.add(element);
//       }
//     });
//     return listCard;
//   }
}
