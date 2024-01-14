# PlantUML Diagrams

The diagrams in this folder are `.puml` PlantUML files (https://plantuml.com/)

They use the C4 PlantUML library (https://github.com/plantuml-stdlib/C4-PlantUML)

There are multiple ways to edit, view and render these files.

Using VS Code extensions is easy.

## Rendering to PNG

I use this docker container https://hub.docker.com/r/dstockhammer/plantuml as a commandline tool to render the diagrams to PNG files.

Run this script to render all diagrams to PNG files in the `../images` folder and they will be includable in the markdown files.

```powershell
>render_diagrams.ps1
```

NB: note that the output filenames is taken from the `@startuml` line in the `.puml` file.
