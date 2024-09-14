import 'dart:async';

class StreamedList<T> {
  StreamController<List<T>> _controller = StreamController.broadcast();
  Stream<List<T>> get stream => _controller.stream;

  List<T> list = [];

  set(List<T> value) {
    list = value;
    _controller.add(value);
  }

  addToList(T object) {
    list.add(object);
    _controller.add(list);
  }

  dispose() {
    _controller.close();
  }
}
