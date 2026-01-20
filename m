Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA0F314A6A
	for <linux-security-module@vger.kernel.org>; Tue, 20 Jan 2026 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924667; cv=none; b=HRjlv+WJma6p90JvXPhHKZsKyW1O26qYdmST6+v7QqG2Q/ib8yaTBE8IdhYfrRFRd+4L3Ozgf66q+XuqFnSQX0cGVHZ2ZUJziltjewm2fIhjZmknRruxl7SruEODPi8i4BiO+6uvU4L+f5Hr+ItgKbYTGA2sDmR7SBOt/PqvWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924667; c=relaxed/simple;
	bh=Q3jZ8i1dgm0geWGcKYEDkz4Xcu60RW+VP7vWspRvnrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUNt3txwqpNKg42fIT35KS4H34UvVwh2jS8bjHd5Bi4yWxJUb2wSfpHI8KkhcYqmcxUEHwijbWl39s5MQ6ykYN3y2tjM0DcJlRBcwkjnZ6sZ82uqkRvVSk6jfWy6mp31l0wE1yFUzj4YeffrHxiltf581jO0Q0ccJxp7zvRYLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=nrfN+00U; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="nrfN+00U"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b70abe3417so537039eec.0
        for <linux-security-module@vger.kernel.org>; Tue, 20 Jan 2026 07:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1768924665; x=1769529465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDVOTSHO4BkrVaUL+NxqaqqJd2byL2pEcox/3hMBRE4=;
        b=nrfN+00UY2zNwGDx33+KZED2uJIg1L3BpduYerqLj0haL22AyRgV1pul5wRXR7P1w7
         d7UtmO9iWXPGcNCr6clQt8aNfOsA2N7FlTc3NIaDBeWLUeubWXrqpfppCeeldZOBO306
         jgYHNz13+2trpQCfKlDdL4+IJ0caDCa4OW1aITUIftHZ9QLEzu2gZ1LQr5ZKWYY2UBsd
         KYSYpjZKIywDiIGxpuxt9z20a2wO99JXqEsPxAsCaEZWm+OUd7gckz9pJyFuPRaDF0rU
         GCCI6CWuhv515R86U5kE6Z4uBGKdTnyOydLTQWYnCCrvTqOUG5RWgSn0nSlWZ9iF5BnL
         3Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924665; x=1769529465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CDVOTSHO4BkrVaUL+NxqaqqJd2byL2pEcox/3hMBRE4=;
        b=H1KSUQbL8ik4Y0FDo8t5Hu+6haDrDCn3xbD3bS1MevkczZww+rnRrsFyAS5JVXLEo+
         Aod7VorAP152z6Kz1JRXUI0X1BXqWEc51aPvQg7ihGrxYS21ii61c1ZvWdWbwa+C2PQ9
         dSxP4WSsbc9cOta3rPLn/xOFebLL02sqNho6Or0hSc0HzpNJ0xyiSuibAjjnHz86KVkS
         uMhGSpWBhC8DcY60m4lhytWwYB25lkNq3FvGqTne73L9ilmOOyUiN0rTdFLb91dLIvfS
         k7wtvjWxc296WkPWegczUeXUy9CmqbapMbHqL91MoLkgUzZQBfjCOuZ5Cwbca6fadKqP
         0Ebg==
X-Forwarded-Encrypted: i=1; AJvYcCWH/AtYDJdD1X2ulzeV1q2YsouzMJysJSRjWkEDYvB/0ccmXEPGblhcNELYgo7Ku/z5+5N3V+oXtQ1xby0zrqAryvoHrA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNed1JR2qm6GUpc2J/JfTBT+rf8VjjfZUT3PiwbOeiA079vuH5
	wXPUGZzFMDzOYa4zthTeD5O8ltxmU424oVTfzyMZ/30o+Dlhy9YhUCCpO8okqZ5cEQ==
