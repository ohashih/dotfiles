" Select project files
:FzfPreviewProjectFilesRpc
:FzfPreviewProjectFiles
:CocCommand fzf-preview.ProjectFiles

" Select file from git ls-files
:FzfPreviewGitFilesRpc
:FzfPreviewGitFiles
:CocCommand fzf-preview.GitFiles

" Select file from directory files (default to current working directory) (Required [ripgrep](https://github.com/BurntSushi/ripgrep))
:FzfPreviewDirectoryFilesRpc {path or none}
:FzfPreviewDirectoryFiles {path or none}
:CocCommand fzf-preview.DirectoryFiles

" Select file buffers. Used open-buffer processes.
:FzfPreviewBuffersRpc
:FzfPreviewBuffers
:CocCommand fzf-preview.Buffers

" Select all buffers. Used open-bufnr processes
:FzfPreviewAllBuffersRpc
:FzfPreviewAllBuffers
:CocCommand fzf-preview.AllBuffers

" Select project files frm oldfiles
:FzfPreviewProjectOldFilesRpc
:CocCommand fzf-preview.ProjectOldFiles

" Select project mru (Most Recently Used) files
:FzfPreviewProjectMruFilesRpc
:FzfPreviewProjectMruFiles
:CocCommand fzf-preview.ProjectMruFiles

" Select project mrw (Most Recently Written) files
:FzfPreviewProjectMrwFilesRpc
:FzfPreviewProjectMrwFiles
:CocCommand fzf-preview.ProjectMrwFiles

" Grep project files from args word
:FzfPreviewProjectGrepRpc {args}
:FzfPreviewProjectGrep {args}
:CocCommand fzf-preview.ProjectGrep {args}

" Run FzfPreviewProjectGrep with the same arguments as before.
:FzfPreviewProjectGrepRecallRpc
:FzfPreviewProjectGrepRecall
:CocCommand fzf-preview.ProjectGrepRecall

" Select tags from tags file (Required [universal-ctags](https://github.com/universal-ctags/ctags))
:FzfPreviewCtagsRpc
:FzfPreviewCtags
:CocCommand fzf-preview.Ctags

" Select tags from current files (Required [universal-ctags](https://github.com/universal-ctags/ctags))
:FzfPreviewBufferTagsRpc
:FzfPreviewBufferTags
:CocCommand fzf-preview.BufferTags

" Select files from oldfiles
:FzfPreviewOldFilesRpc
:FzfPreviewOldFiles
:CocCommand fzf-preview.OldFiles

" Select mru (Most Recently Used) files
:FzfPreviewMruFilesRpc
:FzfPreviewMruFiles
:CocCommand fzf-preview.MruFiles

" Select mrw (Most Recently Written) files
:FzfPreviewMrwFilesRpc
:FzfPreviewMrwFiles
:CocCommand fzf-preview.MrwFiles

" Select line from QuickFix
:FzfPreviewQuickFixRpc
:FzfPreviewQuickFix
:CocCommand fzf-preview.QuickFix

" Select line from LocationList
:FzfPreviewLocationListRpc
:FzfPreviewLocationList
:CocCommand fzf-preview.LocationList

" Select line from current buffer (Required [bat](https://github.com/sharkdp/bat))
:FzfPreviewLinesRpc
:FzfPreviewLines
:CocCommand fzf-preview.Lines

" Select line from loaded buffer
:FzfPreviewBufferLinesRpc
:FzfPreviewBufferLines
:CocCommand fzf-preview.BufferLines

" Select jumplist item
:FzfPreviewJumpsRpc
:FzfPreviewJumps
:CocCommand fzf-preview.Jumps

" Select changelist item
:FzfPreviewChangesRpc
:FzfPreviewChanges
:CocCommand fzf-preview.Changes

" Select mark
:FzfPreviewMarksRpc
:CocCommand fzf-preview.Marks

" Select files from selected resources (project, git, directory, buffer, project_old, project_mru, project_mrw, old, mru, mrw)
:FzfPreviewFromResourcesRpc
:FzfPreviewFromResources
:CocCommand fzf-preview.FromResources

" Execute and edit command history
:FzfPreviewCommandPaletteRpc
:FzfPreviewCommandPalette
:CocCommand fzf-preview.CommandPalette

