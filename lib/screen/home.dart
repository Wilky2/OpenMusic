import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:open_music/data/local/Storage.dart';
import 'package:open_music/screen/music/SearchMusic.dart';
import 'package:open_music/screen/utils/Text.dart';
import 'package:open_music/main.dart';
import 'package:open_music/screen/Setting.dart';
import 'package:open_music/screen/utils/Error.dart';
import 'package:open_music/screen/utils/Progress.dart';
import 'package:provider/provider.dart';
import '../data/api/ApiService.dart';
import '../model/Creator.dart';
import 'music/MiniPlayer.dart';
import 'music/MusicList.dart';
import 'music/Player.dart';
import 'music/PlayerManager.dart';
import 'music/Tracks.dart';
import 'utils/Image.dart';
import 'utils/Title.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> tabs = [AppText.Favorite, AppText.Tracks, AppText.Artists];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SearchMusic();
                    },
                  );
                },
                icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return SettingsPage();
                  })
                );
              },
              icon: Icon(Icons.settings),
            ),
          ],
          bottom: TabBar(
            tabs: tabs.map((tab) =>
                Tab(
                  icon:Icon(getTabIcon(tab)),
                  text: tab.tr(),
                )
            ).toList(),
          ),
        ),
        body:Stack(
          children: [
            TabBarView(
              children: [
                ValueListenableBuilder(
                    valueListenable: StorageService.favoriteChange,
                    builder: (ctx,value,widget)=>Track(key:value?UniqueKey():UniqueKey(),getAllMusic: StorageService.getAllFavoriteMusic)
                ),
                Track(getAllMusic: APIService.getAllMusic,),
                _Artist(),
              ],
            ),
            MiniPlayer(appState: appState),
          ]
        ),
      ),
    );
  }

  IconData getTabIcon(String tab) {
    switch (tab) {
      case AppText.Tracks:
        return Icons.library_music;
      case AppText.Favorite:
        return Icons.favorite;
      case AppText.Artists:
        return Icons.album;
      default:
        return Icons.library_music;
    }
  }

}

class _Artist extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ArtistState();
  }

}

class _ArtistState extends State<_Artist> {
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
                      child: Column(
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
                              musicTitleStyle: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
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