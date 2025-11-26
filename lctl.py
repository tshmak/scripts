#!/usr/bin/env python3
"""
A Wrapper to perform git-like tasks with lakectl <https://docs.lakefs.io/latest/reference/cli/>
"""

import os
import sys
import argparse
import tempfile
import subprocess
from typing import List

def run_cmd(cmd, error_message=None, capture_output=False): 
    if isinstance(cmd, List): 
        cmd = ' '.join(cmd)
    try:
        # Try to get difftool
        result = subprocess.run(
            cmd,
            capture_output=capture_output,
            text=True,
            check=True,
            shell=True
        )
        return result
    except:
        if error_message is not None:
            raise Exception(error_message)
        else:
            raise Exception(f'Command error: {cmd}')

def get_difftool(args): 
    if args.difftool is None:
        result = run_cmd(
                ["git", "config", "--get", "diff.tool"], 
                error_message="Cannot find difftool from git. Please supply --difftool",
                capture_output=True
                )
        if result is not None: 
            result = result.stdout.strip()
        return result
    else:
        return args.difftool

def find_file_upwards(target_filename):
    """
    Recursively search upwards from start_path for target_filename.
    Returns the absolute path if found, else None.
    """
    current_dir = os.path.abspath(os.getcwd())

    while True:
        candidate = os.path.join(current_dir, target_filename)
        if os.path.isfile(candidate):
            return candidate

        # Move one level up
        parent_dir = os.path.dirname(current_dir)
        if parent_dir == current_dir:  # reached root
            break
        current_dir = parent_dir

    return None

def read_lakefs_ref_yaml(lakefs_ref_yaml=None): 
    yaml = find_lakefs_ref_yaml(lakefs_ref_yaml)
    root = os.path.dirname(os.path.realpath(yaml))
    with open(yaml) as f:
        data = f.read().strip().split('\n')
    uri = [x for x in data if x.startswith('src:')][0]
    uri = ':'.join(uri.rstrip('/').split(':')[1:]).strip()
    head = [x for x in data if x.startswith('at_head:')][0]
    head = ':'.join(head.split(':')[1:]).strip()

    return uri, head, root

def find_lakefs_ref_yaml(lakefs_ref_yaml=None): 
    if lakefs_ref_yaml is None: 
        target = find_file_upwards('.lakefs_ref.yaml')
        if target is None: 
            raise Exception("Can't find .lakefs_ref.yaml")
    else: 
        target = lakefs_ref_yaml
    assert os.path.isfile(target)
    return target

def lctl_status(args, remainder):
    # Find URI
    uri, head, root = read_lakefs_ref_yaml(args.lakefs_ref_yaml)
    assert len(args.commits) == 0
    if args.depth == 0: 
        cmd = 'lakectl local status'
    elif args.depth == 1: 
        cmd = f"lakectl local status | grep local | cut -d'/' -f1 | uniq"
    elif args.depth > 1: 
        cmd = f"lakectl local status | grep local | cut -d'/' -f1-{args.depth} | uniq"
    else:
        raise Exception
    
    # Restrict to subdirectories
    if remainder:
        breakpoint() # Check the following ok
        assert len(remainder) == 1
        path = remainder[0]
        relpath = os.path.relpath(path, root)
        assert not relpath.startswith('..') # path must be a subdirectory of root
        cmd = cmd + f' | grep {relpath}'

    run_cmd(cmd)
    return

def lctl_commit(args, remainder):
    # Find URI
    uri, head, root = read_lakefs_ref_yaml(args.lakefs_ref_yaml)
    assert len(args.commits) == 0
    cmd = f'lakectl local commit -m {args.message}'
    run_cmd(cmd)
    return

def lctl_log(args, remainder): 
    # Find URI
    uri, head, root = read_lakefs_ref_yaml(args.lakefs_ref_yaml)

    # -n
    if args.n:
        n = f'--amount {args.n}'
    else:
        n = ''

    # --dot
    if args.dot:
        dot = '--dot'
    else:
        dot = ''

    # Restrict to paths
    if remainder: 
        prefixes = ','.join(remainder)
        prefixes = f'--prefixes {prefixes}'
    else:
        prefixes = ''

    # --branch
    if args.branch is not None: 
        uri0 = '/'.join(uri.rstrip('/').split('/')[:-1]) # Exclude branch
        uri = f'{uri0}/{args.branch}'

    # run_cmd
    cmd = f'lakectl log {dot} {n} {prefixes} {uri} | less'
    run_cmd(cmd)
    return

