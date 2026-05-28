Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3B42EA172
	for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 03:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937786; cv=none; b=hBVoYyROtS3oiGzh+Q46eA9LgF/W5wKwRHmnZDd2TQcSZSMWEk0I1+8uA8bDKznYFediBOBEoj+le3I3WotnsZw68pSP100VqUoDG3k90BJUHYAz9cAKNs1ebgQQl8L8s6KWpDZCKADUvhrTpY+PTFEaKhtXJ6jYO07f/SJyVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937786; c=relaxed/simple;
	bh=8hmcWiqMXncBx3wRB2f8eQI8PzxUIbhv+PKbdAqgZGk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwZxpoBeoimFMB6AM+rt9N2eKKyMEzDGrs0j2lLd09Z5J5z+upAm6rGggm2SpBB+Liawj5OHVNcNkwkECYGqzlu/oOqbyEVE/TpccWdHo4Sc2eq8m3RRE5VevADgqwqwd62iSx7P0VI9nFo9q+ggviNsq7UqM421Le+F8gb/ZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sJf8zlrW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sJf8zlrW"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86FF820B7167;
	Wed, 27 May 2026 20:09:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86FF820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779937774;
	bh=sp3sRNA9Fb6vw6jNsqEHLJV6GZ5DXWihPZxo2zZCP6I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sJf8zlrWkyMw4e+EqhAB7ZuIxe3mW8WGlZ5ZmFhdpynJJGF8f1QDEgoj8asYLe4w5
	 jlmtuqdFJY5SPeP0uAFRPQBTO0tvqp7IWpn+R/RObD/J4dDGD0zgCyodJldRJaN+d6
	 xsvLthNLpwMVgpxni6lppBcR3bYHwRG5pz2h2hIw=
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
Subject: [PATCH 06/11] hornet: gen_sig: fix error string allocations
Date: Wed, 27 May 2026 20:08:15 -0700
Message-ID: <20260528030915.2654994-7-bboscaccy@linux.microsoft.com>
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

The sha256 function was allocating/freeing it's own error strings,
which could case further errors to only return their error number.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 scripts/hornet/gen_sig.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/hornet/gen_sig.c b/scripts/hornet/gen_sig.c
index 4e8caad22f381..647bc3a257dd0 100644
--- a/scripts/hornet/gen_sig.c
+++ b/scripts/hornet/gen_sig.c
@@ -200,8 +200,6 @@ static int sha256(const char *path, unsigned char out[SHA256_LEN], unsigned int
 		return -2;
 	}
 
-	ERR_load_crypto_strings();
-
 	rc = -3;
 	ctx = EVP_MD_CTX_new();
 	if (!ctx) {
@@ -247,7 +245,6 @@ static int sha256(const char *path, unsigned char out[SHA256_LEN], unsigned int
 done:
 	EVP_MD_CTX_free(ctx);
 	fclose(f);
-	ERR_free_strings();
 	return rc;
 }
 
-- 
2.53.0

