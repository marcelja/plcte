package com.bjennware.plcte;

import com.badlogic.gdx.ApplicationAdapter;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.math.Rectangle;
import com.badlogic.gdx.math.Vector2;

import java.util.Random;

public class App extends ApplicationAdapter {
    private EventManager manager;

    SpriteBatch batch;
    Texture pacman;
    Texture ghost;
    Texture dot;

    Vector2 pos = new Vector2();

    @Override
    public void create() {
        batch = new SpriteBatch();
        pacman = new Texture("pacman.png");
        ghost = new Texture("ghost.jpeg");
        dot = new Texture("dot.png");
        manager = new EventManager();
        manager.registerTrigger(new EventManager.Trigger() {
            @Override
            public void trigger() {
                System.out.println("Eat dot");
            }
        }, "eat-dot");

        manager.registerTrigger(new EventManager.Trigger() {
            @Override
            public void trigger() {
                if(manager.hasEvent("eat-dot")) return;
                System.out.println("PacMan hit ghost");
                pos = new Vector2();
                manager.removeEvent("hit-ghost");
            }
        }, "hit-ghost");
        manager.registerTrigger(new EventManager.Trigger() {
            @Override
            public void trigger() {
                System.out.println("PacMan eat ghost");
                pos = new Vector2();
                manager.removeEvent("hit-ghost");
                manager.removeEvent("eat-dot");
                batch.setColor(new Random().nextInt(255) / 255f,new Random().nextInt(255) / 255f,new Random().nextInt(255) / 255f,1);
            }
        }, "hit-ghost","eat-dot");
    }

    @Override
    public void render() {
        Gdx.gl.glClearColor(0.2f, 0.2f, 0.2f, 1);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        batch.begin();
        batch.draw(pacman, pos.x, pos.y, 100, 100);
        batch.draw(ghost, 300, 300, 100, 100);
        batch.draw(dot, 500, 200, 100, 100);
        batch.end();

        if (Gdx.input.isKeyJustPressed(Input.Keys.S)) {
            manager.addEvent("hit-ghost");
            manager.addEvent("one-time");
        }

        if (Gdx.input.isKeyPressed(Input.Keys.RIGHT)) {
            pos.x += 20;
        }
        if (Gdx.input.isKeyPressed(Input.Keys.LEFT)) {
            pos.x -= 20;
        }
        if (Gdx.input.isKeyPressed(Input.Keys.UP)) {
            pos.y += 20;
        }
        if (Gdx.input.isKeyPressed(Input.Keys.DOWN)) {
            pos.y -= 20;
        }

        if (new Rectangle(pos.x, pos.y, 100, 100).overlaps(new Rectangle(300, 300, 100, 100))) {
            manager.addEvent("hit-ghost");
        }

        if (new Rectangle(pos.x, pos.y, 100, 100).overlaps(new Rectangle(500, 200, 100, 100))) {
            manager.addEvent("eat-dot");
        }
    }

    @Override
    public void dispose() {
        batch.dispose();
        pacman.dispose();
    }
}
