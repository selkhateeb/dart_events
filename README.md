# Events for dart
An easy to use event bus library in Dart.

## Installation
In the `dependencies` section of `pubspec.yaml` file add the
following:

```yaml
  events:
    git: git://github.com/selkhateeb/dart_events.git
```

## Usage
here is a simple code that attaches handlers to an event called
`SomeEvent'. Then fires the event on the bus.

```dart
main(){
  var bus = new EventsManager();
  bus.on.SomeEvent.add((e){
    print(e.type); //prints 'SomeEvent' when fired
  });
  bus.dispatch(new Event('SomeEvent'));
}
```

## Help/Support
Feel free to report any issues on github.

## Contribution
Simply fork this repo, do code changes, then ask for pull request.
visit https://help.github.com/articles/fork-a-repo for more details
