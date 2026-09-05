Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518483515EA
	for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2026 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788618152; cv=none; b=qM52r8+fBVjdTOxaZM2/L+lKAXgIn2uHsieZb7YZQuaEq9qfDUuHP/OGJq1SKvO71l3LzwpaphVU1jsYfTi4PtDRTkNR0t6QJn9blZ0gjYFAx9hgGb2yQKvNvfnDHmDWL+faf3I84Xb0xGTg8kEfnxJPSNmp+wzS8zpT4n0/0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788618152; c=relaxed/simple;
	bh=onVBlW7MOcXY/4u/1wLc1luNV8JQgXpPbl+Dwq4jXa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpPAwpgAlL27B6lFLlAScLFvMilKUeYOE/qLDK+dMkgYMNss+zv2bNs6PvN5pZVg7h5/SEIdHjnjQKOWsFtNtLEkBiZr7CL9kwcFnY/xXx6UpV4NBhfDqKwxHLU+jQ0MohvN/gv6nXcgy3hQZ2Z6/6U71NhW/sMcB/JQidXg14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/hNJN39; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/hNJN39"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d8fd3b729dso16921735ad.1
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2026 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788618147; x=1789222947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=005z03CIhBd04YrgIq3DK9hNQnxi1U/rfpjn1baG6tI=;
        b=c/hNJN39rjgbVh8w0XjfqOqL4Y658Q6hGf2lAhAV+DtF1ml1UIvc0b6DiG3ihMlWMU
         7A0o7+QAUU84hpZvF1XGpe6mdl7odM5QA8haXWbAdiDwWAsv+tYF5VOfWhUWwKpTeNcM
         7Jsa4mbpI+St1q3oE4xF2Gf32bkhNVBkw7A2Utum4oaqv0PVkrHp7ChS+wUcAiPRDPHn
         t7n0VkOya2RabVLMaTc/mVBi3XHRFEzvlmK+2bgwT+zfCx3wA8Cz7RONZOlGlmkmx/8y
         vsSF1YVI6Ofi4x4ciXMY/oTmbYje0zsSyCcQ1wA+972XeZVOxuAH1PUXRP8/IqRAz6cD
         CtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788618147; x=1789222947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=005z03CIhBd04YrgIq3DK9hNQnxi1U/rfpjn1baG6tI=;
        b=ftauzP4NYZgApWOaSoY/Omme61ZE8ZOVnxQwV5AKCOBeuxA0/JxkdGKdZ8n9taX6y2
         x8ntNUhLvOZS3uy3Tc6+wN1ugz6dGGn3JFgpYEXwEnRTpCoc/qVfE+lR22z3z/yAbnXM
         xDFHF1UhV1iU9TyPWyqi/yHy76BGFtKB5KPZt+/qL35za1W7HbAyRQEjC8X5VydBJSaw
         EoLQw6BAqpqKmYx8EJnzOeh8Bjf9BqK47FKr+23TmqydTcmlxza+AS1UtZxPp6lMrTTa
         DwsC6Mv9kuz2Cc2z8Q+SnHekivUjnUafcVwWvTLfNimQxLWGIwh9Qg47uKI8lHEyseZK
         aPpA==
X-Forwarded-Encrypted: i=1; AKwUvByBqpa9X0CfXx9phzMS+jkYQfoHWgw0DeojPj32yo6P0u0y+/5WyNt7OBslrQzBrIw2H4nMARMViT/ROyPE4a6IKyR4tTQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lH6DHVgm2L4RJMTeHmAZBA2GSZ3Dv6UaIvy97mnimiqavkMB+q
	bnfGbWgs+ZLYWDqfK36U0PxsixtrMphPPuMYePr5QKvAvmnhRi3jTS/Z
X-Gm-Gg: AYBFou1FVJCaohdnsa3hfGgwxYTQMKEbF/LfAl642KVUtZ9Dr8nFj1wjxuhC7KGRLiF
	4APIRfjQXpzIr2TZ8oQX1ZBnpNYsMQKgFAJ1POxn09tavkGHjBSAJE7ySzB6RJUWRfkP4CWd7aT
	V9w1X5WaqeS31gsvQcd8DhD00SqrogykmgWO4XFCVvgJkeLh2BMKeLjORUX4lIiwuO96qdbiO/l
	9cU4A7pUBu5jBnQh4keun0pkT5gXET2gKgYgwe2STO8IgyeLN0xb/1KOILHZ20Rsfm7K4Vt11u9
	B6BBLaiFsIdOXAX4z1oAin7atqzI1IWCMUi64pcHAe+duJ0EY7z3DdNWfN0WGWexgf87uEh9veU
	qdiLBeewEiP3023kwp3/lsNZTXIwJAXIldl2l+rRiWGxv4zjAXyo2EkCyo8bqYXdskjrKqVnwan
	2Ip8b1bGsf+rmZMPDRKSh7/FZnxs5bjF2HAWb149thiXTHY6U6V5WToxMK8l3lgTFhs77tSconF
	NtewNOVddxmgTeYSVJUT+9ZSWHxsWcc
