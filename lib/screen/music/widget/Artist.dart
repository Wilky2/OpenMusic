import 'package:flutter/material.dart';

import '../../../data/api/ApiService.dart';
import '../../../model/Creator.dart';
import '../../../utils/Error.dart';
import '../../../utils/Image.dart';
import '../../../utils/Progress.dart';
import '../../../utils/Title.dart';
import '../MusicList.dart';

class Artist extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ArtistState();
  }

}

class _ArtistState extends State<Artist> {
  late Future<List<Creator>> _albumList;
  late Key _albumListKey;

  void reload(){
    setState(() {
      _albumListKey =UniqueKey();
      _albumList = APIService.getAllCreator();
    });
  }

  @override
  void initState(){
    super.initState();
    _albumListKey =UniqueKey();
    _albumList = APIService.getAllCreator();

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Creator>>(
          key: _albumListKey,
          future: _albumList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: () async{
                  await Future.delayed(Duration(seconds: 2));
                  reload();
                },
                child: SingleChildScrollView(
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    children:snapshot.data!.map((creator) =>  ElevatedButton(
                        style : ElevatedButton.styleFrom(
                            minimumSize: Size(MediaQuery.of(context).size.width/2-10, MediaQuery.of(context).size.height/2),
                            side: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                            padding: EdgeInsets.all(0),
                            shape : ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0))
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return MusicList(getAllMusic: () { return APIService.getRelatedCreatorMusic(creator:creator); },);
                          })
                          );
                        },
                        child: _ArtistCard(creator: creator,)
                    )
                    ).toList(),
                  ),
                ),
              );
            }else if (snapshot.hasError) {
              return ShowError(reload: reload, error: snapshot.error.toString(),);
            } else {
              return CircularProgress();
            }
          }
      ),
    );
  }
}

class _ArtistCard extends StatelessWidget {
  final Creator creator;

  const _ArtistCard({
    required this.creator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
            flex: 1000,
            child: SizedBox(
              width: MediaQuery.of(context).size.width/2-10,
              height: MediaQuery.of(context).size.height/2,
              child: ShowNetWorkImage(thumbnail: creator.thumbnail ,),
            )
        ),
        SizedBox(
          height: 30,
          child: OverflowTitle(
            text: creator.creator,
            titleStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}