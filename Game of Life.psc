Algoritmo gameOfLife // ESTEBAN CAMACHO
	//INITIALIZE VARIABLES
	size <- 0; status <- 'default'; generation <- 0; population <- 0;
	
	Mientras status = 'default'
		Escribir 'Seleccione una opción: ';
		Escribir '[1] Prueba rápida.';
		Escribir '[2] Configurar juego.';
		Leer option;
		Si option == 1 o option == 2
			Si option == 1
				Borrar Pantalla
				Escribir 'Seleccione una opción: ';
				Escribir '[1] Linea intermitente / Blinker';
				Escribir '[2] Sapo / Toad';
				Escribir '[3] Mira / Aim';
				Escribir '[4] Barco / Boat';
				Escribir '[5] Nave Glider / Ship Glider';
				Leer test;
				Si test >= 1 y test <= 5
					status <- 'inGame';
				SiNo
					Borrar Pantalla
					Escribir "Digite una opción valida.";
				FinSi
			FinSi
			Si option == 2
				status <- 'inMenu';
				Borrar Pantalla;
			FinSi
		SiNo
			Borrar Pantalla
			Escribir "Digite una opción valida.";
		FinSi
	FinMientras
	
	Si status == 'inMenu'
		//GET SIZE
		Escribir 'Digite un número para la dimensión de la cuadricula del juego:'
		Leer size;
	
		//WHILE NUMBER IS TO LOW OR TO HIGH
		Mientras size < 3 o size > 50
			Escribir 'Digite un número mayor a 3 y menor o igual a 50:'
			Leer size;
		FinMientras
	SiNo
		size <- 9;
	FinSi
	
	Borrar Pantalla;
	
	//INITIALIZE ARRAYS
	Dimension gridOne[size,size];
	Dimension gridTwo[size,size];
	
	Segun test Hacer
		1: // BLINKER
			gridOne[5,4] <- 1;
			gridOne[5,5] <- 1;
			gridOne[5,6] <- 1;
			population <- 3;
		2:	// TOAD
			gridOne[3,4] <- 1;
			gridOne[3,5] <- 1;
			gridOne[3,6] <- 1;
			gridOne[4,7] <- 1;
			gridOne[5,7] <- 1;
			gridOne[6,7] <- 1;
			gridOne[8,4] <- 1;
			gridOne[8,5] <- 1;
			gridOne[8,6] <- 1;
			gridOne[4,2] <- 1;
			gridOne[5,2] <- 1;
			gridOne[6,2] <- 1;
			population <- 12;
		3:	// AIM
			gridOne[4,4] <- 1;
			gridOne[4,5] <- 1;
			gridOne[4,6] <- 1;
			gridOne[6,4] <- 1;
			gridOne[6,5] <- 1;
			gridOne[6,6] <- 1;
			gridOne[5,4] <- 1;
			gridOne[5,6] <- 1;
			population <- 8;
		4:	// BOAT
			gridOne[4,4] <- 1;
			gridOne[4,5] <- 1;
			gridOne[5,4] <- 1;
			gridOne[6,5] <- 1;
			gridOne[5,6] <- 1;
			population <- 5;
		5:	// SPACESHIP
			gridOne[1,2] <- 1;
			gridOne[2,3] <- 1;
			gridOne[3,3] <- 1;
			gridOne[3,2] <- 1;
			gridOne[3,1] <- 1;
			population <- 5;
	FinSegun
	status <- 'inMenu'
	
	//INFINITE LOOP WHILE IN MENU
	Mientras status == 'inMenu'
		Para i<-1 Hasta size Con Paso 1 Hacer
			Para j<-1 Hasta size Con Paso 1 Hacer
				Si gridOne[i,j] == 1
					Escribir Sin Saltar " ¤";
				SiNo
					Escribir Sin Saltar " ·";
				FinSi
			FinPara
			Escribir "";
		FinPara
		
		Escribir '';
		Escribir 'Seleccione una opción: ';
		Escribir '[1] Configurar';
		Escribir '[2] Iniciar el juego';
		Leer option;
		Si option == 1 o option == 2
			Si option == 1
				Escribir "Fila a pintar/despintar:";
				Leer row;
				Si row > 0 y row <= size
					Escribir "Columna a pintar/despintar:";
					Leer column;
					Si column > 0 y column <= size
						Si gridOne[row,column] <> 1
							gridOne[row,column] <- 1;
							population = population + 1;
						SiNo
							gridOne[row,column] <- 0;
							population = population - 1;
						FinSi
						Borrar Pantalla;
					SiNo
						Borrar Pantalla
						Escribir "Digite una opción valida.";
					FinSi
				SiNo
					Borrar Pantalla
					Escribir "Digite una opción valida.";
				FinSi
			FinSi
			Si option == 2
				status <- 'inGame';
				Borrar Pantalla;
			FinSi
		SiNo
			Borrar Pantalla
			Escribir "Digite una opción valida.";
		FinSi
	FinMientras
	copyGrid(size, gridOne, gridTwo); //PASSING gridOne TO gridTwo.
	//INFINITE LOOP WHILE IN GAME
	Mientras status == 'inGame'
		copyGrid(size, gridTwo, gridOne); //PASSING gridTwo TO gridOne.
		updateGridBasedOnRules(size, population, gridOne, gridTwo); //APPLYING RULES TO THE ARRAY BY CHANGING ITS VALUES.
		Borrar Pantalla
		generation <- generation + 1 //UPDATE GENERATION.
		Escribir 'Generation: ', generation, '    Population: ', population; //DRAWING STATS.
		drawGrid(size, gridOne); //DRAWING GRID.
		Esperar 500 Milisegundos;
	FinMientras
