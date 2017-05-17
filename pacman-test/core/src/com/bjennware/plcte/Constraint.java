package com.bjennware.plcte;

import java.util.HashSet;

/**
 * Created by user on 17.05.2017.
 */
public class Constraint {
    private EventManager.Trigger trigger;
    private String[] events;
    private boolean changed;

    public Constraint(EventManager.Trigger trigger, String[] events) {
        this.trigger = trigger;
        this.events = events;
        this.changed = true;
    }

    public boolean checkContraintChange(HashSet<String> set) {
        for (String e : events) {
            if (!set.contains(e)) {
                changed = true;
                return false;
            }
        }

        if(!changed) return false;

        changed = false;
        return true;
    }

    public void trigger() {
        trigger.trigger();
    }
}
