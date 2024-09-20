class Task
{
  late String title;
  late bool isCompleted;

  Task({ this.isCompleted=false,required this.title});
   Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }
   static Task fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }
}
