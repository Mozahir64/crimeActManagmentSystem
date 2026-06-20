/*
  Warnings:

  - The values [SP] on the enum `OfficerRank` will be removed. If these variants are still used in the database, this will fail.
  - The values [SP] on the enum `Role` will be removed. If these variants are still used in the database, this will fail.
  - Added the required column `district` to the `Crime_analysis` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "OfficerRank_new" AS ENUM ('DUTYOFFICER', 'SI', 'CRIMEANALYST', 'ADMIN', 'OC');
ALTER TABLE "Thana_officer" ALTER COLUMN "rank" TYPE "OfficerRank_new" USING ("rank"::text::"OfficerRank_new");
ALTER TYPE "OfficerRank" RENAME TO "OfficerRank_old";
ALTER TYPE "OfficerRank_new" RENAME TO "OfficerRank";
DROP TYPE "public"."OfficerRank_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "Role_new" AS ENUM ('DUTYOFFICER', 'SI', 'CRIMEANALYST', 'ADMIN', 'COMMON', 'OC');
ALTER TABLE "public"."User" ALTER COLUMN "role" DROP DEFAULT;
ALTER TABLE "User" ALTER COLUMN "role" TYPE "Role_new" USING ("role"::text::"Role_new");
ALTER TYPE "Role" RENAME TO "Role_old";
ALTER TYPE "Role_new" RENAME TO "Role";
DROP TYPE "public"."Role_old";
ALTER TABLE "User" ALTER COLUMN "role" SET DEFAULT 'COMMON';
COMMIT;

-- AlterTable
ALTER TABLE "Crime_analysis" ADD COLUMN     "district" VARCHAR(20) NOT NULL;
