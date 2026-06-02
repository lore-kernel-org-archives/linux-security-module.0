Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D13939C9
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425434; cv=none; b=McXOWZH0xg8aTN1vz4FcPs8TT5TNXjPSn/dtjCf7xLecUb8+3Hq9KXHpKiBh1DqJ1n0b5Goz3pkJeNG78NHi4pW7rmmHO7OVYP/i/XvRSI0AokPaXdE0xXLP/Dwt/Tmxy88JXhM4JRXnu03JIZ6byZkqKoogkcK95KRfhRn/8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425434; c=relaxed/simple;
	bh=yGmHqvN+tNx9nFuwfgAR7lnyPjv1LoSdSt88PwZ8gvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKNuxjSbcVB3op86OkLu9LNQJN76EdJzV9b1Qp5YII6yMRv+LmAJHwBel3JD4K4ob+u0CZSv1oMQNVQul20Eqd5r3ePNPIIrM9YBmjvpynvcSxB8YVP0Vyuu4+tFQx2UPEIE8HkbuaakyVcX1HQi/w1bdIcRM8ZHhAqlBaHnYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ch/7zvIK; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ch/7zvIK"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9157ec935c5so123097285a.2
        for <linux-security-module@vger.kernel.org>; Tue, 02 Jun 2026 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780425432; x=1781030232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0E1DzJlKHTOcjH8rl6080RB9qdqKpujB6zQVPb2kd8=;
        b=ch/7zvIKrubpI2Fk/Eqv3pzi+C7rAvuA5AuYAC9Ei2ACRYX5LMYEVWWyoJocD2rcEN
         ceMEu+rVH4ycHuKR/j/mgkTtH8WZcNazXF/rxoAqu5x2JMaBd9e1Y0Aasq+OPACcsSDj
         0Fe0hrR/8WYa9DiVcvJxnvo/8dTMYjjHNR1dJ96dX4m4PsHDCpwYqVpx4PevKIkOPdPG
         SomKYdSAEFDO1JQOjHNHIT1RlDynjFrSOPvUUI1SIOEm7lZOHJUOTlG2BuVGWdYQ2FzG
         XgzIIWjPp0jxUzQ0fi4k4FKwvHSDX0vsajiVvVEk+gD0qmBbN7sBLUatLKUjKuPkh99T
         rz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780425432; x=1781030232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0E1DzJlKHTOcjH8rl6080RB9qdqKpujB6zQVPb2kd8=;
        b=blCZVLkpUwcCiFAGbBJEIdu5RHBFW0w2sOaGtRg2WKdaICPiwbV05+6re06yCRBgQd
         Hapl0Tq6lJ6HYVPC5a/BWN6aFl1Bh0Fl/XnCH0ggTWe8l0eeYxl5DjhovpuyrT6L6H4A
         ousSrCn8MrwqdxlgB/vvdqM7FQlibmnoxiAxU/s6yuAP+xfUaGYa+46DZ+P0JyYI1NUj
         s9ztry5ebGaJR4gGdiUC1vh+dpWKAzkWoj4mt/gde7h/ncQ1RiprpZ7MJOTRpn4Y34Pp
         qd9KpCw1XQNSg8isVK64+8k7KqQOStacnL29XPAIdslUDoaFBncS+wqTCwcBV3316XLT
         59DA==
X-Gm-Message-State: AOJu0YxrQCVocAJpogxkWWgJ3YgkGt9CXOkrP7QXaAz4aGxgSAokHfvA
	h9/U8lwCtBmYBwNIXzhUv/t6cQxPpAktab5Np0gCnBSLZ45afozSYPCbXMHkWORAaNhhr9JEtYT
	+ZYr6gYHy
X-Gm-Gg: Acq92OEjpnnG/iIgCbZNL5nYOxUA/0f1Mnz3eMvpMYWSFt9QrywBW22KZyK7rQU5YIc
	DGAbIDCGUvCbf7YOYMdU5Q5R+adzSqfN8zRsQQqiv/eaio6bB+IsvH7YC9kfjpNHgSW94+mwtbc
	9UI+aDs5nxsHFDx/N59Wwmrh8teVMHCbo7sG48s+5pjr2+pwo5XLPQ1TdXaqlKdzhEWkKyk7d4y
	ermLDf0Y4nKwerWHkm42hHRWTGPK5JNLPRuGxT47jv3Y+L4c3f2vyqEMi/ZZMqxqkUl5sIwkdBE
	kr2HYbp9HuO8+7VzKGF4BzwDwyr0ZJ1RsX86mhRLWDjlL8S+Tx3oSHN6j+u2US7pdW8x22Ic0Rk
	QrZ8Oent+p/d6rY9P+lpw6DItUupMDvILSWkErLNIAUh3tNK5xFsqe+uwH/BjWKOjam4Wj4aBGl
	djiL2XqVwIs2CrXI3/KEimlCES/ndmnYs4m8jaa8Z4D/X2r67LSkGKiJogJOXtafW8Ikob5MPmb
	Psy8NOlUtk1AS71gw==
X-Received: by 2002:a05:620a:2544:b0:915:3e46:c44a with SMTP id af79cd13be357-9158a80c3f3mr37251285a.46.1780425431715;
        Tue, 02 Jun 2026 11:37:11 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00b104sm25320285a.4.2026.06.02.11.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:37:11 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Subject: [RFC PATCH] hornet: adjustments for the updated bpf_map_ops::map_get_hash() API
