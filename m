Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC9F33A9FC;
	Tue, 21 Jul 2026 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784666262; cv=none; b=RvvNlE0YJYiAHmV5Ed6EZXWbOl/IO4waxeDr6hYTQUAk/02TyWwDIPkRzV00shJJzYg1Esj96eFdT43fpoeIivRIu0b/y2WVvOYAKPuG7PZ/jW5ZVry4z5YgVeu9QBocK11PU+HgI9s3dg/3XKUgYMnW32cSEG5LAueaoKAOAKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784666262; c=relaxed/simple;
	bh=CUEEDDXaie7jnJLUIUG9G07IerQuHzgiLcpNpNqYy3g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=g4livfgOXygTwDsxh+B6D7sAhDyqI9/LVTlFrqCeIyNBtkSg2RDzUh72u6LQAoGId6WVJSu39k7OI5XTrVLoQg2hg/mC2vFfAAXbM86xqOE2AKeIHEwK+uNYnMamNZRkMG9b444dcFG28ZdtjHczh+0DEJ1WL1H+jAh3W3RUWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=YnRjIsmq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DxvAVzeW; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnericson.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b="YnRjIsmq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DxvAVzeW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A5611D000C2;
	Tue, 21 Jul 2026 16:37:39 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Tue, 21 Jul 2026 16:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1784666259; x=1784752659; bh=NUMpJ2akCJMTRqhsXAU7yOxnT0Vbvmg/
	or0Ox6PDqDY=; b=YnRjIsmq5fLPYEzJDvCsZzE+L5vE5nkCyE9gazO528vQuY71
	on6UwrBcQ2U9PTW6JIeF5vnw2iRalDlFw9iDIcHuKzGY/TborrF6LW5ffwHg7CcM
	Yz0ng64qWm8RQvGTxWjmq4Tb2biWu+4OCO89wE3ndEvIG+v7oqVQaz+S7XWRrtJj
	V5EoY6WYK+Q+o/Yt0Eomn7/52bqLwEIqxOVRZEBJBdw716mRyEqV4dzqvdILx+Lc
	5V6RGHSH5gT8EwtkmOW83AVBLxSoxpClAOiohMA2dNEqxQUdpqgqMuwFmKjQYH8H
	fMJB5Ut/efco09K5zilPlOZVcYhsU+NnARSeyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784666259; x=
	1784752659; bh=NUMpJ2akCJMTRqhsXAU7yOxnT0Vbvmg/or0Ox6PDqDY=; b=D
	xvAVzeWhotqohkFk2/HL/nbWoDZkXhmJwDyI2E++1pz55/xTglYl0DrVySqWvxw4
	Qhs5FZtqYxMpuzcNJSVAHv/BruiT00bOjhh2XYYoIRrDwOAS9UDsFogMr4e1lnaV
	xjk6v52pmW1FBmIT5XarNfqPJXualh7xZrDdLv2WLt7gAgnH4txUZ30L6pbvLpeQ
	JuuKr8gcId5bgh+l7iVpwDvQy9UZgJxDObfP968xarMaiCakon3A/CPQ04y5TnZ2
	eI8PK6pVUGVqJB6WZCb/q7eiCQc+Y60J2mNfU3FLMLvaO+rTbwF5Dno/1K60fSNh
	ZODmIY1QWdaJhSPBx1d0Q==
X-ME-Sender: <xms:kdhfavj9Oteuu2We5KWyaJwqaZ-hefGAh4uyfLVQcvSyPerGkZ8Dpw>
    <xme:kdhfam3GebCSBvIy2HR38JE0HsgJejcgkPvslW0pfPv1oiWMbAIfBXuSY_QrVKhAg
    kLGzvzJGuIpe1E0WiQ2m8_Mg-c74CX6T7qYU0sgTB2QtrfNDerPwj8>
