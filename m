Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FF23290C9
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206438; cv=none; b=LTkn5Lf3boM2QY/SFAHascp6BTlkVwJo6dc1hT5H8r+Hix0Ytw9zsZrsxAvzx826lbrohluD6uJ4tDQJqFYze81cMPMMpI2F1HU9xQJpUwwPZRtJWBJcX1orKi2Z02YZl9+Gsl2h+0t60sEZC2eZvxkF+kbHrNAWeLPqnGFKAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206438; c=relaxed/simple;
	bh=lmPpYSlPcQNZpTQXLMEyB3rxC3XM040jCc/+2R5k/b0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I0FFzqzQVGn42rluDbwcxFoJC7u0HVCfzbxkjTEQSrI0fQ93Pi9E1daPpYyt6Z2atWztjuUByXcWl8ix8747/rCQkA15hOTHGoKDGWHysT/fOwGXM22BJLavbJOq9h6g4d+k97KTbo2vjKHwgYs4aFcPvMaeCTaF8PFXE4f7CL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0gnp6f1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0gnp6f1"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-829ad81b132so13483020b3a.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 22:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206436; x=1773811236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q82HY+Ox5JF0vwG5eIoCl0bQkH1ycg7BDvsoRBp0gXg=;
        b=R0gnp6f1gOltq3j9L2+MtAENcu4iK0WGejYPGIqDP5CHN+C5kYWVwbkjzgiKufJZtE
         fSq7KbjpEryl4h6v3zfPNd2U81AwthhrIQMav6DAxdpxE/t0wdAKjCCWgKXIVCvyKeCY
         jRwCDkWs5VUmLEp0UgWIpqQPKPUcewd57phTSQMis+6Z0dvS8gBIvyozq6x2mLMuY2tH
         n1Z6KobG9fZhyC0HerzWGNhRWGIikEjmp0F+FvXAX8m3A50Dnb9na7oj7usqa3BFKTwb
         57q3OlE4KgpMsuygJFb1Hexn5uI0A+YP03T64FkzFWbs5thnkZNv78R8mc4PQXmE3RUj
         8MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206436; x=1773811236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q82HY+Ox5JF0vwG5eIoCl0bQkH1ycg7BDvsoRBp0gXg=;
        b=UERayRIApAoMFSf+HGNtOgxuhjbWoZ3kwya099kB3OOnHOocFFzccXExeJg3xAxD4+
         Ac+MOsddZUYUCtxCkU0Z1J9eztTUPGUm2SFbBNes3mqp8Id6ZCA3+HZTERcoMKG6cGzl
         es2+5CiSO5EXFpq61n6FaMCHKYm9kT61lnzDFU+QtmrgnV/4GJG7SVppddgvOnbS0CqE
         2W3pESwwB6lRrMjjWahsThfxgEmgGrkXoDyIwlcx/pTLSMrOsv40bQ2MJsW2sKGUxwsX
         uPBW3wmMVRv5UquzePNar5aJjwMl1XJA8mwh9H3ET6/Q4ww60IpuctPOTidJbDxKgft6
         UEPA==
X-Forwarded-Encrypted: i=1; AJvYcCUPr04l78AUfw0hNmvQCSuV6DtfUW7ZsLeR8VT3fYRy7FIakB66gt1w65XDqX7S0cicAYPI0MsoDiFs6d/1QRBQzJG0Of8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBotnw8DlDln28rqLcyNmidnF42GRC2zAw9Heye97QmwDUpb5n
	c9gbvRGUYaTW4PSxyafuZQL0FeWYy+vmFkRVP4NRRjxlzwxhy1Jf5BrM81P4IA8rKIDglTvgi2A
	V02K16A==
X-Received: from pfbdi8.prod.google.com ([2002:a05:6a00:4808:b0:829:7841:17b5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:440d:b0:829:bd4d:3817
 with SMTP id d2e1a72fcca58-829f70462b4mr1340501b3a.28.1773206436051; Tue, 10
 Mar 2026 22:20:36 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:19:53 +0000
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052020.1213705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-7-kuniyu@google.com>
Subject: [PATCH v3 net-next 06/15] smack: Remove IPPROTO_UDPLITE support in security_sock_rcv_skb().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

smack_socket_sock_rcv_skb() is registered as socket_sock_rcv_skb,
which is called as security_sock_rcv_skb() in sk_filter_trim_cap().

Now that UDP-Lite is gone, let's remove the IPPROTO_UDPLITE support
in smack_socket_sock_rcv_skb().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
---
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
---
 security/smack/smack_lsm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 98af9d7b9434..e581d6465946 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4176,7 +4176,6 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
 			sip->sin6_port = th->source;
 		break;
 	case IPPROTO_UDP:
-	case IPPROTO_UDPLITE:
 		uh = skb_header_pointer(skb, offset, sizeof(_udph), &_udph);
 		if (uh != NULL)
 			sip->sin6_port = uh->source;
@@ -4301,8 +4300,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 #if IS_ENABLED(CONFIG_IPV6)
 	case PF_INET6:
 		proto = smk_skb_to_addr_ipv6(skb, &sadd);
-		if (proto != IPPROTO_UDP && proto != IPPROTO_UDPLITE &&
-		    proto != IPPROTO_TCP)
+		if (proto != IPPROTO_UDP && proto != IPPROTO_TCP)
 			break;
 #ifdef SMACK_IPV6_SECMARK_LABELING
 		skp = smack_from_skb(skb);
-- 
2.53.0.473.g4a7958ca14-goog

