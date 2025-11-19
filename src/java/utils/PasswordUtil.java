package utils;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Clase de utilidad para hashear contraseñas usando SHA-256.
 */
public class PasswordUtil {

    /**
     * Hashea una contraseña usando el algoritmo SHA-256.
     * @param password El texto plano de la contraseña.
     * @return El hash de la contraseña como un string hexadecimal.
     */
    public static String hashPassword(String password) {
        try {
            // Obtiene una instancia del algoritmo de hash SHA-256
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            
            // Genera el hash de la contraseña (en bytes)
            byte[] encodedhash = digest.digest(
                    password.getBytes(StandardCharsets.UTF_8));

            // Convierte el arreglo de bytes a un string hexadecimal
            StringBuilder hexString = new StringBuilder(2 * encodedhash.length);
            for (int i = 0; i < encodedhash.length; i++) {
                String hex = Integer.toHexString(0xff & encodedhash[i]);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
            
        } catch (NoSuchAlgorithmException e) {
            // Este error no debería ocurrir si SHA-256 está disponible
            throw new RuntimeException("Error al hashear la contraseña", e);
        }
    }
    
    /**
     * Compara una contraseña en texto plano con un hash almacenado.
     * @param plainPassword La contraseña que ingresó el usuario.
     * @param hashedPassword El hash guardado en la base de datos.
     * @return true si las contraseñas coinciden, false de lo contrario.
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        String hashDelIntento = hashPassword(plainPassword);
        return hashDelIntento.equals(hashedPassword);
    }
}