/*
  Warnings:

  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `firstName` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `lastName` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `passwordHash` on the `User` table. All the data in the column will be lost.
  - You are about to alter the column `email` on the `User` table. The data in that column could be lost. The data in that column will be cast from `VarChar(255)` to `VarChar(150)`.
  - The `role` column on the `User` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the `Cart` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CartItem` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Category` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Order` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `OrderItem` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Product` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ProductImage` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ProductVariant` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[employee_code]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[phone_number]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `password_hash` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `phone_number` to the `User` table without a default value. This is not possible if the table is not empty.
  - The required column `user_id` was added to the `User` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - Added the required column `user_name` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Role" AS ENUM ('DUTYOFFICER', 'SI', 'CRIMEANALYST', 'ADMIN', 'COMMON', 'OC');

-- CreateEnum
CREATE TYPE "OfficerRank" AS ENUM ('DUTYOFFICER', 'SI', 'CRIMEANALYST', 'ADMIN', 'OC');

-- CreateEnum
CREATE TYPE "CrimeType" AS ENUM ('theft', 'domestic_violence', 'cyber_crime', 'fraud', 'extortion', 'drug_offense', 'smuggling', 'vandalism', 'public_disorder', 'corruption', 'others');

-- CreateEnum
CREATE TYPE "SubmissionStatus" AS ENUM ('PENDING', 'SUBMITTED', 'REJECTED');

-- CreateEnum
CREATE TYPE "FileType" AS ENUM ('document', 'video', 'audio', 'image');

-- CreateEnum
CREATE TYPE "InvestigationStatus" AS ENUM ('under_investigation', 'solved');

-- CreateEnum
CREATE TYPE "CaseFlag" AS ENUM ('red', 'green');

-- CreateEnum
CREATE TYPE "RiskLevel" AS ENUM ('low', 'medium', 'high');

-- CreateEnum
CREATE TYPE "EntityType" AS ENUM ('complaint', 'case', 'evidence', 'user');

-- CreateEnum
CREATE TYPE "AuditAction" AS ENUM ('CREATE', 'UPDATE', 'DELETE', 'LOGIN', 'LOGOUT', 'ASSIGN', 'UNASSIGN', 'STATUS_CHANGE');

-- DropForeignKey
ALTER TABLE "Cart" DROP CONSTRAINT "Cart_userId_fkey";

-- DropForeignKey
ALTER TABLE "CartItem" DROP CONSTRAINT "CartItem_cartId_fkey";

-- DropForeignKey
ALTER TABLE "CartItem" DROP CONSTRAINT "CartItem_productId_fkey";

-- DropForeignKey
ALTER TABLE "CartItem" DROP CONSTRAINT "CartItem_variantId_fkey";

-- DropForeignKey
ALTER TABLE "Category" DROP CONSTRAINT "Category_parentId_fkey";

-- DropForeignKey
ALTER TABLE "Order" DROP CONSTRAINT "Order_userId_fkey";

-- DropForeignKey
ALTER TABLE "OrderItem" DROP CONSTRAINT "OrderItem_orderId_fkey";

-- DropForeignKey
ALTER TABLE "OrderItem" DROP CONSTRAINT "OrderItem_productId_fkey";

-- DropForeignKey
ALTER TABLE "Product" DROP CONSTRAINT "Product_categoryId_fkey";

-- DropForeignKey
ALTER TABLE "ProductImage" DROP CONSTRAINT "ProductImage_productId_fkey";

-- DropForeignKey
ALTER TABLE "ProductVariant" DROP CONSTRAINT "ProductVariant_productId_fkey";

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
DROP COLUMN "firstName",
DROP COLUMN "id",
DROP COLUMN "lastName",
DROP COLUMN "passwordHash",
ADD COLUMN     "employee_code" VARCHAR(50),
ADD COLUMN     "password_hash" CHAR(60) NOT NULL,
ADD COLUMN     "phone_number" VARCHAR(20) NOT NULL,
ADD COLUMN     "user_id" UUID NOT NULL,
ADD COLUMN     "user_name" VARCHAR(100) NOT NULL,
ALTER COLUMN "email" SET DATA TYPE VARCHAR(150),
DROP COLUMN "role",
ADD COLUMN     "role" "Role" NOT NULL DEFAULT 'COMMON',
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("user_id");

-- DropTable
DROP TABLE "Cart";

-- DropTable
DROP TABLE "CartItem";

-- DropTable
DROP TABLE "Category";

-- DropTable
DROP TABLE "Order";

-- DropTable
DROP TABLE "OrderItem";

-- DropTable
DROP TABLE "Product";

-- DropTable
DROP TABLE "ProductImage";

-- DropTable
DROP TABLE "ProductVariant";

-- DropEnum
DROP TYPE "OrderStatus";

-- DropEnum
DROP TYPE "UserRole";

-- DropEnum
DROP TYPE "paymentStatus";

-- CreateTable
CREATE TABLE "Thana_info" (
    "geo_code" VARCHAR(20) NOT NULL,
    "thana_name" VARCHAR(100) NOT NULL,
    "district" VARCHAR(100) NOT NULL,
    "thana_email" VARCHAR(150) NOT NULL,
    "latitude" DECIMAL(9,6),
    "longitude" DECIMAL(9,6),
    "tel_no" VARCHAR(20) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Thana_info_pkey" PRIMARY KEY ("geo_code")
);

-- CreateTable
CREATE TABLE "Thana_officer" (
    "employee_id" VARCHAR(50) NOT NULL,
    "first_name" VARCHAR(50) NOT NULL,
    "last_name" VARCHAR(50),
    "phone_number" VARCHAR(20) NOT NULL,
    "thana_code" VARCHAR(20) NOT NULL,
    "rank" "OfficerRank" NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Thana_officer_pkey" PRIMARY KEY ("employee_id")
);

-- CreateTable
CREATE TABLE "Complaint_submission" (
    "complaint_id" UUID NOT NULL,
    "login_id" UUID NOT NULL,
    "thana_code" VARCHAR(20) NOT NULL,
    "area" VARCHAR(150) NOT NULL,
    "crime_type" "CrimeType" NOT NULL,
    "case_description" TEXT NOT NULL,
    "submission_status" "SubmissionStatus" NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Complaint_submission_pkey" PRIMARY KEY ("complaint_id")
);

-- CreateTable
CREATE TABLE "Case_evidence" (
    "evidence_id" UUID NOT NULL,
    "complaint_id" UUID NOT NULL,
    "file_type" "FileType" NOT NULL,
    "file_path" VARCHAR(500) NOT NULL,
    "uploadedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Case_evidence_pkey" PRIMARY KEY ("evidence_id")
);

-- CreateTable
CREATE TABLE "SIAssignment" (
    "assignment_id" UUID NOT NULL,
    "previous_sI_id" VARCHAR(50),
    "current_SI_id" VARCHAR(50) NOT NULL,
    "complaint_id" UUID NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SIAssignment_pkey" PRIMARY KEY ("assignment_id")
);

-- CreateTable
CREATE TABLE "Crime_investigation" (
    "investigation_id" UUID NOT NULL,
    "assignment_id" UUID NOT NULL,
    "investigation_status" "InvestigationStatus" NOT NULL DEFAULT 'under_investigation',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Crime_investigation_pkey" PRIMARY KEY ("investigation_id")
);

-- CreateTable
CREATE TABLE "Case_review" (
    "review_id" UUID NOT NULL,
    "inves_id" UUID NOT NULL,
    "oc_id" VARCHAR(50) NOT NULL,
    "flag" "CaseFlag" NOT NULL DEFAULT 'green',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Case_review_pkey" PRIMARY KEY ("review_id")
);

-- CreateTable
CREATE TABLE "Crime_analysis" (
    "analysis_id" UUID NOT NULL,
    "thana_code" VARCHAR(20) NOT NULL,
    "crime_type" "CrimeType" NOT NULL,
    "period_start" TIMESTAMP(3) NOT NULL,
    "period_end" TIMESTAMP(3) NOT NULL,
    "risk_level" "RiskLevel" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Crime_analysis_pkey" PRIMARY KEY ("analysis_id")
);

-- CreateTable
CREATE TABLE "Audit_log" (
    "log_id" UUID NOT NULL,
    "UserId" UUID NOT NULL,
    "entity_type" "EntityType" NOT NULL,
    "action" "AuditAction" NOT NULL,
    "details" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Audit_log_pkey" PRIMARY KEY ("log_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Thana_info_district_key" ON "Thana_info"("district");

-- CreateIndex
CREATE UNIQUE INDEX "Thana_info_thana_email_key" ON "Thana_info"("thana_email");

-- CreateIndex
CREATE UNIQUE INDEX "Thana_officer_phone_number_key" ON "Thana_officer"("phone_number");

-- CreateIndex
CREATE UNIQUE INDEX "User_employee_code_key" ON "User"("employee_code");

-- CreateIndex
CREATE UNIQUE INDEX "User_phone_number_key" ON "User"("phone_number");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_employee_code_fkey" FOREIGN KEY ("employee_code") REFERENCES "Thana_officer"("employee_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Thana_officer" ADD CONSTRAINT "Thana_officer_thana_code_fkey" FOREIGN KEY ("thana_code") REFERENCES "Thana_info"("geo_code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Complaint_submission" ADD CONSTRAINT "Complaint_submission_login_id_fkey" FOREIGN KEY ("login_id") REFERENCES "User"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Complaint_submission" ADD CONSTRAINT "Complaint_submission_thana_code_fkey" FOREIGN KEY ("thana_code") REFERENCES "Thana_info"("geo_code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Case_evidence" ADD CONSTRAINT "Case_evidence_complaint_id_fkey" FOREIGN KEY ("complaint_id") REFERENCES "Complaint_submission"("complaint_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SIAssignment" ADD CONSTRAINT "SIAssignment_previous_sI_id_fkey" FOREIGN KEY ("previous_sI_id") REFERENCES "Thana_officer"("employee_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SIAssignment" ADD CONSTRAINT "SIAssignment_current_SI_id_fkey" FOREIGN KEY ("current_SI_id") REFERENCES "Thana_officer"("employee_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SIAssignment" ADD CONSTRAINT "SIAssignment_complaint_id_fkey" FOREIGN KEY ("complaint_id") REFERENCES "Complaint_submission"("complaint_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Crime_investigation" ADD CONSTRAINT "Crime_investigation_assignment_id_fkey" FOREIGN KEY ("assignment_id") REFERENCES "SIAssignment"("assignment_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Case_review" ADD CONSTRAINT "Case_review_inves_id_fkey" FOREIGN KEY ("inves_id") REFERENCES "Crime_investigation"("investigation_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Case_review" ADD CONSTRAINT "Case_review_oc_id_fkey" FOREIGN KEY ("oc_id") REFERENCES "Thana_officer"("employee_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Crime_analysis" ADD CONSTRAINT "Crime_analysis_thana_code_fkey" FOREIGN KEY ("thana_code") REFERENCES "Thana_info"("geo_code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Audit_log" ADD CONSTRAINT "Audit_log_UserId_fkey" FOREIGN KEY ("UserId") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;
