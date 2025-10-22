package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import jakarta.json.*;
import java.io.InputStreamReader;
import java.sql.*;

@WebServlet("/ProcesarPedido")
public class ProcesarPedido extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        System.out.println("ProcesarPedido llamado");

        HttpSession sesion = request.getSession(true);

        ArrayList<Producto> carritoJSON = new ArrayList<Producto>();
        AccesoBD con = AccesoBD.getInstance();

        // Limpiar carrito previo si existe
        if (sesion.getAttribute("carritoJSON") != null) {
            sesion.removeAttribute("carritoJSON");
        }

        // Leer JSON desde el cuerpo de la petición
        JsonReader jsonReader = Json.createReader(
                new InputStreamReader(
                        request.getInputStream(), "utf-8")); 

        JsonArray jobj = jsonReader.readArray();

        for (int i = 0; i < jobj.size(); i++) {
            JsonObject prod = jobj.getJsonObject(i);
            Producto nuevo = new Producto();

            // Cambia esto:
            // nuevo.setCodigo(prod.getInt("codigo"));
            // por esto:
            nuevo.setCodigo(Integer.parseInt(prod.getString("codigo")));
            nuevo.setDescripcion(prod.getString("descripcion"));
            nuevo.setImagen(prod.getString("imagen"));
            nuevo.setPrecio(Float.parseFloat(prod.get("precio").toString()));

            String cantidadStr = prod.get("cantidad").toString();
            int cantidad = Integer.parseInt(cantidadStr);
            int existencias = con.obtenerExistencias(nuevo.getCodigo());

            if (cantidad > existencias) {
                cantidad = existencias;
            }

            if (cantidad > 0) {
                nuevo.setCantidad(cantidad);
                carritoJSON.add(nuevo);
            }
        }

        // Guardar carrito actualizado en sesión si hay productos válidos
        if (!carritoJSON.isEmpty()) {
            sesion.setAttribute("carritoJSON", carritoJSON); 
        }


        // Obtener el código del usuario de la sesión
        Integer codigoUsuario = (Integer) sesion.getAttribute("codigo");
        if (codigoUsuario == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Guardar pedido y detalles en la base de datos
        int codigoPedido = -1;
        try (Connection conexion = con.getConexion()) {
            // Insertar pedido
            String sqlPedido = "INSERT INTO pedidos (persona, fecha, importe, estado) VALUES (?, CURRENT_DATE, ?, 1)";
            PreparedStatement psPedido = conexion.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS);
            psPedido.setInt(1, codigoUsuario);
            float importeTotal = 0;
            for (Producto p : carritoJSON) {
                importeTotal += p.getPrecio() ;
            }
            psPedido.setFloat(2, importeTotal);
            psPedido.executeUpdate();

            ResultSet rs = psPedido.getGeneratedKeys();
            if (rs.next()) {
                codigoPedido = rs.getInt(1);
            }

            // Insertar detalles
            String sqlDetalle = "INSERT INTO detalle (codigo_pedido, codigo_producto, unidades, precio_unitario) VALUES (?, ?, ?, ?)";
            PreparedStatement psDetalle = conexion.prepareStatement(sqlDetalle);

            for (Producto p : carritoJSON) {
                psDetalle.setInt(1, codigoPedido);
                psDetalle.setInt(2, p.getCodigo());
                psDetalle.setInt(3, p.getCantidad());
                float precioUnitario = p.getPrecio() / p.getCantidad();
                psDetalle.setFloat(4, precioUnitario);
                psDetalle.addBatch();
            }
            psDetalle.executeBatch();

            // Limpiar el carrito de la sesión
            sesion.removeAttribute("carritoJSON");

            // Pasar el código del pedido al JSP
            request.setAttribute("codigoPedido", codigoPedido);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
            return;
        }

        response.sendRedirect("index.jsp");
    }
}