X-Gm-Gg: AZuq6aKeUa01GQk0mcTfCYqUHnd7FJECU/OMgTO4FUBhShLXd6/cTEtsKNJZkBihl88
	L8QZp1CdzDK4qJD5v/rktjjVOH2Haye3QcV9RaYh2cf46LvBDeXtoZscfcgxqWU71AQ0hvuV/4u
	rdupKKglyygVQMfQ66rTg2QcLu5xisAOvDfSaNjmo1hqKe2IQo+pAmK1sFrG6NO0ORUc7CkIGg4
	kr0ynNJ1LBJTNK+w0aD1LKAl1uo85lmRrjy5TubX9m14hoPp87AJR+BVKRdd0yrG9ih5/n/DFXo
	MkO54XVCHTB+f1c2+FDH5qvS9Du08X3qMX81M+vPS1rpGr8y3ZEp/P7MnC8glRXwgzXlYr2f1lr
	iks1TNPGIz6IG2Tvz+YKcU/jI78eHIysdGQpOoZKRW2j3ze29IU4Ed/ZMXmgfXy5YrQeZO1LoeW
	RwSWbp5z0p49zvELlciknDrUZ1+pJe7MGz7yPpzlYscskKpMXPgg==
X-Received: by 2002:a05:7300:6d15:b0:2b0:5609:a58c with SMTP id 5a478bee46e88-2b6b4119739mr13598652eec.32.1768924664652;
        Tue, 20 Jan 2026 07:57:44 -0800 (PST)
Received: from will-mint.dhcp.asu.edu (ip72-200-102-19.tc.ph.cox.net. [72.200.102.19])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2b6b36550dfsm17650283eec.25.2026.01.20.07.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:57:44 -0800 (PST)
From: Will Rosenberg <whrosenb@asu.edu>
To: 
Cc: Will Rosenberg <whrosenb@asu.edu>,
	Paul Moore <paul@paul-moore.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cipso: harden use of skb_cow() in cipso_v4_skbuff_setattr()
Date: Tue, 20 Jan 2026 08:57:38 -0700
Message-Id: <20260120155738.982771-1-whrosenb@asu.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHC9VhR4d7WXOVR7Y9ee2+=-t2nThzOo-ySMB+5x_87LfBJbZw@mail.gmail.com>
References: <CAHC9VhR4d7WXOVR7Y9ee2+=-t2nThzOo-ySMB+5x_87LfBJbZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If skb_cow() is passed a headroom <= -NET_SKB_PAD, it will trigger a
BUG. As a result, use cases should avoid calling with a headroom that
is negative to prevent triggering this issue.

This is the same code pattern fixed in Commit 58fc7342b529 ("ipv6:
BUG() in pskb_expand_head() as part of calipso_skbuff_setattr()").

In cipso_v4_skbuff_setattr(), len_delta can become negative, leading to
a negative headroom passed to skb_cow(). However, the BUG is not
triggerable because the condition headroom <= -NET_SKB_PAD cannot be
satisfied due to limits on the IPv4 options header size.

Avoid potential problems in the future by only using skb_cow() to grow
the skb headroom.

Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
---

Notes:
    Given that IPv4 option length should not change,
    this may not be a worthwhile patch.
    
    Apologies in advance if this ends up being a waste
    of time.

 net/ipv4/cipso_ipv4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 709021197e1c..32b951ebc0c2 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2196,7 +2196,8 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb,
 	/* if we don't ensure enough headroom we could panic on the skb_push()
 	 * call below so make sure we have enough, we are also "mangling" the
 	 * packet so we should probably do a copy-on-write call anyway */
-	ret_val = skb_cow(skb, skb_headroom(skb) + len_delta);
+	ret_val = skb_cow(skb,
+			  skb_headroom(skb) + (len_delta > 0 ? len_delta : 0));
 	if (ret_val < 0)
 		return ret_val;
 

base-commit: 58bae918d73e3b6cd57d1e39fcf7c75c7dd1a8fe
-- 
2.34.1

