// Making a class for the toDO list using Strings for ID and text while using Boolean to
// check if the task done is true or not
class ToDo {
  String? id;
  String? todoText;
  bool isDone;

//Making sure that ID and Text is required while having task completed to false
  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });
//Adding few values to todoList
  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '01',
        todoText: 'Wake Up early',
        isDone: false,
      ),
      ToDo(
        id: '02',
        todoText: 'Morning Exercise',
        isDone: true,
      ),
      ToDo(
        id: '03',
        todoText: 'Check Emails',
      ),
      ToDo(
        id: '04',
        todoText: 'Do assignments',
      ),
      ToDo(
        id: '05',
        todoText: 'Attend Class',
      ),
      ToDo(
        id: '06',
        todoText: 'Dinner with Mom',
      ),
    ];
  }
}
