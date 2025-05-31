#!/bin/bash

# Verificar suporte a GPU
check_gpu_support() {
    if [ "$USE_GPU" = "true" ]; then
        if command -v nvidia-smi &> /dev/null; then
            echo "GPU NVIDIA detectada"
            export GPU_DRIVER=nvidia
        elif command -v rocm-smi &> /dev/null; then
            echo "GPU AMD detectada"
            export GPU_DRIVER=rocm
        else
            echo "Aviso: GPU não detectada, usando CPU"
            export USE_GPU=false
        fi
    fi
}

# Verificar e configurar GPU
check_gpu_support

# Iniciar o serviço
exec python3 -m uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8080} 