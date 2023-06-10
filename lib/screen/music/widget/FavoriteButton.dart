import 'package:flutter/material.dart';

import '../../../data/local/Storage.dart';
import '../../../model/Music.dart';
import '../../../utils/Error.dart';

class FavoriteButton extends StatefulWidget{

  final Music music;

  const FavoriteButton({super.key,required this.music});

  @override
  State<StatefulWidget> createState() {
    return _FavoriteButtonState();
  }
}

class _FavoriteButtonState extends State<FavoriteButton>{

  late Future<bool> isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = StorageService.isMusicInFavorite(widget.music);
  }

  void reload() {
    setState(() {
      isFavorite = StorageService.isMusicInFavorite(widget.music);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FutureBuilder(
            future: isFavorite,
            builder: (context,result){
              if(result.hasData){
                return IconButton(
                  icon: result.data! ? Icon(Icons.favorite,size: 40,) : Icon(Icons.favorite_border,size: 40,),
                  onPressed: () async{
                    await StorageService.toggleMusicInFavorite(widget.music);
                    setState(() {
                      isFavorite = StorageService.isMusicInFavorite(widget.music);
                    });
                  },
                );
              }
              else if(result.hasError){
                return ShowError(reload: reload, error: result.error.toString());
              }
              else{
                return CircularProgressIndicator();
              }
            }
        ),
      ],
    );
  }
}