Date: Tue,  2 Jun 2026 14:36:59 -0400
Message-ID: <20260602183658.161744-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3416; i=paul@paul-moore.com; h=from:subject; bh=yGmHqvN+tNx9nFuwfgAR7lnyPjv1LoSdSt88PwZ8gvY=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqHyLKqasz+8IOhJYd9uTYoMwIdwiqByu2KUxJT sn+IS7sm2KJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCah8iygAKCRDqIPLalzeJ czrsEACjt9mcQSaZ9RrudwLZfULZPVxMSCAigr4JY4Mln2IJOUVR4n06VkGjtS1f8WY2NPdPSH4 2Rioz9IDyrNWU0WeUHZRTy/91ap25R+iFFhse0e//gIc06esBlyNLGrx+uaQ893ElJnXquSkUD1 rix/VzFKfWwIgAkHtAHq4zn9puznYhMyGWeeEsMlAWy9V6LWvBzNURxgBRDjw5qwnWrtbhpQfoz oajVElUXV10RTmhwTCf39VHMaOkv+M5yJ9DKlr8GrNH6wfeJiiSmQmQ4FPo5H3VkuHF6Gjv2m/g 89UMVuZC8xOmalaYIeL5jQhsh290HqG4r/5V+EWYVyCL5gaa4bYquH4sIrqQppSLTLWRBdymuHv fzmly3ak3ad8JAjBO6gRm6WsBYdYHrnNn1TA9axKeWSugA8ixU0FFmhESn285D7LDUcBtmtogNr RX7NOK0kKoJGy30AltXZ7n3qFd6/wCZqqzvtpyDS8xDFt9H75ngkdYzo5A95cbqofhuCMNcd3T3 MfgN29WFkE0EYUGrY1UwNkc6KCLmXFp0veTmjigrtm+RxJMNIHB06WLHAthkGypxiP0GKmBNfpL nhBTddCId0/PakfkXvg9Kq23prcZOF7K68gHtelpVsWiycuphyulkqMlbMiu6JacydL8DNsaUVV aj+NGBtwTDCRMVQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Commit c48c3a7e7d5b ("bpf: Drop redundant hash_buf from map_get_hash
operation") changed the map_get_hash() API to only take a single
parameter, the bpf_map instance; this commit updates the Hornet code
accordingly.

Beyond the basic map_get_hash() usage change, this commit also removes
the remaining SHA-256 specific code from Hornet, instead relying on the
size of the bpf_map::sha field to determine the appropriate digest size.
While Hornet remains tied to SHA-256 because it is hardcoded into the
BPF subsystem, the Hornet code itself should now be fairly agile with
respect to hash algorithms.  The only area where Hornet does appear to
hardcode a hash algorithm is in the MAP_DIGEST_SIZE macro where the
bpf_map::sha field is referenced, but that is purely a field name and
if the BPF subsystem changes the name to something more generic it will
be easily caught and corrected at build time.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/hornet/hornet_lsm.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
index eeb422db1092..a1cb2e130323 100644
--- a/security/hornet/hornet_lsm.c
+++ b/security/hornet/hornet_lsm.c
@@ -17,16 +17,17 @@
 #include <linux/sort.h>
 #include <linux/asn1_decoder.h>
 #include <linux/oid_registry.h>
+#include <linux/stddef.h>
 #include "hornet.asn1.h"
 
 #define MAX_USED_MAPS 64
 
-/* The only hashing algorithm available is SHA256 due to it be hardcoded
- * in the bpf subsystem.
- */
+/* Use the hash alg hardcoded into the bpf subsystem, currently sha256 */
+#define MAP_DIGEST_SIZE (sizeof_field(struct bpf_map, sha))
+
 struct hornet_prog_security_struct {
 	int signed_hash_count;
-	unsigned char signed_hashes[SHA256_DIGEST_SIZE * MAX_USED_MAPS];
+	unsigned char signed_hashes[MAP_DIGEST_SIZE * MAX_USED_MAPS];
 };
 
 struct hornet_parse_context {
@@ -60,12 +61,12 @@ int hornet_map_hash(void *context, size_t hdrlen,
 {
 	struct hornet_parse_context *ctx = (struct hornet_parse_context *)context;
 
-	if (vlen != SHA256_DIGEST_SIZE && vlen != 0)
+	if (vlen != MAP_DIGEST_SIZE && vlen != 0)
 		return -EINVAL;
 	if (ctx->security->signed_hash_count >= MAX_USED_MAPS)
 		return -EINVAL;
 
-	memcpy(&ctx->security->signed_hashes[ctx->security->signed_hash_count * SHA256_DIGEST_SIZE],
+	memcpy(&ctx->security->signed_hashes[ctx->security->signed_hash_count * MAP_DIGEST_SIZE],
 	       value, vlen);
 
 	return 0;
@@ -188,7 +189,6 @@ static int hornet_bpf_prog_load_integrity(struct bpf_prog *prog, union bpf_attr
 static int hornet_check_prog_maps(struct bpf_prog *prog)
 {
 	struct hornet_prog_security_struct *security;
-	unsigned char hash[SHA256_DIGEST_SIZE];
 	struct bpf_map *map;
 	int i, j;
 	bool found;
@@ -209,12 +209,12 @@ static int hornet_check_prog_maps(struct bpf_prog *prog)
 			if (!READ_ONCE(map->frozen) || !map->ops->map_get_hash)
 				continue;
 
-			if (map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash))
+			if (map->ops->map_get_hash(map))
 				continue;
 
-			if (memcmp(hash,
-				   &security->signed_hashes[i * SHA256_DIGEST_SIZE],
-				   SHA256_DIGEST_SIZE) == 0) {
+			if (memcmp(map->sha,
+				   &security->signed_hashes[i * MAP_DIGEST_SIZE],
+				   MAP_DIGEST_SIZE) == 0) {
 				found = true;
 				break;
 			}
-- 
2.54.0

