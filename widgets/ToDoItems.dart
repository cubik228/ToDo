import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/model/ToDo.dart';





class ToDoItems extends StatelessWidget {
  
  final ToDo todo;
  final onToDoChenged;
  final onDeleteItem;
  
  const ToDoItems({Key? key,required this.todo,required this.onDeleteItem,required this.onToDoChenged}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChenged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding:const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
        tileColor: Colors.white,
        leading:  Icon(
          todo.isDone?
          Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title:  Text(
          todo.todoText!,
        style: TextStyle(
          fontSize: 16,
          color: tdBlack,
          decoration: todo.isDone? TextDecoration.lineThrough : null,
        ),
        ),
        trailing: Container(
          padding:const EdgeInsets.all(0),
          margin:const EdgeInsets.symmetric(vertical: 7),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon:const Icon(Icons.delete),
            onPressed: (){
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
