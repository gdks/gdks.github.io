---
title: GWT MVP with Activities and Places
description: GWT MVP with Activities and Places
header: GWT MVP with Activities and Places
---

### View
```
public interface HelloView extents IsWidget {
    public interface Presenter {
         String getName();
    }
}
```

### ClientFactory

Holds on to instances of views and other reusable resources.

```
public interface ClientFactory {
    EventBus getEventBus();
    HelloView getHelloView();
}
```

### Activity

Similar to Presenter. Implements the Presenter interface defined in the view above.

```
public class HelloActivity extends AbstractActivity implements HelloView.Presenter {
    private String name;
    private ClientFactory clientFactory;

    //this is equivalent to the go method in the Presenter
    @Override
    public void start(AcceptsOneWidget container, EventBus eventBus) {
         HelloView view = clientFactory.getHelloView();
         view.setName(name);
    }
}
```

### Place

Most Activities have an associated Place.

```
public class HelloPlace extends Place {
    private String name;
    public HelloPlace(String token) { this.name = token }
    public String getName() { return this.name; }

    public static class Tokenizer implements PlaceTokenizer<HelloPlace> {
         @Override
         public String getToken(HelloPlace place) { ... }

          @Override
         public HelloPlace getPlace(String token) { ... }
    }
}
```

### PlaceHistoryMapper

Link between PlaceTokenizers and GWT's history mechanism.

```
@WithTokenizers({ HelloPlace.Tokenizer.class, ... })
public interface MyPlaceHistoryMapper extends PlaceHistoryMapper {}
```

### ActivityMapper

How we map each Place to an Activity. Used to automatically route app to an Activity.

```
public class MyActivityMapper implements ActivityMapper {
    @Override
    public Activity get Activity(Place place) {
         if (place instanceof HelloPlace) {
              return new HelloActivity();
         } else if (place instanceof ...) { }
     }
}
```

&nbsp;
