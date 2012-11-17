part of events;

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
