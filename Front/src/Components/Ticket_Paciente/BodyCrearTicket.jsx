import { Box, TextField, Autocomplete, Button, Grid } from '@mui/material'
import { useState, useEffect } from 'react'
import { AxiosGet, AxiosPost } from '../../Helpers/FetchAxios/FetchAxios'
import axios from 'axios'
import Swal from 'sweetalert2'

const styleCampos ={
  width:'100%',

}

function BodyCrearTicket({onClose,tableData}) {

    const [selecttipticket,setSelectTipTicket] = useState([])

    const [tipoticket,setTipoTicket] = useState([])
    const [cedula,setCedula] = useState([])
    

    const TipoDeTicket = () =>{
        const url = 'http://localhost/Farmacia_Alto_Costo/App/ticket/tipoticket/Table'
        AxiosGet(url,setTipoTicket)
    }

    useEffect(() => {
        TipoDeTicket();
    }, []);

    const Add_Ticket= async () => {

        const ticket ={
          tipoticket:selecttipticket,
          cedula:cedula,

        }
        const url = "http://localhost/Farmacia_Alto_Costo/App/ticket/ticket/CrearTicket";
        try {
            const resp = await axios.post(url,JSON.stringify(ticket))
            if (resp.status == 200 && resp.statusText == 'OK') {
              const resp_data = await resp.data

              if(resp_data == 3){
                tableData()
                Swal.fire(
                    'LIMITE ALCANZADO!',
                    `No se puede crear este tipo de ticket`,
                    'error'
                )
                // return false
              }
              
              if (resp_data) {
                tableData()
                  return(
                    Swal.fire(
                      'Ticket Creado!',
                      `Nro: ${resp_data}`,
                      'success',
                      
                    )
                  )
              }else{
                tableData()
                return(
                  Swal.fire(
                    'Error!',
                    'Ocurrio un error inesperado o no selecciono un tipo de ticket válido.',
                    'error'
                  )
                )
              }
              
              console.log(resp_data)
        
            }else{
              console.log('ERROR DESCONOCIDO, NOTIFICAR A LOS DESARROLLADORES')
            }
            
          } catch (error) {
            console.log('ERROR DE RUTA: ' + error)
          }
        tableData()
        
      };
      
      
    const HandleSubmit = (e) =>{
        e.preventDefault()
        Add_Ticket()
        onClose()
        tableData()
    }
    return (
        <>
            <Box component='form' onSubmit={HandleSubmit}>
                <Box>
                  
                  <Autocomplete sx={{my:1,styleCampos}}
                    id="combo-box-demo" 
                    options={tipoticket}
                    onChange={(e,newValue) => {
                        setSelectTipTicket(newValue.PK_TIPO_TICKET)
                    }}
                    getOptionLabel={(option) => option.NOMBRE_TICKET}
                    renderInput={(params) => <TextField {...params} label="Tipo de Ticket" variant="outlined" />}
                  />

                  <TextField sx={styleCampos}
                    id="cedula"
                    label="Cédula"
                    value={cedula}
                    onChange={(e) => setCedula(e.target.value)}
                      
                  />
                </Box>       
                <Box 
                    sx={{mt:2,float:'right'}}
                    >
                    <Button type="submit" variant="contained" color="primary"sx={{mr:2}}>
                        Generar Ticket
                    </Button>
                    <Button variant="contained" color="error" onClick={onClose}>
                        Cancelar
                    </Button>
                </Box>
                

                {/* <p>{selecttipticket}</p>
                <p>{cedula}</p> */}

            </Box>
        </>
    )
}

export default BodyCrearTicket