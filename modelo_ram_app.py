# %% Importar librerías
import streamlit as st
import numpy as np
import matplotlib.pyplot as plt

# %% Título
st.title("Simulación de Nivel de Presión Sonora (modelo simplificado RAM)")

# %% Parámetros de entrada
frecuencia = st.slider("Frecuencia (Hz)", min_value=30, max_value=5000, step=10, value=500)
distancia_max_km = st.slider("Distancia máxima (km)", min_value=1, max_value=20, step=1, value=10)
fuente_db = st.slider("Nivel de fuente sonora (dB)", min_value=100, max_value=240, step=1, value=180)
factor_k = st.slider("Factor geométrico (k)", min_value=10, max_value=30, step=1, value=20)
umbral_usuario = st.number_input("Umbral de afectación (dB)", min_value=0.0, max_value=200.0, value=120.0, step=1.0)

# %% Cálculo
distancias_km = np.linspace(0.1, distancia_max_km, 500)
atenuacion = factor_k * np.log10(distancias_km)  # atenuación geométrica
absorcion = 0.001 * frecuencia * distancias_km   # atenuación por absorción simplificada
nivel_presion = fuente_db - atenuacion - absorcion

# %% Gráfico
fig, ax = plt.subplots()
ax.plot(distancias_km, nivel_presion, label="Nivel de presión sonora", color='blue')
ax.axhline(umbral_usuario, color='red', linestyle='--', label=f'Umbral de afectación ({umbral_usuario} dB)')

ax.set_xlabel("Distancia (km)")
ax.set_ylabel("Nivel de presión sonora (dB)")
ax.set_title(f"Simulación a {frecuencia} Hz")
ax.grid(True)
ax.legend()

st.pyplot(fig)

