Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7609DDF4C
	for <linux-security-module@vger.kernel.org>; Fri,  2 Feb 2024 03:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706845521; cv=none; b=G/qPOJDB4QHKiJnVnpG4ZhE7ivrCdSYcEAmamsjKOUslccizqQt9g1R9UsOgr1bI3c+EMQg8hqBy3ADI17PPKAhUbyu8g9mGyymggGOXs0sXE/gMAzmLzOlirnDRAwjmA2OH269RX9E2gZqhHUtcDI4rRtoQITlkErpa7lHt2ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706845521; c=relaxed/simple;
	bh=+sLC3/sMdldqreq8t261If0XmChHH3bybwx3J4jsT04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fSB2iHUOcCfEpoIlb2NJWDdG6cLxRJxEI7j1yCL9RFVe/2eVKvGzXW/L837x0kC9d+7QA7oyzysoLaSkdone9UM34Hp0R4800GbK3nmeGoBxx5zyxvQxKqIQuMg2pbZO/MtPJTQzsDtFDzk8js3igr2Qgpvf9vVx+gUENjpeyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wkJwZkbb; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wkJwZkbb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706845516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FhDGektx+3oTkSzeRUpmjCM+yvBN/m1UWuemA9fuCj0=;
	b=wkJwZkbb8FTbQTYUmMCc+6wPEba6MbtYyoGnztwdtyD8u/BcuMHY2UAmU4/DrWiR/yr6Ik
	SJLMf1jvr6mRpoFs2k8hZtGv2LX/KGDpgHacW78RxbLQRk1H2juR0LGq5v83zJAEyQrS/M
	6LiXrWwld7xmuiMo19amcNbhO01whQo=
From: George Guo <dongtai.guo@linux.dev>
To: Paul Moore <paul@paul-moore.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: George Guo <guodongtai@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Modify macro NETLBL_CATMAP_MAPTYPE to define a type using typedef
Date: Fri,  2 Feb 2024 11:44:48 +0800
Message-Id: <20240202034448.717589-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Modify NETLBL_CATMAP_MAPTYPE to netlbl_catmap_map_t, which is more 
readable.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/net/netlabel.h       | 8 ++++----
 net/netlabel/netlabel_kapi.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 43ae50337685..9f8387fc7e27 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -145,15 +145,15 @@ struct netlbl_lsm_cache {
  * processing.
  *
  */
-#define NETLBL_CATMAP_MAPTYPE           u64
+typedef u64 netlbl_catmap_map_t;
 #define NETLBL_CATMAP_MAPCNT            4
-#define NETLBL_CATMAP_MAPSIZE           (sizeof(NETLBL_CATMAP_MAPTYPE) * 8)
+#define NETLBL_CATMAP_MAPSIZE           (sizeof(netlbl_catmap_map_t) * 8)
 #define NETLBL_CATMAP_SIZE              (NETLBL_CATMAP_MAPSIZE * \
 					 NETLBL_CATMAP_MAPCNT)
-#define NETLBL_CATMAP_BIT               (NETLBL_CATMAP_MAPTYPE)0x01
+#define NETLBL_CATMAP_BIT               ((netlbl_catmap_map_t)0x01)
 struct netlbl_lsm_catmap {
 	u32 startbit;
-	NETLBL_CATMAP_MAPTYPE bitmap[NETLBL_CATMAP_MAPCNT];
+	netlbl_catmap_map_t bitmap[NETLBL_CATMAP_MAPCNT];
 	struct netlbl_lsm_catmap *next;
 };
 
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 27511c90a26f..a8fa336be1cd 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -610,7 +610,7 @@ int netlbl_catmap_walk(struct netlbl_lsm_catmap *catmap, u32 offset)
 	struct netlbl_lsm_catmap *iter;
 	u32 idx;
 	u32 bit;
-	NETLBL_CATMAP_MAPTYPE bitmap;
+	netlbl_catmap_map_t bitmap;
 
 	iter = _netlbl_catmap_getnode(&catmap, offset, _CM_F_WALK, 0);
 	if (iter == NULL)
@@ -666,8 +666,8 @@ int netlbl_catmap_walkrng(struct netlbl_lsm_catmap *catmap, u32 offset)
 	struct netlbl_lsm_catmap *prev = NULL;
 	u32 idx;
 	u32 bit;
-	NETLBL_CATMAP_MAPTYPE bitmask;
-	NETLBL_CATMAP_MAPTYPE bitmap;
+	netlbl_catmap_map_t bitmask;
+	netlbl_catmap_map_t bitmap;
 
 	iter = _netlbl_catmap_getnode(&catmap, offset, _CM_F_WALK, 0);
 	if (iter == NULL)
@@ -857,7 +857,7 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 
 	offset -= iter->startbit;
 	idx = offset / NETLBL_CATMAP_MAPSIZE;
-	iter->bitmap[idx] |= (NETLBL_CATMAP_MAPTYPE)bitmap
+	iter->bitmap[idx] |= (netlbl_catmap_map_t)bitmap
 			     << (offset % NETLBL_CATMAP_MAPSIZE);
 
 	return 0;
-- 
2.34.1

