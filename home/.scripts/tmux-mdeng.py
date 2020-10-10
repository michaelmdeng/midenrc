import subprocess
import sys


def decode_stdout(output):
    output = output.stdout.decode("utf-8").split("\n")
    return [line.replace("'", " ").strip() for line in output if line]


def curr_windows():
    output = subprocess.run(
        ["tmux", "list-windows", "-F", "'#W'"], capture_output=True, check=True
    )
    return decode_stdout(output)


def curr_windows_main():
    return [window for window in curr_windows() if "extra" not in window]


def curr_windows_extra():
    return [window for window in curr_windows() if "extra" in window]


def panes(window):
    output = subprocess.run(
        ["tmux", "list-panes", "-t", window, "-F", "'#P'"],
        capture_output=True,
        check=True,
    )
    return decode_stdout(output)


def get_extra_window(window):
    return f"{window}-extra"


def get_main_window(window):
    return window.replace("-extra", "")


def convert_to_windows():
    for window in curr_windows_main():
        extra_panes = panes(window)[1:]

        if not extra_panes:
            continue

        extra_window = get_extra_window(window)
        if extra_window not in curr_windows_extra():
            subprocess.run(["tmux", "new-window", "-d", "-n", extra_window], check=True)

        while extra_panes:
            extra_pane = extra_panes[0]
            subprocess.run(
                [
                    "tmux",
                    "move-pane",
                    "-d",
                    "-s",
                    f"{window}.{extra_pane}",
                    "-t",
                    extra_window,
                ],
                check=True,
            )
            extra_panes = panes(window)[1:]

        subprocess.run(["tmux", "kill-pane", "-t", f"{extra_window}.1"], check=True)
        subprocess.run(
            ["tmux", "select-layout", "-t", f"{extra_window}.1", "even-horizontal"],
            check=True,
        )


def convert_to_panes():
    for window in curr_windows_extra():
        extra_panes = panes(window)

        main_window = get_main_window(window)
        while extra_panes:
            extra_pane = extra_panes.pop()
            subprocess.run(
                [
                    "tmux",
                    "move-pane",
                    "-d",
                    "-s",
                    f"{window}.{extra_pane}",
                    "-t",
                    main_window,
                ],
                check=True,
            )

            if extra_panes:
                extra_panes = panes(window)

        subprocess.run(
            ["tmux", "select-layout", "-t", f"{main_window}.1", "main-vertical"],
            check=True,
        )


def switch_extra():
    if not curr_windows_extra():
        return

    output = subprocess.run(
        ["tmux", "display-message", "-p", "'#S:#W'"], capture_output=True, check=True
    )
    session, window = decode_stdout(output)[0].split(":")

    if "extra" in window:
        switch_window = window[: len(window) - 6]
    else:
        switch_window = window + "-extra"

    subprocess.run(
        ["tmux", "select-window", "-t", f"{session}:{switch_window}"],
        capture_output=True,
        check=True,
    )


def main(args):
    if len(args) <= 1:
        action = "pane" if curr_windows_extra() else "window"
    else:
        action = args[1]

    if action == "window":
        convert_to_windows()
    elif action == "pane":
        convert_to_panes()
    elif action == "switch":
        switch_extra()


main(sys.argv)
