class Shape {
    int type;
    private Line line;
    private Circle circle;
    private Rect rect;
    public Shape (Line line){
        this.line = line;
    }
    public Shape (Circle cirlce){
        this.circle = circle
    }
    public Shape (Rect rect){
        this.rect = rect;
    }

    public double area(){
        if(line != null)
            return line.area();
        if ...
    }
}

class Line {
    private int x0, y0;
    private int x1, y1;
    double area() {
        return 0;
    }
}

class Circle {
    private int x, y;
    private double radius;
    double area() {
        return 3.14159 * radius * radius;
    }
}

class Rect{
    private int x0, y0;
    private  int x1, y1;
    double area() {
        return Math.abs((x0 - x1) * (y0 - y1));
    }
}

class Canvas {
    private java.util.Vector<Shape> shapes;
    double area() {
        double sum = 0;
        for(Shape s : shapes)
            sum += s.area();
        return sum;
    }
}