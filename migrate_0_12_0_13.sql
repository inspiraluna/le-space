-- update script le space after application start and scheme update of gorm

update shiro_user set username = 'admin',id=1 where id=2;
delete from shiro_user where id<>1;

delete from customer_shiro_user;
alter table customer_shiro_user auto_increment = 1;
alter table customer auto_increment = 1;
alter table shiro_user auto_increment = 2;
delete from customer;

SET FOREIGN_KEY_CHECKS = 0;
delete from bank_account;
alter table bank_account auto_increment = 1;

insert into bank_account (id,version,bicno,ibanno,account_no,account_owner,bank_name, bank_no,direct_debit_permission) select id,version,bicno,ibanno,account_no,account_owner,bank_name, bank_no,direct_debit_permission from contract;

insert into customer (
id,version,address_line1,address_line2,allow_publish_name_on_website,bank_account_id,city,company,country_id,
created_by_id,date_created,date_modified,fax,modified_by_id,
reverse_charge_system,reverse_charge_systemid,tel1,url,zip) select
id,version,address_line1,address_line2,allow_publish_name_on_website,id,city,company,38,
1, contract_start,now(),fax,1,
false,null,tel1,url,zip from contract;



alter table shiro_user drop full_name;
alter table shiro_user drop photo;
alter table shiro_user drop key email;

insert into customer_shiro_user select id,id from contract;

insert into shiro_user (
id,version,username,password_hash,enabled,email,birthday,created_by_id,date_created,date_modified,facebook_name,firstname,lastname,modified_by_id,occupation,salutation,tel_mobile,twitter_name)
select
id,version,id,email,true,email,birthday,created_by_id,contract_start,now(),facebook_name,firstname,lastname,1,occupation,salutation,tel_mobile,twitter_name from contract where id <> 1;

update contract set customer_id = id;

alter table customer add index FK24217FDEA96121CB (created_by_id), add constraint FK24217FDEA96121CB foreign key (created_by_id) references shiro_user (id);
alter table customer add index FK24217FDE514E78EC (modified_by_id), add constraint FK24217FDE514E78EC foreign key (modified_by_id) references shiro_user (id);
alter table customer_shiro_user add index FKA0BD245A22091DA0 (shiro_user_id), add constraint FKA0BD245A22091DA0 foreign key (shiro_user_id) references shiro_user (id);

update shiro_user set opt_out_iam_here_function=false;


-- überflüssige spalten aus conract löschen.!!! fehlt noch.