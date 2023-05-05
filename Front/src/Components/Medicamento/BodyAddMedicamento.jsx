import {Box,TextField,Button,Autocomplete, Grid, FormControl, Select, InputLabel, MenuItem, Typography} from "@mui/material";
import { useEffect, useState } from "react";
import {AxiosPost,AxiosGet} from '../../Helpers/FetchAxios/FetchAxios.jsx'
import '../../assets/Css/EstructuraForm.css'
const styleCampos ={
  width:'100%'
}


function BodyAddMedicamento({onClose,tableData}) {
  

  const [tipomedicamento, settipomedicamento] = useState([]);
  const [selecttipmedicamento,setSelectTipMedicamento] = useState([])
  
  const [medicamento, setMedicamento] = useState('')
  const [componentprinc, setComponentPrinc] = useState('')

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
  const tipo_medicamento = async () => {
    const url = "http://localhost/Farmacia_Alto_Costo/App/Medicamentos/Tipomedic/table";
    AxiosGet(url,settipomedicamento)
    
  };

  useEffect(() => {
    List_Medicamentos();
  }, []);
  useEffect(() => {
    tipo_medicamento();
  }, []);


  const campoMedicamento = (e) =>{
    const valorInputActualizado = e.target.value;
    const item_medicamento = listmedicamentos.some((item) => 
    item.NOMBRE_MEDICAMENTO == valorInputActualizado
    )
    console.log(item_medicamento)
    
    if (item_medicamento === true){
      setError({
        error:true,
        message: 'Este medicamento ya existe',
      })
    }else {
      setError({
        error:false,
        message: 'Nuevo Medicamento',
        color:'success',
        fucosed:true
        
      })
      console.log('no existe. Nuevo medicamento')
    }
    setMedicamento(valorInputActualizado)
  }
  
  // --------------------------------
  // -----------ADD MEDICAMENTOS-------
  // -------------
  
  const addMedicamento = async () =>{

    const objmedicamento = {
      medicamento:medicamento,
      tipomedicamento:selecttipmedicamento,
      componentprinc:componentprinc,

    }
    console.log(objmedicamento)
    const url = 'http://localhost/Farmacia_Alto_Costo/App/Medicamentos/Medicamento/insert'
    AxiosPost(url,objmedicamento,`Medicamento: ${objmedicamento.medicamento}`,tableData)
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

      <Box component="form" onSubmit={HandleSubmit}>
        
        <Grid container spacing={2} sx={{py:1}}>
          <Grid item xs={12} md={6}>
            <TextField sx={styleCampos}
              id="medicamento1"
              label="Nombre medicamento"
              type="text"
              value={medicamento}
              onChange={campoMedicamento}
              error={error.error}
              helperText ={error.message}
              color={error.color}
              focused={error.fucosed}
            />
          </Grid>
          <Grid item xs={12} md={6}>
              <Autocomplete sx={styleCampos}
                id="combo-box-demo" 
                options={tipomedicamento}
                onChange={(e,newValue) => {
                  setSelectTipMedicamento(newValue.PK_TIPO_MEDICAMENTO)
                }}
                getOptionLabel={(option) => option.TIPO_MEDICAMENTO}
                renderInput={(params) => <TextField {...params} label="Tipo de Medicamento" variant="outlined" />}
              />
          </Grid>
          <Grid item xs={12} >
            <TextField sx={styleCampos}
              id="componente_pirnc"
              label="Componente Pirncipal"
              multiline
              minRows={5}
              maxRows={10}
              value={componentprinc}
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
   
        
      </Box>

     
    </>
  );
}

export default BodyAddMedicamento;
