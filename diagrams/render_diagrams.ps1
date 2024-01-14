# render the diagrams in the diagrams folder using PlantUML

Write-Output "Rendering PlantUML diagrams to ../images/*.png files using a docker container"

docker run --rm -v ${PWD}:/data dstockhammer/plantuml -tpng -o ./images .

# copy the rendered images to the images folder
Copy-Item -Path .\images\*.png -Destination ..\images

# cleanup
Remove-Item -Path .\images\*.png
Remove-Item .\images

