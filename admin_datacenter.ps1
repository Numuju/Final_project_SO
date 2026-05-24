# ============================================================
# Proyecto Final - Sistemas Operacionales
# Herramienta de administración para data center en PowerShell
# Autor: Samuel Navia Quiceno
# ============================================================

# ------------------------------------------------------------
# Function: Show-Users
# Purpose: Placeholder for option 1.
# ------------------------------------------------------------
# ------------------------------------------------------------
# Function: Show-Users
# Purpose: Displays local users and their last login date.
# ------------------------------------------------------------
# ------------------------------------------------------------
# Function: Show-Users
# Purpose: Displays local users and their last login date.
# ------------------------------------------------------------
function Show-Users {

    Clear-Host

    Write-Host "========================================"
    Write-Host " USUARIOS Y ULTIMO LOGIN DEL SISTEMA"
    Write-Host "========================================"

    # Get local users from Windows
    $users = Get-LocalUser

    # Display only the required columns in table format
    $users | Select-Object Name, LastLogon | Format-Table -AutoSize

    Write-Host ""
    Pause
}

# ------------------------------------------------------------
# Function: Show-Disks
# Purpose: Placeholder for option 2.
# ------------------------------------------------------------
function Show-Disks {

    Clear-Host

    Write-Host "========================================"
    Write-Host " DISCOS / FILESYSTEMS CONECTADOS"
    Write-Host "========================================"

    # Get fixed and removable drives from Windows
    $disks = Get-PSDrive -PSProvider FileSystem

    # Display drive name, root path, used space and free space in bytes
    $disks | Select-Object Name, Root, Used, Free | Format-Table -AutoSize

    Write-Host ""
    Pause
}

# ------------------------------------------------------------
# Function: Show-LargestFiles
# Purpose: Placeholder for option 3.
# ------------------------------------------------------------
function Show-LargestFiles {

    Clear-Host

    Write-Host "========================================"
    Write-Host " 10 ARCHIVOS MAS GRANDES"
    Write-Host "========================================"

    # Ask the user for the drive or folder path to analyze
    $path = Read-Host "Ingrese el disco o ruta a analizar. Ejemplo: C:\Users\User"

    # Validate if the path exists
    if (Test-Path $path) {

        Write-Host ""
        Write-Host "Buscando archivos. Esto puede tardar..."
        Write-Host ""

        # Get all files recursively, sort by size descending,
        # select the first 10, and display full path and size in bytes
        Get-ChildItem -Path $path -File -Recurse -ErrorAction SilentlyContinue |
            Sort-Object Length -Descending |
            Select-Object FullName, Length -First 10 |
            Format-Table -AutoSize

    } else {

        Write-Host ""
        Write-Host "La ruta ingresada no existe."
    }

    Write-Host ""
    Pause
}

# ------------------------------------------------------------
# Function: Show-Memory
# Purpose: Placeholder for option 4.
# ------------------------------------------------------------
function Show-Memory {
    Write-Host "Opcion 4: Mostrar memoria libre y swap en uso"
    Pause
}

# ------------------------------------------------------------
# Function: Make-Backup
# Purpose: Placeholder for option 5.
# ------------------------------------------------------------
function DoneBackUp {
    Write-Host "Opcion 5: Hacer backup de un directorio a USB"
    Pause
}

# ------------------------------------------------------------
# Main menu
# ------------------------------------------------------------
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
            Show-Users
        }

        "2" {
            Show-Disks
        }

        "3" {
            Show-LargestFiles
        }

        "4" {
            Show-Memory
        }

        "5" {
            DoneBackUp
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