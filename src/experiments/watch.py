import sys
import os
import time
import subprocess

def file_modif_time(filename):
    return os.stat("./"+filename)

def autorefresh(cmd, files, watch_delay=0.3):
    watch_dir = { filename:file_modif_time(filename) for filename in files }
    print("Watching...",end='')
    sys.stdout.flush()
    while(True):
        time.sleep(watch_delay)
        need_update = False
        for filename, old_time in watch_dir.items():
            new_time = file_modif_time(filename)
            if new_time != old_time:
                need_update = True
                watch_dir[filename] = new_time

        if need_update:
            subprocess.call(cmd, shell=True)
            print("refreshed !")
            print("Watching...",end='')
            sys.stdout.flush()


if __name__ == "__main__":
    autorefresh("make", {"boxstyle1.styl", "example1.jade", "boxlib.coffee", "example1.coffee"})