FinAlgoritmo

Funcion drawGrid(size, grid) //JUST DRAW GRID
	Para i<-1 Hasta size Con Paso 1 Hacer
		Para j<-1 Hasta size Con Paso 1 Hacer
			Si grid[i,j] == 1
				Escribir Sin Saltar " ¤";
			SiNo
				Escribir Sin Saltar " ·";
			FinSi
		FinPara
		Escribir "";
	FinPara
FinFuncion

Funcion copyGrid(size, grid Por Referencia, newGrid Por Referencia) //COPY ONE ARRAY INTO ANOTHER BY PASSING SIZE AND TWO ARRAYS AS PARAMETER.
	Para i<-1 Hasta size Con Paso 1 Hacer
		Para j<-1 Hasta size Con Paso 1 Hacer
			newGrid[i,j] <- grid[i,j];
		FinPara
	FinPara
FinFuncion

Funcion updateGridBasedOnRules(size, population Por Referencia, gridOne Por Referencia, gridTwo Por Referencia) //APPLYING RULES #1 AND #2 OF gridOne AND SAVE CHANGES IN gridTwo.
	//FIND NEIGHBORHOODS
	Para i <- 1 Hasta size Con Paso 1 Hacer
		Para j <- 1 Hasta size Con Paso 1 Hacer
			//CORNERS
			Si i = 1 y j = 1  //UPPER LEFT CORNER
				Si gridOne[1,1] = 1 
					Si gridOne[1,2] + gridOne[2,1] + gridOne[2,2] <= 1 
						population = population - 1;
						gridTwo[1,1] <- 0;
					FinSi
				Sino
					Si gridOne[1,2] + gridOne[2,1] + gridOne[2,2] = 3 
						population = population + 1;
						gridTwo[1,1] <- 1;
					FinSi
				FinSi
			FinSi
			Si i = 1 y j = size  //UPPER RIGHT CORNER
				Si gridOne[1,size] = 1 
					Si gridOne[1,size-1] + gridOne[2,size-1] + gridOne[2,size] <= 1 
						population = population - 1;
						gridTwo[1,size] <- 0;
					FinSi
				Sino
					Si gridOne[1,size-1] + gridOne[2,size-1] + gridOne[2,size] = 3
						population = population + 1;
						gridTwo[1,size] <- 1;
					FinSi
				FinSi 
			FinSi
			Si i = size y j = 1  //LOWER LEFT CORNER
				Si gridOne[size,1] = 1 
					Si gridOne[size-1,1] + gridOne[size-1,2] + gridOne[size,2] <= 1 
						population = population - 1;
						gridTwo[size,1] <- 0;
					FinSi
				Sino
					Si gridOne[size-1,1] + gridOne[size-1,2] + gridOne[size,2] = 3 
						population = population + 1;
						gridTwo[size,1] <- 1;
					FinSi
				FinSi
			FinSi
			Si i = size y j = size  //LOWER RIGHT CORNER
				Si gridOne[size,size] = 1 
					Si gridOne[size-1,size] + gridOne[size,size-1] + gridOne[size-1,size-1] <= 1 
						population = population - 1;
						gridTwo[size,size] <- 0;
					FinSi
				Sino
					Si gridOne[size-1,size] + gridOne[size,size-1] + gridOne[size-1,size-1] = 3 
						population = population + 1;
						gridTwo[size,size] <- 1;
					FinSi
				FinSi
			FinSi
			
			//INSIDE WITHOUT BORDERS
			Si i > 1 y j > 1 y i < size y j < size  
				Si gridOne[i,j] = 1 
					Si gridOne[i-1,j-1] + gridOne[i-1,j] + gridOne[i-1,j+1] + gridOne[i,j+1] + gridOne[i+1,j+1] + gridOne[i+1,j] + gridOne[i+1,j-1] + gridOne[i,j-1] <= 1 o gridOne[i-1,j-1] + gridOne[i-1,j] + gridOne[i-1,j+1] + gridOne[i,j+1] + gridOne[i+1,j+1] + gridOne[i+1,j] + gridOne[i+1,j-1] + gridOne[i,j-1] >= 4 
						population = population - 1;
						gridTwo[i,j] <- 0;
					FinSi
				Sino
					Si gridOne[i-1,j-1] + gridOne[i-1,j] + gridOne[i-1,j+1] + gridOne[i,j+1] + gridOne[i+1,j+1] + gridOne[i+1,j] + gridOne[i+1,j-1] + gridOne[i,j-1] = 3 
						population = population + 1;
						gridTwo[i,j] <- 1;
					FinSi
				FinSi
			FinSi
			
			//BORDERS WITHOUT CORDERS
			Si i = 1 y j > 1 y j < size  //UPPER BORDER
				Si gridOne[1,j] = 1 
					Si gridOne[1,j-1] + gridOne[2,j-1] + gridOne[2,j] + gridOne[2,j+1] + gridOne[1,j+1] <= 1 o gridOne[1,j-1] + gridOne[2,j-1] + gridOne[2,j] + gridOne[2,j+1] + gridOne[1,j+1] >= 4 
						population = population - 1;
						gridTwo[1,j] <- 0;
					FinSi
				Sino
					Si gridOne[1,j-1] + gridOne[2,j-1] + gridOne[2,j] + gridOne[2,j+1] + gridOne[1,j+1] = 3 
						population = population + 1;
						gridTwo[1,j] <- 1;
					FinSi
				FinSi
			FinSi
			Si i > 1 y i < size y j = 1  //LOWER BORDER
				Si gridOne[i,1] = 1 
					Si gridOne[i+1,1] + gridOne[i+1,2] + gridOne[i,2] + gridOne[i-1,2] + gridOne[i-1,1] <= 1 o gridOne[i+1,1] + gridOne[i+1,2] + gridOne[i,2] + gridOne[i-1,2] + gridOne[i-1,1] >= 4 
						population = population - 1;
						gridTwo[i,1] <- 0;
					FinSi
				Sino
					Si gridOne[i+1,1] + gridOne[i+1,2] + gridOne[i,2] + gridOne[i-1,2] + gridOne[i-1,1] = 3 
						population = population + 1;
						gridTwo[i,1] <- 1;
					FinSi
				FinSi
			FinSi
			Si i = size y j > 1 y j < size  //LEFT BORDER
				Si gridOne[size,j] = 1 
					Si gridOne[size,j-1] + gridOne[size-1,j-1] + gridOne[size-1,j] + gridOne[size-1,j+1] + gridOne[size,j+1] <= 1 o gridOne[size,j-1] + gridOne[size-1,j-1] + gridOne[size-1,j] + gridOne[size-1,j+1] + gridOne[size,j+1] >= 4 
						population = population - 1;
						gridTwo[size,j] <- 0;
					FinSi
				Sino
					Si gridOne[size,j-1] + gridOne[size-1,j-1] + gridOne[size-1,j] + gridOne[size-1,j+1] + gridOne[size,j+1] = 3 
						population = population + 1;
						gridTwo[size,j] <- 1;
					FinSi
				FinSi
			FinSi
			Si i > 1 y i < size y j = size  //RIGHT BORDER
				Si gridOne[i,size] = 1 
					Si gridOne[i-1,size] + gridOne[i-1,size-1] + gridOne[i,size-1] + gridOne[i+1,size-1] + gridOne[i+1,size] <= 1 o gridOne[i-1,size] + gridOne[i-1,size-1] + gridOne[i,size-1] + gridOne[i+1,size-1] + gridOne[i+1,size] >= 4 
						population = population - 1;
						gridTwo[i,size] <- 0;
					FinSi
				Sino
					Si gridOne[i-1,size] + gridOne[i-1,size-1] + gridOne[i,size-1] + gridOne[i+1,size-1] + gridOne[i+1,size] = 3 
						population = population + 1;
						gridTwo[i,size] <- 1;
					FinSi
				FinSi
			FinSi
		FinPara
	FinPara
FinFuncion
