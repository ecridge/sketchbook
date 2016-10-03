int radius, diameter;

void setup()
{
  size(900, 900);
  background(102);
  noStroke();
  smooth();
  fill(0, 255, 0);
  radius = (width - 100) / 80;
  diameter = 2 * radius;
}

void draw()
{
  background(102);
  for (int x = 0; x < (width - 100); x += diameter )
  {
    for (int y = 0; y < (height - 100); y += diameter)
    {
      int circleSize = (int) (dist(mouseX - 50, mouseY - 50, x + radius, y + radius) - 25) / 25;
      ellipse(x + radius + 50, y + radius + 50, circleSize, circleSize);
    }
  }
}
