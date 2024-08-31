class PageLKaJugad{
  final String id;
  final String name;
  final int i;

  PageLKaJugad({required this.id, required this.name, required this.i});
}

class OrekJugad{
  final int index;
  final List<PageLKaJugad> data;

  OrekJugad({required this.index, required this.data});
}