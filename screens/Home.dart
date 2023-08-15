import 'package:flutter/material.dart';
import 'package:todo/model/ToDo.dart';
import '../constants/colors.dart';
import '../widgets/ToDoItems.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _BuilderAppBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(children: [
                searchBox(),
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: const Text(
                        "All ToDos",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    for (ToDo toDo in _foundToDo.reversed)
                      ToDoItems(
                        todo: toDo,
                        onToDoChenged: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,

                        
                      ),
                  ],
                ))
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin:const EdgeInsets.only(
                          bottom: 20,
                          right: 20,
                          left: 20
                        ),
                        padding:const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow:const [BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0,0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          
                        ),
                        child: TextField(
                          controller: _todoController,
                          decoration: InputDecoration(
                            hintText: "Add a new todo item",
                            border: InputBorder.none,
                          ),
                        ),
                    ),
                  ),
                  Container(
                    margin:const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child:  ElevatedButton(
                      child: Text(
                        "+",
                        style: TextStyle(fontSize: 40),
                      ),
                      onPressed: (){
                        _addToDoItems(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: tdBlue,
                        minimumSize: Size(64, 64),
                        elevation: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void _handleToDoChange(ToDo toDo){
    setState(() {
      toDo.isDone = !toDo.isDone;   
    });
   
  }
  void _deleteToDoItem(String id){
    setState(() {
       todoList.removeWhere((item) => item.id == id);   
    });
   
  }
  void _addToDoItems (String toDo){
    setState(() {
      todoList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));  
    });
    _todoController.clear();
  }
  void _runFilter(String enteredKeyWord){
    List<ToDo> results = [];
    if(enteredKeyWord.isEmpty  ){
      results = todoList;
    } 
    else{
      results = todoList
      .where((item) => item.todoText!
          .toLowerCase()
          .contains(enteredKeyWord.toLowerCase()))
      .toList(); 
    }
    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child:  TextField(
        onChanged: (value) => _runFilter(value),
        decoration:const InputDecoration(
          contentPadding: EdgeInsets.all(2),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 25),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(
            color: tdGrey,
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  AppBar _BuilderAppBar() {
    return AppBar(
        elevation: 0, //!убирает разделительную линию между appBar и body
        backgroundColor: tdBGColor,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            width: 40,
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50), //!сделали фото круглым
              child: Image.asset("assets/images/avatar.jpeg"),
            ),
          ),
        ]));
  }
}
