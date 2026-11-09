Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794195048;
	b=gnOlPqBR+ttyg1TbJpsAmZ1A3+vHiah3DZwmHh1czLihcwf+AJnS/o5uZNIlZvTWDQ7w
	 QP/Q3IpbLzYq+nrsR3QeI3NWPC0eMg7Zq81YVRkNooBOOWnIovD2EnTlOKwGEQIEpwwgY
	 gxew/ctOaDOp+6fibFudZTWiiPjnbOkhi7hLzxop7XtomJQytazk95JHBAjYr8RHXiYJO
	 ka5JvpvO6D/I9TGFCUBgQJploQ9mfsTUQqfRbmIDvzxk35biZd19EXgJPXNhiPTe9T9wP
	 WH92Mi1lgqmrFxi/KOu2Rk5Mo9xBw9NxypxBKczzo3cINNuCXuywhxUb7caZ7BErI5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794195048;
	h=DMARC-Filter:DKIM-Signature:X-Original-From:
	 Content-Transfer-Encoding:Content-Type:To:Cc:Mime-Version:
	 X-Lms-Return-Path:X-Mailer:Subject:Date:Message-Id:From;
	bh=n+YkuDyPdUfR5lqnlx8AJWXuOw7DyNRylU3/lch8jfk=;
	b=AVwL75AQ1mgYuxz/ZHZfx7l85qoCuTMvs1lHfZipbxqLKDpSbKFSQz45GfGMXyQ7X6gu
	 vKP2v1NmktUNrg6n1NETNCfamCPHLoBC/8fd1PvVyNJ0vNigkLjRH0/RrIzW0KF7YJp+A
	 LJSNP/+aeDqxsPX8sWNbcb/ptynOBdhJ/bOIW0yWk+URSz6IZlkv7eBxlbLTFlSEyx5Yp
	 MgoQpuZcst0tgUQrcAnUwAB940tFyb+W8GPF56qVRuqFEP3yC1Vf/NBxTG8d6UiAZymdL
	 rFZLyXK+ggr8wKlb8X9uUocgTX5tSqTXhO0drgZfKRQOgmHn92PRvvvdXDhVfPo6ZGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b="b/SXpS2B";
	arc=none smtp.remote-ip=209.127.230.114
Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780F606A31C
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 03:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A780F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=b/SXpS2B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794195041; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=n+YkuDyPdUfR5lqnlx8AJWXuOw7DyNRylU3/lch8jfk=;
 b=b/SXpS2BlZ8Xg6kEkCfFi99iyrZTgRwdD2wVK86ImxPtRgVdinGuamYv0ip2sLPuifuuRQ
 OPjYf2wx2s+ZkYMixMjvpo+8NSdhERj6e4xV7+wqVqviuxA62B2c1CjLfTgVmwflhA9LpW
 ja/mtzup0WZPZss4xYJCNiBi0dOXC0YIICRXUfmDSnTrFaScLVrZitaAJR4A14VlkbHhaB
 J2AdFnwUDSERGHTvbW4CTQDMNzh/quG87M6fJljWBS8IJwEe6T+dBOyVgoip2kfPaXjGpk
 OgZfP0c6G/y6LobQ0hRtGr3pBiw4N/etVUKwjAMaXJYKl7mKelkILaSGdH3Uzg==
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: "David Howells" <dhowells@redhat.com>, 
	"Jarkko Sakkinen" <jarkko@kernel.org>, <keyrings@vger.kernel.org>
Cc: "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, 
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26af13e5f+040cfb+vger.kernel.org+weiguixiong@bytedance.com>
X-Mailer: git-send-email 2.55.0
Subject: [PATCH v2] KEYS: do not let an unmatched key decide the search result
Date: Mon,  9 Nov 2026 11:29:20 +0800
Message-Id: <20261109032931.80406-2-weiguixiong@bytedance.com>
From: "Guixiong Wei" <weiguixiong@bytedance.com>

With the dns_resolver key type available, put a key named "foo" in a
fresh session keyring, revoke it, and search for "bar":

  keyctl new_session >/dev/null
  A=$(printf '127.0.0.1\0' | keyctl padd dns_resolver foo @s)
  keyctl revoke "$A"
  keyctl search @s dns_resolver bar

Results:

  keyctl_search: Key has been revoked

The search returns -EKEYREVOKED even though there is no key named "bar".
It should return -ENOKEY.

A dns_resolver search walks the keys in the keyring and uses
dns_resolver_cmp() to compare their descriptions with the requested
name. When keyring_search_iterator() sees the revoked "foo" key, it
records -EKEYREVOKED in ctx->result and skips the key before comparing
its description. The search continues, but without a match it returns
the error recorded for "foo".

Call the match callback before checking for invalidated, revoked or
expired keys. A nonmatching key then leaves ctx->result alone.

Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
Reported-by: Jarkko Sakkinen <jarkko@kernel.org>
Closes: https://lore.kernel.org/lkml/avDG8G-Jl1YsmfCs@kernel.org/
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---

Changes in v2:
- Explain the wrong errno using Jarkko's original reproducer and output.
- Clarify that the search continues after skipping the revoked key.
- Add Reported-by and Closes tags. Keep the code diff unchanged.

v1: https://lore.kernel.org/lkml/20261108131413.12012-2-weiguixiong@bytedance.com/

 security/keys/keyring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 7143f3079d200..39645b8f9b30c 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -598,6 +598,12 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 		return 0;
 	}
 
+	/* A key the caller did not ask for must not decide the result. */
+	if (!ctx->match_data.cmp(key, &ctx->match_data)) {
+		kleave(" = 0 [!match]");
+		return 0;
+	}
+
 	/* skip invalidated, revoked and expired keys */
 	if (ctx->flags & KEYRING_SEARCH_DO_STATE_CHECK) {
 		time64_t expiry = READ_ONCE(key->expiry);
@@ -617,12 +623,6 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 		}
 	}
 
-	/* keys that don't match */
-	if (!ctx->match_data.cmp(key, &ctx->match_data)) {
-		kleave(" = 0 [!match]");
-		return 0;
-	}
-
 	/* key must have search permissions */
 	if (!(ctx->flags & KEYRING_SEARCH_NO_CHECK_PERM) &&
 	    key_task_permission(make_key_ref(key, ctx->possessed),
-- 
2.55.0
