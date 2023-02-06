-- Cleaning Data in SQL Queries

SELECT * 
FROM nashvillehousing.housingdata;

---------------------------------------------------------------------------- 
-- Standardize Date Format
SELECT SaleDate, Convert(SaleDate, Date)
FROM nashvillehousing.housingdata;

ALTER TABLE nashvillehousing.housingdata
Add SaleDateConverted Date;

Update nashvillehousing.housingdata
SET SaleDateConverted = Convert(SaleDate, Date);


-----------------------------------------------------------------------------
-- Populate Property Address Data
SELECT *
FROM nashvillehousing.housingdata
where propertyaddress  =''
order by parcelid;

SELECT a.Parcelid, a.Propertyaddress, b.ParcelID, b.PropertyAddress, IF(a.propertyaddress ='', b.PropertyAddress,'')
FROM nashvillehousing.housingdata a 
JOIN nashvillehousing.housingdata b
	on a.parcelid = b.parcelid 
    and a.uniqueid <> b.uniqueid
WHERE a.propertyaddress ='';

Update nashvillehousing.housingdata a
JOIN nashvillehousing.housingdata b
	on a.parcelid = b.parcelid 
    and a.uniqueid <> b.uniqueid
SET a.Propertyaddress = IF(a.propertyaddress ='', b.PropertyAddress,'')
WHERE a.propertyaddress ='';


-------------------------------------------------------------------------------------------------------
-- Breaking out Address into Individeual Columns (Address, City, State)
SELECT propertyaddress
FROM nashvillehousing.housingdata;

SELECT propertyaddress,
SUBSTRING(PropertyAddress, 1, Position(',' in PropertyAddress)-1) AS Address, 
SUBSTRING(PropertyAddress, Position(',' in PropertyAddress)+1 , LENGTH(propertyaddress)) AS Address
FROM nashvillehousing.housingdata;

ALTER TABLE nashvillehousing.housingdata
Add PropertySplitAddress Nvarchar (255);

Update nashvillehousing.housingdata
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, Position(',' in PropertyAddress)-1);

ALTER TABLE nashvillehousing.housingdata
Add PropertySplitCity Nvarchar (255);

Update nashvillehousing.housingdata
SET PropertySplitCity = SUBSTRING(PropertyAddress, Position(',' in PropertyAddress)+1 , LENGTH(propertyaddress));


SELECT OwnerAddress, 
SUBSTRING_INDEX(OwnerAddress,',',1) as OwnerSplitAddress,
substring_index(Replace(owneraddress,', TN',''),',',-1) as OwnerSplitCity,
SUBSTRING_INDEX(OwnerAddress,',',-1) as OwnerSplitState
FROM nashvillehousing.housingdata;

ALTER TABLE nashvillehousing.housingdata
Add OwnerSplitAddress Nvarchar (255);

Update nashvillehousing.housingdata
SET OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress,',',1);


ALTER TABLE nashvillehousing.housingdata
Add OwnerSplitCity Nvarchar (255);

Update nashvillehousing.housingdata
SET OwnerSplitCity = substring_index(Replace(owneraddress,', TN',''),',',-1);


ALTER TABLE nashvillehousing.housingdata
Add OwnerSplitState Nvarchar (255);

Update nashvillehousing.housingdata
SET OwnerSplitState = SUBSTRING_INDEX(OwnerAddress,',',-1);

-----------------------------------------------------------------------------------
-- Change Y and N to Yes and No in "Sold as Vacant" field
SELECT distinct SoldAsVacant, count(SoldAsVacant)
FROM nashvillehousing.housingdata
group by SoldAsVacant
order by 2;

SELECT SoldAsVacant,
CASE When SoldAsVacant = 'Y' Then 'Yes'
	 When SoldAsVacant = 'N' Then 'No'
	 ELSE SoldAsVacant
     END
FROM nashvillehousing.housingdata;

UPDATE nashvillehousing.housingdata
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' Then 'Yes'
	 When SoldAsVacant = 'N' Then 'No'
	 ELSE SoldAsVacant
     END;
     

-------------------------------------------------------------------------------------------------------------
-- Delete Unused Columns

SELECT * 
FROM nashvillehousing.housingdata;

ALTER TABLE nashvillehousing.housingdata
DROP COLUMN Owneraddress;
ALTER TABLE nashvillehousing.housingdata
DROP COLUMN PropertyAddress;
ALTER TABLE nashvillehousing.housingdata
DROP COLUMN SaleDate;
----------------------------------------------------------------------------
