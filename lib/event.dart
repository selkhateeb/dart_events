part of events;

/** Only [Event] objects and subclasses allowed on the event bus 
 * ([EventsManager]) */
class Event {
  String type;
  Event(this.type);
}
