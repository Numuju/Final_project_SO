# ============================================================
# Proyecto Final - Sistemas Operacionales
# Herramienta de administracion para data center en PowerShell
# Autor: Samuel Navia Quiceno
# ============================================================

function Show-Users {
    Clear-Host

    Write-Host "========================================"
    Write-Host " USUARIOS Y ULTIMO LOGIN DEL SISTEMA"
    Write-Host "========================================"

    # Obtiene los usuarios locales de Windows y muestra su ultimo login.
    Get-LocalUser |
        Select-Object Name, LastLogon |
        Format-Table -AutoSize

    Write-Host ""
    Pause
}

function Show-Disks {
    Clear-Host

    Write-Host "========================================"
    Write-Host " DISCOS / FILESYSTEMS CONECTADOS"
    Write-Host "========================================"

    # Muestra solo unidades del sistema de archivos.
    Get-PSDrive -PSProvider FileSystem |
        Select-Object Name, Root, Used, Free |
        Format-Table -AutoSize

    Write-Host ""
    Pause
}

function Show-LargestFiles {
    Clear-Host

    Write-Host "========================================"
    Write-Host " 10 ARCHIVOS MAS GRANDES"
    Write-Host "========================================"

    $path = Read-Host "Ingrese el disco o ruta a analizar. Ejemplo: C:\Users\User"

    if (Test-Path $path) {
        Write-Host ""
        Write-Host "Buscando archivos. Esto puede tardar..."
        Write-Host ""

        # Busca archivos de forma recursiva, los ordena por tamaño
        # y muestra los 10 más grandes con su ruta completa.
        Get-ChildItem -Path $path -File -Recurse -ErrorAction SilentlyContinue |
            Sort-Object Length -Descending |
            Select-Object FullName, Length -First 10 |
            Format-Table -AutoSize
    }
    else {
        Write-Host ""
        Write-Host "La ruta ingresada no existe."
    }

    Write-Host ""
    Pause
}

function Show-Memory {
    Clear-Host

    Write-Host "========================================"
    Write-Host " MEMORIA LIBRE Y SWAP EN USO"
    Write-Host "========================================"

    # Consulta informacion de memoria fisica del sistema operativo.
    $os = Get-CimInstance Win32_OperatingSystem

    # Los valores vienen en KB, por eso se convierten a bytes.
    $freeMemoryBytes = $os.FreePhysicalMemory * 1024
    $totalMemoryBytes = $os.TotalVisibleMemorySize * 1024
    $usedMemoryBytes = $totalMemoryBytes - $freeMemoryBytes
    $freeMemoryPercent = ($freeMemoryBytes / $totalMemoryBytes) * 100

    # En Windows, el equivalente al swap de Linux es el pagefile.
    $pageFile = Get-CimInstance Win32_PageFileUsage

    # Los valores del pagefile vienen en MB, por eso se convierten a bytes.
    $swapUsedBytes = $pageFile.CurrentUsage * 1024 * 1024
    $swapTotalBytes = $pageFile.AllocatedBaseSize * 1024 * 1024

    if ($swapTotalBytes -gt 0) {
        $swapUsedPercent = ($swapUsedBytes / $swapTotalBytes) * 100
    }
    else {
        $swapUsedPercent = 0
    }

    Write-Host ""
    Write-Host "Memoria libre en bytes: $freeMemoryBytes"
    Write-Host "Memoria total en bytes: $totalMemoryBytes"
    Write-Host "Memoria usada en bytes: $usedMemoryBytes"
    Write-Host ("Porcentaje de memoria libre: {0:N2}%" -f $freeMemoryPercent)

    Write-Host ""
    Write-Host "Swap/Pagefile usado en bytes: $swapUsedBytes"
    Write-Host "Swap/Pagefile total en bytes: $swapTotalBytes"
    Write-Host ("Porcentaje de swap usado: {0:N2}%" -f $swapUsedPercent)

    Write-Host ""
    Pause
}

function DoneBackUp {
    Clear-Host

    Write-Host "========================================"
    Write-Host " BACKUP DE DIRECTORIO A USB"
    Write-Host "========================================"

    $sourcePath = Read-Host "Ingrese la ruta de la carpeta a respaldar"
    $usbPath = Read-Host "Ingrese la ruta de la USB. Ejemplo: D:\"

    if (!(Test-Path $sourcePath)) {
        Write-Host ""
        Write-Host "La carpeta origen no existe."
        Pause
        return
    }

    if (!(Test-Path $usbPath)) {
        Write-Host ""
        Write-Host "La ruta USB no existe."
        Pause
        return
    }

    # Crea una carpeta con fecha y hora para evitar sobrescribir backups.
    $date = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupFolder = "$usbPath\Backup_$date"

    New-Item -ItemType Directory -Path $backupFolder | Out-Null

    Write-Host ""
    Write-Host "Realizando backup..."
    Write-Host ""

    # Copia todo el contenido de la carpeta origen al destino.
    Copy-Item -Path $sourcePath\* -Destination $backupFolder -Recurse -ErrorAction SilentlyContinue

    # Crea el archivo de catalogo dentro del backup.
    $catalogFile = "$backupFolder\catalogo.txt"

    "CATALOGO DE ARCHIVOS" | Out-File $catalogFile
    "=====================" | Out-File $catalogFile -Append
    "" | Out-File $catalogFile -Append

    # Registra nombre completo y fecha de ultima modificacion.
    $files = Get-ChildItem -Path $backupFolder -File -Recurse

    foreach ($file in $files) {
        $line = "Archivo: " + $file.FullName + " | Ultima modificacion: " + $file.LastWriteTime
        $line | Out-File $catalogFile -Append
    }

    Write-Host "Backup realizado correctamente."
    Write-Host "Catalogo generado en:"
    Write-Host $catalogFile

    Write-Host ""
    Pause
}

# ============================================================
# MENU PRINCIPAL
# ============================================================

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
        "1" { Show-Users }
        "2" { Show-Disks }
        "3" { Show-LargestFiles }
        "4" { Show-Memory }
        "5" { DoneBackUp }
        "0" { Write-Host "Saliendo del programa..." }
        default {
            Write-Host "Opcion invalida. Intente nuevamente."
            Pause
        }
    }

} while ($option -ne "0")