package com.bjennware.plcte;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

/**
 * Created by user on 17.05.2017.
 */
public class EventManager {
    private HashSet<String> events;
    private List<Constraint> constraints;

    public EventManager() {
        events = new HashSet<String>();
        constraints = new ArrayList<Constraint>();
    }

    private void checkContraints() {
        for (Constraint c : constraints) {
            if (c.checkContraintChange(events)) c.trigger();
        }
    }

    public void addEvent(String event) {
        events.add(event);
        checkContraints();
    }

    public void removeEvent(String event) {
        events.remove(event);
        checkContraints();
    }

    public void registerTrigger(Trigger trigger, String... events) {
        constraints.add(new Constraint(trigger, events));
    }

    public boolean hasEvent(String event) {
        return events.contains(event);
    }

    public interface Trigger {
        void trigger();
    }
}
