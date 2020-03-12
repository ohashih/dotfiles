POWERLEVEL9K_MODE=nerdfont-complete
[ -f "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"  ] && source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

## Powerlevel9k Settings
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" \U25B8 "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_CONTEXT_TEMPLATE="`hostname -s`"

# Set username to consider a default context, which by default will not be shown.
# https://github.com/bhilburn/powerlevel9k/blob/next/segments/context/README.md

# Set P9KGT background color, either 'light' or 'dark' (this should match the GNOME Terminal's theme).
P9KGT_BACKGROUND='dark'
if [[ $P9KGT_BACKGROUND != 'light' ]] && [[ $P9KGT_BACKGROUND != 'dark' ]]
then
    P9KGT_ERROR=true
    echo "P9KGT error: variable 'P9KGT_BACKGROUND' should be either 'light' or 'dark'"
fi

# Set P9KGT color scheme, either 'light', 'dark' or 'bright' (choose by preference).
P9KGT_COLORS='bright'
if [[ $P9KGT_COLORS != 'light' ]] && [[ $P9KGT_COLORS != 'dark' ]] && [[ $P9KGT_COLORS != 'bright' ]]
then
    P9KGT_ERROR=true
    echo "P9KGT error: variable 'P9KGT_COLORS' should be either 'light', 'dark' or 'bright'"
fi

# Set P9KGT fonts mode, either 'default', 'awesome-fontconfig', 'awesome-mapped-fontconfig', 'awesome-patched', 'nerdfont-complete' or 'nerdfont-fontconfig'.
# https://github.com/bhilburn/powerlevel9k/wiki/About-Fonts
P9KGT_FONTS='awesome-fontconfig'
if [[ $P9KGT_FONTS != 'default' ]] && [[ $P9KGT_FONTS != 'awesome-fontconfig' ]] && [[ $P9KGT_FONTS != 'awesome-mapped-fontconfig' ]] &&
    [[ $P9KGT_FONTS != 'awesome-patched' ]] && [[ $P9KGT_FONTS != 'nerdfont-complete' ]] && [[ $P9KGT_FONTS != 'nerdfont-fontconfig' ]]
then
    P9KGT_ERROR=true
    echo "P9KGT error: variable 'P9KGT_FONTS' should be either 'default', 'awesome-fontconfig', 'awesome-mapped-fontconfig', 'awesome-patched', 'nerdfont-complete' or 'nerdfont-fontconfig'"
else
    POWERLEVEL9K_MODE=$P9KGT_FONTS
fi

if [[ $P9KGT_ERROR != true ]]
then

    # Set P9KGT background color
    if [[ $P9KGT_BACKGROUND == 'light' ]]
    then
        # https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt#light-color-theme
        POWERLEVEL9K_COLOR_SCHEME='light'
        P9KGT_TERMINAL_BACKGROUND=231
    elif [[ $P9KGT_BACKGROUND == 'dark' ]]
    then
        POWERLEVEL9K_COLOR_SCHEME='dark'
        P9KGT_TERMINAL_BACKGROUND=236
    fi

    # Set P9KGT foreground colors
    if [[ $P9KGT_COLORS == 'light' ]]
    then
        P9KGT_RED=009
        P9KGT_GREEN=010
        P9KGT_YELLOW=011
        P9KGT_BLUE=012
    elif [[ $P9KGT_COLORS == 'dark' ]]
    then
        P9KGT_RED=001
        P9KGT_GREEN=002
        P9KGT_YELLOW=003
        P9KGT_BLUE=061
    elif [[ $P9KGT_COLORS == 'bright' ]]
    then
        P9KGT_RED=196
        P9KGT_GREEN=148
        #P9KGT_GREEN=154
        P9KGT_YELLOW=220
        P9KGT_BLUE=075
    fi

    # Customize prompt
    # https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt#adding-newline-before-each-prompt
    POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
    # https://github.com/bhilburn/powerlevel9k/tree/next#customizing-prompt-segments
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir_writable dir vcs)

    # Set 'context' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/context/README.md
    POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND=$P9KGT_YELLOW
    POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=$P9KGT_YELLOW
    POWERLEVEL9K_CONTEXT_SUDO_FOREGROUND=$P9KGT_YELLOW
    POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND=$P9KGT_YELLOW
    POWERLEVEL9K_CONTEXT_REMOTE_SUDO_FOREGROUND=$P9KGT_YELLOW
    POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND=$P9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=$P9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_CONTEXT_SUDO_BACKGROUND=$P9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND=$P9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_CONTEXT_REMOTE_SUDO_BACKGROUND=$P9KGT_TERMINAL_BACKGROUND

    # Set 'dir_writable' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/dir_writable/README.md
    POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND=$P9KGT_YELLOW
    POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND=$P9KGT_RED

    # Set 'dir' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/dir/README.md
    POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=$P9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_DIR_HOME_FOREGROUND=$P9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=$P9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_DIR_ETC_FOREGROUND=$P9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=$P9KGT_BLUE
    POWERLEVEL9K_DIR_HOME_BACKGROUND=$P9KGT_BLUE
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=$P9KGT_BLUE
    POWERLEVEL9K_DIR_ETC_BACKGROUND=$P9KGT_BLUE

    # Set 'vcs' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/vcs/README.md
    POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$P9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$P9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_VCS_CLOBBERED_FOREGROUND=$P9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$P9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_VCS_CLEAN_BACKGROUND=224
    POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=$P9KGT_YELLOW
    POWERLEVEL9K_VCS_CLOBBERED_BACKGROUND=$P9KGT_RED
    POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=224

    # Set 'status' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/status/README.md
    POWERLEVEL9K_STATUS_CROSS=true
    POWERLEVEL9K_STATUS_OK_FOREGROUND=$P9KGT_GREEN
    POWERLEVEL9K_STATUS_ERROR_FOREGROUND=$P9KGT_RED
    POWERLEVEL9K_STATUS_OK_BACKGROUND=$P9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_STATUS_ERROR_BACKGROUND=$P9KGT_TERMINAL_BACKGROUND

    # Set 'root_indicator' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/root_indicator/README.md
    POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND=$P9KGT_YELLOW
    POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND=$P9KGT_TERMINAL_BACKGROUND

    # Set 'background_jobs' segment colors
    # https://github.com/bhilburn/powerlevel9k/blob/next/segments/background_jobs/README.md
    POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=$P9KGT_TERMINAL_BACKGROUND
    POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=$P9KGT_YELLOW

fi
