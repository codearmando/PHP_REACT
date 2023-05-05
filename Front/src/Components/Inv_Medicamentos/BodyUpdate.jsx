import { Box,TextField,Button,Autocomplete,Typography, Grid } from "@mui/material";
import { useEffect, useState } from "react";
import {AxiosPut,AxiosGet} from '../../Helpers/FetchAxios/FetchAxios.jsx'

const styleCampos ={
    width:'100%'
}
// {onClose,medicamentoactual,tipmedicamento,componenteprinc,estatus,gramos,tableData}
function BodyUpdate({onClose,medicamentoactual,estatus,presentacion,gramos,almacen,tableData}) {

    const [selectalmacen,setSelectAlmacen] = useState([])
    const [selectestatusmedicamento,setSelectEstatusMedicamento] = useState([])
    const [tipomedicamento, settipomedicamento] = useState([]);
    const [estatusmedicamento, setEstatusMedicamento] = useState([]);
    const [tipoalmacen, setTipoAlmacen] = useState([])

    const [updatemedicamento, setUpdateMedicamento] = useState('');
    const [updatecomponent, setUpdateComponent] = useState('');

    const tipo_medicamento = async () => {
        const url = "http://localhost/Farmacia_Alto_Costo/App/inv_Medicamento/Tipomedic/Table";
        AxiosGet(url,settipomedicamento)
    
    };
    const tipo_almacen= async () => {
        const url = "http://localhost/Farmacia_Alto_Costo/App/inv_Medicamento/Tipoalmacen/table";
        AxiosGet(url,setTipoAlmacen)
      };
    const estatus_medicamento = async () => {
        const url = "http://localhost/Farmacia_Alto_Costo/App/inv_Medicamento/estatus/table";
        AxiosGet(url,setEstatusMedicamento)
    
    };
    useEffect(() => {
        tipo_medicamento();
    }, []);
    useEffect(() => {
        tipo_almacen();
    }, []);
    useEffect(() => {
        estatus_medicamento();
    }, []);


    // --------------------------------
    // -----------UPDATE MEDICAMENTOS-------
    // -------------
    // const UpdateMedicamento = () =>{

    //     let data_medicamento = null
    //     let data_tipmedicamento = null
    //     let data_componente = null
    //     let data_estatus = null

    //     if (updatemedicamento.length == 0) {
    //         data_medicamento = medicamentoactual
    //     }else{
    //         data_medicamento = updatemedicamento
    //     }
    //     if (selecttipmedicamento.length == 0) {
    //         data_tipmedicamento = tipmedicamento
    //     }else{
    //         data_tipmedicamento = selecttipmedicamento
    //     }
    //     if (updatecomponent.length == 0) {
    //         data_componente = componenteprinc
    //     }else{
    //         data_componente = updatecomponent
    //     }
    //     if (selectestatusmedicamento.length == 0) {
    //         data_estatus = estatus
    //     }else{
    //         data_estatus = selectestatusmedicamento
    //     }
        
    //     const medicamentoUpdate = {
    //         medicamentoactual : medicamentoactual,
    //         medicamento : data_medicamento,
    //         tipmedicamento : data_tipmedicamento,
    //         componenteprinc : data_componente,
    //         estatus : data_estatus,
    //         gramos:gramos,
    //     }
    //     console.log(medicamentoUpdate)
    //     // const url = 'http://localhost/Farmacia_Alto_Costo/App/inv_Medicamento/inventario/Update'
    //     // AxiosPut(url,medicamentoUpdate,tableData)
    //     // tableData()

    // }
    const UpdateInvMedic = () => {
        let data_estatus = null

        if (selectestatusmedicamento.length == 0) {
            data_estatus = estatus
        }else{
            data_estatus = selectestatusmedicamento
        }
        
        const objUpdateinv = {
            medicamentoactual : medicamentoactual,
            presentacion : presentacion,
            gramos:gramos,
            almacen : selectalmacen,
            estatus : data_estatus,
        }
        console.log('DATAENVIAR',objUpdateinv)
        const url = 'http://localhost/Farmacia_Alto_Costo/App/inv_Medicamento/inventario/Update'
        AxiosPut(url,objUpdateinv,`${medicamentoactual} de ${gramos} Modificado `,'',tableData)
        tableData()
    }
    const HandleSubmitUpdate = (e) =>{
        e.preventDefault()
        UpdateInvMedic()
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
                  <Grid item md={6}>   
                    <TextField sx={styleCampos}
                        id="nombre_medicamento_actual"
                        label="Nombre Medicameto Actual"
                        type="text"
                        InputProps={{
                            readOnly: true,
                        }}
                        defaultValue={medicamentoactual}  
                    />
                  </Grid>
                  <Grid item md={6}>   
                    <TextField sx={styleCampos}
                        id="gramos"
                        label="Unidad de medidad"
                        type="text"
                        InputProps={{
                            readOnly: true,
                        }}
                        defaultValue={gramos}  
                    />
                  </Grid>
                  <Grid item md={6}>   
                    <TextField sx={styleCampos}
                        id="estatus_actual"
                        label="Estatus Actual"
                        type="text"
                        InputProps={{
                            readOnly: true,
                        }}
                        defaultValue={estatus}  
                    />
                  </Grid>
                  <Grid item md={6}>   
                    <TextField sx={styleCampos}
                        id="almacen"
                        label="Almacen actual"
                        type="text"
                        InputProps={{
                            readOnly: true,
                        }}
                        defaultValue={almacen}  
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
                    options={estatusmedicamento}
                    onChange={(e,newValue) => {
                        setSelectEstatusMedicamento(newValue.PK_ESTATUS)
                    }}
                    getOptionLabel={(option) => option.ESTATUS}
                    renderInput={(params) => <TextField {...params} label="Nuevo Estatus" variant="outlined" />}
                />
              </Grid>
              <Grid item xs={12} md={6}>
                <Autocomplete sx={styleCampos}
                    id="combo-box-demo" 
                    options={tipoalmacen}
                    onChange={(e,newValue) => {
                        setSelectAlmacen(newValue.PK_ALMACEN)
                    }}
                    getOptionLabel={(option) => option.TIPO_ALMACEN}
                    renderInput={(params) => <TextField {...params} label="Nuevo Almacen" variant="outlined" />}
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