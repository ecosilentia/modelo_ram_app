import streamlit as st
import numpy as np
import matplotlib.pyplot as plt

# Título principal
st.title("Simulador de modelo RAM - Presión Sonora vs Distancia")

# Parámetros de entrada
frecuencia = st.slider("Frecuencia (Hz)", min_value=100, max_value=10000, value=1000, step=100)
presion_inicial = st.slider("Presión sonora inicial (dB re 1μPa)", min_value=100, max_value=220, value=180)
k = st.slider("Factor geométrico (k)", min_value=10, max_value=25, value=15)

# Umbrales de afectación
st.subheader("Umbrales de afectación")
umbral_peces = st.number_input("Umbral para peces (dB)", min_value=100, max_value=220, value=140)
umbral_mamiferos = st.number_input("Umbral para mamíferos marinos (dB)", min_value=100, max_value=220, value=160)

# Modelo RAM simplificado
distancia_km = np.linspace(0.01, 10, 500)
atenuacion_geom = 10 * k * np.log10(distancia_km)
absorcion_media = 0.1  # dB/km
atenuacion_abs = absorcion_media * distancia_km
nivel_presion = presion_inicial - atenuacion_geom - atenuacion_abs

# Gráfico
fig, ax = plt.subplots()
ax.plot(distancia_km, nivel_presion, label="Nivel de presión sonora")
ax.axhline(umbral_peces, color="green", linestyle="--", label="Umbral peces")
ax.axhline(umbral_mamiferos, color="red", linestyle="--", label="Umbral mamíferos marinos")
ax.set_xlabel("Distancia (km)")
ax.set_ylabel("Nivel de presión sonora (dB)")
ax.set_title("Simulación acústica (modelo RAM simplificado)")
ax.legend()
ax.grid(True)

# Mostrar gráfico en Streamlit
st.pyplot(fig)
