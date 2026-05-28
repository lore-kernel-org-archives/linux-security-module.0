Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3D81732
	for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 03:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937777; cv=none; b=BXZ7r7eaCQgQ8/Fs5cYWjPe1meC54G2hbzPYfylMiGlOt/GM193FrhdxcqRUhBWPliO+YPgL0t6oMDP4KMQj9z0GlTPNjg660hik2/ON6/Me1DgNEp1nFljeQQFFzRQxbdQPUxtjVKewGBirQgvvmF/aq0K+yir1vhIpZdTiHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937777; c=relaxed/simple;
	bh=nIF2n6UPAkUTad5yKYQV+FJyQZ+7Y4Sg6SJFQ7lLp7M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jiasqr1qz6GVdPb9K16ddFUh+deu/3MKqnkmtLVG1pQQBo6+sI4nKqdi7nl4B/7zn7MZrS78mlBxCL+Rm28jlAU4v+YAapC0riB/N2hYlOXtSPpPOGgshhBh+lmj594E/xCXBIFVIGDI1XgMwLVTHip60jjWy/zA9J7Qc8IFGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bOMuVWU+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bOMuVWU+"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 81B9920B716A;
	Wed, 27 May 2026 20:09:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 81B9920B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779937764;
	bh=vhfBcWnPKqH4slvsvSEA0CjcPSoU2t8eoY55vnYH5/0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bOMuVWU+TJuVtxcI8v1ZBwBrXSecSNR0e7lOfy9isc7tMOIPxTAGumu9W5+44NOTL
	 gGVc0/nQDUnMbhiXbc+s4LYBGKXkCLwPPOU9HgCAjR+SIPn/NwGDz8mbvK/0r51+PY
	 Trr81ThZMXRLKFbbAv0+XK/J3XUw/Aa7eowH86ks=
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
Subject: [PATCH 03/11] hornet: fix off-by-one bug in max used maps check
Date: Wed, 27 May 2026 20:08:12 -0700
Message-ID: <20260528030915.2654994-4-bboscaccy@linux.microsoft.com>
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

Sashiko correctly reported an off-by-one logic error checking against
the maximum number of used maps.  Removing the index constraint allows
us to simplify the check logic.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 security/hornet/hornet_lsm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
index 35d9522d6bc72..eeb422db1092d 100644
--- a/security/hornet/hornet_lsm.c
+++ b/security/hornet/hornet_lsm.c
@@ -49,8 +49,7 @@ int hornet_next_map(void *context, size_t hdrlen,
 {
 	struct hornet_parse_context *ctx = (struct hornet_parse_context *)context;
 
-	if (++ctx->security->signed_hash_count >= MAX_USED_MAPS)
-		return -EINVAL;
+	ctx->security->signed_hash_count++;
 	return 0;
 }
 
@@ -63,6 +62,8 @@ int hornet_map_hash(void *context, size_t hdrlen,
 
 	if (vlen != SHA256_DIGEST_SIZE && vlen != 0)
 		return -EINVAL;
+	if (ctx->security->signed_hash_count >= MAX_USED_MAPS)
+		return -EINVAL;
 
 	memcpy(&ctx->security->signed_hashes[ctx->security->signed_hash_count * SHA256_DIGEST_SIZE],
 	       value, vlen);
-- 
2.53.0

