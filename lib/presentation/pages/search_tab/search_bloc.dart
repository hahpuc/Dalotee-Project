import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/data/model/response/card_model.dart';
import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/presentation/pages/daily_tab/data.dart';
import 'package:dalotee/presentation/pages/search_tab/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPageBloc extends BlocBase<SearchPageState> {
  final AppRepository appRepository;

  SearchPageBloc({required this.appRepository}) : super(SearchPageState());

  List<CardData> listAllCard = [
    CardData(
        name: "The Fool",
        front: Assets.images.theFoolCard.path,
        back: Assets.images.backCard.path,
        description: description,
        category: "Major Arcana"),
    CardData(
        name: "The Fool",
        front: Assets.images.theFoolCard.path,
        back: Assets.images.backCard.path,
        description: description,
        category: "Pentacles"),
    CardData(
        name: "The Fool",
        front: Assets.images.theFoolCard.path,
        back: Assets.images.backCard.path,
        description: description,
        category: "Cup"),
    CardData(
        name: "The Fool",
        front: Assets.images.theFoolCard.path,
        back: Assets.images.backCard.path,
        description: description,
        category: "Pentacles"),
    CardData(
        name: "The Fool",
        front: Assets.images.theFoolCard.path,
        back: Assets.images.backCard.path,
        description: description,
        category: "Swords"),
    CardData(
        name: "The Fool",
        front: Assets.images.theFoolCard.path,
        back: Assets.images.backCard.path,
        description: description,
        category: "Pentacles"),
    CardData(
        name: "The Fool",
        front: Assets.images.theFoolCard.path,
        back: Assets.images.backCard.path,
        description: description,
        category: "Pentacles"),
    CardData(
        name: "The Fool",
        front: Assets.images.theFoolCard.path,
        back: Assets.images.backCard.path,
        description: description,
        category: "Pentacles"),
    CardData(
        name: "The Fool",
        front: Assets.images.theFoolCard.path,
        back: Assets.images.backCard.path,
        description: description,
        category: "Wands"),
    CardData(
        name: "The Fool",
        front: Assets.images.theFoolCard.path,
        back: Assets.images.backCard.path,
        description: description,
        category: "Wands"),
  ];
  Future<void> getData() async {
    emit(SearchPageLoadingState());
    emit(SearchPageGetDataSuccessState());
    // emit(SearchPageGetDataFailState());
  }

  List<CardData>? getCardWithCategories(String category) {
    List<CardData> listCard = [];
    listAllCard.forEach((element) {
      if (element.category == category) {
        listCard.add(element);
      }
    });
    return listCard;
  }

  List<CardData>? getCardWithName(String name) {
    List<CardData> listCard = [];
    listAllCard.forEach((element) {
      if (element.name == name) {
        listCard.add(element);
      }
    });
    return listCard;
  }
}
