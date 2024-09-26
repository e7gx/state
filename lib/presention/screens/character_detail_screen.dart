import 'package:flutter/material.dart';
import 'package:state_management/data/model/characters.dart';
import 'package:state_management/helpers/constants/my_colors.dart';

class CharacterDetailScreen extends StatelessWidget {
  final CharactersModel selectedCharacter;
  const CharacterDetailScreen({super.key, required this.selectedCharacter});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.primary,
      leading: Container(
          margin: const EdgeInsets.all(7.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              MyColors.primary.withOpacity(0.8),
              Colors.teal.withOpacity(0.8),
            ]),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const BackButton(
            color: MyColors.white,
          )),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MyColors.primary.withOpacity(0.5),
                  Colors.teal.withOpacity(0.5),
                ],
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            child: Text(
              selectedCharacter.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: MyColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        background: Hero(
          tag: selectedCharacter.id,
          child: Image.network(
            selectedCharacter.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget chartacterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        color: Colors.white54,
        thickness: 3.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  // margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    gradient: LinearGradient(colors: [
                      MyColors.primary.withOpacity(0.1),
                      Colors.teal.withOpacity(0.1),
                    ]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      chartacterInfo(
                          'Character Name: ', selectedCharacter.name),
                      buildDivider(),
                      chartacterInfo('Gender: ', selectedCharacter.gender),
                      buildDivider(),
                      chartacterInfo('Current Location: ',
                          selectedCharacter.location.name),
                      buildDivider(),
                      chartacterInfo('Origin: ', selectedCharacter.origin.name),
                      buildDivider(),
                      chartacterInfo('Species: ', selectedCharacter.species),
                      buildDivider(),
                      chartacterInfo('Status: ', selectedCharacter.status),
                      buildDivider(),
                      chartacterInfo('Number of Episodes: ',
                          '${selectedCharacter.episode.length}'),
                      buildDivider(),
                      chartacterInfo(
                          'Character ID: ', '${selectedCharacter.id}'),
                      buildDivider(),
                      chartacterInfo(
                          'Type: ', selectedCharacter.type ?? 'None'),
                      const SizedBox(height: 500),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
