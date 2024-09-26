import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:state_management/data/model/characters.dart';
import 'package:state_management/helpers/constants/my_colors.dart';
import 'package:state_management/logic/cubit/characters_cubit.dart';
import 'package:state_management/presention/widgets/chartacter_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharactersModel> allChartacters;
  late List<CharactersModel> searchResult = [];
  bool _isSearching = false;
  final _searchTextContrller = TextEditingController();

  Widget buildSearchField() {
    return TextField(
      controller: _searchTextContrller,
      cursorColor: MyColors.white,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.white,
          fontSize: 16,
        ),
      ),
      style: const TextStyle(
        color: MyColors.white,
        fontSize: 16,
      ),
      onChanged: (searchedChartacter) {
        addSearchedForChartacterItem(searchedChartacter);
      },
    );
  }

  void addSearchedForChartacterItem(String searchedChartacter) {
    searchResult = allChartacters
        .where(
          (chartacter) => chartacter.name.toLowerCase().startsWith(
                searchedChartacter.toLowerCase(),
              ),
        )
        .toList();
    setState(() {
      // searchResult;
    });
  }

  List<Widget> buildAppAction() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearchQuery();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear_rounded,
            color: MyColors.white,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            startSearch();
          },
          icon: const Icon(
            Icons.search_rounded,
            color: MyColors.white,
          ),
        ),
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(
        onRemove: _stopSearching,
      ),
    );
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchTextContrller.clear();
      addSearchedForChartacterItem('');
    });
  }

  @override
  void initState() {
    super.initState();
    // Trigger the asynchronous data loading
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBluckWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is ChartactersLoaded) {
          allChartacters = (state).chartacters.cast<CharactersModel>();
          return buildLoadedWidget();
        } else {
          return showProgressIndicator();
        }
      },
    );
  }

  Widget showProgressIndicator() {
    return Center(
      child: Lottie.asset('assets/animation/thinking.json'),
    );
  }

  Widget buildLoadedWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.grey,
        child: Column(
          children: [
            buildChartactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildChartactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextContrller.text.isEmpty
          ? allChartacters.length
          : searchResult.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: _searchTextContrller.text.isEmpty
              ? allChartacters[index]
              : searchResult[index],
        );
      },
    );
  }

  Widget buildAppTitle() {
    return const Text(
      'Characters',
      style: TextStyle(
        color: MyColors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? buildSearchField() : buildAppTitle(),
        leading: _isSearching
            ? const BackButton(
                color: MyColors.white,
              )
            : null,
        actions: buildAppAction(),
      ),
      body: buildBluckWidget(),
    );
  }
}
