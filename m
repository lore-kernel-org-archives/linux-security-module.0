Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD434DEC36
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777063; cv=none; b=I1j8+sW1jSeIuJWguayPNpjyGnxVRS7OvaG39/1cCB714o2PC24vi3X7St3j4n+DJnTPuZmw0tfvhh0pqd4uJl/xFDxnfCULHc4RuHxz210HQH/xF80KkLKG1ha0mwg/obC830+Z/yoZkA20M5cZ7WKuhGfuuVf/dWGpvcMPaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777063; c=relaxed/simple;
	bh=dDRtbqYPrbcSZk8XTIR1mhxTewKaoQ7Hl8OVK4zyccw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSBnNJdfgxkBKM44oU35nFueBd4MbyB8mpOUPrHUCbVE/pEQyY6TDkytDIbOg+qFOp6ema/y2KqgUMXcXRzvAnCIDyM8x0OUxC0P28y1AHvgjZgmvDytJ8zM4VjhEkXRpSzUL9V6gRrxzugL2a7quCajIsqL2SFZ5CQjriOZB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5xr+1lP; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5xr+1lP"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7d1802740so748904a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790777053; x=1791381853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0/hVX4C+yQqwsDE4LgI16fX3ANft9SjFARlaoadqqlc=;
        b=W5xr+1lPy4kXFvznJdBdMZA81GHwJDOEyvkLvK1qXGzVdR54+Y1w/jnsnEsyR6XdYT
         73zya3usx/nxhX0b4L2cime9dP1bqlLPQ3STEAxH+8S2npascYUrAgmZi/6/u5HF95Co
         ke3PoUrv3CyQNK0D6VHRIw+WBIjiY6TWTFnwmdKqXwgfBEki7b4ovfMebRI2n0VdI3gy
         XDrEkkZguSzZ+18kiqVU/g9HsiQwo97wvz/JQTZBk2PZrz7pXPHEVcsUiNLx4ZTijRH8
         lpKBYou6V3WBUnRxDNbqbHiWO6Ll+JOMCKQY4B40EHHo+5GWEWC2PZFOQdHFda7/4iEs
         uJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777053; x=1791381853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/hVX4C+yQqwsDE4LgI16fX3ANft9SjFARlaoadqqlc=;
        b=hTocfQKnc2NEjEaHI9FRtgcRqkMhZJ/taoxF45oV5YbuywJmk6g+h4ujCBgeOT51E/
         OTgpPUIKrRVXkKLrRboctrATIkVt2YXG/fKmhz6OVEk4/S+jR3P6pxJzlNNG/+KmpIfN
         NYN7ZDkoD6NbZiwTEecerfhCxVxM42gAiIWKyCmj/LJCDt89RNIbKqyVaeUVc8svxnFX
         Ml7S2LRnDcI35O+MqfCJ3B9EeTE0uKo90s3mKYxULqFmycFkIGTA6W1vsjug6CWJdnjM
         nZ8QLUdlvn0LgZeWMrAF8/a7SQLkfJ94W5p526fXUY+3g9p5kPSWfQ+UKVivQmCOvOU9
         6Kzg==
X-Forwarded-Encrypted: i=1; AKwUvBxM6cLWyH+hyN6YJmVFaLGa9osxZZQNrqLa/3QrCeRtblpSpDigIeA8XhHIEc9x7bioKBbl3a/2O5HY8j8RzQV2CwWnm+M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMGygLjBla4rvhl8BIkHJIFwpYl9UKF0Xxpyf82FKa2w+fc/xx
	kPbitx4glNHghUV803U3sZyoiU7JjP6U/F+4vTZnxN98FpCXXMsuptd6
