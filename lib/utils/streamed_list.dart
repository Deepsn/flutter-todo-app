import 'dart:async';

class StreamedList<T> {
  StreamController<List<T>> _controller = StreamController.broadcast();
  Stream<List<T>> get stream => _controller.stream;

  List<T> list = [];

  addToList(T object) {
    list.add(object);
    _controller.add(list);
  }

  dispose() {
    _controller.close();
  }
}
