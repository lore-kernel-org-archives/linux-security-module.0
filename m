Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466350;
	b=WfYI+OKrg8bsVhukfEgsQIOvIoy5qUHKUtGVyTzgMEe75A7fLGxrzb9g65zeTVtS3Azk
	 qcQYldNezwxNdpryh9CEJ5tSydR2oURR0IOU9IJuNg59WJ+C9ct0RmM4P3vWKDgVxqL0i
	 H8MDzVXdrEL9oauhqh0xsumLHf+qDgsoyBi9Z3eiEWieyUVxho/v4oXjsZaRSiVA4SLZ/
	 KWdWRPpfpNT32u84j91JTDJdC9+B0q+nUPOht6a3rYUgRa7gxZ9pW4QfbJjbJK0h2F0qr
	 M1KPEJv/QyF1tzVsstbyJ4X6z6euxgmvDEvLm4SLnzi9z4F/pcnaNEahGIefyujquPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466350;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=lq8zToKm5HSkMZE8NnYf13h7JPJ8/IiL1/bQ66ONl20=;
	b=cUlhF+gRb0LgnbDaWqzwO7/5pSbYEOb+MPu5Koq5MTKZJAsGgrHhjzgJhWJIFrlzinag
	 3maTCXzv2OlqCrMTGCTrc4j+Q32MA5yFCYhEAs8uck8gDyfHWVSziN/RzzYqQouTQ4X6I
	 N31MvWE5PavNirkP1TO6bLIdx/dnTjjHuP+IUX66yPER9mluC8201/QUSXyaBmQ3bpONa
	 gBeJkDz9NDDOGXD4EIvTYDFbQdz8xs6ZuTbDXD9fgKH84b6hRFZ2LuONdgqzrF1FM61Sq
	 2XgC27gNfPQi+cjEyoGw8EtW/us5X1onynjqJ4XdFewbSrSE3Jf0NL2t4ndF5EJt1Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=EJZPT9Gr;
	arc=none smtp.remote-ip=117.135.210.7
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1A606A32D;
	Thu, 12 Nov 2026 06:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0E1A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=EJZPT9Gr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lq
	8zToKm5HSkMZE8NnYf13h7JPJ8/IiL1/bQ66ONl20=; b=EJZPT9GrZYrCQQIXDX
	G88vjTMVkTanXeK1rTwMol8+B53vWpBhh0dNqmQehD1q8wbO4Qqo/zrpv6vY6omq
	KAhcIN0InzndXhH01FgRpFH9Y8W/JoapXFhnyrP4OB+jEeX5dCuqbB0cdlelfSo1
	nNHJD5KUmSDJuSpnnDL+1bhvE=
Received: from kylin-pc (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3P8UXYvVqLbJWDQ--.30997S2;
	Thu, 12 Nov 2026 14:52:08 +0800 (CST)
From: pandaWall <mangosteen922@126.com>
To: mic@digikod.net,
	gnoack@google.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pandaWall <mangosteen922@126.com>
Subject: [PATCH v3 1/2] landlock: Fix layer composition of LANDLOCK_ACCESS_FS_REFER
Date: Thu, 12 Nov 2026 14:52:02 +0800
Message-ID: <20261112065203.1066536-1-mangosteen922@126.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20261112025528.443654-1-mangosteen922@126.com>
References: <20261112025528.443654-1-mangosteen922@126.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgD3P8UXYvVqLbJWDQ--.30997S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1UKFy7tFyDKFWktF4UXFb_yoW8uw1rpa
	yxJF15Ww48KayS9F1Uuw1xWFy3C393Gr4UJa13K3y2yFyDZrn5Wr429wn0ka1UZrs7ZFZY
	vr47Zryqga1jg37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pt2NW_UUUUU=
X-CM-SenderInfo: 5pdqw0pvwhv0qzssqiyswou0bp/xtbBqhi2rGr1YhiUSQAA3Q

landlock_get_fs_access_mask() unconditionally ORs
_LANDLOCK_ACCESS_FS_INITIALLY_DENIED (i.e. LANDLOCK_ACCESS_FS_REFER)
into every layer's handled filesystem mask.  Layers created from
rulesets that only handle other rule types (network ports, scopes) or
only permissions therefore report REFER as handled even though
landlock_upgrade_handled_layer_config() only adds the bit when
handled.fs is non-zero, and no filesystem rule can ever clear a bit
of such a layer.

The consequence is that stacking any non-filesystem ruleset on top of
a filesystem ruleset makes link(2), rename(2) and
renameat2(RENAME_EXCHANGE) fail with -EXDEV/-EACCES even when each
ruleset individually allows the operation: landlock_unmask_layers()
requires every layer's mask to be cleared, and a non-filesystem
layer's mask can never be.

Only implicitly handle REFER for layers that already handle
filesystem access rights.

Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Signed-off-by: pandaWall <mangosteen922@126.com>
---
 security/landlock/domain.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 935e18b12..07d4a23fc 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -262,9 +262,18 @@ static inline access_mask_t
 landlock_get_fs_access_mask(const struct landlock_domain *const domain,
 			    const u16 layer_level)
 {
-	/* Handles all initially denied by default access rights. */
-	return domain->layers[layer_level].handled.fs |
-	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+	access_mask_t handled = domain->layers[layer_level].handled.fs;
+
+	/*
+	 * Only layers that handle filesystem access rights implicitly
+	 * handle REFER.  A layer that handles other rule types (e.g.
+	 * network, scopes) must not imply REFER, otherwise it would
+	 * spuriously deny link and rename operations.
+	 */
+	if (handled)
+		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+
+	return handled;
 }
 
 static inline access_mask_t
-- 
2.56.0

