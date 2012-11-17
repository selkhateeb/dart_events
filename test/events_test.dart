
import 'package:unittest/unittest.dart';
import 'package:events/events_lib.dart';

void main(){
  group('Typical API usage tests', () {
    test('singleton', () {
      var bus1 = new EventsManager();
      var bus2 = new EventsManager();
      expect(bus1, equals(bus2), reason:'not singleton'); 
    });

    test('add handler and dispatch', () {
      var bus = new EventsManager();
      bus.on.some_event_add_remove.add(expectAsync1((e){}));
      bus.dispatch(new Event('some_event_add_remove'));
    });
        
    test('add/remove handlers', () {
      var bus = new EventsManager();
      var handler1 = expectAsync1((e){});
      var handler2 = (e) => guardAsync((e){ 
        expect(false, 'handler 2 should not be reached'); 
        });
      
      bus.on.some_event_a_r.add(handler1);
      bus.on.some_event_a_r.add(handler2);
      bus.on.some_event_a_r.remove(handler2);
      
      bus.dispatch(new Event('some_event_a_r'));
    });
    
    test('add multiple handlers', () {
      var bus = new EventsManager();
      var handler1 = expectAsync1((e){}, count:2);
      bus.on.some_event_2.add(handler1);
      bus.on.some_event_2.add(handler1);
      bus.dispatch(new Event('some_event_2'));
    });
  });
  
  group('EventsManager', (){
    test('verify "on" returns the same object each time', (){
      var bus = new EventsManager();
      expect(bus.on, equals(bus.on));
    });

    test('dispatch', (){
      var bus = new EventsManager();
      bus.on.some_event.add(expectAsync1((e){}));
      bus.dispatch(new Event('some_event'));
    });

    test('_getEventHandlers', (){
      var bus = new EventsManager();
      expect(bus.on.some_other_event, equals(bus.on.some_other_event));
      expect(bus.on.some_other_event, isNot(equals(bus.on.some_event)));
    });
  });

  group('Event', (){
    test('constructor', (){
      var type = 'some_nice_type';
      var event = new Event(type);
      expect(type, equals(event.type));
    });
  });

  group('EventHandlers', (){
    test('add', (){
      var handlers = new EventHandlers();
      var handler = (e){};
      handlers.add(handler);
      for(var h in handlers){
        expect(handler, equals(h));
      }
    });

    test('remove', (){
      var handlers = new EventHandlers();
      var handler = (e){};
      handlers.add(handler);
      handlers.remove(handler);
      for(var h in handlers){
        expect(false, 'failed .. should not be here');
      }
    });
    
  });
}
