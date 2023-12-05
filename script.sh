#!/bin/bash
echo "¡¡¡ ATENCIÓN !!!" 
echo -e "A la hora de poner la ruta de la carpeta, tendrás que especificar siempre la "/" del final.\n \n "

echo Dime el nombre del archivo que contendrá las lineas invertidas por cada alumno
read nombreTabla

echo Dime la carpeta en donde se contienen todos los ficheros de los alumnos
read folder

cantidadAlumnos=$(ls -l $folder | grep -a -v "total" | wc -l)

for ((usuActual=1; usuActual <= $cantidadAlumnos ; usuActual++))
do
        alumnoActual=$(ls -l $folder | grep -a -v "total" | cut -d " " -f10 | head -n $usuActual | tail -n 1)
        nombreAlumno=$(echo $alumnoActual | cut -d "-" -f1)

        lineasAlumnoActual=$(cat $folder$alumnoActual | grep -v "clear" | wc -l)
        lineasManAlumnoActual=$(cat $folder$alumnoActual | grep -a "man *" | wc -l)
        lineasHelpAlumnoActual=$(cat $folder$alumnoActual | grep -a "help" | wc -l)

        if [ "$usuActual" -eq 1 ]; then
                echo "Alumno;LineasInvertidas;LineasUsandoMan;LineasUsandoArgHelp" > $nombreTabla
                echo "$nombreAlumno;$lineasAlumnoActual;$lineasManAlumnoActual;$lineasHelpAlumnoActual" >> $nombreTabla
        else
                echo "$nombreAlumno;$lineasAlumnoActual;$lineasManAlumnoActual;$lineasHelpAlumnoActual" >> $nombreTabla
        fi
done

cat $nombreTabla | sort -n -t";" -k2 > /tmp/$nombreTabla
rm $nombreTabla && mv /tmp/$nombreTabla .
