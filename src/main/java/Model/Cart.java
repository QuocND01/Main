package Model;

public class Cart {

    private String cartID;
    private String customerID;
    private String bookID;
    private int quantity;

    public Cart() {
    }

    public Cart(String cartID, String customerID, String bookID, int quantity) {
        this.cartID = cartID;
        this.customerID = customerID;
        this.bookID = bookID;
        this.quantity = quantity;
    }

    public String getCartID() {
        return cartID;
    }

    public void setCartID(String cartID) {
        this.cartID = cartID;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public String getBookID() {
        return bookID;
    }

    public void setBookID(String bookID) {
        this.bookID = bookID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "Cart{" + "cartID=" + cartID + ", customerID=" + customerID + ", bookID=" + bookID + ", quantity=" + quantity + '}';
    }
}
