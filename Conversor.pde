import controlP5.*;

ControlP5 cp5;
static int colorH,colorS,colorV;
static int colorC,colorM,colorY,colorK;
static int colorR,colorG,colorB;
String textValue = "";

void setup() {
  size(700,400);
  int linha1=50;
  int linha2= linha1+70;
  int linha3=linha2+70;
  PFont font = createFont("arial",20);
  //PImage[] imgs = {loadImage("button_a.png"),loadImage("button_b.png"),loadImage("button_c.png")};
  
  cp5 = new ControlP5(this);
                 
  // TextFields do RGB
  cp5.addTextfield("red").setPosition(20,linha1).setSize(50,50).setFont(createFont("tahoma",25)).setFocus(true).setCaptionLabel("red").setAutoClear(false);
  
  cp5.addTextfield("green").setPosition(100,linha1).setSize(50,50).setFont(createFont("tahoma",25)).setCaptionLabel("green").setAutoClear(false);
   
  cp5.addTextfield("blue").setPosition(180,linha1).setSize(50,50).setFont(createFont("tahoma",25)).setCaptionLabel("blue").setAutoClear(false);
     
  cp5.addButton("converterRGB").setPosition(240,linha1).setSize(180,50).setCaptionLabel("Converter RGB").updateSize(); 
  
  //TextFields do HSL
  cp5.addTextfield("h").setPosition(20,linha2).setSize(50,50).setFont(createFont("tahoma",25)).setCaptionLabel("H....").setAutoClear(false);
  
  cp5.addTextfield("s").setPosition(100,linha2).setSize(50,50).setFont(createFont("tahoma",25)).setCaptionLabel("Saturation").setAutoClear(false);
   
  cp5.addTextfield("v").setPosition(180,linha2).setSize(50,50).setFont(createFont("tahoma",25)).setCaptionLabel("V...").setAutoClear(false);
     
  cp5.addButton("converterHSV").setPosition(240,linha2).setSize(180,50).setCaptionLabel("Converter HSV").updateSize(); 
  
  //TextFields do HSL
  cp5.addTextfield("c").setPosition(20,linha3).setSize(50,50).setFont(createFont("tahoma",25)).setCaptionLabel("Cyan").setAutoClear(false);
  
  cp5.addTextfield("m").setPosition(100,linha3).setSize(50,50).setFont(createFont("tahoma",25)).setCaptionLabel("Magent").setAutoClear(false);
   
  cp5.addTextfield("y").setPosition(180,linha3).setSize(50,50).setFont(createFont("tahoma",25)).setCaptionLabel("Yellow").setAutoClear(false);
  
  cp5.addTextfield("k").setPosition(260,linha3).setSize(50,50).setFont(createFont("tahoma",25)).setCaptionLabel("Black").setAutoClear(false);
  
  cp5.addButton("converterCMYK").setPosition(320,linha3).setSize(100,50).setCaptionLabel("Converter CMYK").updateSize(); 
  
  textFont(font);
}

void draw() {
  background(4);
  //fill(255);
  //text(textValue, 360,180);
}

public void preenchaHSV(){
  cp5.get(Textfield.class,"h").setText(String.valueOf(colorH));
  cp5.get(Textfield.class,"s").setText(String.valueOf(colorS));
  cp5.get(Textfield.class,"v").setText(String.valueOf(colorV));
}

public void preenchaCMYK(){
  cp5.get(Textfield.class,"c").setText(String.valueOf(colorC));
  cp5.get(Textfield.class,"m").setText(String.valueOf(colorM));
  cp5.get(Textfield.class,"y").setText(String.valueOf(colorY));
  cp5.get(Textfield.class,"k").setText(String.valueOf(colorK));
}

public void preenchaRGB(){
  cp5.get(Textfield.class,"red").setText(String.valueOf(colorR));
  cp5.get(Textfield.class,"green").setText(String.valueOf(colorG));
  cp5.get(Textfield.class,"blue").setText(String.valueOf(colorB));
}

