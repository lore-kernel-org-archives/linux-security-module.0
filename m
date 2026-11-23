Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434306;
	b=d2fNFYnydL61pBjuYKuA9JoUONA6hhPAPvGAyla1i7fxUbMNVreE9Ls16hlksiQRgZ+b
	 tFT3hv7hro7rZEbGBfRGPDdWEDjlsQjtZRgsNNfWf70IykUjq1Tg3Vyv6ikjsDV7DoB83
	 2oJ0zpeJRe29jQ4NehROKzTpH7/v8xQ6yshiklNl5H8pPhtFBsa/iY5h1YLsNTFgupX++
	 4JKblT4gU4pNR5uTyay4HNBb6w16CiXEeGIJZb5wSXzNm2ZGPjehB1X/loBHqCpEXkW/A
	 UKjqclvPfKEZco6jE+IK+vZAuE1FvR5n11ZsZlSkwIbSdR4FoAR2X67xEFuE9ROcv2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pVqS5lS0RoTOTBL4CoDpn/qs9ZBbwa0oy02KVDKJZu4=;
	b=3NS3skyh5lv/mYH+wutR8gSqH1BeOmSna8V2TRnZQlTKCgVWdBwcj8VCsk4XnFMhd294
	 uF/mldTh6EbqvyYFM3WyucZT4ybrogLYgurq1BXtUX+h0o3f9AdTzG4zpQPr1CnCuPKF9
	 9g0HF8NWzIe700jWIw5lFyIkrdIjzHb2PNXUKKaA+X0UMtmUGP37WraFAAuyNUeoAy4Kz
	 WcGhFEE+Iv5cNlNlngv7cgTpwL/hd1x4ZK5uf4q8gipLopwx/IceMt4YcAFGkFEFJI91O
	 63yTg5EMXEGb8fNATxRke4NN3Ms9Pg4kI/GASux6+oHpsuZ0cCSPyn+xl+q/IuY4bgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YHJMp8Bm;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9B606A327
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 11:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BC9B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YHJMp8Bm
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a315ed211so4074377eec.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 03:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1795434305; x=1796039105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVqS5lS0RoTOTBL4CoDpn/qs9ZBbwa0oy02KVDKJZu4=;
        b=YHJMp8Bmk8/Y5UGI3WO+C/4G37ilVZeCpz7VnZ7ZI2IEqbBuGcd/bi+hG2XsQHt0u7
         um+s77GVp+2kloGsHhii9lNheqXIJCDiWwoYZG38b3ObmOX4hBZ0pYvhqgAorDSuz1n9
         roxIut84FpOVTZ4fqXz+GvpsVZxTIycJSxLESdALF462vjsH2nqeASBtJr4ZWVNM0qgr
         gT/KLKX8kxCCh0S1zIh3TIdwb3XU/uJYwxtVIGxau2qZTdn5ztZMfTG/C9uru6fQimLZ
         Fh0iyxte36lYEhK1do5rJtSxdFpMh5s6nMhI8OITJZ+WoWcqjfyqesDbAqJRyImOmISc
         Y/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434305; x=1796039105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pVqS5lS0RoTOTBL4CoDpn/qs9ZBbwa0oy02KVDKJZu4=;
        b=JQqi1NWbnNXNAkVbSJLaatPYVlF7vU2g5mqsotwZj2nldvId2QIDeP3BhNx/JGkEYI
         Ozup8IhqWYsN2NUdgjMXUie4VoE+rjlE3rT+CZhh32Od8qKNeIrdiyjtGovdMi2ATcWP
         vZgHdVLU7P/achFeVUSCrCElBtLY1ssbrppI+UQfMkStEpuzZDivYIaMd1w7mPZZ9ohh
         WIXLzpsm1h0d71KCel+NthLRlXtdeGk6EN1GZHoTDXECvgRpS2j0c50FfuhuirlrUa30
         34lHvJyYtBlFixoqzgcFBRUHEL2vaGNv2VuD6IOtRjjkhE1f1URo+sqZWAC9qSksJZUe
         FsIA==
