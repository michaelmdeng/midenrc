import argparse
from glob import glob
import os
import subprocess
import sys

DEFAULT_WIKI_PATH = '~/Dropbox/vimwiki/wiki'
DEFAULT_HTML_PATH = '~/Dropbox/vimwiki/html'

def vw_all_to_html(wiki, html, verbose=False, run_all=False):
    vw_dir = os.path.expanduser(wiki)
    html_dir = os.path.expanduser(html)

    files = glob(vw_dir + "/**/*.md") + glob(vw_dir + "/*.md")
    rel_paths = [f[len(vw_dir) + 1:] for f in files]
    out_files = [f"{html_dir}/{rel_path[:len(rel_path) - 3]}.html" for rel_path in rel_paths]

    out_dirs = {os.path.dirname(out_file) for out_file in out_files}
    dir_cmds = [["mkdir", "-p", out_dir] for out_dir in out_dirs]
    for dir_cmd in dir_cmds:
        if verbose:
            print(f"Running {' '.join(dir_cmd)}")
        subprocess.run(args=dir_cmd, check=True)

    for (f, of) in zip(files, out_files):
        source_mod_time = os.path.getmtime(f)
        dest_mod_time = os.path.getmtime(of) if os.path.exists(of) else None

        if run_all or (not dest_mod_time) or (dest_mod_time and source_mod_time > dest_mod_time):
            cmd = ["pandoc", "-r", "markdown", "-w", "html", f, "-o", of]
            if verbose:
                print(f"Running {' '.join(cmd)}")
            subprocess.run(args=cmd, check=True)
        elif verbose:
            print(f"Did not convert {f} to {of} since it has not changed")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Pandoc convert Vimwiki')
    parser.add_argument('-w',
                        '--wiki',
                        required=False,
                        default=DEFAULT_WIKI_PATH,
                        help='Directory to convert markdown files in')
    parser.add_argument('--html',
                        required=False,
                        default=DEFAULT_HTML_PATH,
                        help='Directory to output converted html files in')
    parser.add_argument('-v',
                        '--verbose',
                        action='store_true',
                        help='Whether to log verbose output')
    parser.add_argument('-a',
                        '--all',
                        action='store_true',
                        default=False,
                        help='Whether to convert all files regardless of changes')
    args = parser.parse_args(sys.argv[1:])

    vw_all_to_html(args.wiki, args.html, verbose=args.verbose, run_all=args.all)
