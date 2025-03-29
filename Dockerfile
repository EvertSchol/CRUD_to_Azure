# Start met een officiële Python-image
FROM python:3.10-slim

# Zet de werkdirectory in de container
WORKDIR /app

# Kopieer de requirements.txt naar de container
COPY requirements.txt /app/

# Upgrade pip naar de laatste versie
RUN python3 -m pip install --upgrade pip

# Installeer de afhankelijkheden
RUN pip install -r requirements.txt

# Kopieer de inhoud van je project naar de container
COPY . /app/

# Maak een virtuele omgeving aan
RUN python3 -m venv venv

# Activeer de virtuele omgeving en voer de Flask-setup uit
RUN . venv/bin/activate && \
    export FLASK_APP=crudapp.py && \
    flask db init && \
    flask db migrate -m "entries table" && \
    flask db upgrade

# Stel de poort in die Flask zal gebruiken
EXPOSE 80

# Start de Flask-applicatie op poort 80
CMD ["flask", "run", "--host=0.0.0.0", "--port=80"]