X-Forwarded-Encrypted: i=1; AL+hErENiqRCNrRuOKvfyXW5tjIe7/kEFl96YEie+oIOrNC5kaQkA6ONe82akr4ND94b7lxlweRgk0WwZOOVFGoGN2qbriPRh4s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RYVnP9oPhrnCiQz2aBUt+o7Pi3b0y9UrUKoX1p1sBK2BWq5AH
	saFJUhsP6ymz8Sjz3cax3mYcYT+kI7ojXkYFQN3KPI8XH95Ew8PsuZcDo5qrbiOKkmtu
X-Gm-Gg: AZFdTZfIsflB+aCVvjqNNahbZjHiGqgQbUSFwiy4k3I4fqy9B7DL+sVyKYpv191tMni
	4Z/o7AgBIpR3qQLxUvfMtNLI3rKtPr54dC7UKWy0Yu6WUx8I6P7QvJDKuk7xZURJHkp9zEmh5De
	7oHshEbZnbsVWcRElG93qtHyU+/ur/6y+Mx2tErbOhZDsW0QpYe9MQ55f3hPgDpWk87jRa0oqYs
	NPP9QpcjBeUTQNUUH2uK3NXvOO7U/KW1yO5NwU6grFM0G5r7vdSUCzsTSs+fUZvdSMQ/MqI2Ne9
	IifO5/nSx5/K6JXKm27Bz5gxaIq+hgN5JcPI0nB9k4q8BIekxCfu2qr6/jozAAiO6bbMIS2jOAx
	dVWIyz4VkgJDeXeMGjms4R4G9RfEOuHQ2nSxyi1b26ULhkuM8Zhm5rGyhQGsCK0QmoHy6DuVWkp
	FrRN7JpNPmZfOwcMZ+JVIiayHb0t2VMvoCNHHXjej07cCzIDGW2CCRhgevKgiCvjyCfZrjhkiKN
	J17+a3eUmLacB/rXC7yqqnA+lzsplfvL5cIH4ZrNsthwrtccO8ntztVDYZBvaLS3VRWaag3l6Mx
	LCXyQTzO8Fd2bfYus0k6BLkYu+htm/fvKHkmcD0AxtKwHHehR+ru9g8eQYQLgZXAiy/wvJ4tW3h
	nmT1PvHqW6r03AbfxcP2zR1g4Co8r129LfNAMBBe+nWmfUQvYJ5tzMQ==
X-Received: by 2002:a05:7301:4283:b0:386:96fb:28c with SMTP id 5a478bee46e88-38696fb2022mr9810486eec.18.1795434305311;
        Mon, 23 Nov 2026 03:45:05 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:14e:94e0:654e:d7ff:13d2:447d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm41943583eec.10.2026.11.23.03.44.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 03:45:05 -0800 (PST)
From: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>
To: bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org
Cc: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	David Hildenbrand <david@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jmorris@namei.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kees Cook <kees@kernel.org>,
	Ketan Bhardwaj <ketan@armoriq.io>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: [RFC PATCH v4 6/6] MAINTAINERS: add an entry for the Kernel Assurance Plane
Date: Mon, 23 Nov 2026 17:13:08 +0530
Message-ID: <20261123114308.8103-7-harisudhan@armoriq.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123114308.8103-1-harisudhan@armoriq.io>
References: <20261123114308.8103-1-harisudhan@armoriq.io>
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

Add the KAP maintainers and the files they look after.

Assisted-by: Claude
Co-developed-by: Ketan Bhardwaj <ketan@armoriq.io>
Signed-off-by: Ketan Bhardwaj <ketan@armoriq.io>
Signed-off-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8..0946d151e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14118,6 +14118,16 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media.git
 F:	drivers/media/radio/radio-keene*
 
+KERNEL ASSURANCE PLANE (KAP)
+M:	Ketan Bhardwaj <ketan@armoriq.io>
+M:	HARIHARA SUDHAN. R <harisudhan@armoriq.io>
+L:	linux-security-module@vger.kernel.org
+S:	Supported
+F:	Documentation/ABI/testing/securityfs-kap
+F:	Documentation/security/kap.rst
+F:	include/linux/kap.h
+F:	security/kap/
+
 KERNEL AUTOMOUNTER
 M:	Ian Kent <raven@themaw.net>
 L:	autofs@vger.kernel.org
-- 
2.43.0

