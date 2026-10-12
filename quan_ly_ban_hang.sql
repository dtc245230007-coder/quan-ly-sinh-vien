-- BAI TAP: THAO TAC VOI CSDL QUAN LY BAN HANG
-- MySQL
-- Luu y: Tu "Order" la tu khoa SQL, nen dung backticks: `Order`.
-- Chay cac lenh INSERT sau khi da tao 4 bang theo bai thuc hanh.

-- 1. Them du lieu vao Customer
INSERT INTO Customer (cID, Name, cAge) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

-- 2. Them du lieu vao `Order`
INSERT INTO `Order` (oID, cID, oDate, oTotalPrice) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

-- 3. Them du lieu vao Product
INSERT INTO Product (pID, pName, pPrice) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

-- 4. Them du lieu vao OrderDetail
INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 3),
(2, 3, 8),
(2, 5, 4),
(3, 2, 3);

-- 5. Hien thi ma hoa don, ngay mua va tong tien dang luu trong bang Order
-- Neu de bai yeu cau cot ten oPrice, co the dat alias nhu ben duoi.
SELECT oID, oDate, oTotalPrice AS oPrice
FROM `Order`;

-- 6. Hien thi khach hang da mua hang va san pham ho mua
SELECT DISTINCT c.Name, p.pName
FROM Customer AS c
JOIN `Order` AS o ON o.cID = c.cID
JOIN OrderDetail AS od ON od.oID = o.oID
JOIN Product AS p ON p.pID = od.pID
ORDER BY c.Name, p.pName;

-- 7. Hien thi ten khach hang khong mua bat ky san pham nao
SELECT c.Name
FROM Customer AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM `Order` AS o
    JOIN OrderDetail AS od ON od.oID = o.oID
    WHERE o.cID = c.cID
);

-- 8. Hien thi ma hoa don, ngay ban va gia tien tinh tu chi tiet san pham
SELECT o.oID, o.oDate,
       COALESCE(SUM(od.odQTY * p.pPrice), 0) AS oPrice
FROM `Order` AS o
LEFT JOIN OrderDetail AS od ON od.oID = o.oID
LEFT JOIN Product AS p ON p.pID = od.pID
GROUP BY o.oID, o.oDate
ORDER BY o.oID;

-- 9. Cap nhat tong tien hoa don trong bang Order (tuy chon, neu can luu tong tien)
UPDATE `Order` AS o
LEFT JOIN (
    SELECT od.oID, SUM(od.odQTY * p.pPrice) AS total_price
    FROM OrderDetail AS od
    JOIN Product AS p ON p.pID = od.pID
    GROUP BY od.oID
) AS totals ON totals.oID = o.oID
SET o.oTotalPrice = COALESCE(totals.total_price, 0);
