public class Estacionamento {
	    Map<String, String> MapCar = new Map<String, String>();
		
        public void AddCar(String placa, String modelo){
            MapCar.put(placa, modelo);
        }
          public String BuscarVrumVrum(String placa){
              if (MapCar.containsKey(placa)){
                  return 'Carro encontrado' + MapCar.get(placa);
              }
              return 'Carro não encontrado';
          }
}