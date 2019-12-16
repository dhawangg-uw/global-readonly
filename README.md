Default emacs read-only-mode is only for current buffer,
if switch buffer or open new file, then read-only-mode will be changed.
so, i write some function for keep read-only-mode state.

The mouse key changed text sometimes, so this package will be auto disable
all mouse key. if you don't want disable all mouse key,
set global-readonly-disable-mouse to nil before require.

Usage:

Add to load-path, require global-readonly, then use global-readonly-toggle.


