void main() {
  var a = 3;
  final List<int> myList = [1, 2, (a > 2) ? 3 : 4];
  print(myList);
}
