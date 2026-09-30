Received: from cvsmtppost25.nm.naver.com (cvsmtppost25.nm.naver.com [114.111.35.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC9F37BE6F
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 04:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741896; cv=none; b=QC0kQS++/l5Mxwqmrehw3FrgXCCo8oGFO0QTSBtID6jcT2PMOkqmZfh/1XCB0jrim7RDTGNooVekOMLkmwB1lZy5+wdi1TTNSMtu5UGrTXYoerwscbIOFXFiZ4QoMIndggaaA2L9Y/is2qJi1MNlLLgl/3OWTMv7tGrQImp24B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741896; c=relaxed/simple;
	bh=ZjTG9yNUbRoiE0GdcobNdfLoGv9hmanVKYDsL9+gTPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZH3Utg5WK+kcxs3+KogvzjkDIFEudSxfyvjIMveOqNu2G258ENSTuh1qqkb4G4HFRgMjuumfB3hFzUGz6ZllKrfV68cH1i/QagqhSRGWx2KiYQ/P+W7u8QHd+kHar94ukfGb2LOYX1pVOSHADLD0t84mTcswn4fdGEzUHSPVgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=tMholKOF; arc=none smtp.client-ip=114.111.35.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="tMholKOF"
Received: from cvsendbo034.nm ([10.112.20.50])
  by cvsmtppost25.nm.naver.com with ESMTP id cIcHOVscQ3C4Gj+21houBg
  for <linux-security-module@vger.kernel.org>;
  Wed, 30 Sep 2026 04:18:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1790741892; bh=ZjTG9yNUbRoiE0GdcobNdfLoGv9hmanVKYDsL9+gTPw=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=tMholKOFmOVQRy8r/mhwYyDoYf1AlHZBDgQ2N0RlDj2o+KMJSl/QVgRhyKWKHqU5m
	 C2xR87m7GrWVoeZmB9rGBDCJCt22gw/p6tjA7w6JA+XPvYe27eR0PoZ02pk/NTixvC
	 w1qguOoshfje4T5AwOLUI2Gw2fcGF17T+toBsFjnvtDKjeU0MZfNDJd139TcLmb2nF
	 vgjDsA8fUNI8fxzUswqkA+BIqoggRTHnA+M2e7Khf2XbbvSK/uPKxJhp5SmHIB6hro
	 K3FzMOprt3lVaMuZsIDbxFmIklnc0I60zfV3XmMYFthdlma5LffTJMCortrxMxGcUW
	 Pkrnyvcdu63Ew==
X-Session-ID: ns4qJ9EHSLqO6AP88x0C4g
X-Works-Send-Opt: OPRwpzGdjHmdKHFOMr39Ko3YKBm9jAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: /dYmFqglFqJZ+Hmwaxtl+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by mvnsmtp03.nm.naver.com with ESMTP id ns4qJ9EHSLqO6AP88x0C4g
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Wed, 30 Sep 2026 04:18:11 -0000
From: tjdqudcks0424@naver.com
To: jarkko@kernel.org,
	dhowells@redhat.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=EC=84=B1=EB=B3=91=EC=B0=AC?= <tjdqudcks0424@naver.com>
Subject: [PATCH] KEYS: Fix add_key() race with keyring restriction
Date: Wed, 30 Sep 2026 13:18:01 +0900
Message-ID: <20260930041802.6114-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 성병찬 <tjdqudcks0424@naver.com>

__key_create_or_update() snapshots keyring->restrict_link before taking
the destination keyring's semaphore.  keyring_restrict() installs a
restriction while holding that semaphore.

This allows a writer to observe no restriction, wait for the keyring
owner to install a reject-all restriction and return successfully, and
then link a key using the stale NULL snapshot.  The writer only needs
write permission on the destination keyring.

Move the restrict_link read after __key_link_lock() and
__key_link_begin().  The read and the subsequent restriction check are
then serialized with restriction installation by keyring->sem.

The race was reproduced on v7.2.8 in 19 executions where restriction
installation returned before the link completed.  All 19 linked the key
despite the reject-all restriction.  With this change, 312 executions
reached the same ordering and every add_key() call failed with -EPERM.

The issue was found by manual concurrency analysis assisted by AI-based
analysis and independently verified with a QEMU reproducer and kernel
instrumentation.

Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into a keyring")
Cc: stable@vger.kernel.org
Signed-off-by: 성병찬 <tjdqudcks0424@naver.com>
---
 security/keys/key.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index b34a64d81d47..a438c4508595 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -840,9 +840,6 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 
 	key_check(keyring);
 
-	if (!(flags & KEY_ALLOC_BYPASS_RESTRICTION))
-		restrict_link = keyring->restrict_link;
-
 	key_ref = ERR_PTR(-ENOTDIR);
 	if (keyring->type != &key_type_keyring)
 		goto error_put_type;
@@ -880,6 +877,9 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	if (!(flags & KEY_ALLOC_BYPASS_RESTRICTION))
+		restrict_link = keyring->restrict_link;
+
 	if (restrict_link && restrict_link->check) {
 		ret = restrict_link->check(keyring, index_key.type,
 					   &prep.payload, restrict_link->key);

base-commit: 6f8319e3e9a44dd537d17f41565a8453c560a581
-- 
2.43.0

