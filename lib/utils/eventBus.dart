import 'package:event_bus/event_bus.dart';
import 'package:uitest/model/typeInfo.dart';
EventBus eventBus = new EventBus();
class TypeSelectEvent {
  TypeInfo typeInfo;
  TypeSelectEvent(this.typeInfo);
}