package tienda;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public final class AccesoBD {
	private static AccesoBD instanciaUnica = null;
	private Connection conexionBD = null;

	public static AccesoBD getInstance(){
		if (instanciaUnica == null){
			instanciaUnica = new AccesoBD();
		}
		return instanciaUnica;
	}

	private AccesoBD() {
		abrirConexionBD();
	}

	public void abrirConexionBD() {
		if (conexionBD == null) {
			crearConexion();
		} else {
			try {
				if (conexionBD.isClosed()) {
					crearConexion();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	private void crearConexion() {
		String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
		String DB_URL = "jdbc:mariadb://localhost:3306/daw";
		String USER = "root";
		String PASS = "DawLab";
		try {
			Class.forName(JDBC_DRIVER);
			conexionBD = DriverManager.getConnection(DB_URL, USER, PASS);
		} catch (Exception e) {
			System.err.println("No se ha podido conectar a la base de datos");
			System.err.println(e.getMessage());
			e.printStackTrace();
		}
	}
	public boolean comprobarAcceso() {
		abrirConexionBD();
		return (conexionBD != null);
	}

    public List<ProductoBD> obtenerProductosBD(int categoria) {
		abrirConexionBD();
		List<ProductoBD> productos = new ArrayList<>();
	
		try {
			String query = "SELECT codigo, nombre, precio, existencias, imagen, categoria FROM productos WHERE categoria = ?";
			PreparedStatement s = conexionBD.prepareStatement(query);
			s.setInt(1, categoria);
			ResultSet resultado = s.executeQuery();
			while (resultado.next()) {
				ProductoBD producto = new ProductoBD();
				producto.setCodigo(resultado.getInt("codigo"));
				producto.setNombre(resultado.getString("nombre"));
				producto.setPrecio(resultado.getFloat("precio"));
				producto.setStock(resultado.getInt("existencias"));
				producto.setImagen(resultado.getString("imagen"));
				producto.setCategoria(resultado.getInt("categoria"));
				productos.add(producto);
			}
			System.out.println("Productos obtenidos: " + productos.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return productos;
	}

	public int comprobarUsuarioBD(String usuario, String clave) {
		abrirConexionBD();

		int codigo = -1;
		
		try{
			String con = "SELECT codigo FROM usuarios WHERE usuario=? AND clave=?";
			PreparedStatement s = conexionBD.prepareStatement(con);
			s.setString(1,usuario);
			s.setString(2,clave);

			ResultSet resultado = s.executeQuery();

			// El usuario/clave se encuentra en la BD

			if ( resultado.next() ) {
				codigo =  resultado.getInt("codigo");
			}
		}
		catch(Exception e) {

			// Error en la conexión con la BD
			System.err.println("Error verificando usuario/clave");
			System.err.println(e.getMessage());
			e.printStackTrace();
		}

		return codigo;
	}

	public Connection getConexion() {
		abrirConexionBD();
		return conexionBD;
	}

public UsuarioBD obtenerUsuario(int codigo) {
    abrirConexionBD();
    UsuarioBD usuario = null;
    String sql = "SELECT * FROM usuarios WHERE codigo = ?";

    try (PreparedStatement stmt = conexionBD.prepareStatement(sql)) {
        stmt.setInt(1, codigo);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            usuario = new UsuarioBD();
            usuario.setId(rs.getInt("codigo"));
            usuario.setUsuario(rs.getString("usuario"));
            usuario.setPassword(rs.getString("clave"));
            usuario.setActivo(rs.getInt("activo"));
            usuario.setAdmin(rs.getInt("admin"));
            usuario.setNombre(rs.getString("nombre"));
            usuario.setApellidos(rs.getString("apellidos"));
            usuario.setDireccion(rs.getString("domicilio"));
            usuario.setCiudad(rs.getString("poblacion"));
			usuario.setProvincia(rs.getString("provincia"));
            usuario.setCp(rs.getString("cp"));
            usuario.setTelefono(rs.getString("telefono"));
            usuario.setDni(rs.getString("dni"));
            usuario.setEmail(rs.getString("correo_electronico"));
        }
    } catch (Exception e) {
        System.err.println("Error al obtener usuario por código");
        e.printStackTrace();
    }

    return usuario;
}


public boolean actualizarContrasena(int codigoUsuario, String nuevaContrasena) {
    String sql = "UPDATE usuarios SET clave = ? WHERE codigo = ?";

    try (Connection conn = getConexion();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, nuevaContrasena);
        ps.setInt(2, codigoUsuario);

        int filasAfectadas = ps.executeUpdate();
        return filasAfectadas > 0;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

public boolean actualizarPerfil(int codigo, String nombre, String apellidos, String dni, String email,
                                String domicilio, String poblacion, String provincia, String cp, String telefono) {
    Connection con = null;
    PreparedStatement ps = null;
    try {
        con = getConexion();
        String sql = "UPDATE usuarios SET nombre=?, apellidos=?, domicilio=?, poblacion=?, provincia=?, cp=?, telefono=?, dni=?, correo_electronico=? WHERE codigo=?";
        ps = con.prepareStatement(sql);
        ps.setString(1, nombre);
        ps.setString(2, apellidos);
        ps.setString(3, domicilio);
        ps.setString(4, poblacion);
        ps.setString(5, provincia);
        ps.setString(6, cp);
        ps.setString(7, telefono);
		ps.setString(8, dni);
        ps.setString(9, email);
		ps.setInt(10, codigo);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

public int obtenerExistencias(int codigo) {
        int existencias = 0;
        String sql = "SELECT existencias FROM productos WHERE codigo = ?";
		Connection conexion = getConexion();
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, codigo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    existencias = rs.getInt("existencias");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return existencias;
    }

	public List<PedidoBD> obtenerPedidosBD(int codigoUsuario) {
			abrirConexionBD();
			List<PedidoBD> pedidos = new ArrayList<>();
		
			try {
				Connection conn = getConexion();
				String query = "SELECT codigo, persona, fecha, importe, estado FROM pedidos WHERE persona = ?";
				PreparedStatement s = conn.prepareStatement(query);
				s.setInt(1, codigoUsuario);
				ResultSet resultado = s.executeQuery();
				while (resultado.next()) {
					PedidoBD pedido = new PedidoBD();
					pedido.setCodigo(resultado.getInt("codigo"));
					pedido.setPersona(resultado.getInt("persona"));
					pedido.setFecha(resultado.getDate("fecha"));
					pedido.setImporte(resultado.getBigDecimal("importe"));
					pedido.setEstado(resultado.getInt("estado"));
					pedidos.add(pedido);
				}
				System.out.println("Pedidos obtenidos: " + pedidos.size());
			} catch (Exception e) {
				e.printStackTrace();
			}
			return pedidos;
		}

		public void cancelarPedido(int codigoPedido, int nuevoEstado) {
		try (Connection con = getConexion();
			PreparedStatement ps = con.prepareStatement(
				"UPDATE pedidos SET estado = ? WHERE codigo = ?")) {
			ps.setInt(1, nuevoEstado);
			ps.setInt(2, codigoPedido);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<Producto> obtenerProductosPorPedido(int codigoPedido) {
		List<Producto> productos = new ArrayList<>();
		String sql = "SELECT p.codigo, p.nombre, p.precio, p.imagen, d.unidades " +
					 "FROM productos p JOIN detalle d ON p.codigo = d.codigo_producto " +
					 "JOIN pedidos ped ON ped.codigo = d.codigo_pedido WHERE ped.codigo = ?";

		try (Connection con = getConexion();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, codigoPedido);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Producto producto = new Producto();
				producto.setCodigo(rs.getInt("codigo"));
				producto.setDescripcion(rs.getString("nombre"));
				producto.setPrecio(rs.getFloat("precio"));
				producto.setImagen(rs.getString("imagen"));
				producto.setCantidad(rs.getInt("unidades"));
				productos.add(producto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return productos;
	}
}
