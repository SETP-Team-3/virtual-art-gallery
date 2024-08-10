-- Disable safe update mode
SET SQL_SAFE_UPDATES = 0;

-- Set ALL the artwork.status to 'available' again
UPDATE `vartgallery`.`artwork` SET `status` = 'available';

-- Set ALL the artwork.buyer_id to NULL again
UPDATE `vartgallery`.`artwork` SET `buyer_id` = NULL;

-- Set ALL the artwork.version to 0 again
UPDATE `vartgallery`.`artwork` SET `version` = 0;

-- Empty out whatever's in the transaction table
TRUNCATE TABLE `vartgallery`.`transaction`;

-- Reset the AUTO_INCREMENT for the transaction table so that the next transaction's id will start at '1' again
ALTER TABLE `vartgallery`.`transaction` AUTO_INCREMENT = 1;

-- Re-enable safe update mode
SET SQL_SAFE_UPDATES = 1;
