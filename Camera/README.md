Modificaciones de CAMARA.

**- MOVE EYES.**
Ahora tanto mouseX como mouseY controlan la posición de la cámara en el plano horizontal y vertical, permitiendo un movimiento libre en 2 ejes.

**Perspective vs Ortho**
El valor mínimo de "far" se redujo de 120 a 20, para que muestre mas al mover el mouse. Se movió de 10 a 100 unidades, lo que puede causar que objetos cercanos sean recortados.  El límite izquierdo se redujo a la mitad.

**Perspective**
El FOV se redujo de 90° a 60°, lo que produce menos distorsión en los bordes de la imagen y se agregó una tercera caja más pequeña y lejana para mejorar la percepción de profundidad y el efecto de perspectiva.
