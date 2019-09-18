#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from os import path
import sys
import logging
import subprocess
from argparse import ArgumentParser
from textwrap import dedent
from datetime import datetime
from dateutil import parser, tz

LOGGING_LEVEL_MAP = {
    "CRITICAL": logging.CRITICAL,
    "ERROR": logging.ERROR,
    "WARN": logging.WARN,
    "INFO": logging.INFO,
    "DEBUG": logging.DEBUG
}

PROG_NAME = "git_autocommit"
GIT_DIR = path.abspath(
    path.join(path.dirname(__file__), "..")
)
COMMIT_MSG_PREFIX = "Auto-Commit"


arg_parser = ArgumentParser(
    description="Git: Commit and Push automatically"
)

arg_parser.add_argument(
    "--log-level",
    type=str,
    help="Maximum logging level",
    choices=LOGGING_LEVEL_MAP.keys(),
    default="DEBUG"
)
args = arg_parser.parse_args()

logging.basicConfig(
    stream=sys.stdout,
    level=LOGGING_LEVEL_MAP[args.log_level],
    format="[%(asctime)s] -%(name)s-  %(levelname)8s: %(message)s",
    datefmt="%Y/%m/%d %H:%M:%S"
)


def log(level, msg):
    logger = logging.getLogger(PROG_NAME)

    for line in msg.split("\n"):
        logger.log(level, line)


def run(*args, **kwargs):
    kwargs.update(dict(
        cwd=GIT_DIR,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT
    ))
    log(logging.DEBUG, "EXEC COMMAND: " + " ".join([str(arg) for arg in args]))
    res = subprocess.run(*args, **kwargs)
    log(logging.DEBUG, "RETURN CODE : {0}".format(res.returncode))

    if res.returncode != 0:

        raise Exception("Exit ({0})".format(res.returncode))

    return res


def check_timedelta(days=None, hours=None, minutes=5, seconds=None):
    dt_last_commit = parser.parse(
        run("git log -1 --format=%cd".split()).stdout.decode().rstrip("\n")
    )
    dt_now = datetime.now(tz=dt_last_commit.tzinfo)

    log(
        logging.DEBUG,
        "Last Commmit: " + dt_last_commit.strftime(
            "%Y/%m/%d %H:%M:%S"
        ) + "\n" +
        "         Now: " + dt_now.strftime(
            "%Y/%m/%d %H:%M:%S"
        )
    )

    delta = dt_now - dt_last_commit

    log(
        logging.DEBUG,
        "  Time Delta: {d}d{h}h{m}m{s}s".format(
            d=delta.days,
            h=delta.seconds // (60*60),
            m=(delta.seconds % (60*60)) // 60,
            s=delta.seconds % 60
        )
    )

    seconds = (
        seconds if seconds else 0
        + (minutes * 60) if minutes else 0
        + (hours * 60 * 60) if hours else 0
        + (days * 60 * 60 * 24) if days else 0
    )

    if days is None:
        return delta.seconds >= seconds
    else:
        return (delta.seconds >= seconds) and (delta.days >= days)


# if check_timedelta():
if True:
    res = run("git diff --name-only".split())

    changed = [file for file in res.stdout.decode().rstrip(
        "\n").split("\n") if file]

    if not changed:
        log(logging.INFO, "Nothing to commit. -- skipped")
    else:
        res = run("git add --update".split())
        res = run(["git", "commit", "-m",
                   "{commit_msg} ({date_time})".format(
                       commit_msg=COMMIT_MSG_PREFIX,
                       date_time=datetime.now().strftime("%Y/%m/%d %H:%M:%S")
                   )
                   ])
        if res.returncode == 0:
            log(logging.INFO, "Successed to commit")

            res = run("git log -1 --stat".split())
            commit_log = "###### COMMIT LOG <-- ######\n"
            commit_log += res.stdout.decode()
            commit_log += "###### --> COMMIT LOG ######"
            log(logging.INFO, commit_log)

        res = run("git push".split())
        if res.returncode == 0:
            log(logging.INFO, "Successed to push")
else:
    log(logging.INFO, "Time distance is short. -- skipped")
