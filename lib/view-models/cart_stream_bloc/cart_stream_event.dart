abstract class CartStreamEvent {
  @override
  List<Object> get props => [];
}

class FetchCartItems extends CartStreamEvent {
  FetchCartItems();
}
