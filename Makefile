build:
	docker-compose build

run: build
	docker-compose up -d

stop:
	docker-compose down

logs:
	docker-compose logs

card_db:
	docker exec -it api-gateway_postgres-cards_1 -U user -d card_db

user_db:
	docker exec -it api-gateway_postgres-auth-1 psql -U user -d user_db

history_db:
	docker exec -it api-gateway_postgres-history_1 psql -U user -d history_db

account_db:
	docker exec -it api-gateway_postgres-accounts_1 psql -U user -d account_db

analysis_db:
	docker exec -it api-gateway_mongo-analysis_1 mongosh
