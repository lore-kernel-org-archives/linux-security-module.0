Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B672C11C6
	for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937774; cv=none; b=C2wIWiRgDIP57kelGSWGt84QDUgQU93UUEAhuaD/+Pz6Y7Xe32FPUNs0YZhF2/Fg3ndKGMT74Ee/ig1u9zmpQivzK4KTwijC703TjKC6oD7V3TXYzt4NQ9q3QC4KY4X+dxzCxPnUWJSn/ACdmMlHrCX9kC1c81jcwfMakK6gyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937774; c=relaxed/simple;
	bh=xIszCXtgFPxoy/BZIoLUR/g0NRrq9Y9+6Kd0MaYCoSo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rbt7yycJ17kedlspJOm5f1CivPVP4O3LN/fPVYcmfCcik/RoGI/383dSkmntqYYviMB7bKPop4qcAC2//ILdQF4cBcR4YJgtJ/SDLRMp4df/dtCRl9pWn31ZwxisHFMghSGTIHvI6Bh75EtCW0fRFS2o+XQXa0qjRAZ4rWK5KSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ssq6KYJ4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ssq6KYJ4"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 71D9020B7169;
	Wed, 27 May 2026 20:09:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71D9020B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779937761;
	bh=oMw/WKJ5yXjYaVzw/C+px3AzlnpxEEBvJmwcNGfNtBM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ssq6KYJ46mHsb9j1FEyrHaHQo7bWjRI03K5R717aeBOPNvwdkcjPimxP8mN5TSy3z
	 loaAaURm1eBirvd0jRQMbvVOrjDLevWPA0z5Jbj6asqVQtl+foFOpS+odmrheSvV3e
	 qlV5uGuMRtTnKD2n9EEsb9H2QGoYQ48IHAg5NWFM=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: "Jonathan Corbet" <corbet@lwn.net>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"Paul Moore" <paul@paul-moore.com>,
	"James Morris" <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Eric Biggers" <ebiggers@kernel.org>,
	"Fan Wu" <wufan@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	"Blaise Boscaccy" <bboscaccy@linux.microsoft.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 02/11] hornet: invert map set check logic
Date: Wed, 27 May 2026 20:08:11 -0700
Message-ID: <20260528030915.2654994-3-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a multi-map hash verification scenario, a logic bug may have
allowed an attacker to provide duplicate maps to satisfy the hash
check count. Instead, invert the logic to verify each map discretely

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 security/hornet/hornet_lsm.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
index 516038413f321..35d9522d6bc72 100644
--- a/security/hornet/hornet_lsm.c
+++ b/security/hornet/hornet_lsm.c
@@ -191,7 +191,6 @@ static int hornet_check_prog_maps(struct bpf_prog *prog)
 	struct bpf_map *map;
 	int i, j;
 	bool found;
-	int covered_count = 0;
 
 	security = hornet_bpf_prog_security(prog);
 
@@ -200,18 +199,18 @@ static int hornet_check_prog_maps(struct bpf_prog *prog)
 
 	mutex_lock(&prog->aux->used_maps_mutex);
 
-	/* Verify every used_map has a matching signed hash */
-	for (j = 0; j < prog->aux->used_map_cnt; j++) {
-		map = prog->aux->used_maps[j];
+	/* Verify every signed map exists in used_maps */
+	for (i = 0; i < security->signed_hash_count; i++) {
+		found = false;
+		for (j = 0; j < prog->aux->used_map_cnt; j++) {
+			map = prog->aux->used_maps[j];
 
-		if (!READ_ONCE(map->frozen) || !map->ops->map_get_hash)
-			continue;
+			if (!READ_ONCE(map->frozen) || !map->ops->map_get_hash)
+				continue;
 
-		if (map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash))
-			continue;
+			if (map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash))
+				continue;
 
-		found = false;
-		for (i = 0; i < security->signed_hash_count; i++) {
 			if (memcmp(hash,
 				   &security->signed_hashes[i * SHA256_DIGEST_SIZE],
 				   SHA256_DIGEST_SIZE) == 0) {
@@ -223,15 +222,10 @@ static int hornet_check_prog_maps(struct bpf_prog *prog)
 			mutex_unlock(&prog->aux->used_maps_mutex);
 			return -EPERM;
 		}
-		covered_count++;
 	}
 
 	mutex_unlock(&prog->aux->used_maps_mutex);
 
-	/* Ensure all signed hashes were accounted for */
-	if (covered_count != security->signed_hash_count)
-		return -EPERM;
-
 	return 0;
 }
 
-- 
2.53.0

