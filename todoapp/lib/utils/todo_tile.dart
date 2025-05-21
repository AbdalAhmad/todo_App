import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskname;
  final bool taskCompeleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  // Function(String)? onTaskNameChanged;
  Function()? onEdit;

  TodoTile(
      {super.key,
      required this.taskname,
      required this.taskCompeleted,
      required this.onChanged,
      // required this.onTaskNameChanged,
      required this.deleteFunction,
       required this.onEdit,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.red.shade300,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color:Color(0xFFD1C042),
              borderRadius: BorderRadius.circular(10)),
          child: Row(children: [
            //checkbox
            Checkbox(
              value: taskCompeleted,
              onChanged: onChanged,
              activeColor: Colors.black,
            ),
            Expanded(
              child: InkWell(
                onTap: onEdit,
                child: Text(
                  taskname,
                  style: TextStyle(
                      decoration: taskCompeleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                          overflow:TextOverflow.ellipsis,
                ),
               
              ),
            )
          ]),
        ),
      ),
    );
  }
}
