import java.util.*;

public class MatrixStack {
    private ArrayList<Matrix> elements = new ArrayList<>();
    
    public Matrix pop() {
        return elements.remove(elements.size() - 1);
    }
    
    public void push(Matrix matrix) {
        elements.add(matrix);
    }
    
    public int size() {
        return elements.size();
    }
}