X-ME-Proxy-Cause: dmFkZTF3rXLCIiptege6YMZPKaRJIePD9MrJX4rMyB6sdBv93uLMJg8w25jzlbdoAhoQfl
    l8lTcApXWr0rbELm6i72jMQkk2n8r57DQUjeyMhgRMiDkSjxvtNzyxoxEZo0qiZu6j2UJn
    CPtD+8sCySgDBHQKR0NkiNDbpZ0xzcU+KjuOWuUA1Ko8qnw0QHBEQZaycN2WXNIfZ8Yj//
    SG2uimGoHhjS0UVteX9xtjE8Vxx9m96W5AAaXA/GDzukWGh9bM5HKDYgI51FznvtpJrfv+
    GnwEDWD23mKK2i6XB1uObnmL46M+QGIyYYaJ7RE1sM6fkqZI4kmIKNmcgmy0uRgzMZY4sB
    XzyliDs2YDwNXmd3VRKipULW06OcH37pqBT66rTmE0+rbm95tJuq04e+wwr1QqTsvMs0+T
    lKHZNv8NbFUgsbonmFJdSYpaTWu23pvBYD7SssPpttil5827GjXCMSaq+0/ZgE3Ev/W2zu
    SX96lpJgmmxqXD/kyiv9MRdtsO/QiovT8Rm2kEn/sgFwIHrXbtzKKGekdJ7kTWBGvBzP2N
    AP6htyxpNRdXNuhH6zZZ+nCIzR/bPDBBuFDJqzDAKBfJvlbkv5BkL26PqUFyZ1aPZ3BZRy
    v+uj9NMsZLoZfvmY7Qmt/wUj+PzgS5uTPqWI14NOlKLy/NS6pMNcLFnvZPdQ
X-ME-Proxy: <xmx:kdhfaiFYfk4gOD3qjBcz5pRv8WNFAWpEXJAYFoTG8Hpav494vWPaqA>
    <xmx:kdhfasHHjWiTw6qwaElDprDgGUR3_i9Ud6zuLJ9gdqPA-8SHRZG2ig>
    <xmx:kdhfaq2SYLRGXZUaXZMFUsm9chBF3NRu1DDLY_Ofjd3YpT9oX26dcA>
    <xmx:kdhfaud4fDCgEuURzz7Tzobh6D8yNr32Icrs5NhQcHDvqakGkTNghQ>
    <xmx:k9hfainLeNW-taYDJEY2d2vA1sawdjqZYpYXm7vLvfAL_NrJ09H8ATNP>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CA9BA2CC0083; Tue, 21 Jul 2026 16:37:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AudyXjUgQ8Ew
Date: Tue, 21 Jul 2026 16:37:07 -0400
From: "John Ericson" <mail@johnericson.me>
To: "David Laight" <david.laight.linux@gmail.com>
Cc: "Kuniyuki Iwashima" <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Cong Wang" <cwang@multikernel.io>,
 "Simon Horman" <horms@kernel.org>, "Christian Brauner" <brauner@kernel.org>,
 "David Rheinsberg" <david@readahead.eu>, "Andy Lutomirski" <luto@kernel.org>,
 "Sergei Zimmerman" <sergei@zimmerman.foo>,
 "network dev" <netdev@vger.kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 "Paul Moore" <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <9c437c7c-7919-41e2-9161-fc94803a9b34@app.fastmail.com>
In-Reply-To: <85991dc3-6fa5-4466-a0cb-b407291cdb44@app.fastmail.com>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
 <20260703073948.2541875-3-John.Ericson@Obsidian.Systems>
 <e6f54c5b-2c92-4772-b2f9-5c21e2ec50a9@app.fastmail.com>
 <20260718215855.07284fb1@pumpkin>
 <85991dc3-6fa5-4466-a0cb-b407291cdb44@app.fastmail.com>
Subject: Re: unix_stream_connect and socket address resolution
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

In case this is useful or interesting to anyone, I deep a some history
spelunking, and the restart logic in question seems to date back to
Import 2.2.4pre6:

https://github.com/tbodt/linux-history/commit/7d4fc34b9bbc0a14d3e5f6b2f978373422e1ca8a#diff-0553d076c243e06ae312480cb8cb52f1cebe1d80fc099d3842593e12c9e0d4f3

---
@@ -673,9 +703,25 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	   we will have to recheck all again in any case.
 	 */
 
+restart:
 	/*  Find listening sock */
 	other=unix_find_other(sunaddr, addr_len, sk->type, hash, &err);
 
+	if (!other)
+		return -ECONNREFUSED;
+
+	while (other->ack_backlog >= other->max_ack_backlog) {
+		unix_unlock(other);
+		if (other->dead || other->state != TCP_LISTEN)
+			return -ECONNREFUSED;
+		if (flags & O_NONBLOCK)
+			return -EAGAIN;
+		interruptible_sleep_on(&unix_ack_wqueue);
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		goto restart;
+        }
+
 	/* create new sock for complete connection */
 	newsk = unix_create1(NULL, 1);
 
@@ -704,7 +750,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 	/* Check that listener is in valid state. */
 	err = -ECONNREFUSED;
-	if (other == NULL || other->dead || other->state != TCP_LISTEN)
+	if (other->dead || other->state != TCP_LISTEN)
 		goto out;
 
 	err = -ENOMEM;
---

My question can be basically restated: why should the `restart` label
not go *after* the `unix_find_other` call?

Cheers,

John
