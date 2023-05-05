import { Box,TextField,Button,Autocomplete,Typography, Grid, Select, MenuItem, FormControl, InputLabel } from "@mui/material";
import { useEffect, useState } from "react";
import {AxiosPut,AxiosGet} from '../../Helpers/FetchAxios/FetchAxios.jsx'

const styleCampos ={
    width:'100%'
}
// {onClose,medicamentoactual,tipmedicamento,componenteprinc,estatus,gramos,tableData}
function BodyUpdate({onClose,medicamentoactual,componenteprinc,tipmedicamento,tableData}) {

    const [medicamento,setMedicamento] = useState('')
    const [tipomedicamento,setTipoMedicamento] = useState([])
    const [selecttipomedicamento,setSelectTipoMedicamento] = useState([])
    const [componentprinc,setComponentPrinc] = useState('')

    const tipo_medicamento = async () => {
        const url = "http://localhost/Farmacia_Alto_Costo/App/Medicamentos/Tipomedic/table";
        AxiosGet(url,setTipoMedicamento)
    
    };
    useEffect(() => {
        tipo_medicamento();
    }, []);


    // --------------------------------
    // -----------UPDATE MEDICAMENTOS-------
    // -------------

    const UpdateEstatusInvMedic = () => {
        let data_tipmedicamento = null
        let data_medicamento = null
        let data_componente = null

        if (selecttipomedicamento.length == 0) {
            data_tipmedicamento = tipmedicamento
        }else{
            data_tipmedicamento = selecttipomedicamento
        }
        if (medicamento.length == 0) {
            data_medicamento = medicamentoactual
        }else{
            data_medicamento = medicamento
        }
        if (componentprinc.length == 0) {
            data_componente = componenteprinc + componentprinc
        }else{
            data_componente = componenteprinc + componentprinc
        }
        
        const MedicamentoUpdate = {
            medicamentoactual : medicamentoactual,
            medicamento : data_medicamento,
            tipomedicamento : data_tipmedicamento,
            componenteprinc : data_componente,
        }
        
        console.log(MedicamentoUpdate)
        const url = 'http://localhost/Farmacia_Alto_Costo/App/medicamentos/medicamento/update'
        AxiosPut(url,MedicamentoUpdate,`${MedicamentoUpdate.medicamentoactual}`,`a ${MedicamentoUpdate.medicamento}`,tableData)
        tableData()
    }
    const HandleSubmitUpdate = (e) =>{
        e.preventDefault()
        UpdateEstatusInvMedic()
        onClose()
        tableData()
       
    }

  return (
    <>
    
        <Box component='form' onSubmit={HandleSubmitUpdate}>
            <Box>
                <Typography variant="p" color="primary">Datos Actuales</Typography>
                <br />
                <br />
                <Grid container spacing={2}>
                  <Grid item md={8}>
                    <TextField sx={styleCampos}
                        id="tipo_medicamento_actual"
                        label="Tipo Medicameto Actual"
                        type="text"
                        InputProps={{
                            readOnly: true,
                        }}
                        defaultValue={tipmedicamento}  
                    />
                  </Grid>
                </Grid>
            </Box>
            <br />
            <hr />
            <Typography variant="p" color="primary">Modificar dato:</Typography>
            <br />
            <br />
            <Grid container spacing={2}>
              <Grid item xs={12} md={6}>
                <Autocomplete sx={styleCampos}
                    id="combo-box-demo" 
                    options={tipomedicamento}
                    placeholder={tipmedicamento}
                    onChange={(e,newValue) => {
                        setSelectTipoMedicamento(newValue.PK_TIPO_MEDICAMENTO)
                    }}
                    getOptionLabel={(option) => option.TIPO_MEDICAMENTO}
                    renderInput={(params) => <TextField {...params} label="Nuevo Tipo Medicamento" variant="outlined" />}
                />
              </Grid>
              <Grid item xs={12} md={6}>
                <TextField sx={styleCampos}
                    id="nombre_medicamento_modif"
                    label="Medicameto Modificar"
                    type="text"
                    defaultValue={medicamentoactual} 
                    onChange={(e) => setMedicamento(e.target.value)}   
                />
              </Grid>
              <Grid item xs={12}>
              <TextField sx={styleCampos}
                    id="componente_pirnc"
                    label="Componente Pirncipal"
                    multiline
                    rows={5}
                    defaultValue={componenteprinc}
                    onChange={(e) => setComponentPrinc(e.target.value)}
                />
              </Grid>
              
            </Grid>

            <Box 
                    sx={{mt:2,float:'right'}}
                >
                <Button type="submit" variant="contained" color="primary" sx={{mr:2}}>
                    Registrar
                </Button>
                <Button variant="contained" color="error" onClick={onClose}>
                    Cancelar
                </Button>
            </Box>

            {/* <p>seleccion:  {selecttipmedicamento}</p> */}
        </Box>


    </>
  )
}

export default BodyUpdate