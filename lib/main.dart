import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/tasks.dart';
import 'model/task.dart';
import 'view/taskdetail.dart';
import 'view/taskitem.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final tasksNotifier = Tasks();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => tasksNotifier,
      child: MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => const MainPage(),
          '/detail': (context) => TaskDetail(),
        },
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Task? task;
    return Consumer<Tasks>(
      builder: (context, tasks, child) => Scaffold(
        body: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            itemCount: tasks.tasklist.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                child: GestureDetector(
                  child: TaskItem(task: tasks.tasklist[index]),
                  onTap: () async => {
                    task = await Navigator.of(context).pushNamed('/detail',
                        arguments: tasks.tasklist[index]) as Task?,
                    if (task != null)
                      {
                        tasks.update(task!),
                      }
                  },
                ),
                onDismissed: (direction) {
                  tasks.delete(tasks.tasklist[index]);
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => {
            task = await Navigator.of(context)
                .pushNamed('/detail', arguments: Task(0, '', '')) as Task?,
            if (task != null)
              {
                tasks.add(task!),
              }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
