import re
import subprocess
import sys

BASE_PATTERN_STRING = r'^[a-f0-9]{4},(?P<hsize>\d+)x(?P<vsize>\d+),0,0'
DIMENSIONS_PATTERN_STRING = r'\d+x\d+,\d+,\d+'
LEFT_TOP_BOTTOM_LAYOUT_PATTERN = re.compile(
    f"{BASE_PATTERN_STRING}"
    f"{{{DIMENSIONS_PATTERN_STRING},(?P<leftPaneId>\\d+),{DIMENSIONS_PATTERN_STRING}"
    f"\[{DIMENSIONS_PATTERN_STRING},(?P<topPaneId>\\d+),{DIMENSIONS_PATTERN_STRING},(?P<bottomPaneId>\\d+)]}}$"
)
LEFT_RIGHT_LAYOUT_PATTERN = re.compile(
    BASE_PATTERN_STRING +
    '{' +
        DIMENSIONS_PATTERN_STRING + r',(?P<leftPaneId>\d+),' +
        DIMENSIONS_PATTERN_STRING + r',(?P<rightPaneId>\d+)' +
    '}$'
)

def parse_layout(layout):
    match = LEFT_TOP_BOTTOM_LAYOUT_PATTERN.match(layout)
    if match:
        return (int(match.group('hsize')), int(match.group('vsize')), [
            int(match.group('leftPaneId')),
            int(match.group('topPaneId')),
            int(match.group('bottomPaneId'))
        ])

    match = LEFT_RIGHT_LAYOUT_PATTERN.match(layout)
    if match:
        return (int(match.group('hsize')), int(match.group('vsize')), [
            int(match.group('leftPaneId')),
            int(match.group('rightPaneId')),
            None
        ])

    return None

def layout_checksum(layout):
    csum = 0
    for c in layout:
        csum = (csum >> 1) + ((csum & 1) << 15)
        csum += ord(c)

    return '{:04x}'.format(csum)

def convert_layout(layout):
    (hsize, vsize, panes) = parse_layout(layout)
    left_pane = panes[0]
    top_pane = panes[1]
    bottom_pane = panes[2]

    left_size = round(hsize * .65)
    right_size = hsize - left_size - 1
    if bottom_pane:
        root = f"{hsize}x{vsize},0,0"
        top_size = round(vsize / 2)
        bottom_size = vsize - top_size - 1
        top_bottom_cell = f"[{right_size}x{top_size},{left_size + 1},0,{top_pane},{right_size}x{bottom_size},{left_size + 1},{top_size + 1},{bottom_pane}]"
        left_right_cell = f"{{{left_size}x{vsize},0,0,{left_pane},{right_size}x{vsize},{left_size + 1},0{top_bottom_cell}}}"
        layout = root + left_right_cell

        return layout_checksum(layout) + ',' + layout
    else:
        root = f"{hsize}x{vsize},0,0"
        left_right_cell = f"{{{left_size}x{vsize},0,0,{top_pane},{right_size}x{vsize},{left_size + 1},0,{top_pane}}}"
        layout = root + left_right_cell

        return layout_checksum(layout) + ',' + layout

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

def get_panes(window):
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
        extra_panes = get_panes(window)[1:]

        if not extra_panes:
            continue

        extra_window = get_extra_window(window)
        extra_window_created = False
        if extra_window not in curr_windows_extra():
            subprocess.run(["tmux", "new-window", "-d", "-n", extra_window], check=True)
            extra_window_created = True

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
            extra_panes = get_panes(window)[1:]

        if extra_window_created:
            subprocess.run(["tmux", "kill-pane", "-t", f"{extra_window}.0"], check=True)
        subprocess.run(
            ["tmux", "select-layout", "-t", f"{extra_window}.0", "even-horizontal"],
            check=True,
        )

def convert_to_panes():
    for window in curr_windows_extra():
        extra_panes = get_panes(window)

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
                extra_panes = get_panes(window)

        subprocess.run(
            ["tmux", "select-layout", "-t", f"{main_window}.1", "main-vertical"],
            check=True,
        )

    # set default layout
    curr_win_output = subprocess.run(
        ["tmux", "display-message", "-p", "#W"],
        capture_output=True,
        check=True
    )
    curr_win = decode_stdout(curr_win_output)[0]
    for window in curr_windows_main():
        subprocess.run(
            ["tmux", "select-window", "-t", f"{window}"],
            capture_output=True,
            check=True
        )
        output = subprocess.run(
            ["tmux", "display-message", "-p", "#{window_layout}"],
            capture_output=True,
            check=True,
        )
        layout = decode_stdout(output)[0]
        new_layout = convert_layout(layout)
        # print(f"layout for {window}: {layout} to new layout: {new_layout}")
        # print(' '.join(["tmux", "select-layout", f"{new_layout}"]))
        subprocess.run(
            ["tmux", "select-layout", f"{new_layout}"], capture_output=True, check=True
        )
    subprocess.run(
        ["tmux", "select-window", "-t", f"{curr_win}"],
        capture_output=True,
        check=True
    )



def switch_extra():
    if not curr_windows_extra():
        sys.exit(1)

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


# output = subprocess.run(
#     ["tmux", "display-message", "-p", "#{window_layout}"], capture_output=True, check=True
# )
# layout = decode_stdout(output)[0]
# print(layout)
# new_layout = convert_layout(layout)
# print(new_layout)
# cmd = ["tmux", "select-layout", f"'{new_layout}'"]
# print(' '.join(cmd))
# subprocess.run(
#     ["tmux", "select-layout", f"{new_layout}"], capture_output=True, check=True
# )
main(sys.argv)
