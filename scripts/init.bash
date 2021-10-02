#!/bin/bash

function enableAutoCommit {
	(
		set -x;
    if [[ $(uname) == "Darwin" ]]; then
      launchctl load ~/Library/LaunchAgents/com.popunbom.dotfiles.git-autocommit.plist; 
      launchctl list | grep "autocommit"
    fi
	)
}

function disableAutoCommit {
	(
		set -x;
    if [[ $(uname) == "Darwin" ]] ; then
      launchctl unload ~/Library/LaunchAgents/com.popunbom.dotfiles.git-autocommit.plist;
      launchctl list | grep "autocommit"
    fi
	)
}
