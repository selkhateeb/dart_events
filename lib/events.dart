library events;

/** Event bus class */
class EventsManager {
  
  /** singleton factory */
  static final EventsManager _instance = new EventsManager._internal();
  factory EventsManager() => _instance;
  
  /** place holder for Events object */
  Events _events;
  
  /** keeps track of events and their handlers */
  Map<String, EventHandlers> _map = new Map<String, EventHandlers>();
  
  /** internal constructor for factory to use */
  EventsManager._internal(){
    this._events = new Events(this);    
  }
  
  /** gets list of events to add/remove handlers from.
   * It returns a generic object to add any type of event.
   * Example:
   *    var eventbus = new EventsManager();
   *    eventbus.on.any_event.add((e){ print(e);}); 
   */
  Events get on => _events;
  
  /** Dispatches the event to its handlers.
   * if no handlers are found, this function has no effect. 
   */
  void dispatch(Event event){
    for (var handler in this._map[event.type]) {
      handler(event);
    }
  }

  /** gets/creates the handlers for the event type.
   * If no handlers exist it will create a new [EventHandlers] object
   * and returns it. 
   */
  EventHandlers _getEventHandlers(String eventName) {
    if(!this._map.containsKey(eventName)){
      this._map[eventName] = new EventHandlers();
    }
    return this._map[eventName];
  }
}



/** Manages what type of events to return 
 *  this is what returns when using [EventsManager.on]
 */
class Events {
  
  EventsManager _eventsManager;

  Events(EventsManager eventsManager):
    this._eventsManager = eventsManager; 

  /** here is where the magic happens. We take the 'getter' name,
   * use it as an event name and return an instance of [EventHandlers]
   * through [EventsManager] 
   */
  EventHandlers noSuchMethod(InvocationMirror invocationMirror){
    var eventType = invocationMirror.memberName.replaceAll('get:', '');
    return this._eventsManager._getEventHandlers(eventType);
  }
}



/** A list like class to mange event handlers */
class EventHandlers extends Iterable {
  List<Function> _handlers = new List();
  
  /** adds handler to this event */
  void add(Function handler){
    this._handlers.add(handler);
  }
  
  /** removes the handler and returns it */
  Function remove(Function handler){
    return this._handlers.removeAt(this._handlers.indexOf(handler));
  }

  Iterator iterator() => this._handlers.iterator();
}



/** Only [Event] objects and subclasses allowed on the event bus 
 * ([EventsManager]) */
class Event {
  String type;
  Event(this.type);
}