public void converterRGB(){
  double red=Double.valueOf(cp5.get(Textfield.class,"red").getText()); 
  double green=Double.valueOf(cp5.get(Textfield.class,"green").getText());
  double blue=Double.valueOf(cp5.get(Textfield.class,"blue").getText());
  
  RGBtoCMYK(red,green,blue);
  RGBtoHSV(red,green,blue);
  preenchaHSV();
  preenchaCMYK();
}

public void converterHSV(){
  double h=Double.valueOf(cp5.get(Textfield.class,"h").getText()); 
  double s=Double.valueOf(cp5.get(Textfield.class,"s").getText());
  double v=Double.valueOf(cp5.get(Textfield.class,"v").getText());
  
  HSVtoRGB(h,s,v);
  RGBtoCMYK(colorR,colorG,colorB);
  preenchaRGB();
  preenchaCMYK();
}

public void converterCMYK(){
  double c=Double.valueOf(cp5.get(Textfield.class,"c").getText()); 
  double m=Double.valueOf(cp5.get(Textfield.class,"m").getText());
  double y=Double.valueOf(cp5.get(Textfield.class,"y").getText());
  double k=Double.valueOf(cp5.get(Textfield.class,"k").getText());
  
  CMYKtoRGB(c,m,y,k);
  RGBtoHSV(colorR,colorG,colorB);
  preenchaRGB();
  preenchaHSV();
}

public static void RGBtoHSV(double r,double g,double b){
    double maxV,minV, h,s,v;
    
    maxV=max(r/255, g/255, b/255);
    minV=min(r/255, g/255, b/255);
    
    double delta=(maxV-minV);
    
    if(maxV!=0)
      s=delta/maxV;
    else
      s=0;
      
    v=maxV;
    
    if(delta==0){
      h=0;
    }else if(maxV==(r/255))
      h=60*(((g/255 - b/255)/delta)%6);
    else if(maxV==(g/255))
      h=60*(((b/255 - r/255)/delta)+2);
    else
        h=60*(((r/255 - g/255)/delta)+4);
    //123 111 235
    colorH=(int)Math.round(h);
    colorS=(int)Math.round(s*100);
    colorV=(int)Math.round(v*100);
}

public static void HSVtoRGB(double h,double s,double v){

    s=s/100;
    v=v/100;
    double c=v*s;
    double x=c*(1-Math.abs((h/60)%2-1));
    double m=v-c;
    double rc,gc,bc;
    if(h<60){
        rc=c; gc=x; bc=0;
    }else if(h<120){
        rc=x; gc=c; bc=0;
    }else if(h<180){
        rc=0; gc=c; bc=x;
    }else if(h<240){
        rc=0; gc=x; bc=c;
    }else if(h<300){
        rc=x; gc=0; bc=c;
    }else{
        rc=c; gc=0; bc=x;
    }
    
    colorR=(int) Math.round((rc+m)*255);
    colorG=(int) Math.round((gc+m)*255);
    colorB=(int) Math.round((bc+m)*255);
}
    
public static void RGBtoCMYK(double r,double g,double b){
    double rc,gc,bc,k,c,m,y;
    
    rc=r/255;        
    gc=g/255;
    bc=b/255;
    k=1-max(rc,gc,bc);
    c = (1 - rc - k) / (1 - k);
    
    m = (1 - gc - k) / (1 - k);
    
    y = (1 - bc - k) / ( 1 - k);
    
    colorC=(int)Math.round(c*100);
    colorM=(int)Math.round(m*100);
    colorY=(int)Math.round(y*100);
    colorK=(int)Math.round(k*100);
}

public static void CMYKtoRGB(double c,double m,double y,double black){
  c=c/100;
  m=m/100;
  y=y/100;
  black=black/100;
  colorR=(int)Math.round(255 * ( 1 - c) * ( 1 - black));
  colorG=(int)Math.round(255 * ( 1 - m) * ( 1 - black));
  colorB=(int)Math.round(255 * ( 1 - y) * ( 1 - black));
}
    
public static double max(double rc,double gc,double bc){
    if(rc>=gc && rc>=bc)
        return rc;
    
    if(gc>rc && gc>bc)
        return gc;
    
    return bc;
}
    
public static double min(double rc,double gc,double bc){
    if(rc>=gc && bc>=gc)
        return gc;
    
    if(gc>rc && bc>rc)
        return rc;
    
    return bc;
}
