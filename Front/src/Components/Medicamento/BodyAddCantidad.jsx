import { ReactDOM } from "react"
import { Box,TextField,Button,Autocomplete, IconButton, Grid } from "@mui/material";
import React, { useState, useEffect } from 'react'
import axios from "axios";

import ControlPointTwoToneIcon from '@mui/icons-material/ControlPointTwoTone';
import HighlightOffTwoToneIcon from '@mui/icons-material/HighlightOffTwoTone';
// import  {AxiosPost}  from "../../assets/JS/FetchAxios.js";
import {AxiosPost,AxiosGet} from '../../Helpers/FetchAxios/FetchAxios.jsx'

const styleCampos ={
  width:'100%'
}

function BodyAddCantidad({onClose,tableData}) {

  const [selectmedicamento,setSelectMedicamento] = useState([])
  const [listmedicamentos,setListMedicamentos] = useState([])

  const [cantidad,setCantidad] = useState('')
  const [lote,setLote] = useState('')

  const List_Medicamentos=  () => {
    const url = "http://localhost/Farmacia_Alto_Costo/App/inv_Medicamento/medicamentos/table";
    AxiosGet(url,setListMedicamentos)
  };
  
  useEffect(() => {
    List_Medicamentos();
  }, []);
  
  const Add_Cantidad= async () => {

    const cantidad_medicamento ={
      medicamento:selectmedicamento,
      cantidad:cantidad,
      lote:lote
    }
    const url = "http://localhost/Farmacia_Alto_Costo/App/inv_Medicamento/inventario/InsertCantidad";
    AxiosPost(url,cantidad_medicamento,`Nueva cantidad del Medicamento : ${cantidad_medicamento.medicamento} agregada`,tableData)
    tableData()
  };
  
  const HandleSubmit = (e) =>{
    e.preventDefault()
    Add_Cantidad()
    onClose()
    tableData()
  }

  return (
    <>

      <Box component='form' id="form_count_medicamento" onSubmit={HandleSubmit}>
        <Grid container spacing={2}>
          <Grid item xs={12} md={4}>
          <Autocomplete sx={styleCampos}
            id="combo-box-demo" 
            options={listmedicamentos}
            onChange={(e,newValue) => {
              setSelectMedicamento(newValue.PK_MEDICAMENTO)
            }}
            getOptionLabel={(option) => option.NOMBRE_MEDICAMENTO}
            renderInput={(params) => <TextField {...params} label="Medicamento" variant="outlined" />}
          />
          </Grid>
          <Grid item xs={12} md={4}>
            <TextField sx={styleCampos}
              id="cantidad"
              label="cantidad de Medicameto"
              type="number"
              value={cantidad}
              onChange={(e) => setCantidad(e.target.value)}
            />
          </Grid>
          <Grid item xs={12} md={4}>
            <TextField sx={styleCampos}
              id="lote"
              label="Cantidad de lotes"
              type="number"
              value={lote}
              onChange={(e) => setLote(e.target.value)}
            />
          </Grid>
          <Grid item xs={12} md={2}>
            <IconButton aria-label="add" color="success" >
              <ControlPointTwoToneIcon fontSize="inherit" />
            </IconButton>
            <IconButton aria-label="add" color="warning" onClick={() => console.log('delete')}>
              <HighlightOffTwoToneIcon fontSize="inherit" />
            </IconButton>
          </Grid>
        </Grid>

        <Box 
            sx={{mt:2,float:'right'}}
          >
          <Button type="submit" variant="contained" color="primary"sx={{mr:2}}>
            Registrar
          </Button>
          <Button variant="contained" color="error" onClick={onClose}>
            Cancelar
          </Button>
        </Box>
      </Box>
      {/* <p>selecicon: {selectmedicamento}</p> */}
           
    </>
  )
}

export default BodyAddCantidad