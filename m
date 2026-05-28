Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D94281732
	for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 03:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937789; cv=none; b=C3fiC/Ry+nqmY29ZhixzlUrD3P4loahqkid0og3LNqByvX/utUEQH8mNHGm1P4GFoCNSbwTqtQmhfvJQft62+HTiLtnFmU1SUlyZBRcl0JUa2TLuyY5w5olAE6hNnoMKb30rY+VfAaCa3vutCllfHVV5eGOoi3G3F3xAGFtNaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937789; c=relaxed/simple;
	bh=5yra/LPdhXUQjVdUbPWsJ3DdxBfG1ju4kacOKLPNgxY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXBvdoaiznjWf9zP2+uPuDCIZBnIx1d6BvKWo0G6T/Z7mRxxo10IACrUNJMcijay7hXZk5VvLDrkakn5hAM5sjKQoikb5OJO1p03WGq+NAqhZepZT+z8s5Bc4dsPrZ4Vieg1Z/odngPijXYAUuppmak04o+RoxyF1sBcoxxfpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FnE/a66r; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FnE/a66r"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 90B6720B7168;
	Wed, 27 May 2026 20:09:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90B6720B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779937776;
	bh=uaVSqd/oXvRlUx3+IJWeoIMSBdopFKsZQzKYmN4vyo0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FnE/a66r/dckrlfEIUapvLvzh8BjvM0MfCI8SvnlcvNiiJij60koxLxc5aYmYWxAL
	 69G94VVDhKEqGsaZ3WFeC/RskofeNb9weo/vDo5B2xVaJjsTvJmegsRbCRJrmfOR5p
	 htZRgVfSRI6kdovp4/ag/s5WNstNhpK8SL3MbnzU=
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
Subject: [PATCH 07/11] hornet: gen_sig: check for bad allocations
Date: Wed, 27 May 2026 20:08:16 -0700
Message-ID: <20260528030915.2654994-8-bboscaccy@linux.microsoft.com>
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

There were a few sites where gen_sig failed to check for bad return
values after allocations. Error out appropriately as needed.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 scripts/hornet/gen_sig.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/scripts/hornet/gen_sig.c b/scripts/hornet/gen_sig.c
index 647bc3a257dd0..fb9ae1934206a 100644
--- a/scripts/hornet/gen_sig.c
+++ b/scripts/hornet/gen_sig.c
@@ -248,13 +248,25 @@ static int sha256(const char *path, unsigned char out[SHA256_LEN], unsigned int
 	return rc;
 }
 
-static void add_hash(MAP_SET *set, unsigned char *buffer, int buffer_len)
+static int add_hash(MAP_SET *set, unsigned char *buffer, int buffer_len)
 {
-	HORNET_MAP *map = NULL;
+	HORNET_MAP *map;
 
 	map = HORNET_MAP_new();
-	ASN1_OCTET_STRING_set(map->hash, buffer, buffer_len);
-	sk_HORNET_MAP_push(set->maps, map);
+	if (!map)
+		return -1;
+
+	if (ASN1_OCTET_STRING_set(map->hash, buffer, buffer_len) != 1) {
+		HORNET_MAP_free(map);
+		return -1;
+	}
+
+	if (sk_HORNET_MAP_push(set->maps, map) <= 0) {
+		HORNET_MAP_free(map);
+		return -1;
+	}
+
+	return 0;
 }
 
 int main(int argc, char **argv)
@@ -353,13 +365,18 @@ int main(int argc, char **argv)
 	ERR(!si, "add signer failed");
 
 	set = MAP_SET_new();
+	ERR(!set, "alloc MAP_SET failed");
 	set->maps = sk_HORNET_MAP_new_null();
+	ERR(!set->maps, "alloc HORNET_MAP stack failed");
 
 	for (i = 0; i < hash_count; i++) {
 		if (sha256(hashes[i].file, hash_buffer, &hash_len) != 0) {
 			DIE("failed to hash input");
 		}
-		add_hash(set, hash_buffer, hash_len);
+		if (add_hash(set, hash_buffer, hash_len) != 0) {
+			ERR_print_errors_fp(stderr);
+			DIE("failed to add hash to map set");
+		}
 	}
 
 	oid = OBJ_txt2obj("2.25.316487325684022475439036912669789383960", 1);
@@ -380,7 +397,18 @@ int main(int argc, char **argv)
 	b_out = bio_open_wr(out_path);
 	ERR(!b_out, "opening output path failed");
 
-	i2d_CMS_bio_stream(b_out, cms_out, NULL, 0);
+	err = i2d_CMS_bio_stream(b_out, cms_out, NULL, 0);
+	ERR(!err, "writing CMS signature to %s failed", out_path);
+
+	/*
+	 * File BIOs wrap stdio, which buffers writes; small payloads will
+	 * report success from BIO_write even when the underlying file is
+	 * full or otherwise un-writable. Force a flush and check it before
+	 * the BIO is freed, otherwise gen_sig could exit successfully with
+	 * a truncated or empty signature file (e.g. ENOSPC on /dev/full).
+	 */
+	err = BIO_flush(b_out);
+	ERR(err <= 0, "flushing %s failed", out_path);
 
 	BIO_free(data_in);
 	BIO_free(b_out);
-- 
2.53.0

