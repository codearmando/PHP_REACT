import { Box, Button, TextField, Select,InputLabel, MenuItem, Alert, Stack, Collapse, Autocomplete, Grid, Typography, Radio, RadioGroup, FormControlLabel, FormLabel, FormControl } from '@mui/material'
import React, { useEffect, useState } from 'react'
import { AxiosGet,AxiosPost } from '../../Helpers/FetchAxios/FetchAxios'
import PadStartCiudadano from '../../Helpers/Ciudadano/PadStartCiudadano'
import axios from 'axios'
import '../../assets/Css/FormStep.css'

import { nextformstep,beforeformstep } from '../../assets/JS/FormStep'

const styleCampos ={
    width:'100%',

}
const styleFormCiudadano ={
    display:'flex',
    alignItems:'center',
    justifyContent:'center'

}

function BodyRegistrarpaciente({cedula,onClose,tableData}) {

    const [ciudadano,setCiudadano] = useState({})
    const [pariente,setPariente] = useState({})
    const [ciudadanop,setCiudadanop] = useState('')
    const [selectnac,setSelectNac] = useState('')
    const [selectnacp,setSelectNacP] = useState('')
    
    const [open, setOpen] = useState(false);
    const [open2, setOpen2] = useState(false);
    const [openp, setOpenp] = useState(false);
    const [openp2, setOpenp2] = useState(false);
    const [openoption, setOpenOption] = useState(false);
    
    const [listpatologias,setListPatologias] = useState([])
    const [listmedicos,setListMedicos] = useState([])
    const [selectpatologia,setSelectPatologia] = useState([])
    const [selectmedico,setSelectMedico] = useState([])
    
    const [peso,setPeso] = useState('')
    const [altura,setAltura] = useState('')
    const [supcorporal,setSupCorporal] = useState('')
    const [correo,setCorreo] = useState('')
    const [tlf,setTlf] = useState('')
    const [tlfalterno,setTlfAlterno] = useState('')


    
    const datos_ciudadano = async () =>{

        let datacedula = `${selectnac + PadStartCiudadano(cedula)}`
        const cedulaciudadano = {
            cedulanac : datacedula
        }

        const url = 'http://localhost/Farmacia_Alto_Costo/App/ciudadanos/ciudadano/table'
      
        const resp = await axios.post(url,JSON.stringify(cedulaciudadano))
        const resp_data = await resp.data

        if (resp_data) {
            
            setCiudadano({
                PK_CIUDADANO :resp_data.PK_CIUDADANO,
                NOMBRE :resp_data.NOMBRE,
                APELLIDO :resp_data.APELLIDO,
                SEXO :resp_data.SEXO,
                FECHA_NACIMIENTO :resp_data.FECHA_NACIMIENTO.split(/[-/]/).reverse().join("/"),
            })
            setOpen(!open);
            setOpen2(false);
            console.log(resp_data.PK_CIUDADANO)
            
        }else{
            setOpen(false);
            setOpen2(!open2);
            return false
            
        }
        // tableData()
    }
    const datos_Pariente = async () =>{

        let datacedula = `${selectnacp + PadStartCiudadano(ciudadanop)}`
        const cedulaciudadano = {
            cedulanac : datacedula
        }

        const url = 'http://localhost/Farmacia_Alto_Costo/App/ciudadanos/ciudadano/table'
      
        const resp = await axios.post(url,JSON.stringify(cedulaciudadano))
        const resp_data = await resp.data

        if (resp_data) {
            
            setPariente({
                PK_CIUDADANO :resp_data.PK_CIUDADANO,
                NOMBRE :resp_data.NOMBRE,
                APELLIDO :resp_data.APELLIDO,
                SEXO :resp_data.SEXO,
                FECHA_NACIMIENTO :resp_data.FECHA_NACIMIENTO.split(/[-/]/).reverse().join("/"),
            })
            setOpenp(!openp);
            setOpenp2(false);
            console.log(resp_data.PK_CIUDADANO)
            
        }else{
            setOpenp(false);
            setOpenp2(!openp2);
            return false
            
        }
        // tableData()
    }
    const HandleSubmitCiudadano = (e) =>{
        e.preventDefault()
        datos_ciudadano()
      
    }
    const HandleSubmitPariente = (e) =>{
        e.preventDefault()
        datos_Pariente()
      
    }
    // -------------------------
    // REGISTRAR PACIENTE
    // ----------------------------

    const ListPatologias = () =>{
        const url ='http://localhost/Farmacia_Alto_Costo/App/paciente/ListPatologias/Table'
        AxiosGet(url,setListPatologias)
    }
    useEffect(() =>{
        ListPatologias()
    },[])
    const ListMedicos = () =>{
        const url ='http://localhost/Farmacia_Alto_Costo/App/medicos/medico/Table'
        AxiosGet(url,setListMedicos)
    }
    useEffect(() =>{
        ListMedicos()
    },[])
    const Paciente = () =>{
        const dataPaciente = {
            pk_ciudadano : ciudadano.PK_CIUDADANO,
            pk_ciud_pariente : pariente.PK_CIUDADANO,
            cedula : cedula,
            patologia : selectpatologia,
            medico : selectmedico,
            peso : document.getElementById('peso').value,
            altura : altura,
            supcorporal : supcorporal,
            correo : correo,
            tlf : tlf,
            tlfalterno : tlfalterno,

        }
        console.log(dataPaciente)
        const url ='http://localhost/Farmacia_Alto_Costo/App/paciente/paciente/Insert'
        AxiosPost(url,dataPaciente,'Paciente Registrado!',tableData)
        tableData()
        
    }


    const HandleSubmitPaciente = (e) =>{
        e.preventDefault()
        Paciente()
        onClose()
      
    }

    
  return (
    <>

        <Box className = 'Cont_form_step'>

            <Box className='slider_form'>

                <Box component='form' className='form_ciudadano' id='form_step'  onSubmit={HandleSubmitCiudadano}>

                    {/*--------------------  */}
                    {/* Buscar ciudadano  */}
                    {/*--------------------  */}
                    <Box>
                        <center>
                            <Grid container spacing={2} sx={{mt:1}}>
                                <Grid item xs={12} md={5}>
                                    <FormControl fullWidth>
                                        <InputLabel id="demo-simple-select-label">Age</InputLabel>
                                        <Select sx={styleCampos}
                                            labelId="demo-simple-select-label"
                                            id="select_nac"
                                            value={selectnac}
                                            label="Nacionalidad"
                                            onChange={(e) => setSelectNac(e.target.value)}
                                            >
                                            <MenuItem value='V'>V</MenuItem>
                                            <MenuItem value='E'>E</MenuItem>
                                            
                                        </Select>
                                    </FormControl>
                                </Grid>
                                <Grid item xs={12} md={5}>
                                    <TextField sx={styleCampos}
                                        id="Cédula"
                                        label="Cédula"
                                        defaultValue={cedula}
                                        InputProps={{
                                            readOnly: true,
                                        }}
                                        // onChange={}
                                        
                                    />
                                </Grid>
                                <Grid item xs={12} md={2}>    
                                    <Button type="submit" variant="contained" color="primary"sx={{mt:1}}>
                                        Buscar
                                    </Button>
                                </Grid>
                            </Grid>
                        </center>
                        {/* Informacion de ciudadano  */}
                        <Box className='cont_collapse' sx={{mt:1}}>
                            <Collapse in={open}>
                                <Typography variant="p" color="primary" sx={{mt:3}}>Datos Obtenidos:</Typography>
                                <Grid container spacing={2} sx={{my:2}}>
                                    <Grid item  md={5} >
                                        <TextField sx={styleCampos}
                                            id="nombre"
                                            label="Nombre"
                                            type="text"
                                            value={ciudadano.NOMBRE}
                                            InputProps={{
                                                readOnly: true,
                                            }}
                                            color="success" focused
                                        />
                                    </Grid>
                                    <Grid item  md={5}>       
                                        <TextField sx={styleCampos}
                                            id="apellido"
                                            label="Apellido"
                                            type="text"
                                            value={ciudadano.APELLIDO}
                                            InputProps={{
                                                readOnly: true,
                                            }}
                                            color="success" focused
                                        />
                                    </Grid>
                                    <Grid item  md={5}>       
                                        <TextField sx={styleCampos}
                                            id="sexo"
                                            label="Sexo"
                                            type="text"
                                            value={ciudadano.SEXO}
                                            InputProps={{
                                                readOnly: true,
                                            }}
                                            color="success" focused
                                        />
                                    </Grid>
                                    <Grid item  md={5}>
                                        <TextField sx={styleCampos}
                                            id="fecha_nacimiento"
                                            label="Fecha de Nacimiento"
                                            type="text"
                                            value={ciudadano.FECHA_NACIMIENTO}
                                            InputProps={{
                                                readOnly: true,
                                            }}
                                            color="success" focused
                                        />     
                                    </Grid>

                                </Grid>
                                
                                <Box 
                                    sx={{mt:2,float:'right'}}
                                    >
                                    <Button variant="contained" id='btn_next' color="info" onClick={() => nextformstep()} >
                                    
                                        Siguiente
                                    </Button>
                                </Box>
                                
                            </Collapse>  
                            {/* mensaje de error */}
                            <Collapse in={open2}>
                                <Stack sx={{ width: '100%', mt:1 }} spacing={2}>
                                    <Alert severity="warning"><strong>Los Datos no son Correctos</strong> o <strong>No esta REGISTRADO . " POR FAVOR BERIFIQUE "</strong>!</Alert>
                                </Stack>
                            </Collapse>     
                        </Box>
                    </Box>
                </Box>
                <Box component='form' className='form_ciudadano' id='form_step'  onSubmit={HandleSubmitPariente}>

                    {/*--------------------  */}
                    {/* Buscar pariente  */}
                    {/*--------------------  */}
                    <Box>
                        <FormControl>
                            <FormLabel id="demo-row-radio-buttons-group-label">Asignar Pariente ?</FormLabel>
                            <RadioGroup
                                row
                                aria-labelledby="demo-row-radio-buttons-group-label"
                                name="row-radio-buttons-group"
                            >
                                <FormControlLabel value="female" control={<Radio />} label="Si" onClick={() => setOpenOption(!openoption)} />
                                <FormControlLabel value="male" control={<Radio />} label="No" onClick={() => setOpenOption(false)} />
                                
                            </RadioGroup>
                        </FormControl>
                        <Collapse in={openoption}>
                            <center>
                                <Grid container spacing={2} sx={{mt:1}}>
                                    <Grid item xs={12} md={5}>
                                        <FormControl fullWidth>
                                            <InputLabel id="demo-simple-select-label">Age</InputLabel>
                                            <Select sx={styleCampos}
                                                labelId="demo-simple-select-label"
                                                id="select_nac"
                                                value={selectnacp}
                                                label="Nacionalidad"
                                                onChange={(e) => setSelectNacP(e.target.value)}
                                                >
                                                <MenuItem value='V'>V</MenuItem>
                                                <MenuItem value='E'>E</MenuItem>
                                                
                                            </Select>
                                        </FormControl>
                                    </Grid>
                                    <Grid item xs={12} md={5}>
                                        <TextField sx={styleCampos}
                                            id="Cédulapariente"
                                            label="Cédula Pariente"
                                            type='text'
                                            defaultValue={ciudadanop}
                                            onChange={(e) => setCiudadanop(e.target.value)}
                                            
                                        />
                                    </Grid>
                                    <Grid item xs={12} md={2}>    
                                        <Button type="submit" variant="contained" color="primary"sx={{mt:1}}>
                                            Buscar
                                        </Button>
                                        
                                    </Grid>
                                </Grid>
                            </center>
                            {/* Informacion de paciente  */}
                            <Box className='cont_collapse' sx={{mt:1}}>
                                <Collapse in={openp}>
                                    <Typography variant="p" color="primary" sx={{mt:3}}>Datos Obtenidos:</Typography>
                                    <Grid container spacing={2} sx={{my:2}}>
                                        <Grid item  md={5} >
                                            <TextField sx={styleCampos}
                                                id="nombre"
                                                label="Nombre"
                                                type="text"
                                                value={pariente.NOMBRE}
                                                InputProps={{
                                                    readOnly: true,
                                                }}
                                                color="success" focused
                                            />
                                        </Grid>
                                        <Grid item  md={5}>       
                                            <TextField sx={styleCampos}
                                                id="apellido"
                                                label="Apellido"
                                                type="text"
                                                value={pariente.APELLIDO}
                                                InputProps={{
                                                    readOnly: true,
                                                }}
                                                color="success" focused
                                            />
                                        </Grid>
                                        <Grid item  md={5}>       
                                            <TextField sx={styleCampos}
                                                id="sexo"
                                                label="Sexo"
                                                type="text"
                                                value={pariente.SEXO}
                                                InputProps={{
                                                    readOnly: true,
                                                }}
                                                color="success" focused
                                            />
                                        </Grid>
                                        <Grid item  md={5}>
                                            <TextField sx={styleCampos}
                                                id="fecha_nacimiento"
                                                label="Fecha de Nacimiento"
                                                type="text"
                                                value={pariente.FECHA_NACIMIENTO}
                                                InputProps={{
                                                    readOnly: true,
                                                }}
                                                color="success" focused
                                            />     
                                        </Grid>

                                    </Grid>

                                    
                                    
                                </Collapse>  
                                {/* mensaje de error */}
                                <Collapse in={openp2}>
                                    <Stack sx={{ width: '100%', mt:1 }} spacing={2}>
                                        <Alert severity="warning"><strong>Los Datos no son Correctos</strong> o <strong>No esta REGISTRADO . " POR FAVOR BERIFIQUE "</strong>!</Alert>
                                    </Stack>
                                </Collapse> 

                            </Box>
                        </Collapse>   
                        <Box 
                            sx={{mt:2,float:'right'}}
                            >
                            <Button variant="contained" id='btn_next' color="warning" sx={{mr:2}} onClick={() => beforeformstep()} >
                                Volver
                            </Button>
                            <Button variant="contained" id='btn_next' color="info" onClick={() => nextformstep()} >
                                        
                                Siguiente
                            </Button>
                        </Box>    
                    </Box>
                </Box>


                {/* ------------------- */}
                {/*-------REGISTRAR PACIENTE-------  */}
                {/* ------------------- */}
            
                <Box component='form' className='form_paciente' id='form_step' onSubmit={HandleSubmitPaciente} >
                    <Box className='cont_inputs'>
                        <Typography variant="p" color="primary" sx={{borderBottom:'1px solid #ccc'}}>Información de Paciente:</Typography>
                        {/* <hr style={{color:'#e8e8e8'}} /> */}
                        <Grid container spacing={2} sx={{py:1,pb:1}}>
                            <Grid item xs={12} md={6}>    
                                <Autocomplete sx={styleCampos} 
                                    id="combo-box-demo" 
                                    options={listpatologias}
                                    onChange={(e,newValue) => {
                                        setSelectPatologia(newValue.PK_PATOLOGIA)
                                    }}
                                    getOptionLabel={(option) => option.NOMBRE_PATOLOGIA}
                                    renderInput={(params) => <TextField {...params} label="Patologias" variant="outlined" />}
                                />
                                
                            </Grid>
                            <Grid item xs={12} md={6}>    
                                
                                <Autocomplete sx={styleCampos} 
                                    id="combo-box-demo" 
                                    options={listmedicos}
                                    onChange={(e,newValue) => {
                                        setSelectMedico(newValue.PK_MEDICOS)
                                    }}
                                    getOptionLabel={(option) => option.NOMBRE}
                                    renderInput={(params) => <TextField {...params} label="Farmaceutico" variant="outlined" />}
                                />
                            </Grid>
                            <Grid item xs={12} md={4}>    
                                
                                <TextField sx={styleCampos}
                                    id="peso"
                                    label="Peso"
                                    type="text"
                                    value={peso}
                                    onChange={(e) => setPeso(e.target.value) }
                                    
                                />
                            </Grid>
                            <Grid item xs={12} md={4}>    
                                
                                <TextField sx={styleCampos}
                                    id="altura"
                                    label="Altura"
                                    type="text"
                                    value={altura}
                                    onChange={(e) => setAltura(e.target.value) }
                                    
                                />
                            </Grid>
                            <Grid item xs={12} md={4}>    
                                
                                <TextField sx={styleCampos}
                                    id="superficie_corporal"
                                    label="Superficie Corporal"
                                    type="text"
                                    value={supcorporal}
                                    onChange={(e) => setSupCorporal(e.target.value) }
                                    
                                />
                            </Grid>
                            
                        </Grid>
                        <br /> 
                        <Typography variant="p" color="primary" sx={{borderBottom: '1px solid #ccc'}}>Contactos:</Typography>
                        {/* <hr style={{color:'#e8e8e8'}} /> */}
                        <br />
                        <Grid container spacing={2} sx={{py:1}}>
                            
                            
                            <Grid item xs={12} md={4}>    
                                
                                <TextField sx={styleCampos}
                                    id="correo"
                                    label="Correo"
                                    type="text"
                                    value={correo}
                                    onChange={(e) => setCorreo(e.target.value) }
                                    
                                />
                            </Grid>
                            <Grid item xs={12} md={4}>    
                                
                                <TextField sx={styleCampos}
                                    id="Tlf"
                                    label="Teléfono"
                                    type="number"
                                    value={tlf}
                                    onChange={(e) => setTlf(e.target.value) }
                                    
                                />
                            </Grid>
                            <Grid item xs={12} md={4}>    
                                <TextField sx={styleCampos}
                                    id="Tlf_alterno"
                                    label="Teléfono Alterno"
                                    type="number"
                                    value={tlfalterno}
                                    onChange={(e) => setTlfAlterno(e.target.value) }
                                    
                                />
                            </Grid>
                        </Grid>
                        
                        {/* <Typography variant="p" color="primary"></Typography>
                        <hr /> */}
                                                                   
                        <Box 
                            sx={{mt:2,float:'right'}}
                            >
                            <Button type="button" variant="contained" color="warning" sx={{mr:2}} onClick={() => beforeformstep()}>
                                Volver
                            </Button>    
                            <Button type="submit" variant="contained" color="success"sx={{mr:2}}>
                                Registrar
                            </Button>    
                        </Box>
                    </Box>
                </Box>  

            </Box>

            <Box 
                sx={{mt:2,float:'right'}}
                > 
                    <Button variant="contained" color="error" onClick={onClose}>
                    Cancelar
                </Button>

            </Box>
        </Box>


        {/* <input type="text" value={ciudadano.PK_CIUDADANO} /> */}
        {/* <p>{ciudadano.PK_CIUDADANO}</p> */}
        {/* <p>{cedula}</p> */}
    </>
  )
}

export default BodyRegistrarpaciente