# Grep vim help
:FzfPreviewGrepHelpRpc
:FzfPreviewGrepHelp
:CocCommand fzf-preview.GrepHelp

" Interactive git integration. (Required [Fugitive](https://github.com/tpope/vim-fugitive) or [Gina](https://github.com/lambdalisue/gina.vim))
:FzfPreviewGitActionsRpc
:FzfPreviewGitActions
:CocCommand fzf-preview.GitActions

" Select git status listed file. (Required [Fugitive](https://github.com/tpope/vim-fugitive) or [Gina](https://github.com/lambdalisue/gina.vim))
:FzfPreviewGitStatusRpc
:FzfPreviewGitStatus
:CocCommand fzf-preview.GitStatus

" Select references from vim-lsp
:FzfPreviewVimLspReferencesRpc
:FzfPreviewVimLspReferences

" Select diagnostics from vim-lsp
:FzfPreviewVimLspDiagnosticsRpc
:FzfPreviewVimLspDiagnostics

" Select current file diagnostics from vim-lsp
:FzfPreviewVimLspCurrentDiagnosticsRpc
:FzfPreviewVimLspCurrentDiagnostics

" Select definitions from vim-lsp
:FzfPreviewVimLspDefinitionRpc
:FzfPreviewVimLspDefinition

" Select type definitions from vim-lsp
:FzfPreviewVimLspTypeDefinitionRpc
:FzfPreviewVimLspTypeDefinition

" Select implementations from vim-lsp
:FzfPreviewVimLspImplementationsRpc
:FzfPreviewVimLspImplementations

" Select tags from vista.vim (Required [vista.vim](https://github.com/liuchengxu/vista.vim))
:FzfPreviewVistaCtagsRpc
:FzfPreviewVistaCtags
:CocCommand fzf-preview.VistaCtags

" Select current buffer tags from vista.vim (Required [vista.vim](https://github.com/liuchengxu/vista.vim))
:FzfPreviewVistaBufferCtagsRpc
:FzfPreviewVistaBufferCtags
:CocCommand fzf-preview.VistaBufferCtags

" Select bookmarks (Required [vim-bookmarks](https://github.com/MattesGroeger/vim-bookmarks))
:FzfPreviewBookmarksRpc
:FzfPreviewBookmarks
:CocCommand fzf-preview.Bookmarks

" Select register history (Required [yankround.vim](https://github.com/LeafCage/yankround.vim))
:FzfPreviewYankroundRpc
:FzfPreviewYankround
:CocCommand fzf-preview.Yankround

" Select memolist (Required [glidenote/memolist.vim](https://github.com/glidenote/memolist.vim))
:FzfPreviewMemoListRpc
:FzfPreviewMemoList
:CocCommand fzf-preview.MemoList

" Grep memolist (Required [glidenote/memolist.vim](https://github.com/glidenote/memolist.vim))
:FzfPreviewMemoListGrepRpc
:FzfPreviewMemoListGrep
:CocCommand fzf-preview.MemoListGrep

" Search TodoComments (Required  [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim))
:FzfPreviewTodoCommentsRpc
:FzfPreviewTodoComments
:CocCommand fzf-preview.TodoComments

" Open the PR corresponding to the selected line (Required [GitHub cli](https://github.com/cli/cli))
:FzfPreviewBlamePRRpc
:FzfPreviewBlamePR
:CocCommand fzf-preview.BlamePR

" Select references from coc.nvim (only coc extensions)
:CocCommand fzf-preview.CocReferences

" Select diagnostics from coc.nvim (only coc extensions)
:CocCommand fzf-preview.CocDiagnostics

" Select current file diagnostics from coc.nvim (only coc extensions)
:CocCommand fzf-preview.CocCurrentDiagnostics

" Select definitions from coc.nvim (only coc extensions)
:CocCommand fzf-preview.CocDefinition

" Select type definitions from coc.nvim (only coc extensions)
:CocCommand fzf-preview.CocTypeDefinition

" Select implementations from coc.nvim (only coc extensions)
:CocCommand fzf-preview.CocImplementations

" Select outline from coc.nvim (only coc extensions)
:CocCommand fzf-preview.CocOutlineo
