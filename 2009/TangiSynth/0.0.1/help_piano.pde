void help()
{
  piano = false;
  if (loaded) loaded = false;  //make sure splash screen isn't being displayed
  image(help_image, 150, height - 325);
  //change size by writing to file (read upon startup)
}

void piano()
{
  //draw piano to screen, recieve touch info
}
