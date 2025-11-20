abstract class DetailEvent {}
class LoadDetail extends DetailEvent {
  final int movieId;
  LoadDetail(this.movieId);
}