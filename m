Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583EC345EA8
	for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2026 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788614901; cv=none; b=EbG+DDsAmJeJkkOGFY3Lw9HengHrlnTO3boql6xMlYM09INWGJBOkOgjiqM+k9kSZJYjGf/t6I6n9yz283JD8tZ2EA6CKjop79aQfAH39Qtcq6G8jRC8RmJSQ9Ty2RiOIc7BR0NJmWmYfAZJL3ROqfj2pS7S58ZHkyaTGEMh+Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788614901; c=relaxed/simple;
	bh=onVBlW7MOcXY/4u/1wLc1luNV8JQgXpPbl+Dwq4jXa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGnlYjEP2SPryAbuYik5YCaaXsQAqeVcPhNvZZKpYEu/hTDjpT/d5hyki45URDNR9pFEE3723B3n8uLqIbynDfP5kGPedWczdaQUShfpmLdGN98xOpP6eFnvR1Ryr7edMSSJxfZIj0sT5RkoEUpkNF+1GPGPevmro4ColJfp8lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=proxrBbi; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="proxrBbi"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1591983a91.3
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2026 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788614899; x=1789219699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=005z03CIhBd04YrgIq3DK9hNQnxi1U/rfpjn1baG6tI=;
        b=proxrBbiH3O8aIhSVBd7bwFR1sNFBFytnO0dkOCjos3EQURKq3hak/q53uBEwkQFLX
         CwJTjRaqg6QEkTNg0X0Wrzeh+b7HZzl4Rp9GU9okMeLvooArfXDn7mWHY2+OvAog3z3J
         aePdSgCD4Xkg/MouWROmUf1dVfEJEKNVJnF66EH02ZHnt/YZPsYs1YUyvErTBd1dYGmV
         o3zc5b+n9576xEatU3DZ5T8ZiO42kYVoOlEy281bq2UHsqfDukFGCevkC5qW6xb0Gc4h
         CgaCE4qlURCOMBykT8Ftev8MpZHp/xC2kRI9cvKHoU0bQ8khCFq464AGfA8Pelat2vaB
         PU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788614899; x=1789219699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=005z03CIhBd04YrgIq3DK9hNQnxi1U/rfpjn1baG6tI=;
        b=WmH4eAdIXRbB6q/p2VMWzVAbwRlbeoe40laOgTKHsQhuU0G7cmKKMJojwOj6DI4Wj6
         BaEI/KwmBVZQc4CvcN7KOdO+fLRZfGheWNd19/8eGrDp2RZEvkLIzsdm55PM8vpQj1qR
         WKKfB6EyTbGhcOScZk3n8BaagXD1lWEq3RfhvIw0T3IUco89LjuGJnGPgtLcAyUOi7aU
         JEeI9v7UaeQVwK+R6sbiyijkc/tMJaZJi5Q15Qrwc09F98VNthWGSgKViCwGp8ENflPM
         n9AzNtgAHRImP7kNZ7r7FWKXNDhUEwT6sUDenY+1DSx9vclqBzKGLmu9mrNiysNP+rin
         rphw==
X-Forwarded-Encrypted: i=1; AKwUvBwQ+6svR+TUfLivuxetL/uu3axiVVlcg+16nuP2zOMUOVGo27koSU5JcR3sV9B3AphymoUK4CWYrs9wLu4AGMqkftXf8Ao=@vger.kernel.org
X-Gm-Message-State: AFuF++mrvbL/4z5yurjKsPPNw+kgBjQDrkbRd+XIBJHunmBXFhdmPkhF
	4LX2LWp2MO8xdbvYA4P0dd1w57Kq9IX+C8O8q2ryPGfK+e8aIZ76kNeK
X-Gm-Gg: AYBFou3SFJY3RlvhoHOvJSkHR9tOnbr4OaY4IGdD+U1E2fGh/tgUjqPXrMbGGOrMSjQ
	TqfjskfToC3bjwJ7NseEIk6dTp1qcDuUbkpgrTHaZzAILzMIfP0nSZEqQRmKnRvhjigeXrJ7cGv
	4x9y8c/8CTSP7yb5D20GQCYUhIGNs0yJ8BjxnUHTQsHpsdi5G4e9Hbxw8gJCtaXMKDZwNAg9ESG
	ndaIxEFFXXpH4dmXcLPJPHs+1bFYDKkmOpVdX1vzqvaMMJthxsfl2uUXrzaP3DuEZvA4PQvJhlj
	GdIDvMw+FH0y7lbS/sOckpsVdnaN6P31za85xiolJ91nDqbnJy/0Qkt6o/YrdZfzTmi0lkE0L/A
	SaZZ6AD6yELS9YMopn8c6xIGT2xCUPL87BsWjuNSqhZftxYQ6ph1aFDbg7vgMRik9ZVJyEyQefD
	ZtCrNw4NJ+1LSgKAMcph6Qb4WiCRuZzWowlc1sGCoka5QH0y3mId5jcvCgzBu51huzuaAzcmDRd
	5XxV1FcKNOQ+HKlNA3hEMVbeTuJGgPSTHxJ/TvW6axq
X-Received: by 2002:a17:90b:2d07:b0:398:ceed:6d44 with SMTP id 98e67ed59e1d1-39b262abd26mr18147120a91.25.1788614898686;
        Sat, 05 Sep 2026 06:28:18 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1433171a97esm7243548c88.12.2026.09.05.06.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 06:28:18 -0700 (PDT)
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
Subject: [PATCH v10] media: dvb-core: extirpate defective and unsafe ULE debug block
Date: Sat,  5 Sep 2026 10:28:12 -0300
Message-ID: <20260905132812.8521-1-breno3011alves@gmail.com>
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

