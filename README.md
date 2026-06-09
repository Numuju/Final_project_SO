# Proyecto Final - Sistemas Operativos

# Autor

Samuel Navia Quiceno


## Descripción

Este proyecto consiste en el desarrollo de una herramienta administrativa para un data center utilizando PowerShell en Windows.

La aplicación implementa un menú interactivo que permite ejecutar diferentes tareas administrativas relacionadas con usuarios, almacenamiento, memoria y backups del sistema.

El proyecto fue desarrollado como parte del curso de Sistemas Operativos.

---

# Funcionalidades

## 1. Usuarios y último login

Muestra los usuarios locales registrados en el sistema y la fecha/hora de su último inicio de sesión.

Comandos utilizados:

- Get-LocalUser
- Select-Object
- Format-Table

---

## 2. Discos / filesystems conectados

Muestra las unidades conectadas al sistema, incluyendo espacio usado y espacio libre en bytes.

Comandos utilizados:

- Get-PSDrive
- Select-Object
- Format-Table

---

## 3. Diez archivos más grandes

Permite al usuario especificar una ruta y muestra los 10 archivos más grandes encontrados de forma recursiva.

Comandos utilizados:

- Get-ChildItem
- Sort-Object
- Select-Object
- Test-Path

---

## 4. Memoria libre y swap en uso

Muestra información relacionada con memoria física y pagefile (swap equivalente en Windows).

Comandos utilizados:

- Get-CimInstance
- Win32_OperatingSystem
- Win32_PageFileUsage

---

## 5. Backup de directorio a USB

Permite realizar una copia de seguridad de un directorio hacia una memoria USB y genera automáticamente un catálogo TXT con los archivos respaldados y su fecha de modificación.

Comandos utilizados:

- Copy-Item
- Get-Date
- Out-File
- Get-ChildItem

---

# Estructura del proyecto

```text
Proyecto-SO-PowerShell/
│
├── admin_datacenter.ps1
├── README.md
│
├── docs/
│
└── evidencias/
```

---

# Ejecución del proyecto

Abrir PowerShell dentro de la carpeta del proyecto y ejecutar:

```powershell
powershell -ExecutionPolicy Bypass -File .\admin_datacenter.ps1
```

---

# Conceptos utilizados

Durante el desarrollo del proyecto se aplicaron conceptos relacionados con:

- PowerShell
- Administración de sistemas
- Modularización mediante funciones
- Manejo de archivos
- Pipeline (`|`)
- Validación de rutas
- Procesamiento recursivo de directorios
- Automatización de tareas administrativas

---

# Evidencias

## Menú principal

Agregar captura en:

```text
evidencias/menu.png
```

## Opción 1

```text
evidences/evidencia_1.png
```

## Opción 2

```text
evidences/evidencia_2.png
```

## Opción 3

```text
evidences/evidencia_3.png
```

## Opción 4

```text
evidences/evidencia_4.png
```

## Opción 5

```text
evidences/evidencia_5.png
```

## Catálogo generado

```text
evidences/evidencia_6.png
```

## Carpeta de BackUp

```text
evidences/evidencia_7.png
```
---

