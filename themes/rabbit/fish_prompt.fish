function fish_prompt
  # Cache exit status

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname)
  end
  if not set -q __fish_user
    switch (id -u)
      case 0
	     set -g __fish_user '#'
      case '*'
	     set -g __fish_user '&'
    end
  end
  set -g __fish_prompt_char '~'

  # Setup colors
  set -l normal (set_color normal)
  set -l white (set_color FFFFFF)
  set -l turquoise (set_color 5fdfff)
  set -l orange (set_color df5f00)
  set -l hotpink (set_color df005f)
  set -l blue (set_color 53D1ED)
  set -l green (set_color 228B22)
  set -l greeno (set_color -o 87ff00)
  set -l purple (set_color af5fff)
  set -l red (set_color D70000)
  set -l redo (set_color -o FF0000)
  set -l yellow (set_color E0D757)
  set -l pathc (set_color 5fdfff)
  set -l __fish_git_prompt_my string replace '(' '' (__fish_git_prompt)
 
  # Configure __fish_git_prompt
  set -g __fish_git_prompt_char_stateseparator ''
  set -g __fish_git_prompt_color 0000D6 #5fdfff
  set -g __fish_git_prompt_color_flags df5f00
  set -g __fish_git_prompt_color_prefix white
  set -g __fish_git_prompt_color_suffix white
  set -g __fish_git_prompt_showdirtystate false
  set -g __fish_git_prompt_showuntrackedfiles false
  set -g __fish_git_prompt_showstashstate false
  set -g __fish_git_prompt_show_informative_status false 
 
  # Env
  set -l last_status $status
  set -l __work_dir (string replace $HOME '~' (pwd))
  
  # Last status
  set -l __exit_code -1
  set -l __prompt 'y'
  if test $last_status -eq 0
    set __prompt $greeno$__fish_prompt_char$greeno' ' 
    set __exit_code $white'0'
  else
   set __prompt $white'% '
   set __exit_code $redo$last_status
  end 
  # Time
  set -l __time $white'{'$yellow(date "+%y-%m-%d %H:%M")$white'}'
  set -g __fish_pyenv_branch (pyenv version-name)


  # Line
  echo -sne '('$__fish_pyenv_branch') '$__time \
    ''$green$__fish_prompt_hostname$white \
    ':'$pathc$__work_dir$turquoise \
    (__fish_git_prompt) \
    '\n' $red'avonar'$white \
    $__prompt;

  
end

function pyenv_prompt
  set -g __fish_pyenv_branch (pyenv version-name)
end

