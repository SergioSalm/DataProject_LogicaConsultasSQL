--2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.
SELECT "title" AS "pelicula"  --,"rating"
FROM "film" AS F
WHERE "rating" = 'R'

 --3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40
SELECT concat("first_name" , ' ' , "last_name") AS "nombre_actor" --,"actor_id"
FROM "actor" AS A
WHERE "actor_id" BETWEEN 30 AND 40

--4. Obtén las películas cuyo idioma coincide con el idioma original.
SELECT "film_id", "title" AS "pelicula" --, "language_id", "original_language_id"
FROM "film" AS F 
WHERE "language_id" = "original_language_id"

--5. Ordena las películas por duración de forma ascendente.
SELECT title AS "pelicula" , length AS "duracion"
FROM "film" AS F 
ORDER BY length ASC

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
SELECT concat("first_name" , ' ' , "last_name") AS "nombre_actor"
FROM "actor" AS A
WHERE "last_name" ILIKE '%Allen%' --ponemos el ILIKE porque en la BBDD está todo en mayúsculas

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.
SELECT "rating" AS "clasificacion", count("film_id") AS "numero_peliculas" 
FROM "film" AS F
GROUP BY "rating"

--8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film. (3*60 = 180)
SELECT "title" AS "pelicula" --, "rating", "length" 
FROM "film" AS F 
WHERE "rating" = 'PG-13' OR "length" > 180 

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT VARIANCE("replacement_cost") AS "variabilidad_reemplazar_peliculas" 
FROM "film" AS F


--10. Encuentra la mayor y menor duración de una película de nuestra BBDD
SELECT  max("length") AS "mayor_duracion"  ,min("length") AS "menor_duracion" 
FROM "film" AS F 

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT "amount" AS "importe_antepenultimo_alquiler"
FROM "payment" AS P
WHERE "rental_id" IN (
	SELECT "rental_id" --Buscar el antepenúltimo registro en la tabla de alquileres (rental)
	FROM "rental" AS R
	ORDER BY "rental_date"  DESC
	LIMIT 1
	OFFSET 2)

--12. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC- 17ʼ ni ‘Gʼ en cuanto a su clasificación.
SELECT "title" AS "pelicula" --, "rating"
FROM "film" AS F 
WHERE "rating" not IN ('G', 'NC-17')

--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
SELECT "rating" AS "clasificacion", avg("length") AS "promedio_duracion" 
FROM "film" AS F
GROUP BY "rating"
 
--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
SELECT "title" AS "pelicula" --,"length" 
FROM "film" AS F 
WHERE "length" > 180 

--15. ¿Cuánto dinero ha generado en total la empresa?
SELECT sum("amount") AS "dinero_generado"
FROM "payment" AS P 
 
--16. Muestra los 10 clientes con mayor valor de id.
SELECT "customer_id"
FROM "customer" AS C
ORDER BY "customer_id" desc
LIMIT 10
 
--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.
SELECT  concat("first_name" , ' ' , "last_name") AS "nombre_actor"
FROM "actor" AS A
WHERE "actor_id" IN (
	SELECT "actor_id" 
	FROM "film_actor" AS FA
	JOIN "film" AS F
	ON FA.film_id = F.film_id
	AND F."title" = 'EGG IGBY')	
 
--¿?18. Selecciona todos los nombres de las películas únicos.

 
--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.
SELECT "title", "film_id", "length" 
FROM "film"
WHERE "film_id" IN (
	SELECT "film_id"
	FROM "film_category" AS FC
	JOIN "category" AS C
	ON FC."category_id" = c."category_id"
	AND C."name" = 'Comedy') --Las comendias tiene el nombre 'Comedy' en la tabla category
AND film."length" > 180
 
--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT "categoria", avg("media_peliculas")
FROM (SELECT f."film_id", fc."category_id" AS "categoria", f."length" as "media_peliculas"
        FROM film AS f 
        JOIN film_category AS fc 
        ON fc."film_id" = f."film_id") 
GROUP BY "categoria"
HAVING avg("media_peliculas") > 110

--21. ¿Cuál es la media de duración del alquiler de las películas?
SELECT AVG(r."return_date" - "rental_date") AS duracion_media_alquiler
FROM "rental" r 

--¿?22. Crea una columna con el nombre y apellidos de todos los actores y actrices.


--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
SELECT date_trunc('day', "rental_date") AS DIA, count("rental_id") AS numero_alquiler
FROM "rental"
GROUP BY DATE_TRUNC('day', "rental_date")
ORDER BY "numero_alquiler" DESC


--24. Encuentra las películas con una duración superior al promedio.
SELECT "title", "length"
FROM "film" AS f
WHERE "length" > (
	SELECT AVG("length") AS media 
	FROM "film") --La media es de 115.272
ORDER BY "length"


--25. Averigua el número de alquileres registrados por mes.
SELECT  to_char("rental_date", 'mm/yyyy') AS mes, count("rental_id") as numero_alquiler
FROM "rental"
GROUP BY mes
ORDER BY numero_alquiler DESC


