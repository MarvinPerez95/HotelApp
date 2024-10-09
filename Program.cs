using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelApp
{
    internal class Program
    {
        public static void Main(string[] args)
        {
            bool op = false;
            do
            {
                Console.WriteLine("Bienvenido a su Hotel/n");
                Console.WriteLine("1. Ver habitaciones disponibles");
                Console.WriteLine("2. Realizar reserva");
                Console.WriteLine("3. Consultar reserva");
                Console.WriteLine("4. Reprogramar reserva");
                Console.WriteLine("5. Cancelar reserva");
                Console.WriteLine("0. Salir");
                
                int option = Convert.ToInt32(Console.ReadLine());
                Console.Clear();

                switch (option)
                {
                    case 0:
                        Console.WriteLine("Gracias por su visita");
                        Console.ReadLine();
                        op = true;
                        break;
                    case 1:
                        Console.WriteLine("Bienvenido a reserva");
                        Program.Reserva();
                        break;
                    case 2:
                        Program.Consulta();
                        break;
                    case 3:
                        Program.Reprogramar();
                        break;
                    case 4:
                        Program.Cancelar();
                        break;
                    case 5:
                        
                        break;
                    default:
                        Console.WriteLine("Opcion no disponible");
                        break;
                }
            } while (op != true);
        }

        public static void Reserva()
        {
            Console.WriteLine("reserva");
        }

        public static void Consulta()
        {
            Console.WriteLine("Consulta");
        }

        public static void Reprogramar()
        {
            Console.WriteLine("Reprogramar");
        }

        public static void Cancelar()
        {
            Console.WriteLine("Cancelar");
        }
    }

    //Conecion a base

}
