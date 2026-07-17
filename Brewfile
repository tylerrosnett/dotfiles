# Brewfile — `brew bundle` installs everything. macOS (Apple Silicon).

# Adopt apps that were installed manually instead of failing
cask_args adopt: true

# --- Shell & core CLI ---
brew "lsd"              # ls replacement (aliased in .aliases)
brew "fzf"              # fuzzy finder
brew "jq"               # JSON processor
brew "yq"               # YAML processor
brew "tree"
brew "wget"
brew "btop"             # resource monitor
brew "watch"
brew "direnv"           # per-directory env vars

# --- Git ---
brew "gh"               # GitHub CLI
brew "git-delta"        # better diffs
brew "lazygit"          # git TUI

# --- Kubernetes ---
brew "kubernetes-cli"   # kubectl
brew "kubectx"          # kubectx + kubens
brew "k9s"
brew "kind"
brew "helm"
brew "kustomize"
brew "krew"             # kubectl plugin manager
brew "kubeconform"      # manifest validation
brew "dive"             # container image inspection
brew "int128/kubelogin/kubelogin"  # kubectl OIDC auth (kubelogin/oidc-login)

# --- GitOps / IaC ---
brew "fluxcd/tap/flux"
brew "argocd"
brew "opentofu"         # tf alias in .aliases

# --- VMware / VCF ---
brew "govc"             # vSphere CLI (govmomi)

# --- Runtimes ---
brew "go"
brew "nvm"              # Node Version Manager; also manages npm versions
brew "uv"               # python package/project manager; also manages python versions
brew "powershell"       # pwsh shell

# --- Networking & media ---
brew "nmap"             # network/port scanner
brew "ffmpeg"           # audio/video transcoding
brew "pandoc"           # document conversion

# --- Apps & fonts ---
cask "ghostty"
cask "visual-studio-code"
cask "firefox"
cask "rectangle"                 # window management
cask "scroll-reverser"           # reverse trackpad vs mouse-wheel scrolling
cask "raycast"                   # launcher / productivity
cask "claude"                    # Claude desktop
cask "obsidian"
cask "bitwarden"                 # password manager
cask "fantastical"               # calendar
cask "obs"                       # screen recording / streaming
cask "zoom"
cask "font-meslo-lg-nerd-font"   # MesloLGS NF — required by powerlevel10k
