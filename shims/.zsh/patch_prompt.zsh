#!/usr/bin/env zsh


# Fix Prompt (paradox)
function prompt_paradox_start_segment {
  local bg fg
  [[ -n "$1" ]] && bg="%K{$1}" || bg="%k"
  [[ -n "$2" ]] && fg="%F{$2}" || fg="%f"
  if [[ "$_prompt_paradox_current_bg" == 'default' ]]; then
    print -n "%K{$_prompt_paradox_current_bg}%F{$1}"$'%{\e[7m%}'"$_prompt_paradox_segment_separator"$'%{\e[0m%}'"$bg$fg"
  elif [[ "$_prompt_paradox_current_bg" != 'NONE' && "$1" != "$_prompt_paradox_current_bg" ]]; then
    print -n "$bg%F{$_prompt_paradox_current_bg}$_prompt_paradox_segment_separator$fg"
  else
    print -n "$bg$fg"
  fi

  if [[ -n "$3" ]]; then
		if [[ "$_prompt_paradox_current_bg" != 'NONE' ]]; then
			print -n " "
		fi
		print -n "$3 "
	fi

  _prompt_paradox_current_bg="$1"
}
function prompt_paradox_build_prompt {
  # prompt_paradox_start_segment [bg] [fg]
  prompt_paradox_start_segment default default '%(?::%F{red}✘ )%(!:%F{yellow}⚡ :)%(1j:%F{cyan}⚙ :)%F{blue}%n%F{red}@%F{green}%m%f'
  prompt_paradox_start_segment blue 255 '$_prompt_paradox_pwd'

  if [[ -n "$git_info" ]]; then
    prompt_paradox_start_segment green black '${(e)git_info[ref]}${(e)git_info[status]}'
  fi

  if [[ -n "$python_info" ]]; then
    prompt_paradox_start_segment white black '${(e)python_info[virtualenv]}'
  fi

  prompt_paradox_end_segment
}
  PROMPT='
${(e)$(prompt_paradox_build_prompt)}
${editor_info[keymap]} '
