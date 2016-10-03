void drawConnectors()
{
  if (!help)  //as long as the help screen isn't being displayed, draw the connectors
  {
    //code for drawing connectors between pucks  
  }
}

void drawPucks()
{
  if (!help) 
  {
    //code for drawing pucks 
  }
}

void help()
{
   image(help_image, (width / 2) - (400 / 2), (height / 2) - (300 / 2));
}

void flash()  //flashes screen when a window (such as help) is to be displayed [CALLED WHEN 'flash' IS TRUE]
{
  if (flashAlpha <= 0) flashAlpha = 255;
  flashAlpha -= 16;
  fill(255, 255, 255, flashAlpha);
  rect(0, 0, width, height);
  if (flashAlpha <= 0) flash = false;
}
