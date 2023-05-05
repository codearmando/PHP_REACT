import {Box,TextField,Button,Autocomplete, Grid, FormControl, Select, InputLabel, MenuItem, Typography} from "@mui/material";
import { useEffect, useState } from "react";
import {AxiosPost,AxiosGet} from '../../Helpers/FetchAxios/FetchAxios.jsx'
import '../../assets/Css/EstructuraForm.css'
const styleCampos ={
  width:'100%'
}


function BodyAddMedicamento({onClose,tableData}) {
  
  const [tipoalmacen, setTipoAlmacen] = useState([])
  const [tipomedicamento, settipomedicamento] = useState([]);
  const [presentacion, setPresentacion] = useState('')
  const [estatus, setEstatus] = useState('')
  const [selectmedicamento,setSelectMedicamento] = useState([])
  const [selectalmacen,setSelectAlmacen] = useState([])
  const [selectpresentacion,setSelectPresentacion] = useState([])
  const [selectunidadmedida,setSelectUnidadMedida] = useState('')
  const [selectestatus,setSelectEstatus] = useState([])
  
  const [nromedida, setNroMedida] = useState('')
  const [cantidad, setCantidad] = useState('')
  const [lote, setLote] = useState('')
  const [fechavencimiento, setFechaVencimiento] = useState('')
  const [componentprinc, setComponentPrinc] = useState('')
  const [observacion, setObservacion] = useState('')


  const [listmedicamentos,setListMedicamentos] = useState([])
  const [error,setError] = useState({
    error : false,
    message : '',
    color:null,
    fucosed: null
  })

  const List_Medicamentos=  () => {
    const url = "http://localhost/Farmacia_Alto_Costo/App/Medicamentos/ListMedicamento/table";
    AxiosGet(url,setListMedicamentos)
  };
  const tipo_almacen= async () => {
    const url = "http://localhost/Farmacia_Alto_Costo/App/inv_Medicamento/Tipoalmacen/table";
    AxiosGet(url,setTipoAlmacen)
  };
  const Presentacion= async () => {
    const url = "http://localhost/Farmacia_Alto_Costo/App/inv_Medicamento/presentacion/table";
    AxiosGet(url,setPresentacion)
    
  };
  const Estatus= async () => {
    const url = "http://localhost/Farmacia_Alto_Costo/App/inv_Medicamento/estatus/table";
    AxiosGet(url,setEstatus)
    
  };
  useEffect(() => {
    List_Medicamentos();
  }, []);
  useEffect(() => {
    tipo_almacen();
  }, []);
  useEffect(() => {
    Presentacion();
  }, []);
  useEffect(() => {
    Estatus();
  }, []);
  
  // --------------------------------
  // -----------ADD MEDICAMENTOS-------
  // -------------
  
  const addMedicamento = async () =>{

    const objmedicamento = {
      pk_medicamento:selectmedicamento.pk_medicamento,
      medicamento:selectmedicamento.name_medicamento,
      presentacion:selectpresentacion,
      almacen:selectalmacen,
      unidadmedida:nromedida +'-'+ selectunidadmedida,
      cantidad:cantidad,
      lote:lote,
      estatus:selectestatus,
      fechavencimiento:fechavencimiento.split(/[-/]/).reverse().join("/"),
      observacion:observacion,
    }
    console.log(objmedicamento)
    const url = 'http://localhost/Farmacia_Alto_Costo/App/inv_Medicamento/inventario/insert'
    AxiosPost(url,objmedicamento,`Medicamento: ${objmedicamento.medicamento} de ${objmedicamento.unidadmedida}`,tableData)
    tableData()
  }

  const HandleSubmit = (e) => {
    e.preventDefault()
    addMedicamento()
    onClose()
    tableData()
  }
  
  
  return (
    <>
      {/* sx={{width:'1200px'}} */}
      <Box component="form"  onSubmit={HandleSubmit}>
  
      <Typography variant="p" color="primary">Medicamento y sus detalles:</Typography>
      
      <Grid container spacing={2} sx={{py:1}}>
        <Grid item xs={12} md={3.5}>
          <Autocomplete sx={styleCampos}
            id="combo-box-demo" 
            options={listmedicamentos}
            onChange={(e,newValue) => {
              setSelectMedicamento({
                  pk_medicamento: newValue.PK_MEDICAMENTO,
                  name_medicamento: newValue.NOMBRE_MEDICAMENTO
                })
            }}
            getOptionLabel={(option) => option.NOMBRE_MEDICAMENTO}
            renderInput={(params) => <TextField {...params} label="Medicamento" variant="outlined" />}
          />
        </Grid>
          <Grid item xs={12} md={4.5}>
            <Autocomplete sx={styleCampos}
              id="combo-box-demo" 
              options={presentacion}
              onChange={(e,newValue) => {
                setSelectPresentacion(newValue.PK_PRES_MEDICAMENTO)
              }}
              getOptionLabel={(option) => option.PRESENT_MEDICAMENTO}
              renderInput={(params) => <TextField {...params} label="Presentacion medicamento" variant="outlined" />}
            />
          </Grid>
          <Grid item xs={12} md={4}>
            <Autocomplete sx={styleCampos}
              id="combo-box-demo" 
              options={tipoalmacen}
              onChange={(e,newValue) => {
                setSelectAlmacen(newValue.PK_ALMACEN)
              }}
              getOptionLabel={(option) => option.TIPO_ALMACEN}
              renderInput={(params) => <TextField {...params} label="Tipo de Almacen" variant="outlined" />}
            />
          </Grid>
        
      </Grid> 
      {/* <hr /> */}

      <Typography variant="p" color="primary" >Unidad de Medida y Cantidad:</Typography>

      <Grid container spacing={2} sx={{py:1,pb:1}}>
        <Grid item xs={12} md={3} >
          <TextField sx={styleCampos}
            id="nro_medida"
            label="Nro medida"
            type="number"
            value={nromedida}
            onChange={(e) => setNroMedida(e.target.value)}
            // placeholder="ejem:4"
            // focused
          />
        </Grid>
        <Grid item xs={12} md={3} >
          <FormControl fullWidth>
            <InputLabel id="demo-simple-select-label">Unidad de Medida</InputLabel>
            <Select sx={styleCampos}
              labelId="demo-simple-select-label"
              id="demo-simple-select"
              value={selectunidadmedida}
              label="Tipo Unidad medida"
              onChange={(e) => setSelectUnidadMedida(e.target.value)}
            >
              <MenuItem value='miligramos(mg)'>miligramos(mg)</MenuItem>
              <MenuItem value='mililitros(ml)'>mililitros(ml)</MenuItem>
              <MenuItem value='gramos(g)'>gramos(g)</MenuItem>
              <MenuItem value='litros(l)'>litros(l)</MenuItem>
            </Select>
          </FormControl>
       
        </Grid>
        <Grid item xs={12} md={3} >
          <TextField sx={styleCampos}
            id="cantidad"
            label="cantidad Medicameto"
            type="number"
            value={cantidad}
            onChange={(e) => setCantidad(e.target.value)}
          
          />
        </Grid>
        <Grid item xs={12} md={3} >
          <TextField sx={styleCampos}
            id="lote" 
            label="Cantidad de lotes"
            type="number"
            value={lote}
            onChange={(e) => setLote(e.target.value)}
          />
    
        </Grid>
        
      </Grid>
      {/* <hr /> */}
      <Typography variant="p" color="primary" >Más Información:</Typography>
      <Grid container spacing={2} sx={{py:1,pb:1}}>
        <Grid item xs={12} md={6} >
          <TextField sx={styleCampos}
            id="fecha_vencimiento"
            label="Fecha de vencimiento"
            type="date"
            value={fechavencimiento}
            onChange={(e) => setFechaVencimiento(e.target.value)}
            focused
          />
        </Grid>
        <Grid item xs={12} md={6}>
          <Autocomplete sx={styleCampos}
            id="combo-box-demo" 
            options={estatus}
            onChange={(e,newValue) => {
              setSelectEstatus(newValue.PK_ESTATUS)
            }}
            getOptionLabel={(option) => option.ESTATUS}
            renderInput={(params) => <TextField {...params} label="Estatus Medicamento" variant="outlined" />}
          />
        </Grid>
        <Grid item xs={12} md={12}>
          <TextField sx={styleCampos}
            id="observacion"
            label="Observacion"
            placeholder='NOTA: la observación es si algunos medicamentos a registrar no estarán en su almacenamiento correspondiente por "x" motivo. De lo contrario ingresar : NINGUNA POR AHORA'
            multiline
            minRows={5}
            maxRows={10}
            value={observacion}
            onChange={(e) => setObservacion(e.target.value)}
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
   
        
      </Box>

     
    </>
  );
}

export default BodyAddMedicamento;
