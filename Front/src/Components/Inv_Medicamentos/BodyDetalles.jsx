import { Box, TextField, Button, TextareaAutosize, Grid, Typography } from '@mui/material'
import React from 'react'
// 
const styleCampos ={
    width:'100%'
}
function BodyDetalles({onClose,almacen,medicamento,tipomedicamento,presentmedicamento,unidadmedida,piso,pasillo,cantidad,lotes,estatus,fecha_vencimiento,componente,observacion}) {
    // if(estatus == 'DISPONIBLE'){
    //     estatus.style={color:'blue'}
    // }
  return (
    <>
        
        <Box component='form' >

            <Typography variant="p" color="primary">Detalles del Medicamento:</Typography>  
            <br />
            <br />
            <Grid container spacing={2}>
                <Grid item xs={6} md={4}>
                    <TextField sx={styleCampos}
                        id="tipo_almacen"
                        label="Tipo de Almacen"
                        type='text'
                        defaultValue={almacen}
                        InputProps={{
                            readOnly: true,
                        }}
                        color="success" focused
                        
                    />
                </Grid>
                <Grid item xs={6} md={4}>
                    <TextField sx={styleCampos}
                        id="nombre_medicamento"
                        label="Nombre Medicamentos"
                        type='text'
                        defaultValue={medicamento}
                        InputProps={{
                            readOnly: true,
                        }}
                        color="success" focused
                    />
                </Grid>
                <Grid item xs={12} md={4}>
                    <TextField sx={styleCampos}
                        id="tipo_medicamento"
                        label="Tipo de Medicamentos"
                        type='text'
                        defaultValue={tipomedicamento}
                        InputProps={{
                            readOnly: true,
                        }}
                        color="success" focused
                    />                 
                </Grid>
                <Grid item xs={12} md={4}>
                    <TextField sx={styleCampos}
                        id="present_medicamento"
                        label="Presentación"
                        type='text'
                        defaultValue={presentmedicamento}
                        InputProps={{
                            readOnly: true,
                        }}
                        color="success" focused
                    />                 
                </Grid>
                <Grid item xs={12} md={4}>
                    <TextField sx={styleCampos}
                        id="Unidad_medida"
                        label="Unidad de medida"
                        type='text'
                        defaultValue={unidadmedida}
                        InputProps={{
                            readOnly: true,
                        }}
                        color="success" focused
                    />                 
                </Grid>
            </Grid>
            <br />
            <Typography variant="p" color="primary">ubicación y Cantidad:</Typography>  
            <br />
            <br />

            <Grid container spacing={2}>
                <Grid item xs={12} md={2}>
                    <TextField sx={styleCampos}
                        id="piso"
                        label="piso"
                        type='text'
                        defaultValue={piso}
                        InputProps={{
                            readOnly: true,
                        }}
                        color="success" focused
                    />                 
                </Grid> 
                <Grid item xs={12} md={4}>
                    <TextField sx={styleCampos}
                        id="pasillo"
                        label="pasillo"
                        type='text'
                        defaultValue={pasillo}
                        InputProps={{
                            readOnly: true,
                        }}
                        color="success" focused
                    />                 
                </Grid>
                <Grid item xs={6} md={2}>
                
                    <TextField sx={styleCampos}
                        id="cantidad"
                        label="Cantidad"
                        type='text'
                        defaultValue={cantidad}
                        InputProps={{
                            readOnly: true,
                        }}
                        color="success" focused
                    />
                </Grid>
                <Grid item xs={6} md={2}>
                    <TextField sx={styleCampos}
                        id="lotes"
                        label="Lotes"
                        type='text'
                        defaultValue={lotes}
                        InputProps={{
                            readOnly: true,
                        }}
                        color="success" focused
                    />
                
                </Grid>     
            </Grid>
            <br />
            <Typography variant="p" color="primary">Estado del Medicamento:</Typography>  
            <br />
            <br />
                  
            <Grid container spacing={2}>
                
                    <Grid item xs={6} lg={6} >
                    
                        <TextField sx={styleCampos}
                            id="estatus"
                            label="Estatus"
                            type='text'
                            defaultValue={estatus}
                            InputProps={{
                                readOnly: true,
                            }}
                            color="success" focused
                        />
                    </Grid>
                    <Grid item xs={6} lg={6} >
                    
                        <TextField sx={styleCampos}
                            id="fecha_vencimiento"
                            label="Fecha Vencimiento"
                            type='date'
                            defaultValue={fecha_vencimiento}
                            InputProps={{
                                readOnly: true,
                            }}
                            color="success" focused
                        />
                    </Grid>

            </Grid>
            <br />
            <Typography variant="p" color="primary">Más Información:</Typography>  
            <br />
            <br />
            <Grid container spacing={2}>
                
                    <Grid item xs={12} lg={6} >
                    
                        <TextField sx={styleCampos}
                            id="componente"
                            label="Componente Principal"
                            multiline
                            rows={5}
                            maxRows={10}
                            defaultValue={componente}
                            InputProps={{
                                readOnly: true,
                            }}
                            color="success" focused
                        />
                    </Grid>
                    <Grid item xs={12} lg={6} >
                    
                        <TextField sx={styleCampos}
                            id="observacion"
                            label="Observacion"
                            multiline
                            rows={5}
                            maxRows={10}
                            defaultValue={observacion}
                            InputProps={{
                                readOnly: true,
                            }}
                            color="success" focused
                        />
                    </Grid>

            </Grid>
            
        </Box>

        {/* <Box sx={{mt:1}}>
            <Button variant="contained" color="error" onClick={onClose}>
              Cerrar
            </Button>
        </Box> */}
    
    </>
  )
}

export default BodyDetalles