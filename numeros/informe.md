## Preguntas teóricas

### Aporte de los mensajes de DD
En un double dispatch (DD), ¿qué información aporta cada uno de los dos llamados?

Aporta la clase de uno de los objetos, donde el segundo receptor sabe como operar con el primero.

### Lógica de instanciado
Con lo que vieron y saben hasta ahora, ¿donde les parece mejor tener la lógica de cómo instanciar un objeto?
Nos parece mejor que cada clase concreta pueda instanciarse sin pasar por una superclase. Aunque para este ejercicio nos vino muy conveniente utilizar `Entero with:` para instanciar `Positivo`s, `Negativo`s, `Zero`s y `One`s.

¿por qué?
Nos parece más legible y más cómodo tener la lógica de instanciamiento directamente en su misma clase. Queda más claro qué clases son instanciables y que clases no.

¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?
Se instanciaría con un valor default desde un 'initialize' genérico y luego se modificarian los campos relevantes a la clase llamada.

### Nombres de las categorías de métodos
Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?

El propósito de los mensajes, digamos, tomando como ejemplo este TP pusimos nombres como "arithmetic operations - private" para los mensajes de implementación de double-dispatch sobre las operaciones aritméticas.
Otro criterio que utilizamos es la visibilidad o exposición de métodos a otros objetos del entorno.

### Subclass Responsibility
Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?

Son necesarios para que la superclase comprenda el comportamiento de sus subclases y sean estas quién definan el 'como'.
Se pone para dar a entender que cada sublcase debe implementar este método.
Por documentación, en otros lenguajes es obligatorio pero en Smalltalk no lo es.

### No rompas
¿Por qué está mal/qué problemas trae romper encapsulamiento?

Acopla el código, genera dependencias a nivel 'como' y no a nivel 'que'.