X-Gm-Gg: AYBFou1DSLVqFDc+f3BiCbk2z5w3r7QHnbrsy8wKKEWfjuxCK5/ekk/3f8rek/Qw2qv
	JkGzAJq3Xj2D888c8ivugboLeZovVp32KRZNiy32z4JvuNEgZU9nKnCmwDMUTZ+0ko6iKQl00ra
	V1XwFV3IjQESVqIa+/gcv9FQOnvA8wiBQ0yKdBogLL0nkyYVf8FkGrr1laavTvhz/Hs8bC6GUSo
	TjPRtvGOHMrSfKaCYhcVHjzq5PuHhiChDbP1Tnj/W6hlF2a1/9pYm02vJcUhjwI0BMu3cqTtG2b
	1dgPeWPezYrrirBHW4qwoLoO5aJsgsPOfWPmEWXO7Qi4HOpU71eCttaFyLf/nHtJNu/aC4Ya08c
	+xa00wBfRFK/OZ3RbMg9lNEZflQwfneIU23i1lmkBTurZPTOhA1Mh/T1VWOjb1bunZHXJxGUK+L
	bv4RMY+/iZxI8FvnEUZ4cssL4FQI6hTGis9z2KK8YOOinmFYOYpwymbYbpejVz6ZfbXVG5soyx7
	Qdk+fDGvRY=
X-Received: by 2002:a17:90b:564e:b0:3a0:d9ee:a2e9 with SMTP id 98e67ed59e1d1-3a4d18c09b8mr1192177a91.45.1790777052463;
        Wed, 30 Sep 2026 07:04:12 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7dab202f1sm1031140a12.27.2026.09.30.07.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:04:11 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net] cipso: adjust cached option offsets when removing CIPSO
Date: Wed, 30 Sep 2026 23:04:00 +0900
Message-ID: <20260930140400.2955466-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cipso_v4_skbuff_delattr() shifts every IPv4 option after CIPSO left by
cipso_len, but leaves the cached srr, rr, ts and router_alert offsets at
their old locations.

With a valid eight-byte CIPSO option followed by a seven-byte RR option,
RR moves from offset 28 to 20 while opt->rr remains 28.  The stale offset
then points into packet payload, letting the sender control both the
length and bytes copied by __ip_options_echo().  Setting the length to
255 produced this condensed KASAN result:

  BUG: KASAN: stack-out-of-bounds in __ip_options_echo
  Write of size 255
  Call Trace:
   __ip_options_echo
   run_cipso_stale_offset [net_candidate_probe]

The destination holds 40 bytes of option data.  In an existing
uninstrumented x86-64 v7.2 build, __icmp_send() places that buffer
immediately before its stack canary, and the 255-byte copy also crosses
the saved return address.  A canary mismatch unconditionally panics;
no canary disclosure or control-flow exploit was demonstrated.

Mirror cipso_v4_delopt() and subtract cipso_len from each cached offset
that follows CIPSO.  cipso_len is the logical distance moved by the first
memmove(); hdr_len_delta includes padding, while the later header move and
network-header reset relocate the bytes and their base together.

The adjusted input leaves rr at 20 with length 7 and completes without a
sanitizer report.  Natural remote reachability requires a configured
SELinux/NetLabel gateway and a later option consumer; the retained test
invokes the real mutation and echo consumer directly because the available
rootfs has no SELinux policy or netlabelctl.

Fixes: 89aa3619d141 ("cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/ipv4/cipso_ipv4.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index a05aa075de1a5..135b57c2c4f9e 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2272,6 +2272,14 @@ int cipso_v4_skbuff_delattr(struct sk_buff *skb)
 	new_hdr_len_actual = hdr_len_actual - cipso_len;
 	new_hdr_len = (new_hdr_len_actual + 3) & ~3;
 	hdr_len_delta = (iph->ihl << 2) - new_hdr_len;
+	if (opt->srr > opt->cipso)
+		opt->srr -= cipso_len;
+	if (opt->rr > opt->cipso)
+		opt->rr -= cipso_len;
+	if (opt->ts > opt->cipso)
+		opt->ts -= cipso_len;
+	if (opt->router_alert > opt->cipso)
+		opt->router_alert -= cipso_len;
 
 	/* 1. shift any options after CIPSO to the left */
 	memmove(cipso_ptr, cipso_ptr + cipso_len,

base-commit: 99b43ede9e355ba35244cc9470bf1819774ce39d
-- 
2.55.0

