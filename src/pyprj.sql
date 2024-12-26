\c postgres;

drop database if exists pyprj_fnl;
create database pyprj_fnl;

\c pyprj_fnl;
\i part1.sql;

create or replace procedure pyprj_import() as $$
declare 
	name_list varchar[] = array[
			['personal_info', 'Personal_Data.tsv'], 
			['cards', 'Cards.tsv'],
			['transactions', 'Transactions.tsv'],
			['sku_group', 'Groups_SKU.tsv'], 
			['product_grid', 'SKU.tsv'], 
			['checks', 'Checks.tsv'], 
			['stores', 'Stores.tsv']];

	match varchar[];
begin
	foreach match slice 1 IN array name_list 
	loop
		execute format('call import(%L, %L, ''\t'', False)', match[1], match[2]);
	end loop;
end;
$$ language plpgsql;

call pyprj_import();

create or replace procedure pyprj_export() as $$
declare 
	name_list varchar[] = array[
			['personal_info', 'Personal_Data.tsv'], 
			['cards', 'Cards.tsv'],
			['transactions', 'Transactions.tsv'],
			['sku_group', 'Groups_SKU.tsv'], 
			['product_grid', 'SKU.tsv'], 
			['checks', 'Checks.tsv'], 
			['stores', 'Stores.tsv']];

	match varchar[];
begin
	foreach match slice 1 IN array name_list 
	loop
		execute format('call export(%L, %L, '','', False)', match[1], match[2]);
	end loop;
end;
$$ language plpgsql;

call pyprj_export();

--\i part2.sql;
--\i part3.sql;
--\i part5.sql;
