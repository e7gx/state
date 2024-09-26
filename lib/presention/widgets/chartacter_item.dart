import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:state_management/helpers/constants/my_colors.dart';
import 'package:state_management/data/model/characters.dart';
import 'package:state_management/helpers/constants/strings.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});
  final CharactersModel character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.teal,
            blurRadius: 2,
            spreadRadius: 0.1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            characterDetailScreen,
            arguments: character,
          );
        },
        child: GridTile(
          footer: Hero(
            tag: character.id,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              color: Colors.black54,
              child: Text(
                ' ${character.name}',
                style: const TextStyle(
                  color: Colors.white,
                  height: 1.3,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: MyColors.primary,
            child: character.image.isNotEmpty
                ? FadeInImage(
                    placeholder: const AssetImage('assets/images/hhh.png'),
                    image: NetworkImage(character.image),
                    fit: BoxFit.cover,
                  )
                : Lottie.asset('assets/animation/thinking.json'),
          ),
        ),
      ),
    );
  }
}
