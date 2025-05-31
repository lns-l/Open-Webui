# Verificar se esta rodando no Windows
if (-not [System.Environment]::OSVersion.Platform -eq 'Win32NT') {
    Write-Error "Este script deve ser executado no Windows."
    exit 1
}

# Verificar se o Docker esta instalado
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "Docker nao encontrado. Por favor, instale o Docker Desktop para Windows."
    exit 1
}

# Verificar se o Docker esta rodando
try {
    $dockerInfo = docker info 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Docker nao esta rodando. Por favor, inicie o Docker Desktop."
        exit 1
    }
} catch {
    Write-Error "Erro ao verificar o Docker: $_"
    exit 1
}

# Verificar GPU NVIDIA
if (Get-Command nvidia-smi -ErrorAction SilentlyContinue) {
    Write-Host "GPU NVIDIA detectada"
} else {
    Write-Host "GPU NVIDIA nao detectada"
}

# Verificar GPU AMD
if (Get-Command rocm-smi -ErrorAction SilentlyContinue) {
    Write-Host "GPU AMD detectada"
} else {
    Write-Host "GPU AMD nao detectada"
}

# Funcao para exibir o menu interativo
function Show-Menu {
    Write-Host "`n=== Menu Docker Compose ==="
    Write-Host "1. Iniciar containers"
    Write-Host "2. Parar containers"
    Write-Host "3. Reiniciar containers"
    Write-Host "4. Exibir logs"
    Write-Host "5. Sair"
    $choice = Read-Host "Escolha uma opcao (1-5)"
    return $choice
}

# Funcao para exibir o menu de compose
function Show-ComposeMenu {
    Write-Host "\n=== Escolha o compose para iniciar ==="
    Write-Host "1. Iniciar apenas ollama"
    Write-Host "2. Iniciar apenas webui"
    Write-Host "3. Iniciar ambos"
    $choice = Read-Host "Escolha uma opcao (1-3)"
    return $choice
}

# Funcao para iniciar apenas ollama
function Start-Ollama {
    Write-Host "Iniciando apenas ollama..."
    docker-compose -f docker-compose.ollama.yml up -d
}

# Funcao para iniciar apenas webui
function Start-Webui {
    Write-Host "Iniciando apenas webui..."
    docker-compose -f docker-compose.webui.yml up -d
}

# Funcao para parar containers
function Stop-Containers {
    Write-Host "Parando containers..."
    docker-compose -f docker-compose.webui.yml down
    docker-compose -f docker-compose.ollama.yml down
}

# Funcao para reiniciar containers
function Restart-Containers {
    Stop-Containers
    Start-Containers
}

# Funcao para exibir logs
function Show-Logs {
    Write-Host "Exibindo logs..."
    docker-compose -f docker-compose.ollama.yml logs -f
}

# Atualizar funcao Start-Containers para usar o menu
function Start-Containers {
    $composeOption = Show-ComposeMenu
    switch ($composeOption) {
        "1" { Start-Ollama }
        "2" { Start-Webui }
        "3" { 
            Start-Ollama
            Start-Webui
        }
        default { Write-Host "Opcao invalida. Nao foi iniciado nenhum compose." }
    }
}

# Loop principal do menu
while ($true) {
    $option = Show-Menu
    switch ($option) {
        "1" { Start-Containers }
        "2" { Stop-Containers }
        "3" { Restart-Containers }
        "4" { Show-Logs }
        "5" { exit }
        default { Write-Host "Opcao invalida. Tente novamente." }
    }
} 