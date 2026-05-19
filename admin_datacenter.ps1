# ============================================================
# Proyecto Final - Sistemas Operacionales
# Herramienta de administración para data center en PowerShell
# Autor: Samuel Navia Quiceno
# ============================================================

# This script displays a simple administration menu.
# Each option will execute a specific system administration task.

do {
    Clear-Host

    Write-Host "========================================"
    Write-Host "   MENU ADMINISTRADOR DATA CENTER"
    Write-Host "========================================"
    Write-Host "1. Mostrar usuarios y ultimo login"
    Write-Host "2. Mostrar discos conectados"
    Write-Host "3. Mostrar los 10 archivos mas grandes"
    Write-Host "4. Mostrar memoria libre y swap en uso"
    Write-Host "5. Hacer backup de un directorio a USB"
    Write-Host "0. Salir"
    Write-Host "========================================"

    $option = Read-Host "Seleccione una opcion"

    switch ($option) {
        "1" {
            Write-Host "Opcion 1 seleccionada"
            Pause
        }

        "2" {
            Write-Host "Opcion 2 seleccionada"
            Pause
        }

        "3" {
            Write-Host "Opcion 3 seleccionada"
            Pause
        }

        "4" {
            Write-Host "Opcion 4 seleccionada"
            Pause
        }

        "5" {
            Write-Host "Opcion 5 seleccionada"
            Pause
        }

        "0" {
            Write-Host "Saliendo del programa..."
        }

        default {
            Write-Host "Opcion invalida. Intente nuevamente."
            Pause
        }
    }

} while ($option -ne "0")