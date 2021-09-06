drop database if exists primjer;
create database primjer;
use primjer;

create table decko(
sifra int not null primary key auto_increment,
prviputa datetime,
modelnaocala varchar(41),
nausnica int,
zena int not null
);

create table zena(
sifra int not null primary key auto_increment,
novcica decimal(14,8) not null,
narukvica int not null,
dukserica varchar(40) not null,
haljina varchar(30),
hlace varchar(32),
brat int not null
);

create table brat(
sifra int not null primary key auto_increment,
nausnica int not null,
treciputa datetime not null,
narukvica int not null,
hlace varchar(31),
prijatelj int
);

create table prijatelj(
sifra int not null primary key auto_increment,
haljina varchar(35),
prstena int not null,
introvertno bit,
stilfrizura varchar(36) not null
);

create table prijateljostavljena(
  sifra int not null primary key auto_increment,
  prijatelj int not null,
  ostavljena int not null
);

create table ostavljena(
sifra int not null primary key auto_increment,
prviputa datetime not null,
kratkamajica varchar(39) not null,
drugiputa datetime,
marka decimal(14,10)
);

create table svekrva(
sifra int not null primary key auto_increment,
hlace varchar(48) not null,
suknja varchar(42) not null,
ogrlica int not null,
treciputa datetime not null,
dukserica varchar(32) not null,
narukvica int not null,
punac int 
);

create table punac(
sifra int not null primary key auto_increment,
ekstrovertno bit not null,
suknja varchar(30) not null,
majica varchar(44) not null,
prviputa datetime not null
);

alter table svekrva add foreign key(punac) references punac(sifra);
alter table decko add foreign key(zena) references zena(sifra);
alter table prijateljostavljena add foreign key(prijatelj) references prijatelj(sifra);
alter table prijateljostavljena add foreign key(ostavljena) references ostavljena(sifra);
alter table zena add foreign key(brat) references brat(sifra);
alter table brat add foreign key(prijatelj) references prijatelj(sifra);

insert into brat (nausnica,treciputa,narukvica) values (20,'2015-01-09',5);
insert into brat (nausnica,treciputa,narukvica) values (26,'2018-12-13',7);
insert into brat (nausnica,treciputa,narukvica) values (10,'2020-11-09',15);

insert into zena (novcica,narukvica,dukserica,brat) values (110.25,1,'nike',1);
insert into zena (novcica,narukvica,dukserica,brat) values (170.35,1,'adidas',2);
insert into zena (novcica,narukvica,dukserica,brat) values (150.55,1,'puma',3);

insert into prijatelj (prstena,stilfrizura) values (10,'plava');
insert into prijatelj (prstena,stilfrizura) values (7,'crna');
insert into prijatelj (prstena,stilfrizura) values (25,'plava');

insert into ostavljena (prviputa,kratkamajica) values ('2019-01-01','nike');
insert into ostavljena (prviputa,kratkamajica) values ('2016-01-01', 'adidas');
insert into ostavljena (prviputa,kratkamajica) values ('2015-01-01', 'puma');

insert into prijateljostavljena(prijatelj,ostavljena) values (1,2);
insert into prijateljostavljena(prijatelj,ostavljena) values (2,3);
insert into prijateljostavljena(prijatelj,ostavljena) values (2,1);

update svekrva set suknja='Osijek';

delete from decko where modelnaocala like '%ab%';

select a.drugiputa, f.zena, e.narukvica 
from ostavljena a 
inner join prijateljostavljena b on a.sifra=b.ostavljena 
inner join prijatelj c on c.sifra=b.prijatelj 
inner join brat d on d.prijatelj=c.sifra
inner join zena e on e.brat=d.sifra 
inner join decko f on e.sifra=f.zena 
where d.treciputa is not null and c.prstena like 219 
order by e.narukvica desc;

select a.prstena, a.introvertno from prijatelj a
left join prijateljostavljena b on a.sifra=b.prijatelj
where a.sifra is not null;

#preimenuje imena kolona, vrijednost ostaje ista
select stilfrizura as crna, prstena as vjencaniprsten
from prijatelj
where sifra>1
order by stilfrizura desc
limit 1;


#preimenuje imena prvog riješenja
select 'stilfrizura' as crna, 'prstena' as vjencaniprsten
from prijatelj
where sifra>1
order by stilfrizura desc
limit 1;


# distinct oznaka
select distinct prstena from prijatelj;



select sum(a.novcica)
from zena a inner join decko b on a.sifra=b.zena 
where a.sifra > 1;





select  sum(f.zena), avg(e.narukvica )
from ostavljena a 
inner join prijateljostavljena b on a.sifra=b.ostavljena 
inner join prijatelj c on c.sifra=b.prijatelj 
inner join brat d on d.prijatelj=c.sifra
inner join zena e on e.brat=d.sifra 
inner join decko f on e.sifra=f.zena 
where d.treciputa is not null and c.prstena like 219 
group by f.zena 
having sum(f.zena)>1
order by f.sifra desc;


select hlace, suknja as odjeca from svekrva
union
select majica, prviputa as sedmiputa from punac;

create table novaTablica
select hlace, suknja as odjeca from svekrva
union
select majica, prviputa as sedmiputa from punac;

# unos podataka u tablicu na osnovu select
insert into novaTablica 
select hlace, suknja as odjeca from svekrva
union
select majica, prviputa as sedmiputa from punac;

select distinct hlace from novaTablica;

select count(*) from novaTablica;


select * from punac where majica not in 
(select distinct sifra from svekrva);


delete from punac where majica not in 
(select distinct sifra from svekrva);




