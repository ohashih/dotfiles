# GitHub CLI + fzf functions

# ghq: List and cd to repository
ghcd() {
  local repo
  repo=$(ghq list | fzf --preview 'bat --color=always --style=header,grid $(ghq root)/{}/README.md 2>/dev/null || ls -la $(ghq root)/{}')
  if [[ -n "$repo" ]]; then
    cd "$(ghq root)/$repo"
  fi
}

# gh repo list: List your repositories and clone selected one
# Usage: ghclone [organization]
ghclone() {
  local org="$1"
  local repo
  if [[ -n "$org" ]]; then
    repo=$(gh repo list "$org" --limit 1000 --json nameWithOwner,description,updatedAt \
      --template '{{range .}}{{.nameWithOwner}}	{{.description}}	{{timeago .updatedAt}}{{"\n"}}{{end}}' \
      | fzf --delimiter='\t' \
            --with-nth=1,2 \
            --preview 'gh repo view {1} --json description,stargazerCount,forkCount,updatedAt --template "⭐ {{.stargazerCount}} | 🍴 {{.forkCount}} | Updated: {{timeago .updatedAt}}\n\n{{.description}}"' \
      | cut -f1)
  else
    repo=$(gh repo list --limit 1000 --json nameWithOwner,description,updatedAt \
      --template '{{range .}}{{.nameWithOwner}}	{{.description}}	{{timeago .updatedAt}}{{"\n"}}{{end}}' \
      | fzf --delimiter='\t' \
            --with-nth=1,2 \
            --preview 'gh repo view {1} --json description,stargazerCount,forkCount,updatedAt --template "⭐ {{.stargazerCount}} | 🍴 {{.forkCount}} | Updated: {{timeago .updatedAt}}\n\n{{.description}}"' \
      | cut -f1)
  fi
  if [[ -n "$repo" ]]; then
    gh repo clone "$repo"
  fi
}

# gh repo list: Browse and open in browser
# Usage: ghopen [organization]
ghopen() {
  local org="$1"
  local repo
  if [[ -n "$org" ]]; then
    repo=$(gh repo list "$org" --limit 1000 --json nameWithOwner,description \
      --template '{{range .}}{{.nameWithOwner}}	{{.description}}{{"\n"}}{{end}}' \
      | fzf --delimiter='\t' \
            --with-nth=1,2 \
            --preview 'gh repo view {1}' \
      | cut -f1)
  else
    repo=$(gh repo list --limit 1000 --json nameWithOwner,description \
      --template '{{range .}}{{.nameWithOwner}}	{{.description}}{{"\n"}}{{end}}' \
      | fzf --delimiter='\t' \
            --with-nth=1,2 \
            --preview 'gh repo view {1}' \
      | cut -f1)
  fi
  if [[ -n "$repo" ]]; then
    gh repo view "$repo" --web
  fi
}

# gh: Search public repos and clone
ghsearch() {
  local query="$1"
  if [[ -z "$query" ]]; then
    echo "Usage: ghsearch <query>"
    return 1
  fi
  local repo
  repo=$(gh search repos "$query" --limit 50 --json fullName,description,stargazersCount \
    --template '{{range .}}{{.fullName}}	⭐{{.stargazersCount}}	{{.description}}{{"\n"}}{{end}}' \
    | fzf --delimiter='\t' \
          --with-nth=1,2,3 \
          --preview 'gh repo view {1}' \
    | cut -f1)
  if [[ -n "$repo" ]]; then
    gh repo clone "$repo"
  fi
}

# gh issue list: Browse issues with fzf
ghissue() {
  local issue
  issue=$(gh issue list --limit 50 --json number,title,state,author \
    --template '{{range .}}#{{.number}}	{{.title}}	{{.state}}	@{{.author.login}}{{"\n"}}{{end}}' \
    | fzf --delimiter='\t' \
          --with-nth=1,2,3,4 \
          --preview 'gh issue view {1} | head -50' \
    | cut -f1 | tr -d '#')
  if [[ -n "$issue" ]]; then
    gh issue view "$issue"
  fi
}

# gh pr list: Browse PRs with fzf
ghpr() {
  local pr
  pr=$(gh pr list --limit 50 --json number,title,state,author,headRefName \
    --template '{{range .}}#{{.number}}	{{.title}}	{{.state}}	{{.headRefName}}	@{{.author.login}}{{"\n"}}{{end}}' \
    | fzf --delimiter='\t' \
          --with-nth=1,2,3,4 \
          --preview 'gh pr view {1} | head -50' \
    | cut -f1 | tr -d '#')
  if [[ -n "$pr" ]]; then
    gh pr view "$pr"
  fi
}

# gh pr checkout: Checkout PR branch
ghprco() {
  local pr
  pr=$(gh pr list --limit 50 --json number,title,headRefName,author \
    --template '{{range .}}#{{.number}}	{{.title}}	{{.headRefName}}	@{{.author.login}}{{"\n"}}{{end}}' \
    | fzf --delimiter='\t' \
          --with-nth=1,2,3,4 \
          --preview 'gh pr view {1} | head -50' \
    | cut -f1 | tr -d '#')
  if [[ -n "$pr" ]]; then
    gh pr checkout "$pr"
  fi
}

# gh gist: Browse and copy gist content
ghgist() {
  local gist
  gist=$(gh gist list --limit 50 \
    | fzf --preview 'gh gist view {1}' \
    | awk '{print $1}')
  if [[ -n "$gist" ]]; then
    gh gist view "$gist" --raw | pbcopy
    echo "Gist content copied to clipboard"
  fi
}

# gh: Create new repo interactively
ghnew() {
  local name="$1"
  if [[ -z "$name" ]]; then
    echo -n "Repository name: "
    read name
  fi
  local visibility
  visibility=$(echo -e "private\npublic" | fzf --prompt="Visibility: ")
  if [[ -n "$name" && -n "$visibility" ]]; then
    gh repo create "$name" "--$visibility" --clone
    cd "$name"
  fi
}

# gh: Browse starred repos
ghstar() {
  local repo
  repo=$(gh api user/starred --paginate --jq '.[].full_name' \
    | fzf --preview 'gh repo view {}')
  if [[ -n "$repo" ]]; then
    echo -n "Clone $repo? [y/N]: "
    read answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
      gh repo clone "$repo"
    else
      gh repo view "$repo" --web
    fi
  fi
}
