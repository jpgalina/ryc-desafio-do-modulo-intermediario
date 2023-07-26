import 'package:marvel_api/api/api.dart';
import 'package:marvel_api/model/series.dart';
import 'package:mobx/mobx.dart';

part 'series_list.store.g.dart';

class SeriesListStore = _SeriesListStore with _$SeriesListStore;

abstract class _SeriesListStore with Store {
  @observable
  List<Series> list = [];

  @observable
  bool isFetching = false;

  @observable
  bool fetchError = false;

  @action
  void fillList() {
    isFetching = true;
    API.getSeries().then((value) {
      stopFetching();
      list = value;
      if (list.isEmpty) {
        triggerError();
      } else {
        reset();
      }
    });
  }

  void reset() {
    fetchError = false;
  }

  @action
  void triggerError() {
    fetchError = true;
  }

  @action
  void stopFetching() {
    isFetching = false;
  }
}