def lctl_difftool(args, remainder):
    # Find URI
    uri, head, root = read_lakefs_ref_yaml(args.lakefs_ref_yaml)
    if len(args.commits) == 2: 
        com1 = args.commits[0]
        com2 = args.commits[1]
    elif len(args.commits) == 1: 
        com1 = args.commits[0]
        com2 = None
    elif len(args.commits) == 0: 
        com1 = head
        com2 = None
    else:
        raise Exception('Must specify 1 or 2 commits as positional arguments')

    # Diff one file only
    assert len(remainder) == 1
    path = remainder[0]
    assert os.path.isfile(path) # Only file allowed. No folders
    tfile1 = os.path.join(tempfile.gettempdir(), f'{args.tempfilename}.1')
    tfile2 = os.path.join(tempfile.gettempdir(), f'{args.tempfilename}.2')

    # Get relpath
    relpath = os.path.relpath(path, root)
    assert not relpath.startswith('..') # path must be a subdirectory of root

    # Get difftool
    difftool = get_difftool(args)

    # Download to tempfile
    uri0 = '/'.join(uri.rstrip('/').split('/')[:-1]) # Exclude branch
    if os.path.isfile(tfile1):
        os.remove(tfile1)
    run_cmd(f'lakectl fs download {uri0}/{com1}/{relpath} {tfile1}')
    if com2 is not None:
        if os.path.isfile(tfile2):
            os.remove(tfile2)
        run_cmd(f'lakectl fs download {uri0}/{com2}/{relpath} {tfile2}')
        difffile = tfile2
    else:
        difffile = path
    
    # Run diff
    run_cmd(f'{difftool} {tfile1} {difffile}') 
    return


def main():
    p = argparse.ArgumentParser(
        description="A Wrapper to perform git-like tasks with lakectl <https://docs.lakefs.io/latest/reference/cli/>"
    )
    
    # Create subparsers object
    subparsers = p.add_subparsers(
        title="subcommands",
        description="valid subcommands",
        help="additional help",
        dest="command"   # store the subcommand name in args.command
    )

    # Define a parent parser with shared arguments
    parent_parser = argparse.ArgumentParser(add_help=False)
    parent_parser.add_argument("commits", nargs='*', help="Enable verbose output")
    parent_parser.add_argument("-f", "--lakefs_ref_yaml", default=None, help="The .lakefs_ref.yaml file")
    
    # Sub-command: status
    p_status = subparsers.add_parser("status", parents=[parent_parser], help="lakectl local status")
    p_status.add_argument("-d", "--depth", help="Depth of the changes to display", type=int, default=0)
    
    # Sub-command: commit
    p_commit = subparsers.add_parser("commit", parents=[parent_parser], help="lakectl local commit")
    p_commit.add_argument("-m", "--message", help="Commit message", required=True)
    
    # Sub-command: log
    p_log = subparsers.add_parser("log", parents=[parent_parser], help="lakectl log")
    p_log.add_argument("--dot", action='store_true')
    p_log.add_argument("-n", type=int, help="number of results to return")
    p_log.add_argument("--branch", default=None)
    
    # Sub-command: difftool
    p_difftool = subparsers.add_parser("difftool", parents=[parent_parser], help="Like git difftool")
    p_difftool.add_argument("--tempfilename", default='lctl.tmp')
    p_difftool.add_argument("--difftool", default=None, help="Specify the difftool. If not get it from git config")
    
    # Manually split by --
    raw_args = sys.argv[1:]
    if '--' in raw_args:
        sep_index = raw_args.index('--')
        before_separator = raw_args[:sep_index]
        remainder = raw_args[sep_index + 1:]
    else:
        before_separator = raw_args
        remainder = []

    args = p.parse_args(before_separator)
    
    # Dispatch based on sub-command
    if args.command == "status":
        lctl_status(args, remainder)
    elif args.command == "commit":
        lctl_commit(args, remainder)
    elif args.command == "difftool":
        lctl_difftool(args, remainder)
    elif args.command == "log":
        lctl_log(args, remainder)
    else:
        p.print_help()

if __name__ == "__main__":
    main()

