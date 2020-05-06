import 'package:flash_card/main.dart';
import 'package:moor/moor.dart' as moor;
import 'package:flash_card/services/database.dart' as data;
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DeckList(),
    );
  }
}

class DeckList extends StatefulWidget {
  @override
  _DeckListState createState() => _DeckListState();
}

class _DeckListState extends State<DeckList> {
  TextEditingController _textController = TextEditingController();

  Future<void> _showCreatDeckDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Deck'),
            content: Container(
              child: TextField(
                controller: _textController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Deck Name',
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final db = AppDatabase.of(context).database;
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: StreamBuilder(
        stream: db.watchAllDecks(),
        builder: (context, snapshot) {
          final _decks = snapshot.data ?? List();

          return GridView.builder(
            itemCount: _decks.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 25.0,
              mainAxisSpacing: 25.0,
            ),
            itemBuilder: (context, index) {
              if (index == _decks.length) {
                return _buildItem(addItem: true);
              }
              return _buildItem(deck: _decks[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildItem({data.Deck deck, bool addItem: false}) {
    final db = AppDatabase.of(context).database;
    return InkWell(
      onTap: () async {
        if (addItem == true) {
          await _showCreatDeckDialog();
          final newDeck =
              data.DecksCompanion(name: moor.Value(_textController.text));
          db.addDeck(newDeck);
        } else {
          Navigator.pushNamed(context, '/deck_content', arguments: deck);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
          bottom: Radius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Theme.of(context).primaryColorLight,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: !addItem
              ? ItemDeck(
                  deckName: deck.name,
                )
              : Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        size: MediaQuery.of(context).size.width / 7,
                        color: Colors.black54,
                      ),
                      Text('New Deck')
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class ItemDeck extends StatelessWidget {
  final String deckName;

  ItemDeck({this.deckName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.expand,
      children: <Widget>[
        Align(
          alignment: Alignment(0, 1),
          child: FractionallySizedBox(
            // widthFactor: 0.9,
            heightFactor: 0.5,
            child: Container(
              color: Theme.of(context).primaryColorLight,
              child: Align(
                alignment: Alignment(0, 0.6),
                child: Text(deckName),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, -1),
          child: FractionallySizedBox(
            heightFactor: 0.8,
            widthFactor: 0.6,
            child: DeckIco(),
          ),
        ),
      ],
    );
  }
}

class DeckIco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          _buildCard(align: Alignment(-0.3, -0.5)),
          _buildCard(align: Alignment(0, -0.2)),
          _buildCard(align: Alignment(0.3, 0.1)),
        ],
      ),
    );
  }

  Widget _buildCard({Alignment align}) {
    return Align(
      alignment: align,
      child: FractionallySizedBox(
        widthFactor: 0.7,
        heightFactor: 0.7,
        child: Card(
          elevation: 10.0,
          child: align == Alignment(0.3, 0.1)
              ? Center(
                  child: Icon(
                    Icons.open_in_new,
                    color: Colors.black54,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

// class CardAddWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: InkWell(
//         onTap: () async {

//         },
//         child: ClipRRect(
//           borderRadius: BorderRadius.vertical(
//             top: Radius.circular(10.0),
//             bottom: Radius.circular(10.0),
//           ),
//           child: Container(
//             width: 200.0,
//             height: 200.0,
//             decoration: BoxDecoration(
//                 border: Border.all(
//                   width: 1.0,
//                   color: Theme.of(context).primaryColorLight,
//                 ),
//                 borderRadius: BorderRadius.circular(10.0)),
//             child: Container(
//               color: Theme.of(context).primaryColor.withOpacity(0.1),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Icon(
//                     Icons.add,
//                     size: MediaQuery.of(context).size.width / 7,
//                     color: Colors.black54,
//                   ),
//                   Text('New Deck')
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
