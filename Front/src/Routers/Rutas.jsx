import { BrowserRouter, Routes,Route } from 'react-router-dom'
import Home from '../Components/Home/PageHome'
import Inventario_Medic from '../Components/Inv_Medicamentos/Inventario_Medic'
import ViewMedicamento from '../Components/Medicamento/ViewMedicamento'
import ViewTicket from '../Components/Ticket_Paciente/ViewTicket'
import Viewpaciente from '../Components/Pacientes/Viewpaciente'
import Sidebar from './Sidebar'

function Rutas() {
  return (
    
    <BrowserRouter>
      <Sidebar />
      <Routes>
      <Route path='/' element={<Home/>} />
      <Route path='/Medicamentos' element={<ViewMedicamento />} />
      <Route path='/InventarioMedicamentos' element={<Inventario_Medic />} />
      <Route path='/Ticket' element={<ViewTicket />} />
      <Route path='/Paciente' element={<Viewpaciente />} />
      {/* cuando la ruta no exite*/}
      {/* <Route path='*' element={<Error404/> } /> */}
      </Routes>
    </BrowserRouter>
    
  )
}

export default Rutas