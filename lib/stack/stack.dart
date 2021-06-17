// import 'dart:core';
//
// class Stack{
//     static List past = [];
//    static var present =  0;
//   static List future =  [];
//
//
//   canUndo(){
//     if(Stack.past.length>0){
//       Stack.future.add(Stack.present);
//       Stack.present = Stack.past.removeLast();
//     }
//   }
//
//   canRedo(){
//     if(Stack.future.length >0){
//       Stack.past.add(Stack.present);
//       Stack.present = Stack.present;
//     }
//   }
// //   const updateState = function(value) {
// //   state.past = state.present;
// //   state.present = value;
// // };
//
//
// }

// import 'dart:collection';
//
// class Stack<String> {
//   final _stack = Queue<String>();
//
//   void push(String element) {
//     _stack.addLast(element);
//   }
//
//   String pop() {
//     final String lastElement = _stack.last;
//     _stack.removeLast();
//     return lastElement;
//   }
//
//   void clear() {
//     _stack.clear();
//   }
//
//   bool get isEmpty => _stack.isEmpty;
// }