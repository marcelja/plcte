import random
import time


class PacMan():
    def __init__(self, number_dots):
        self.number_dots = number_dots

    def eat_dot(self):
        print("eats dot")

    def start(self):
        while True:
            time.sleep(random.randint(1, 3))
            self.eat_dot()

        # Create a counter for eat_dot() executions
        """
        when eat_dot() == self.number_dots:
            self.next_level()
        """


if __name__ == '__main__':
    print("workd")
    pacman = PacMan(20)
    pacman.start()
