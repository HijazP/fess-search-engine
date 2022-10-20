cd ihatetobudget
docker compose run --rm ihatetobudget pipenv run python manage.py migrate
docker compose run --rm ihatetobudget pipenv run python manage.py createsuperuser