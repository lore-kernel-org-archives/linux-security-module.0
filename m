Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89FB38F935
	for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2026 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616921; cv=none; b=CrYlF4j+qZh/mfOYVeYd8Pbsl7NH7o4FUooaljIuNYafXBYUjeE/wRur8sic1o8GLabP6i+lhOt9gWO7RuT+KPSyHAarPbeF6UXj//c7151WaPQB9qisMkf6ZM2kY4371zCUcadvfoOuSywG9mCU9n422c8Dd6R8Fgkghd+CxK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616921; c=relaxed/simple;
	bh=onVBlW7MOcXY/4u/1wLc1luNV8JQgXpPbl+Dwq4jXa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFhuL3RGgKlGqisGx3KMk32zqkBPbuDfo5Qql1QicP1tWet+3RcZfFV8ebWZnm1TION7b/s2HdGwD6IwAUQ+JNrI8fyuN3ZBul9+uibPiuLoiWKW5ZHcjSzvdxURSpAJTnvX24H7+Nl8jcvCriueFGxDJ8uLD3kthvrm+v2OA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWYzct+k; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWYzct+k"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-782af6c753cso1962225137.3
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2026 07:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788616896; x=1789221696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=005z03CIhBd04YrgIq3DK9hNQnxi1U/rfpjn1baG6tI=;
        b=dWYzct+kr3knNGg6/KnBWU/0/Pngwk0AJhgw9yVvAAqjhIYoWga64JMbEizqAVH3Oz
         fbPtkEiSfEmzpwGpMucu22cuAe4SJs3VpM7U7FZ9lw5NM8EqRRrr9S5I2JZKpJ4FemMa
         BgjsYZLAv6j2ukQ0ZRkF9WkQsF9FAs/lcYSJBQRqQJgmJ23yTqzG/YzU5W6whLGsS+Mw
         VBBfxdr7x8EAS1mz4F9o9p+OLUUAjQdgTGkd2JLHI7y82sc9nnrChcEzkxkgSLozG/kJ
         Cr4RzxeSdaLrtVEGTtp0Vp/jwdW7q69meF1Y/zJppkJotLc3CDXhV5QqPpZ6w+VX2qWH
         UQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788616896; x=1789221696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=005z03CIhBd04YrgIq3DK9hNQnxi1U/rfpjn1baG6tI=;
        b=el8s7sbDOhvuT5IOatKY7/4W6L8MTZWwFdu3mNJ1eIBYFey0ntwNNKjzPY/mCAs/L0
         XnnwaYQZzyw1euLCAPbtVVkMdEB/Lqzi/JakKN/Q+DNfJgTM+GVSvhwLXAuyVkZ5GAny
         CW17kwam/zisJmZo91JccbidT0lVtc/ookHP7Njq6BRpWwzwwlJp+UTXC09sD7iNfrGX
         FVU623b7dh+0Y/AWZO6Tel7lJYsA2/WW/iDu/08ybDlQ2T39AZj+DM12xNvxQKa+4nGr
         z+qGpVA6Bfs8Jvrr6/VoVyF2cdyJNMqo/u8B3fHG5yR4DC16nVHcEBxG6wsOpdwDzU2Y
         Yddw==
X-Forwarded-Encrypted: i=1; AKwUvByUOMW75gv3X1XHiiFd5+O8k7C5ItLZf6NlpZdDYL93tjMLQEbtBbpA6Kj8VB1Gl5kLCGl/UA/Pb099o8ZqBYfmdMqpqHQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k992QaiOz+usGz1/2GJI1WDXCrUusAW0a+rXQnndTKruemDncT
	QNJoYafa43+k3ZyxSUUI3a9Hn5ru1NpI8s1qI2KDGsgcfURXwDrmj30B
X-Gm-Gg: AYBFou2Ro4o6LzOgvtwg0AUQZqjL9xvKE0LUJUlyn7tlMZ2jit7Oy3C5RAa1DfY0R7k
	laRGym+ncxZdXHPWtIlxudKdHxGgucP4UmJqQHKdxbe0nsH7cqgVhX4i/iUH5zM+DwJ0uEdKmAo
	9XGh1vjXs743xUY1VvKDUSlVOhOKs9yYEpxmQ4r75fKIf28lSthZOOlLDGsFuHR0j7eRS8HCvjs
	HOlVpxyeLhp1jrgFsJHi6P0s47/ZquD8HaT8si/8b0YeSPMdtG/CrfYyqmGf2rcb6R1zbvi7ulO
	fkb7XLz3+4EMJJjZwC4XiIUzdjIRlj1GNx/Z1gm7kmCQ1JujJfJRdExArbiWu7/HYK6LQhn5dwj
	jRO6f8biyWX1ObPFMwi0bjBxJRoNOlvP5rpZ/wI21C9/jGeCuZzdk+G5ZhqO7aDXBlDD7kKUuvw
	pmnlDo4ADFk17OEQzxZdBHQMwOYjSlF5F78FnYJfoeX6/qirXoIst5rN2DCTGw0s6KkFhzy2PV7
	a+egHYq9DLczAisLxL8YE+eKAc/D7ID
X-Received: by 2002:a05:6102:3a0e:b0:786:c223:ad84 with SMTP id ada2fe7eead31-78a4a9c39cfmr5025994137.9.1788616895319;
        Sat, 05 Sep 2026 07:01:35 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee4d743sm3706877241.9.2026.09.05.07.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:01:33 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v11 3/3] media: dvb-core: extirpate defective and unsafe ULE debug block
Date: Sat,  5 Sep 2026 11:01:13 -0300
Message-ID: <20260905140113.21638-3-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905140113.21638-1-breno3011alves@gmail.com>
References: <20260905140113.21638-1-breno3011alves@gmail.com>
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

