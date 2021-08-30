# TestRapi

Las capas de la aplicación (por ejemplo capa de persistencia, vistas, red, negocio, etc) y qué clases pertenecen a cual.

- View: 
    - HomeVC
    - SearchVC
    - TabbarVC
    - MovieDetailVC


- Interactor: 
    - HomeInteractor
    - SearchInteractor
    - MovieDetailInteractor
    
    
- Presenter: 
    - HomePresenter
    - MovieDetailPresenter
    - SearchPresenter


- Entity: 
    - AutorizationEntity
    - MoviesEntity
    - MovieDetailEntity
    
    
- Routing:
    - HomeRouter
    - MovieDetailRouter
    - SearchRouter    


- Red: 
    - ConnectionLayer Pod creado por Miguel Mexicano Herrera https://cocoapods.org/pods/ConnectionLayer
  
  
- Utils: 
    - NutUtils Pod creado por Miguel Mexicano Herrera https://cocoapods.org/pods/NutUtils
    
    
- Componentes Visuales: 
    - NUTComponents Pod creado por Miguel Mexicano Herrera https://cocoapods.org/pods/NUTComponents
    





La responsabilidad de cada clase creada.

    - las clases de view controller se encargan de presentar a el usuario la informacion
    - las clases interactor se encargan de la logica de negocio.
    - la clase conectionLayer se encargan de hacer las peticiones http y https.
    - las clases presenter se encargan de dar formato a la informacion para poder mostrarlas al usuario final.


-En qué consiste el principio de responsabilidad única? Cuál es su propósito?
    - indica que cada clase o modulo deberia de tener una sola responsabilidad, debe de ser responsable de realizar solo las tareas para el cual fue creada.


-Qué características tiene, según su opinión, un “buen” código o código limpio:
    debe ser un codigo entendible, escalable y mantenible
