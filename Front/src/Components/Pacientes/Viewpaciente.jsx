import {
  Box,Button,TextField,Select,InputLabel,MenuItem,Alert,Stack,Collapse,Grid,Typography, FormControl} from "@mui/material";
import PadStartCiudadano from "../../Helpers/Ciudadano/PadStartCiudadano";
import React, { useState } from 'react'
import axios from 'axios'
import { LoadingButton } from "@mui/lab";
import MUIDataTable from 'mui-datatables';

// muidatatable global 
import { customHeadRender } from '../../Helpers/Muidatatable/muidatatable';
import '../../assets/Css/muidatatable.css'
import '../../assets/Css/Popup.css'

const styleCampos ={
    width:'100%',

}
const styleFormCiudadano ={
    display:'flex',
    alignItems:'center',
    justifyContent:'center'

}

function Paciente() {

    const [open, setOpen] = useState(false);
    const [open2, setOpen2] = useState(false);
    const [spiner, setSpiner] = useState(false);
     
    const [cedula,setcedula] = useState('')
    const [paciente,setPaciente] = useState([])
    const [selectnac,setSelectNac] = useState('')

    const datos_paciente = async () => {

        let datacedula = `${selectnac + PadStartCiudadano(cedula)}`;
        const cedulaciudadano = {
        cedulanac: datacedula,
        };

        const url ="http://localhost/Farmacia_Alto_Costo/App/paciente/paciente/table";

        const resp = await axios.post(url, JSON.stringify(cedulaciudadano));
        const resp_data = await resp.data;

        if (resp_data) {
            setPaciente({
                CEDULA: resp_data.CEDULA,
                PACIENTE: resp_data.PACIENTE,
                NOMBRE_PATOLOGIA: resp_data.NOMBRE_PATOLOGIA,
                FARMACEUTICO: resp_data.FARMACEUTICO,
                PARIENTE: resp_data.PARIENTE,
                PESO: resp_data.PESO,
                ALTURA: resp_data.ALTURA,
                SUPERFICIE_CORPORAL: resp_data.SUPERFICIE_CORPORAL,
                CORREO: resp_data.CORREO,
                TELEFONNO: resp_data.TELEFONNO,
                TLF_ALTERNO: resp_data.TLF_ALTERNO,
                ESTATUS: resp_data.ESTATUS,
            });
            setOpen(!open);
            setOpen2(false);
            setSpiner(false)
            // console.log(resp_data);
        } else {
            setOpen(false);
            setOpen2(!open2);
            setSpiner(false)
            return false;
        }
        // setSpiner(false)
        // tableData()
    }

    const HandleSubmitCiudadano = (e) =>{
        e.preventDefault()
        datos_paciente()
        console.log(paciente)
        setSpiner(true)
        // console.log(rows)
    }

    const columns = [

      {
        name : 'CEDULA',
        label : 'CEDULA',
        options:{
            customHeadRender: (columnMeta, handleToggleColumn) => {
              return customHeadRender(columnMeta, handleToggleColumn)
            },
            customBodyRender: (value, tableMeta, updateValue) => {
              return <div className="celdas_data">{value}</div>
            },
      }
      },
      {
        name : 'PACIENTE',
        label : 'PACIENTE',
        options:{
            customHeadRender: (columnMeta, handleToggleColumn) => {
              return customHeadRender(columnMeta, handleToggleColumn)
            },
            customBodyRender: (value, tableMeta, updateValue) => {
              return <div className="celdas_data">{value}</div>
            },
      }
      },
      {
        name : 'NOMBRE_PATOLOGIA',
        label : 'NOMBRE_PATOLOGIA',
        options:{
            customHeadRender: (columnMeta, handleToggleColumn) => {
              return customHeadRender(columnMeta, handleToggleColumn)
            },
            customBodyRender: (value, tableMeta, updateValue) => {
              return <div className="celdas_data">{value}</div>
            },
      }
      },
      {
        name : 'FARMACEUTICO',
        label : 'FARMACEUTICO',
        options:{
            customHeadRender: (columnMeta, handleToggleColumn) => {
              return customHeadRender(columnMeta, handleToggleColumn)
            },
            customBodyRender: (value, tableMeta, updateValue) => {
              return <div className="celdas_data">{value}</div>
            },
      }
      },
      {
        name : 'PARIENTE',
        label : 'PARIENTE',
        options:{
            customHeadRender: (columnMeta, handleToggleColumn) => {
              return customHeadRender(columnMeta, handleToggleColumn)
            },
            customBodyRender: (value, tableMeta, updateValue) => {
              return <div className="celdas_data">{value}</div>
            },
      }
      },
      {
          name : 'Action',
          label : 'ACCIONES',
          options:{
            customHeadRender: (columnMeta, handleToggleColumn) => {
              return customHeadRender(columnMeta, handleToggleColumn)
            },
            customBodyRender:(value, tableMeta, updateValue) =>{
                const transf_obj = Object.assign({},tableMeta.rowData)
                return (
                    <>
                        
                      <div className="celdas_data">
                        <Button variant="contained" color="success" onClick={() => console.log(transf_obj[0])}>
                          Asignar Ciclo
                        </Button>
                      </div>
                        
                    </>
                )
            }
            
          }
        },
  
      
  
  ]


  const opciones ={
      filterType: 'checkbox',
      // fixedHeader: true,
      selectableRows: false ,// o none
      // selectableRowsOnClick: true,
      filter:true,
      search:true,
      searchPlaceholder:'Buscar..',
      // searchAlwaysOpen:true,
      print: false ,
      download: false ,
      viewColumns:true,
      sort:true,
      draggable:true,
      responsive:'standard',
      rowsPerPage: 5,
      rowsPerPageOptions:[5,10,15,20,30,40,50],
  
      draggableColumns:{
          enabled:true
      },
  
  }
    


  return (
    <>
      {/* <center> */}
      <Box sx={{width:'100%'}}
          component="form"
          className="form_ciudadano"
          id="form_step"
          onSubmit={HandleSubmitCiudadano}
        >
        {/*--------------------  */}
        {/* Buscar ciudadano  */}
        {/*--------------------  */}
        <Box sx={{width:'100%'}}>
          <Box sx={{width:'100%',bgcolor:'#ffffff',p:'1rem',boxShadow:'2px 2px 6px #ccc',}}>
            <Box id='subheader-global'>
              <Typography variant="h6" color="initial" sx={{color:'#fff',py:1}}>Buscar Paciente</Typography>
            </Box>
            <Grid container spacing={2} >
              <Grid item xs={12} md={2}>
                <FormControl fullWidth>
                <InputLabel id="demo-simple-select-label">Nacionalidad</InputLabel>
                <Select
                    sx={styleCampos}
                    labelId="demo-simple-select-label"
                    id="select_nac"
                    value={selectnac}
                    label="Nacionalidad"
                    onChange={(e) => setSelectNac(e.target.value)}
                >
                    <MenuItem value="V">V</MenuItem>
                    <MenuItem value="E">E</MenuItem>
                </Select>
                </FormControl>
              </Grid>
              <Grid item xs={12} md={3}>
                  <TextField
                  sx={styleCampos}
                  id="cedula"
                  label="Cédula"
                  defaultValue={cedula}
                  onChange={(e) => setcedula(e.target.value)}
                  />
              </Grid>
              <Grid item xs={12} md={2}>
                <LoadingButton

                  type="submit"
                  variant="contained"
                  loading={spiner}
                  // loadingPosition="start"
                  // loadingIndicator='Cargando...'
                  sx={{ mt: 1 }}
                >
                  Buscar
                </LoadingButton>
              </Grid>
            </Grid>
            {/* Informacion de ciudadano  */}
            <Box className="cont_collapse"  >
                        {/* datos en tabla */}
                        <Collapse in={open}>
                            <Typography variant="p" color="primary" sx={{ mt: 3 }}>
                                Datos Obtenidos:
                            </Typography>
                            
                            <Box component='div' sx={{ width: '100%' }}>
                                <MUIDataTable 
                                    title={"PACIENTE"}
                                    data={[paciente]}
                                    columns={columns}
                                    options={opciones}
                                />
                            </Box>
        
                        </Collapse>
                        {/* mensaje de error */}
                        <Collapse in={open2}>
                            <Stack sx={{ width: "100%", mt: 1 }} spacing={2}>
                                <Alert severity="warning">
                                <strong>Los Datos no son Correctos</strong> o{" "}
                                <strong>No esta REGISTRADO . " POR FAVOR BERIFIQUE "</strong>!
                                </Alert>
                            </Stack>
                        </Collapse>
            </Box>
          </Box>
              
        </Box>
      </Box>
      {/* </center> */}
    
    </>
  );
}

export default Paciente;
