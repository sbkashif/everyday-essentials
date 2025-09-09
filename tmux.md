		○ Start a session: `tmux new -s <session_name>` (Observe a green strip at the bottom of the terminal with session name printed over it)
		○ Run the shell script that you would otherwise submit in the scheduling system
		○ Monitor progress: `tmux attach -t <session_name>`
		○ Exit the session (while keeping it running in background): Ctrl+B --> Release the keys --> D. A message regarding detachment will be printed on screen.
		○ Similarly you can create multiple sessions, and see the list of all the sessions from `tmux ls`
Terminate a run in between by killing the session: tmux kill-session -t <session-name><img width="538" height="181" alt="image" src="https://github.com/user-attachments/assets/89785cbc-0d9a-4c8d-9d32-0cd9ad5a0ab3" />
