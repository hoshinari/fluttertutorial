// Replace the code in main.dart with the following.

import 'package:flutter/material.dart';

const String _name = "Your Name";
var member = ["私","モブ"];

void main() {
  runApp(new FriendlychatApp());
}

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "FakeLine",
      home: new ChatScreen(),
    );
  }

}

// Modify the ChatScreen class definition to extend StatefulWidget.

class ChatScreen extends StatefulWidget {                     //modified
  @override                                                        //new
  State createState() => new ChatScreenState();        
              //new
  
} 

// Add the ChatScreenState class definition in main.dart.

class ChatScreenState extends State<ChatScreen> {                  
  final List<ChatMessage> _messages = <ChatMessage>[];            //メッセージの格納リスト
  String _message;
  String _selected = 'One';
  
  final TextEditingController _textController = new TextEditingController(); //new
  @override                                                        //new
  Widget build(BuildContext context) {
    String dropdownValue = 'One';
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Lineもどきの会"),
        backgroundColor: Color.fromARGB(255, 70, 70, 80),
      ),
      body: new Column(                                        //modified
        children: <Widget>[                                         //new
          new Flexible(                                             //new
            child: new ListView.builder(                            //new 
              padding: new EdgeInsets.all(8.0),                     //list一つのパーツのパディング
              reverse: true,                                        //new
              itemBuilder: (_, int index) => _messages[index],      //new
              itemCount: _messages.length,                          //new
            ),                                                      //new
          ),
          
          new Divider(height: 1.0), 

          new Container(
            child:_buildMemberComposer(),
          ),

          new Container(                                            //new
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor),                  //new
            child: _buildTextComposer(),                       //modified
          ),                                                       //new
        ],                                                          //new
      ),                                                            //new
    );
  }

  Widget _buildMemberComposer(){
    return new Container(
              child: DropdownButton<String>(
                value: _selected,
                onChanged: (String value)=> popupSelected(value),
                items: <DropdownMenuItem<String>>[
                  const DropdownMenuItem<String>(
                    value: 'One',
                    child: const Text('One'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'Two',
                    child: const Text('Two'),
                  ),
                ],
              ),
              );
  }

  void popupSelected(String value){
    setState((){
      _selected = value;
      _message = 'select: $_selected';

    });

  }

  Widget _buildTextComposer() {
    
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),       //おそらくmargin
      child: new Row(                                            //new
        children: <Widget>[                                      //new
          new Container(                                                 //new
            margin: new EdgeInsets.symmetric(horizontal: 4.0),           //new
            child: new IconButton(                                       //new
              icon: new Icon(Icons.add),                              
            ), 
          ), 
          new Container(                                                 //new
            margin: new EdgeInsets.symmetric(horizontal: 4.0),           //new
            child: new IconButton(                                       //new
            icon: new Icon(Icons.camera_alt),
            ), 
          ), 
          new Container(                                                 //new
            margin: new EdgeInsets.symmetric(horizontal: 4.0),           //new
            child: new IconButton(                                       //new
              icon: new Icon(Icons.photo),                              
            ), 
          ), 
          new Flexible(                                          //new
            child: new TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: new InputDecoration.collapsed(
                hintText: "Send a message"),
            ),
          ),
          new Container(                                                 //new
            margin: new EdgeInsets.symmetric(horizontal: 4.0),           //new
            child: new IconButton(                                       //new
              icon: new Icon(Icons.send),                                //new
              onPressed: () => _handleSubmitted(_textController.text)),  //new
          ),                                                      //new
          
        ],                                                        //new
      ), 
    );
    
  }

  
  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(                         //new
      text: text,                                                  //new
    );                                                             //new
    setState(() {                                                  //new
      _messages.insert(0, message);                                //new
    });          
  }
}
class ChatMessage extends StatelessWidget {
  ChatMessage({this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(child: new Text(member[1])),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_, style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


