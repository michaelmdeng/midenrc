import subprocess
import sys

def curr_windows():
    output = subprocess.run(['tmux', 'list-windows', '-F', '\'#W\''],
                            capture_output=True)
    return [line.replace('\'', ' ').strip() for line in output.stdout.decode('utf-8').split('\n') if line]

def curr_windows_main():
    return [window for window in curr_windows() if 'extra' not in window]

def curr_windows_extra():
    return [window for window in curr_windows() if 'extra' in window]

def panes(window):
    output = subprocess.run(['tmux', 'list-panes', '-t', window, '-F', '\'#P\''],
                            capture_output=True)
    return [line.replace('\'', ' ').strip() for line in output.stdout.decode('utf-8').split('\n') if line]

def get_extra_window(window):
    return f'{window}-extra'

def get_main_window(window):
    return window.replace('-extra', '')

def convert_to_windows():
    for window in curr_windows_main():
        extra_panes = panes(window)[1:]

        if not extra_panes:
            continue

        extra_window = get_extra_window(window)
        if extra_window not in curr_windows_extra():
            subprocess.run(['tmux', 'new-window', '-d', '-n', extra_window])

        while extra_panes:
            print(extra_panes)
            extra_pane = extra_panes[0]
            subprocess.run(['tmux', 'move-pane', '-d', '-s', f'{window}.{extra_pane}', '-t', extra_window])
            extra_panes = panes(window)[1:]

        subprocess.run(['tmux', 'kill-pane', '-t', f'{extra_window}.1'])
        subprocess.run(['tmux', 'select-layout', '-t', f'{extra_window}.1', 'even-horizontal'])

def convert_to_panes():
    for window in curr_windows_extra():
        extra_panes = panes(window)

        main_window = get_main_window(window)
        print(main_window)
        while extra_panes:
            extra_pane = extra_panes[0]
            subprocess.run(['tmux', 'move-pane', '-d', '-s', f'{window}.{extra_pane}', '-t', main_window])
            extra_panes = panes(window)

        subprocess.run(['tmux', 'select-layout', '-t', f'{main_window}.1', 'main-vertical'])

action = sys.argv[1]

if action == 'window':
    convert_to_windows()
elif action == 'pane':
    convert_to_panes()
