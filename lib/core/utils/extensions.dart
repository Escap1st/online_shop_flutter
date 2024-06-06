extension LetExtension<T extends Object> on T {
  R let<R>(R Function(T it) func) {
    return func(this);
  }
}

extension AlsoExtension<T extends Object> on T {
  T also(void Function(T it) func) {
    func(this);
    return this;
  }
}
