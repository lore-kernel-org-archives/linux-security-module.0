Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5F4B44BD
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791386765; cv=none; b=FKuGRK0q/2+mA9Hkb/jrYUuUdcK1bzuaX8bvguy0z6SwGCT9US1wdReGqi/7hhpilvddVx2ALHmEO4XJHTE3F9MESXoykEWomwiN60vUqS6Ajfj+YtS8Lqsxg58L/CekfFQwHzg7rn2L9dZkCqvJqCQJnXVBO7MX0CuruRkETco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791386765; c=relaxed/simple;
	bh=N6Mwje/jk5LkEVovjy6c4cdZNQ2w3u+xqBwLIGCWajE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O7/xelpzC1oXJSCOlWHQ8kh+Uqw7bnup7G8PE/WgsSEtNqqlp4kM21oH866+Up0bZj5gAg5s+BAzSLJDzLHc9f3NMC2/zOUXQoeAJ8fKA8Aac0LunOb2EnY0x3GQx2qPJvpsXlexGEMJ2c+WuZWQLCpMh8Qk+Lh2y7JIsdLrdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEanHDDi; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEanHDDi"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-34c89609923so2198842eec.1
        for <linux-security-module@vger.kernel.org>; Wed, 07 Oct 2026 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791386760; x=1791991560; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r5LK61z8EbTq0+O4wcf4iS1SXssqVs9NYokbeiW5mo0=;
        b=jEanHDDidr2AKzdsrUJIbz9hKo5jLTF7kVZBSlW+WUK1C6G82M92J9HnKj1QDBB2Ud
         6g0mqrvNw2LmFn7KrGKeGVLQvLrnszJdkc1c/7wdseCNPes3okO7N95OpnBAqYEWZoa4
         y/R2M7jY9lZ/PqyH97cNmYICHqpC20VPqYcdS3vt+ZBruQ5VPm2qwAz2uiTrCZfF2Xoc
         /I89uI5HWHeTdXRZTEBqp+OAfq8Xs5ujG0rgqnLT+qOzD2zulMWtQtBsHyXpu83x2I1N
         udcXEBD7TsKjiEG2eNm9h5x/cPSM7JPIL8Kq5tvGQgdvH0FSXcbsaNfqdnyNfj3JYCSK
         ijpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791386760; x=1791991560;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r5LK61z8EbTq0+O4wcf4iS1SXssqVs9NYokbeiW5mo0=;
        b=iiAU1hhgCfjB4/ScvGkl2irSKV1WBVyPm51omMWnHw2NqI3PQRxmt/skMJiZei3oCL
         AeWMNYKR4EKkrNbyEwNq+2fO5Q4sL9GfOzzlZjI25IzRRAUOANriZOUiy2m2dOKHSIYW
         I/aS4uaJbly+dbVJGRy1n9AWcFPJ/ugIYKkiq465lLfnEhzfaN8ASZ3sXSER8QXNdMze
         GfQGzQwKX8p1kL+rDyuo0upXvfaYoshVUowcNIy1snZmgEUsnHYMmiANlMBLX/8or70k
         rCV1R9hLd/gdWYGa/GYzwSuSjBbJhRwE8gUlHWSTt8AXniYtcUXQZy8fvTvYn6+4zWXo
         laZg==
X-Forwarded-Encrypted: i=1; AKwUvBwtZuoapWyhQOGDGWJUNi2vryY0EX+DMcg1LxE/687EJ97R/inJ7OjOC2KbqIfyN+UdIj7Xet0vS/dYy1fpzQGS0aXxumc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrvmRPXS4/5vrxGJ6Srahz3kioZXloSdO4miibM/6B7Mxvkrzz
	jRQGVW+y1AiXQXgxmBo7984f4XDXDD3vQCuxLsoSSIslnmmC5EtxhAqp
X-Gm-Gg: AYBFou0M0cYiI8I9apRlC82TtzJjPZpb91PBmvolV6Yz0zNxAg7lXNdVqJF//rohfQE
	sJGM55cjmGd/ZY8hWL4y1iF4IUcF9XClbY2MS8o1noYxjR/TGM2hRQQ0FwQTu15UKW12VATZb4A
	fCB/d6S2S2Gq7szP2oeuQ/COOkPfSdCOK7jmWKJV4b4E2Gy0Eeofs/okpyqRQ0T8aN4ZDoNlGpl
	JR3cFumthdKOoqMqzjPJS7bJxrp3cBHteWIzrdZJhssKinT07JThyH7EMPMaeaeVJniHbI9A08W
	QkVqS9GplmsyhzeBVcaZNt6DG8o8ExgJ7RO4rbuV6lvrSSD4ZoIHVz6M16oPSPpSu0zfAX+DoLt
	aZwrCa2738dmrCLHVFp7bTSYe0eDhBCZZeyubRmHOqSI5FA6Sf/U49EOH7rEzDmvCHZIFmH0R1b
	lKC2gFpHHdQI5mMC/nUQNinP4rA8DU3ZBQcRiYpJeS8v6M1Guk8LkNb6Q7kc7+pnJoEFGRbY9vF
	TxwN9ZWNAuEbx7zjqtVJ75JOZvr331bRJoMk53W/zEKxu/j1djROkeqshoktm7vMfSj2noGyQT/
	ScZ4+2c/kE8ty0wJZ7A8J23GLrUK0Ao3IrCDqaaYMrjL94lhIzgC
X-Received: by 2002:a05:7300:e9cc:10b0:34c:1692:f2d0 with SMTP id 5a478bee46e88-3515dd8201dmr3203304eec.8.1791386734242;
        Wed, 07 Oct 2026 08:25:34 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([95.173.223.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515af26f10sm9234416eec.13.2026.10.07.08.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 08:25:33 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject:
 [PATCH net] calipso: update payload_len when removing the CALIPSO option
Date: Wed, 07 Oct 2026 12:25:00 -0300
Message-ID: <179138670045.80227.16292613517250896744@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

calipso_skbuff_delattr() removes the CALIPSO option from the hop-by-hop
extension header, or the whole extension header if CALIPSO is its only
option, and pulls the skb by the removed length.  It never updates
ipv6hdr->payload_len, so after a successful removal the header still
claims the original length.

calipso_skbuff_setattr() already adjusts payload_len by the length it
adds; the delete path was missed.

This is reached on the forward path when a packet carrying CALIPSO is
sent to a destination mapped to an unlabeled NetLabel domain.  The
forwarded packet then has a payload_len larger than its real payload
by the removed length (8 to 264 bytes), and the receiver drops it as
truncated.

Adjust payload_len after the header is moved.

Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly.")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
Found by code review.  Compile-tested only (arm64, W=1); not runtime-tested.

 net/ipv6/calipso.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index c6a34334e..c072eca50 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1428,6 +1428,9 @@ static int calipso_skbuff_delattr(struct sk_buff *skb)
 		skb_pull(skb, delta);
 		memmove((char *)ip6_hdr + delta, ip6_hdr, size);
 		skb_reset_network_header(skb);
+		ip6_hdr = ipv6_hdr(skb);
+		ip6_hdr->payload_len =
+			htons(ntohs(ip6_hdr->payload_len) - delta);
 	}
 
 	return 0;
