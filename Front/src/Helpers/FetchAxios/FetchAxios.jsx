import axios from "axios";
import Swal from 'sweetalert2'

export const AxiosGet = async (url,setestado) => {
  try {
    const resp = await axios.post(url)
    if (resp.status == 200 && resp.statusText == 'OK') {
      const resp_data = await resp.data
      setestado(resp_data)
      // return resp_data
      
    }else{
      console.log('ERROR DESCONOCIDO, NOTIFICAR A LOS DESARROLLADORES')
    }
    
  } catch (error) {
    console.log('ERROR DE RUTA: ' + error)
  }
}
export const AxiosPost = async (url,obj_data,dataname,tableData) => {
  try {
    const resp = await axios.post(url,JSON.stringify(obj_data))
    if (resp.status == 200 && resp.statusText == 'OK') {
      const resp_data = await resp.data
      console.log('respuesta-data',resp_data)
      if(resp_data == 2){
        
        tableData()
        return (
          Swal.fire(
            'Registrado!',
            `${dataname} Registrado` ,
            'success'
          )
        )
      }else if(resp_data == 1){
        return(
          Swal.fire(
            'Error!',
            `${dataname} ya esta Registrado.`,
            'error'
          )
        )
      }else{
        return(
          Swal.fire(
            'Error!',
            'Ocurrio un error inesperado.',
            'error'
          )
        )
      }

    }else{
      console.log('ERROR DESCONOCIDO, NOTIFICAR A LOS DESARROLLADORES')
    }
    
  } catch (error) {
    console.log('ERROR DE RUTA: ' + error)
  }
}
export const AxiosPut = async (url,obj_data,dataname,datamodif = null,tableData) => {
  try {
    const resp = await axios.post(url,JSON.stringify(obj_data))
    if (resp.status == 200 && resp.statusText == 'OK') {
      const resp_data = await resp.data
      console.log('RESPUESTA:',resp_data)
      if(resp_data == 2){
        
        tableData()
        return (
          Swal.fire(
            'Modificado!',
            `${dataname} ${datamodif}`,
            'success'
          )
        )
      }else if(resp_data == 1){
        return(
          Swal.fire(
            'Error!',
            `${datamodif} ya esta Registrado.`,
            'error'
          )
        )
      }else{
        return(
          Swal.fire(
            'Error inesperado!',
            'Esta intentando Modificar un registro no existente en la data.',
            'error'
          )
        )
      }

    }else{
      console.log('ERROR DESCONOCIDO, NOTIFICAR A LOS DESARROLLADORES')
    }
    
  } catch (error) {
    console.log('ERROR DE RUTA: ' + error)
  }
  
}
export const AxiosDelete = (url,obj_data,dataname,tableData) => {
  try {

    Swal.fire({
      title: `¿ Esta Seguro de eliminar ${dataname} ?`,
      text: `El registro ${dataname} sera eliminado permanentemente`,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3c3b3d',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Si, Eliminar!'
    }).then(async(result) => {
      if (result.isConfirmed) {

        const resp = await axios.post(url,JSON.stringify(obj_data))
        if (resp.status == 200 && resp.statusText == 'OK') {
          const resp_data = await resp.data 

          if(resp_data == 2){
            Swal.fire(
              'Eliminado!',
              `El Registro ${dataname} ha sido eliminado.`,
              'success'
            )

          }else{
            Swal.fire(
              'Error de Emergencia!',
              'Esta intentando eliminar un registro no existente o no se encuentra en la data.',
              'success'
            )
          }
          tableData()

        }else{
          console.log('ERROR DESCONOCIDO, NOTIFICAR A LOS DESARROLLADORES')
        }

      }
    })

  } catch (error) {
    console.log('ERROR DE RUTA: ' + error)
  }
  
}
