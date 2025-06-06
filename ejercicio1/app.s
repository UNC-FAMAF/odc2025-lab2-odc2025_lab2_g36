	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480
	.equ BITS_PER_PIXEL,  	32

	.equ GPIO_BASE,      0x3f200000
	.equ GPIO_GPFSEL0,   0x00
	.equ GPIO_GPLEV0,    0x34

        .include "auxiliares.s"

	.globl main

main:
	// x0 contiene la direccion base del framebuffer
 	mov x20, x0	// Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------
/* ESTO PARA QUE PINTE EL FUCSIA lo saco por el momento.
	movz x10, 0xC7, lsl 16
	movk x10, 0x1585, lsl 00

	mov x2, SCREEN_HEIGH         // Y Size
loop1:
	mov x1, SCREEN_WIDTH         // X Size
loop0:
	stur w10,[x0]  // Colorear el pixel N
	add x0,x0,4	   // Siguiente pixel
	sub x1,x1,1	   // Decrementar contador X
	cbnz x1,loop0  // Si no terminó la fila, salto
	sub x2,x2,1	   // Decrementar contador Y
	cbnz x2,loop1  // Si no es la última fila, salto
*/
	// Ejemplo de uso de gpios
	mov x9, GPIO_BASE

	// Atención: se utilizan registros w porque la documentación de broadcom
	// indica que los registros que estamos leyendo y escribiendo son de 32 bits

	// Setea gpios 0 - 9 como lectura
	str wzr, [x9, GPIO_GPFSEL0]

	// Lee el estado de los GPIO 0 - 31
	ldr w10, [x9, GPIO_GPLEV0]

	// And bit a bit mantiene el resultado del bit 2 en w10
	and w11, w10, 0b10

	// w11 será 1 si había un 1 en la posición 2 de w10, si no será 0
	// efectivamente, su valor representará si GPIO 2 está activo
	lsr w11, w11, 1

//--- DIBUJAMOS LA IMAGEN ---//
bl dibujar_fondo

//---- COPA ---
movz x15, 300, lsl 0          // x inicial
movz x16, 240, lsl 0        // y inicial
bl dibujar_copa

//------- NUBES (nada mas movemos los x e y en donde queremos que esten las nubes)----------
// x15, x16 = x , y

    movz x15, 150, lsl 0
    movz x16, 70, lsl 0
    bl dibujar_nube

    movz x15, 250, lsl 0
    movz x16, 120, lsl 0
    bl dibujar_nube

    movz x15, 400, lsl 0
    movz x16, 70, lsl 0
    bl dibujar_nube

    movz x15, 50, lsl 0
    movz x16, 120, lsl 0
    bl dibujar_nube

    movz x15, 500, lsl 0
    movz x16, 120, lsl 0
    bl dibujar_nube

    movz x15, 145, lsl 0
    movz x16, 213, lsl 0
    bl dibujar_nube

    movz x15, 450, lsl 0
    movz x16, 238, lsl 0
    bl dibujar_nube

	//---------------------------------------------------------------
	// Infinite Loop

InfLoop:
	b InfLoop
