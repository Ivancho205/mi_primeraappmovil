# mi_primeraappmovil_1

# Propuesta del Proyecto: TruequeU

Mi app se llama TruequeU. Está dirigida a estudiantes de tecnologías e ingenierías de la Institución Universitaria Pascual Bravo, quienes necesitan conseguir una bata de laboratorio limpia y de su talla de forma rápida para una práctica puntual. La app le ayudará a solucionar la falta imprevista de bata mediante un catálogo de préstamos entre compañeros dentro del campus, estados de disponibilidad y solicitudes instantáneas.

### 1. Nombre de la app
**TruequeU** *(Préstamo exprés de batas en la I.U. Pascual Bravo)*

### 2. Usuario
**Estudiantes de carreras tecnológicas e ingenierías** de la Institución Universitaria Pascual Bravo que asisten a clases de laboratorio y olvidaron su bata, no cuentan con una propia o prefieren no usar las batas de la institución por estar desgastadas o en mal estado.

# 3. Problema
Muchos estudiantes se ven en apuros antes de ingresar a sus laboratorios en la I.U. Pascual Bravo porque olvidaron llevar su bata de laboratorio. Las batas disponibles o prestadas en la universidad suelen estar desgastadas, deterioradas o manchadas. Al mismo tiempo, otros estudiantes en el campus llevan su bata limpia en el morral y no la están utilizando en ese horario.

# 4. Solución
**TruequeU** conecta a los estudiantes dentro de la Pascual Bravo para prestar o alquilar batas de laboratorio limpias y en buen estado. Permite solicitar una bata de la talla adecuada en cuestión de minutos y gestionar la entrega y devolución directamente entre compañeros en los bloques del campus.


# 5. Funciones iniciales
1. **Publicar una bata:** El estudiante prestador registra su bata indicando la talla (S, M, L, XL), el estado de la prenda y su ubicación o bloque actual.
2. **Buscar y solicitar préstamo:** El estudiante que necesita la bata explora las opciones disponibles en el campus por talla y realiza la solicitud inmediata.
3. **Confirmar entrega y devolución:** Ambos usuarios confirman cuando la bata se entrega al inicio de la clase y cuando se devuelve al finalizar.


# 6. Recorrido principal
1. **Paso 1 (Inicio):** El estudiante abre la app e ingresa a la pantalla principal.
2. **Paso 2 (Búsqueda):** Revisa las batas de laboratorio disponibles en el campus filtradas por talla y ubicación (ej. *Bloque 4*).
3. **Paso 3 (Solicitud):** Selecciona una bata de su talla y presiona *"Solicitar bata"*.
4. **Paso 4 (Encuentro y Firma):** Se coordina el punto de encuentro en el campus y el estudiante firma en la pantalla para confirmar que recibe la bata limpia.
5. **Paso 5 (Devolución):** Al terminar la práctica de laboratorio, entrega la bata de regreso y ambos marcan el préstamo como *"Finalizado"*.

# 7. Datos
La app necesita almacenar localmente o en base de datos la siguiente información:
* **Usuario:** Nombre, correo institucional, carrera (Tecnología/Ingeniería) y valoración de reputación.
* **Bata:** Talla (S, M, L, XL), estado (Excelente, Bueno), tarifa de préstamo (o si es gratuito), ubicación/bloque y disponibilidad (`disponible`, `prestada`).
* **Préstamo:** ID del prestador, ID del solicitante, hora de inicio, hora de devolución estimada y estado (`pendiente`, `activo`, `finalizado`).

# 8. Canvas / Elemento visual o gesto de dibujo
* **Firma digital de conformidad:** Al momento de recibir la bata, la app desplegará un lienzo táctil desarrollado con el widget **Canvas (`CustomPaint`) de Flutter**. El estudiante realizará su firma a mano alzada con el dedo sobre la pantalla para constatar que recibe la bata limpia y en óptimas condiciones para su laboratorio.
