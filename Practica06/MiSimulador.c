#include "CacheSim.h"
#include <stdio.h>

/* Posa aqui les teves estructures de dades globals
 * per mantenir la informacio necesaria de la cache
 * */
 int cache[128];
 int validez[128];
 int acierto = 0;
 int fallo = 0;


/* La rutina init_cache es cridada pel programa principal per
 * inicialitzar la cache.
 * La cache es inicialitzada al començar cada un dels tests.
 * */
void init_cache ()
{
	/* Escriu aqui el teu codi */

	for(int i = 0; i < 128; ++i) validez[i] = 0;
	

}

/* La rutina reference es cridada per cada referencia a simular */ 
void reference (unsigned int address, unsigned int LE)
{
	unsigned int byte;
	unsigned int bloque_m; 
	unsigned int linea_mc;
	unsigned int tag;
	unsigned int miss;
	unsigned int lec_mp;
	unsigned int mida_lec_mp;
	unsigned int esc_mp;
	unsigned int mida_esc_mp;
	unsigned int replacement;
	unsigned int tag_out;

	/* Escriu aqui el teu codi */

	byte = address%32;
	bloque_m = address/32;
	linea_mc = bloque_m%128;
	tag = bloque_m/128;

	replacement = 0;
	lec_mp = (!LE && (cache[linea_mc] != tag || !validez[linea_mc])); //SOLO LEE A MP SI ES MISS Y LECTURA
	mida_lec_mp = 0;
	esc_mp = LE; //ESCRIU A MP SEPRE QUE LLEGUEIX
	mida_esc_mp = LE; //ESCRIU UNA PARAULA QUE ES 1 BYTE
	
	miss = !(validez[linea_mc] == 1 && cache[linea_mc] == tag);

 	if(!validez[linea_mc] && !LE){ //ESCRIU A MP Y NO REEMPLAZA SI ESTA BUIT
 		mida_lec_mp = 32;
 		cache[linea_mc] = tag;
		validez[linea_mc] = 1;
	}
	else if (cache[linea_mc] != tag && !LE){ //MISS Y REMPLAZA SI HAY OTRA ETIQUETA
		tag_out = cache[linea_mc];
 		mida_lec_mp = 32;
 		cache[linea_mc] = tag;
		replacement = 1;
	}
	
	if (miss) ++fallo;
	else ++acierto;
	

	/* La funcio test_and_print escriu el resultat de la teva simulacio
	 * per pantalla (si s'escau) i comproba si hi ha algun error
	 * per la referencia actual
	 * */
	test_and_print (address, LE, byte, bloque_m, linea_mc, tag,
			miss, lec_mp, mida_lec_mp, esc_mp, mida_esc_mp,
			replacement, tag_out);
}

/* La rutina final es cridada al final de la simulacio */ 
void final ()
{
 	/* Escriu aqui el teu codi */ 
 	
 	printf("Hits: %d\nMiss: %d\n",acierto,fallo);
 	
 	
  
  	
}