--¿Salen nulos?26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
SELECT  AVG("total_pagado"), STDDEV("total_pagado"), VARIANCE("total_pagado") 
FROM (
	SELECT sum("amount") AS "total_pagado"
	FROM "payment" AS P) AS "ventas_agrupadas"


--¿?27. ¿Qué películas se alquilan por encima del precio medio?
-- ¿sería la medía de las películas? Porque hay películas que unas veces se alquilan por encima de la media y otras veces por debajo
SELECT "title"--, P."amount" 
FROM "film" AS F
JOIN "inventory" AS I
ON F."film_id" = I."film_id"
JOIN "rental" AS R
ON I."inventory_id" = R."inventory_id"
JOIN "payment" AS P
ON R."rental_id" = P."rental_id"
AND P."amount" < (
	SELECT AVG("amount") 
	FROM "payment") --La media es de 4.20066
GROUP BY "title" 	

--FICTION CHRISTMAS se alquila por 0.99 y por 4.99
SELECT "amount" 
FROM "payment" AS p
JOIN rental AS R
ON p.RENTAL_ID  = r.RENTAL_ID 
JOIN INVENTORY AS I 
ON i.INVENTORY_ID  = r.INVENTORY_ID 
JOIN FILM AS F 
ON f.FILM_ID  = i.FILM_ID 
AND f.TITLE  = 'FICTION CHRISTMAS'


--28. Muestra el id de los actores que hayan participado en más de 40 películas.
SELECT "actor"
FROM (
    SELECT "actor_id" AS "actor", count("film_id") as "num_peliculas"
    FROM film_actor AS fa 
    GROUP BY "actor_id")
WHERE "num_peliculas" > 40

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
SELECT f."title", count("pelicula") 
FROM (
	SELECT i."film_id" AS "pelicula" --seleccionamos las películas que están disponibles en el inventario
    FROM "inventory" AS i 
    RIGHT JOIN "rental" AS r 
	ON r."inventory_id" = i."inventory_id"
    WHERE "return_date" < now()) as inventario_disponible --suponemos que si la fecha de retorno es inferior al dia de hoy. Entran los que tengan valor nulo también.
RIGHT JOIN "film" AS f 
ON f."film_id" = inventario_disponible."pelicula"
GROUP BY f."title"


--30. Obtener los actores y el número de películas en las que ha actuado.
SELECT a."actor_id" ,a."first_name" , a."last_name" , peliculas_actor."numero_peliculas"
FROM (
	SELECT fa."actor_id", count(fa."film_id") AS "numero_peliculas"
   	FROM  "film_actor" AS fa 
   	GROUP BY "actor_id") AS peliculas_actor
RIGHT JOIN "actor" AS a 
ON a."actor_id" = peliculas_actor."actor_id"

--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
SELECT f."title" as "pelicula", string_agg(concat(a."first_name", ' ',a."last_name"),' -- ') AS "actores"
FROM "film" AS f 
LEFT JOIN "film_actor" AS fa 
ON f."film_id" = fa."film_id" 
LEFT JOIN "actor" AS a 
ON fa."actor_id" = a."actor_id"
GROUP BY f."title"

--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
SELECT concat(a."first_name", ' ',a."last_name") AS "actor", string_agg(f."title",' -- ') AS "peliculas"
FROM "actor" AS a 
LEFT JOIN "film_actor" AS fa 
ON a."actor_id"	= fa."actor_id"
LEFT JOIN "film" AS f 
ON  fa."film_id" = f."film_id"
GROUP BY a."actor_id"


--¿todos los registros de alquiler para cada película? 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
SELECT 

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
SELECT total_gastado_cliente."customer_id", c."first_name", c."last_name", total_gastado_cliente."total_gastado"
FROM (
	SELECT  p."customer_id", sum(p."amount") AS total_gastado
	FROM "payment" AS P 
	GROUP BY p."customer_id"
	ORDER BY total_gastado DESC
	LIMIT 5) AS total_gastado_cliente
JOIN "customer" AS C
ON c."customer_id" = total_gastado_cliente."customer_id"
ORDER BY total_gastado_cliente."total_gastado" DESC

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
SELECT a."actor_id", a."first_name"
FROM "actor" AS a
WHERE a."first_name" = 'JOHNNY'

--36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
SELECT a."first_name" AS "Nombre", a."last_name" AS "Apellido"
FROM "actor" AS a

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
--38. Cuenta cuántos actores hay en la tabla “actorˮ.
--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
--40. Selecciona las primeras 5 películas de la tabla “filmˮ.
--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
--45. Encuentra los actores que han participado en películas de la categoría 'Action'.
--46. Encuentra todos los actores que no han participado en películas.
--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
--48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.
--49. Calcula el número total de alquileres realizados por cada cliente.
--50. Calcula la duración total de las películas en la categoría 'Action'.
--51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.
--52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.
--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido.
 
--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.
--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.
--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.
--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
--62. Encuentra el número de películas por categoría estrenadas en 2006.
--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