X-Received: by 2002:a17:90b:2784:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-39b26272bdcmr22265404a91.16.1788618147352;
        Sat, 05 Sep 2026 07:22:27 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243a9388sm13347645c88.10.2026.09.05.07.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:22:26 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-media@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v2] media: dvb-core: extirpate defective and unsafe ULE debug block
Date: Sat,  5 Sep 2026 11:22:22 -0300
Message-ID: <20260905142222.22818-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Completely purge the unmaintained DVB_ULE_DEBUG code block from
dvb_net.c and its Kconfig definition to eliminate severe lockless race
conditions and clean up the unused function signature parameter.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/media/dvb-core/Kconfig   | 11 ---------
 drivers/media/dvb-core/dvb_net.c | 42 +-------------------------------
 2 files changed, 1 insertion(+), 52 deletions(-)

diff --git a/drivers/media/dvb-core/Kconfig b/drivers/media/dvb-core/Kconfig
index 8b3f2d53c..c6a97add8 100644
--- a/drivers/media/dvb-core/Kconfig
+++ b/drivers/media/dvb-core/Kconfig
@@ -67,14 +67,3 @@ config DVB_DEMUX_SECTION_LOSS_LOG
 
 	  If you are unsure about this, say N here.
 
-config DVB_ULE_DEBUG
-	bool "Enable DVB net ULE packet debug messages"
-	depends on DVB_CORE
-	help
-	  Enable extra log messages meant to detect problems while
-	  handling DVB network ULE packet loss inside the Kernel.
-
-	  Should not be enabled on normal cases, as logs can
-	  be very verbose.
-
-	  If you are unsure about this, say N here.
diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dvb_net.c
index a2159b2bc..5060b8866 100644
--- a/drivers/media/dvb-core/dvb_net.c
+++ b/drivers/media/dvb-core/dvb_net.c
@@ -68,19 +68,6 @@ static inline __u32 iov_crc32( __u32 c, struct kvec *iov, unsigned int cnt )
 
 #define DVB_NET_MULTICAST_MAX 10
 
-#ifdef DVB_ULE_DEBUG
-/*
- * The code inside DVB_ULE_DEBUG keeps a history of the
- * last 100 TS cells processed.
- */
-static unsigned char ule_hist[100*TS_SZ] = { 0 };
-static unsigned char *ule_where = ule_hist, ule_dump;
-
-static void hexdump(const unsigned char *buf, unsigned short len)
-{
-	print_hex_dump_debug("", DUMP_PREFIX_OFFSET, 16, 1, buf, len, true);
-}
-#endif
 
 struct dvb_net_priv {
 	int in_use;
@@ -320,16 +307,6 @@ static int dvb_net_ule_new_ts_cell(struct dvb_net_ule_handle *h)
 {
 	/* We are about to process a new TS cell. */
 
-#ifdef DVB_ULE_DEBUG
-	if (ule_where >= &ule_hist[100*TS_SZ])
-		ule_where = ule_hist;
-	memcpy(ule_where, h->ts, TS_SZ);
-	if (ule_dump) {
-		hexdump(ule_where, TS_SZ);
-		ule_dump = 0;
-	}
-	ule_where += TS_SZ;
-#endif
 
 	/*
 	 * Check TS h->error conditions: sync_byte, transport_error_indicator,
@@ -659,23 +636,6 @@ static void dvb_net_ule_check_crc(struct dvb_net_ule_handle *h,
 			h->ts_remain > 2 ?
 				*(unsigned short *)h->from_where : 0);
 
-	#ifdef DVB_ULE_DEBUG
-		hexdump(iov[0].iov_base, iov[0].iov_len);
-		hexdump(iov[1].iov_base, iov[1].iov_len);
-		hexdump(iov[2].iov_base, iov[2].iov_len);
-
-		if (ule_where == ule_hist) {
-			hexdump(&ule_hist[98*TS_SZ], TS_SZ);
-			hexdump(&ule_hist[99*TS_SZ], TS_SZ);
-		} else if (ule_where == &ule_hist[TS_SZ]) {
-			hexdump(&ule_hist[99*TS_SZ], TS_SZ);
-			hexdump(ule_hist, TS_SZ);
-		} else {
-			hexdump(ule_where - TS_SZ - TS_SZ, TS_SZ);
-			hexdump(ule_where - TS_SZ, TS_SZ);
-		}
-		ule_dump = 1;
-	#endif
 
 		h->dev->stats.rx_errors++;
 		h->dev->stats.rx_crc_errors++;
@@ -843,7 +803,7 @@ static void dvb_net_ule(struct net_device *dev, const u8 *buf, size_t buf_len)
 				       *(tail - 2) << 8 |
 				       *(tail - 1);
 
-			dvb_net_ule_check_crc(&h, iov, ule_crc, expected_crc);
+			dvb_net_ule_check_crc(&h, ule_crc, expected_crc);
 
 			/* Prepare for next SNDU. */
 			reset_ule(h.priv);
-- 
2.43.0

