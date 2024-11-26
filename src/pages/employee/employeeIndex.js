import React, { useState } from "react";
import { Routes, Route } from "react-router-dom";
import Header from "../../components/Header/Header";
import Footer from "../../components/Footer/Footer";
import VerCliente from "../../components/VerCliente/VerCliente";
import VerClases from "../../components/Clases/VerClases/VerClases.js";
import PlanDetails from "../Planes/VerPlan";
import RutinaAdminIndex from "../../components/Rutina/RutinaAdminIndex";
import Payments from "../../components/Payments/Payments";
import Planes from "../Planes/Planes";
import { useAuth } from "../../context/RoleContext.js";
import { TicketeraChart } from "../../components/Graficos/Ticketeras.js";
import { ClientCreationChart } from "../../components/employeeG/EmployeeGraficos.js";
import { PlanesChart } from "../../components/Graficos/Planes.js";
import Relleno from "../../components/Relleno/Relleno.js";

function AdminPage() {
  const { user } = useAuth();
  
  // Estado para manejar la gráfica seleccionada
  const [selectedChart, setSelectedChart] = useState("Planes");

  // Función para renderizar la gráfica seleccionada
  const renderSelectedChart = () => {
    switch (selectedChart) {
      case "Planes":
        return <PlanesChart />;
      case "Cliente":
        return <ClientCreationChart />;
      case "Ticketeras":
        return <TicketeraChart />;
      default:
        return null;
    }
  };

  return (
    <>
      <Header />
      <Relleno/>
      <div style={{
        marginTop: "100px",
        marginBottom: "3%",
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        width: "100%",
        fontSize: "1.8rem"
      }}>
        <h2>Bienvenido, {user ? user.username : "Usuario"}</h2>

        {/* Menú Horizontal */}
        <div style={{
          display: "flex",
          justifyContent: "center",
          gap: "20px",
          margin: "20px 0"
        }}>
          {/* Botones para seleccionar la gráfica */}
          <button 
            onClick={() => setSelectedChart("Planes")}
            style={{
              padding: "10px 20px",
              backgroundColor: selectedChart === "Planes" ? "#2679f7" : "#f1f1f1",
              color: selectedChart === "Planes" ? "white" : "black",
              border: "none",
              borderRadius: "5px",
              cursor: "pointer",
              transition: "all 0.4s ease-in-out"
            }}
          >
            Planes
          </button>
          <button 
            onClick={() => setSelectedChart("Cliente")}
            style={{
              padding: "10px 20px",
              backgroundColor: selectedChart === "Cliente" ? "#2679f7" : "#f1f1f1",
              color: selectedChart === "Cliente" ? "white" : "black",
              border: "none",
              borderRadius: "5px",
              cursor: "pointer",
              transition: "all 0.4s ease-in-out"
            }}
          >
            Cliente
          </button>
          <button 
            onClick={() => setSelectedChart("Ticketeras")}
            style={{
              padding: "10px 20px",
              backgroundColor: selectedChart === "Ticketeras" ? "#2679f7" : "#f1f1f1",
              color: selectedChart === "Ticketeras" ? "white" : "black",
              border: "none",
              borderRadius: "5px",
              cursor: "pointer",
              transition: "all 0.4s ease-in-out"
            }}
          >
            Ticketeras
          </button>
        </div>

        {/* Renderizar la gráfica seleccionada */}
        <div style={{ width: "85%", maxWidth: "800px", marginTop: "20px" }}>
          {renderSelectedChart()}
        </div>
      </div>

      <Routes>
        <Route path="VerCliente" element={<VerCliente />} />
        {/* <Route path="VerProducto" element={<VerProducto />} /> */}        
        <Route path="VerClases" element={<VerClases />} />
        <Route path="/Planes/*" element={<Planes />} />
        <Route path="PlanDetails/:planId" element={<PlanDetails />} />
        <Route path="RutinaAdminIndex" element={<RutinaAdminIndex />} />
        <Route path="Payments" element={<Payments />} />
      </Routes>
      <Footer />
    </>
  );
}

export default AdminPage;