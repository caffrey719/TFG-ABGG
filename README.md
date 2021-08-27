# TFG-ABGG
El proyecto se encuentra organizado en los siguientes archivos dependiendo de su propósito:

* **Simula_Vertical.m:** Función destinada a la simulación del modelo analítico bajo la actuación de fuerzas armónicas verticales.
* **Simula_Horizontal.m:** Función destinada a la simulación del modelo analítico bajo la actuación de fuerzas armónicas horizontales.
* **Graficas_TFG.m:** Script responsable de la obtención de los resultados de la simulación del modelo analítico.
* **Plot_StickSlip.m:** Función encargada de graficar una única variable frente al tiempo.
* **Plot_StickSlip_2ejes.m:** Función encargada de graficar dos variables frente al tiempo en una misma figura.
* **crear_frame.m:** Función responsable de la creación de un fotograma a partir de una gráfica.
* **crear_animacion.m:** Función encargada de la creación de la animación de la simulación realizada, a partir de todos los fotogramas obtenidos. 

Si se desea ejecutar el código de simulación y obtener sus resultados, basta con ejecutar el archivo _Graficas_TFG.m_, seleccionando el tipo de actuación de las fuerzas armónicas, dependiendo de si se desea simular el modelo bajo la acción de fuerzas verticales u horizontales. Además, también es posible cambiar los parámetros empleados para la simulación de los _bristle-bots_, localizados en este mismo fichero.
