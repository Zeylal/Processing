
String emplacement = ""; 
boolean TESTMODE = true;

String fichier =  "zine_nom_prenom.png"; 

//Fractal
int N = 100 ; int M = 100 ; float RR = 300 ; 

float X[] = new float[N] ; float Y[] = new float[N] ;
float R ; float A ; int I ; int II ; float Q ; 

void setup() {
  size(1240, 874); 
  init();         
  
  
 
  background(0);
  fill(0,0,0,10) ; 
  stroke(255,0,0) ;
  for ( I = 0 ; I < N ; I++ ){
    X[I] = random(-300,+300) ; Y[I] = random(-300,+300) ;
  }
}



void mydraw() {
  fill(0);
  ellipse(random(width), random(height), 10, 10);
  
  rect(0,0,599,599) ;
  for ( I = 0 ; I < N ; I++ ){
    for ( II = 0 ; II < M ; II++ ){
      R = sqrt(pow(X[I],2)+pow(Y[I],2)) ; 
      A = atan(Y[I]/X[I]) ;
      if ( X[I] < 0 ){ A = A+PI ; }  
      if ( X[I] >= 0 && Y[I] < 0 ){ A = A+(2*PI) ; }
      A = A/2 + Q ; R = R * sqrt(2) ;
      X[I] = R*cos(A) ; Y[I] = R*sin(A) ;
      Y[I] = Y[I]-RR ;
      point(X[I]+450,Y[I]+450) ; 
    }//II
    if( R > 30000 ){ X[I] = random(-300,+300) ; Y[I] = random(-300,+300) ; }
  }//I
  Q = (mouseX-300)/600 ;
  RR = mouseY ;
}







void draw() {
  mydraw();
  marges(); 
  if (frameCount == 250) {
    if (!TESTMODE) {
      saveFrame(emplacement + fichier);
      exit();
    }
    noLoop();
  }
}

void keyPressed() {
  if (key == ' ') redraw();
  if (key == 's') saveFrame();
}



void init() {
  if (args != null) {
    println(args.length);
    for (int i = 0; i < args.length; i++) {
      println(args[i]);
    }
    fichier = args[0];
    emplacement = args[1];
    if (args[2].equals("0")) TESTMODE = false;
    else TESTMODE = true;
    println("fichier : " + fichier);
    println("emplacement : " + emplacement);
    println("testmode : " + TESTMODE);
    println(fichier + " en cours");
  } else {
    println("args == null");
  }
}

void marges() {
  colorMode(RGB);
  fill(255);
  stroke(255);
  rect(0, 0, width, 24);         
  rect(0, height-24, width, 24); 
  rect(0, 0, 24, height);        
  rect(width-24, 0, 24, height); 
}
