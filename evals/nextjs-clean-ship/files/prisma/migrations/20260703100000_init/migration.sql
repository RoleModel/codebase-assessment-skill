CREATE TABLE "User" ("id" TEXT PRIMARY KEY, "name" TEXT, "email" TEXT UNIQUE, "emailVerified" TIMESTAMP(3), "image" TEXT);
CREATE TABLE "Account" ("userId" TEXT NOT NULL REFERENCES "User"("id") ON DELETE CASCADE, "type" TEXT NOT NULL, "provider" TEXT NOT NULL, "providerAccountId" TEXT NOT NULL, "refresh_token" TEXT, "access_token" TEXT, "expires_at" INTEGER, "token_type" TEXT, "scope" TEXT, "id_token" TEXT, "session_state" TEXT, PRIMARY KEY ("provider", "providerAccountId"));
CREATE TABLE "Session" ("sessionToken" TEXT NOT NULL UNIQUE, "userId" TEXT NOT NULL REFERENCES "User"("id") ON DELETE CASCADE, "expires" TIMESTAMP(3) NOT NULL);
CREATE TABLE "Product" ("id" TEXT PRIMARY KEY, "name" TEXT NOT NULL, "priceCents" INTEGER NOT NULL);
CREATE TABLE "Order" ("id" TEXT PRIMARY KEY, "userId" TEXT NOT NULL REFERENCES "User"("id"), "productId" TEXT NOT NULL, "status" TEXT NOT NULL DEFAULT 'pending', "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP);
CREATE INDEX "Order_userId_idx" ON "Order"("userId");
