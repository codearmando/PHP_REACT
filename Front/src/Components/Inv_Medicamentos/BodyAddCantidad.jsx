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

  const [selectmedicamento,setSelectMedicamento] = useState(null)
  const [selectmedidamedicamento,setSelecMedidatMedicamento] = useState(null)
  const [selecpresentmedicamento,setSelecPresentMedicamento] = useState(null)
  const [listmedicamentos,setListMedicamentos] = useState([])
  const [listunidadmedidamedicamentos,setListUnidadMedidaMedicamentos] = useState([])
  const [listmedidamedicamentos,setListMedidaMedicamentos] = useState([])
  const [listPresentacionmedicamentos,setListPresentacionMedicamentos] = useState([])

  const [cantidad,setCantidad] = useState('')
  const [lote,setLote] = useState('')

  const List_Medicamentos=  () => {
    const url = "http://localhost/Farmacia_Alto_Costo/App/Medicamentos/ListMedicamento/table";
    AxiosGet(url,setListMedicamentos)
  };
  const List_UnidadMedida_Medicamentos=  () => {
    const url = "http://localhost/Farmacia_Alto_Costo/App/medicamentos/listUnidadMedida/table";
    AxiosGet(url,setListUnidadMedidaMedicamentos)
  };
  
  useEffect(() => {
    List_Medicamentos();
  }, []);
  useEffect(() => {
    List_UnidadMedida_Medicamentos();
  }, []);

  const detallesmedicamento = () =>{
    let valorselect = selectmedicamento
    let presentacionmedic= listunidadmedidamedicamentos.filter((item) =>
    item.FK_MEDICAMENTO === valorselect
    )

    document.getElementById("select-presentacion").value=null;
    setSelecPresentMedicamento('')
    setSelecPresentMedicamento(null)
    setListPresentacionMedicamentos([])
    setListPresentacionMedicamentos(presentacionmedic)

    console.log(selectmedicamento)
    console.log(selecpresentmedicamento)
  }
  
  const medidadasmedicamento = () =>{
    let valorselect = selecpresentmedicamento
    let unidadmedic = listunidadmedidamedicamentos.filter((item) =>
    item.FK_MEDICAMENTO === selectmedicamento &&
    item.PRESENT_MEDICAMENTO === valorselect
    )
    document.getElementById("select-presentacion").value=null;

    setListMedidaMedicamentos(unidadmedic)
    // setSelecMedidatMedicamento('')
    // setSelecMedidatMedicamento(null);
  }
  useEffect(() => {
    detallesmedicamento();
  }, [selectmedicamento]);
  useEffect(() => {
    medidadasmedicamento();
  }, [selecpresentmedicamento]);
  const handleMedicamentoChange = (e, newValue) => {
    setSelectMedicamento(newValue ? newValue.PK_MEDICAMENTO : null);
    
    setSelecPresentMedicamento([]);
    setSelecMedidatMedicamento([]);

    detallesmedicamento();
    medidadasmedicamento();
  };
  const Add_Cantidad= async () => {

    const cantidad_medicamento ={
      medicamento:selectmedicamento,
      cantidad:cantidad,
      lote:lote
    }
    // const url = "http://localhost/Farmacia_Alto_Costo/App/inv_Medicamento/inventario/InsertCantidad";
    // AxiosPost(url,cantidad_medicamento,`Nueva cantidad del Medicamento : ${cantidad_medicamento.medicamento} agregada`,tableData)
    // tableData()
  };
  
  const HandleSubmit = (e) =>{
    e.preventDefault()
    Add_Cantidad()
    // onClose()
    tableData()
    console.log(listPresentacionmedicamentos)
    
  }

  return (
    <>

      <Box component='form' id="form_count_medicamento" onSubmit={HandleSubmit}>
        <Grid container spacing={2}>
          <Grid item xs={12} md={4}>
            <Autocomplete sx={styleCampos}
              id="select-medicamento" 
              options={listmedicamentos}
              onChange={handleMedicamentoChange}
              getOptionLabel={(option) => option.NOMBRE_MEDICAMENTO}
              renderInput={(params) => <TextField {...params} label="Medicamento" variant="outlined" />}
            />
          </Grid>
          <Grid item xs={12} md={4}>
            <Autocomplete sx={styleCampos}
              id="select-presentacion" 
              defaultValue={selecpresentmedicamento}
              options={listPresentacionmedicamentos}
              onChange={(e, newValue) => {
                setSelecPresentMedicamento(newValue ? newValue.PRESENT_MEDICAMENTO  : null);
              }}
              getOptionLabel={(option) => option.PRESENT_MEDICAMENTO}
              renderInput={(params) => <TextField {...params} label="Unidad Medida" variant="outlined" />}
            />
          </Grid>
          <Grid item xs={12} md={4}>
            <Autocomplete sx={styleCampos}
              id="select-medida_medicamento" 
              options={listmedidamedicamentos}
              onChange={(e,newValue) => {
                setSelecMedidatMedicamento(newValue.UNIDAD_MEDIDA)

              }}
              getOptionLabel={(option) => option.UNIDAD_MEDIDA}
              renderInput={(params) => <TextField {...params} label="Unidad Medida" variant="outlined" />}
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