import {
    Box,Button,TextField,Select,InputLabel,MenuItem,Alert,Stack,Collapse,Autocomplete,Grid,Typography,Radio,RadioGroup,FormControlLabel,FormLabel, FormControl} from "@mui/material";
  import PadStartCiudadano from "../../Helpers/Ciudadano/PadStartCiudadano";
  import React, { useEffect, useState } from 'react'
  import axios from 'axios'
  import { DataGrid } from '@mui/x-data-grid';
  
  const styleCampos ={
      width:'100%',
  
  }
  const styleFormCiudadano ={
      display:'flex',
      alignItems:'center',
      justifyContent:'center'
  
  }
  
  function Viewpaciente() {
  
      const [open, setOpen] = useState(false);
      const [open2, setOpen2] = useState(false);
  
       
      const [cedula,setcedula] = useState('')
      const [paciente,setPaciente] = useState({})
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
              // console.log(resp_data);
          } else {
              setOpen(false);
              setOpen2(!open2);
              return false;
          }
          // tableData()
      }
  
      const HandleSubmitCiudadano = (e) =>{
          e.preventDefault()
          datos_paciente()
          console.log(paciente)
          // console.log(rows)
      }
  
      const columns = [
        { field: 'cedula', headerName: 'CEDULA', width: 120 },
        { field: 'paciente', headerName: 'PACIENTE', width: 320 },
        { field: 'patologia', headerName: 'NOMBRE DE PATOLOGIA', width: 250 },
        { field: 'farmaceutico', headerName: 'FARMACEUTICO', width: 250 },
        { field: 'pariente', headerName: 'PARIENTE', width: 250 },
        { field: 'actions', headerName: 'ACCIONES', width: 300 },
  
      ];
      const rows = [
        {
          id:cedula,
          cedula: paciente.CEDULA,
          paciente: paciente.PACIENTE,
          patologia:paciente.NOMBRE_PATOLOGIA,
          farmaceutico:paciente.FARMACEUTICO,
          pariente:paciente.PARIENTE
        },
      ]
      const options = {
        pageSize:5,
        rowsPerPageOptions:[5,10,20]
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
            <Box>
              <center>
                <Grid container spacing={2} sx={{ mt: 1 }}>
                  <Grid item xs={12} md={1}>
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
                  <Grid item xs={12} md={2}>
                    <TextField
                      sx={styleCampos}
                      id="cedula"
                      label="Cédula"
                      defaultValue={cedula}
                      onChange={(e) => setcedula(e.target.value)}
                    />
                  </Grid>
                  <Grid item xs={12} md={2}>
                    <Button
                      type="submit"
                      variant="contained"
                      color="primary"
                      sx={{ mt: 1 }}
                    >
                      Buscar
                    </Button>
                  </Grid>
                </Grid>
              </center>
              {/* Informacion de ciudadano  */}
              <Box className="cont_collapse" sx={{ mt: 1 }}>
                {/* datos en tabla */}
                <Collapse in={open}>
                  <Typography variant="p" color="primary" sx={{ mt: 3 }}>
                    Datos Obtenidos:
                  </Typography>
                  
                  <Box component='div' sx={{ width: '100%' }}>
                    <DataGrid
                      rows={rows}
                      columns={columns}
                      // options={options}
                      pageSize={5}
                      // checkboxSelection
                    
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
        {/* </center> */}
      </>
    );
  }
  
  export default Viewpaciente;
  