
## Redraw
### Original
<img width="646" height="367" alt="image" src="https://github.com/user-attachments/assets/cc873380-cdcc-4034-acd5-4912d5a639a9" />

Cada click se mueve ligeramente hacia arriba.

### Cambio
* Se agregó **x** para controlar la posición horizontal de la nueva
línea vertical.
* boolean auto que es variable bandera que indica si la animación corre
sola (true) o solo avanza con clics (false).
* x = 0 en setup la línea vertical empieza pegada al borde izquierdo.
* Línea vertical nueva → line(x, 0, x, height) dibuja una barra de
arriba a abajo en la posición x.

<img width="637" height="385" alt="image" src="https://github.com/user-attachments/assets/7bd9cf2b-9f84-449c-8f86-e3d13dcf6af5" />

El tema es que se mueve pero pues aja.

## Width and Height
### Original
<img width="666" height="383" alt="image" src="https://github.com/user-attachments/assets/672c3f48-8f33-4202-abe2-3226bcb727a8" />

### Cambio
* Fondo negro.  background(0)
* Naranja en vez de verde las barras horizontales ahora son naranjas.  fill(255, 150, 0)
* Barras mas delgadas ligeramente. rect 5

<img width="655" height="394" alt="image" src="https://github.com/user-attachments/assets/6270e3c4-2c61-4bab-a6da-0a831afd3d80" />

## Recursion
### ORIGINAL:
<img width="629" height="385" alt="image" src="https://github.com/user-attachments/assets/30f40919-3c2b-4de6-903a-7d4abe942c55" />

### Cambio
* Se agregó **y** como parámetro → permite que cada círculo esté a distinta
altura.
* ellipse usa y en vez de height/2 → cada círculo se dibuja en la
posición vertical que le corresponde dentro del árbol.
* La raíz arranca cerca del suelo (height - 40), para dejar espacio hacia arriba.
* x - radius/2	Ramas más juntas
* y - radius*1.5	Árbol más alto y estrecho
* colorMode(HSB); fill(level*40, 255, 255);  Cambio de colores

<img width="647" height="399" alt="image" src="https://github.com/user-attachments/assets/334d64c9-2b13-45f7-a332-873fe30e5a47" />
