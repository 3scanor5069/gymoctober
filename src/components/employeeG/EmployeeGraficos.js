import React, { useState, useEffect } from 'react';
import ReactECharts from 'echarts-for-react';
import './employeeGraficos.css';

const EmployeeGraficos = () => {
  const [clientOption, setClientOption] = useState({});
  const [activityOption, setActivityOption] = useState({});
  const [ratingOption, setRatingOption] = useState({});

  useEffect(() => {
    fetchClientData();
    setupActivityChart();
    setupRatingChart();
  }, []);

  const fetchClientData = async () => {
    try {
      const response = await fetch('http://localhost:3005/client');
      const data = await response.json();
      const processedData = processClientData(data);
      updateClientChartOption(processedData);
    } catch (error) {
      console.error('Error fetching client data:', error);
    }
  };

  const processClientData = (data) => {
    const sortedData = data.sort((a, b) => new Date(a.fechaCreacion) - new Date(b.fechaCreacion));
    const cumulativeData = [];
    let totalClients = 0;

    sortedData.forEach((client) => {
      totalClients += 1;
      const date = new Date(client.fechaCreacion);
      cumulativeData.push([+date, totalClients]);
    });

    return cumulativeData;
  };

  const updateClientChartOption = (processedData) => {
    setClientOption({
      tooltip: {
        trigger: 'axis',
        position: (pt) => [pt[0], '10%'],
        formatter: (params) => {
          const date = new Date(params[0].value[0]);
          return `Fecha: ${date.toLocaleString()}<br/>Total Clientes: ${params[0].value[1]}`;
        },
      },
      title: {
        left: 'center',
        text: 'Crecimiento de Empleados',
      },
      xAxis: {
        type: 'time',
        boundaryGap: false,
      },
      yAxis: {
        type: 'value',
        boundaryGap: [0, '100%'],
      },
      series: [
        {
          name: 'Empleados Acumulados',
          type: 'line',
          smooth: true,
          symbol: 'none',
          areaStyle: {},
          data: processedData,
        },
      ],
    });
  };

  const setupActivityChart = () => {
    setActivityOption({
      tooltip: { trigger: 'axis' },
      legend: { data: ['Ciclismo', 'Correr', 'Caminar'] },
      xAxis: { type: 'category', data: ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'] },
      yAxis: { type: 'value' },
      series: [
        {
          name: 'Ciclismo',
          type: 'line',
          data: [2, 3, 5, 8, 6, 2, 3],
        },
        {
          name: 'Correr',
          type: 'line',
          data: [1, 2, 3, 4, 3, 1, 2],
        },
        {
          name: 'Caminar',
          type: 'line',
          data: [3, 4, 3, 2, 1, 3, 4],
        },
      ],
    });
  };

  const setupRatingChart = () => {
    setRatingOption({
      tooltip: { trigger: 'item' },
      legend: { orient: 'vertical', left: 'left' },
      series: [
        {
          name: 'Rating Actividades',
          type: 'pie',
          radius: ['40%', '70%'],
          data: [
            { value: 25, name: 'Correr' },
            { value: 20, name: 'Nadar' },
            { value: 30, name: 'Ciclismo' },
            { value: 25, name: 'Caminar' },
          ],
        },
      ],
    });
  };

  return (
    <div className="dashboard">
      <h1 className="dashboard-title">Dashboard Employee</h1>
      <div className="dashboard-cards">
        <div className="card">
          <h3>Heart Rate</h3>
          <p>96 bpm</p>
        </div>
        <div className="card">
          <h3>Calories Burned</h3>
          <p>360 kcal</p>
        </div>
        <div className="card">
          <h3>Steps</h3>
          <p>1.2k steps</p>
        </div>
        <div className="card">
          <h3>Distance</h3>
          <p>3.8 km</p>
        </div>
      </div>
      <div className="charts-container">
        <ReactECharts option={clientOption} style={{ height: '400px', width: '100%' }} />
        <ReactECharts option={activityOption} style={{ height: '400px', width: '100%' }} />
        <ReactECharts option={ratingOption} style={{ height: '400px', width: '100%' }} />
      </div>
    </div>
  );
};

export default EmployeeGraficos;
