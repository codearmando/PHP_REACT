import axios from 'axios'
import {AxiosDelete } from '../../Helpers/FetchAxios/FetchAxios.jsx'
import PadStartCiudadano from '../../Helpers/Ciudadano/PadStartCiudadano.jsx'
import Swal from 'sweetalert2'

async function BodyPacienteRetirado (cedula,tableData) {

    let ci
    let venezolano = {
        ci: `${'V' + PadStartCiudadano(cedula)}`
    }
    let extranjero = {
        ci: `${'E' + PadStartCiudadano(cedula)}`
    }
    const urlselect = 'http://localhost/Farmacia_Alto_Costo/App/ciudadanos/ciudadano/buscpaciretirado'
      
    let resp = await axios.post(urlselect,JSON.stringify(venezolano))
    let resp_data = await resp.data

    if (resp_data) {
        ci = resp_data.CEDULA
        console.log('true1')
            
    }else{
        let resp = await axios.post(urlselect,JSON.stringify(extranjero))
        let resp_data = await resp.data
        if(resp_data){
            ci = resp_data.CEDULA
            console.log('true2')
        }
            
    }
    // ----------------------
    // PACIENTE RETIRADO
    // ----------------------
    
    const obj_data ={
        ci : ci,
        cedula : cedula
    }
    const dataname ={
        cedula
    }
    console.log(obj_data)
    const url = 'http://localhost/Farmacia_Alto_Costo/App/Paciente/paciente/InsertPaciRetirado'
    AxiosDelete(url,obj_data,`Nro Cédula: ${dataname.cedula}`,tableData)
    tableData()
    
}

export default BodyPacienteRetirado