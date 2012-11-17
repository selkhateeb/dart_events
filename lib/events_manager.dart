part of events;

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
