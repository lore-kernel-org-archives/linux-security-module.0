Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C93AB466;
	Wed, 22 Jul 2026 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736229; cv=none; b=Fvs36IFOu4C/44ux//bK2ZjOsD03KhgJYKuqfCSwEN3SLZMXNVN/UqicmR4SQuAI3ahOHMS/ybUC8XjC5lWyF332fRIjmWGA0ZCqsRDRdhzcwa4dNvvkBzS++nEkhtjS0iq1JTEVjr0942oVJYz2HdbK6NIO9Br9v32lN0+v7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736229; c=relaxed/simple;
	bh=rU5sRSJCoz6G3n2g1fR9DQWvfHVM6+fAIyg62rOd2K4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ITRNrQtXwbD7+hPIOgOHQLzTpATBZ1IrnDXcMNxz7AH0eyVkXvmOLNB1nUtGFvZeS1D+Vuc+ac5BmBCDLGj0/g2H8oq26qmuTEfWFVUhfZYGFamPqeOOn4pSJb0wvlTan6QCo9sQNdbD8bGb97ra2maoxmXb57zo40QfM4WEeGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=UhSCho1S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FF4I4aF6; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnericson.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b="UhSCho1S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FF4I4aF6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 029DA7A00B3;
	Wed, 22 Jul 2026 12:03:46 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Wed, 22 Jul 2026 12:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1784736226; x=1784822626; bh=rU5sRSJCoz6G3n2g1fR9DQWvfHVM6+fA
	Iyg62rOd2K4=; b=UhSCho1SKHXc1Fqenq05vR99FgsrCS1fVAbNGZODu+uqG63I
	IByXIvzp5tP6jEi20UaGgaJlS74iughVONq8XnBFmVp7v8li2VHQ7qZv91HO1+DV
	a0B3c6wow7rkd+yYuj5g9MkW6v3YqejnOjnPpjR51w7C2FDKP9+2NxOcgqTH02Nx
	2pOB6xd8DAd4JTG5vr2tkfYCk6ioQH1JyZVhcr0xVZE8I97c/cGu9zkbv9F1CCnY
	N08ruMvhyPBshfFWceDop7K0MGEDJugZ58ZhxxeXXFTOyXM10uolheORmJ1wAL+K
	sLqd4n7CvOahpBX1GKOpe1lmwPt8Pqzw2rWj6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784736226; x=
	1784822626; bh=rU5sRSJCoz6G3n2g1fR9DQWvfHVM6+fAIyg62rOd2K4=; b=F
	F4I4aF6xItVSVUVnhw+rlpV751t1owovvYAi2xn4EBu+zejZTrDOvAUPofGBcrQY
	m+UXD9goqteC90NaMGM85hgV4lFojpTY3TNc8KPTjQyy3YzWg+0RvcFj8t59Yx2h
	fExebfYf8BEgWfrtNQvRz10qr5qJ3thZMUGg4iZ/oBFhtGcvZkNOilfrFqgPO1Tq
	p9Txaax6U8FULk4rC9yV5FIVySbxuu3Uj1E6VcP+dfXZgHPBdaBcEQgyGRVGOrDJ
	qSB+C5iqYUvWbh0yk85zXrlVjgMNG/onCZyyU3yBnVTKCnp6ex6X+zo7IAa6iw1p
	bSBLuMBKaD7WW87GWYq4A==
X-ME-Sender: <xms:4elgap26aQsqhWubtXhYb3VWdsKs5YDqbJER8DRTqA2W4IPpvG3XOA>
    <xme:4elgaq5W-OOBu2JoPgfyR58HDzl9L8Qndiim7mv4vaDFz8Z5ZdEVgLXivQAMIbvo0
    tl4GOc-qtxoJ2K10PMGGX-Bxx7zhRlGRKWuUeZSsrePpwnfulDXRjg>
X-ME-Proxy-Cause: dmFkZTGm89tu8D9gX8cvwUODaFhf1vJsL2B3jc3BqvnQ0+Dkr21XKMByXsD2wFcYG9kG9j
    h8WGXtTEuOxA/27EgFc1GBkdG5kv3l+icyNCOqZoRh0FPvjkHuznLmNUovwR4bDDzl10AA
    i6iJSVjWtvWz8dqNjEIFuCbgGlhd7751ZiJt92nkDNNN/fBGb0M0RLqPwyT2Wq9LAHDArx
    fsh8Z//YQCxctsi7KcIBh43Gx4bB8VnVBd3NPMdlBAEzVsLEuBbG4RGfiAaoEvb8WHPaq6
    BgQHmvogJvf0BXLCNi7ftIz9/wltLkpP50Q+LiSw1YDJflhhadxrqJfPQZQDy8WV60/+Wx
    H4YNLjhzO6mFX2FpaxEm6HhJQIVAVclR1OTvFoi2Eti+pfWTxDbBF21HYX6IIXbYGgB0AB
    FatyN6HCz2DqnDSutPovTUT4QW50rPk+4kAH/Ydy+GeXWwEqerNKSP2Q2Wnp7zAlnNH1xw
    un/50rvh5HNYgBj5oj48ozAkwbfZoV3mYZecH/Y+We9ss8hgvC2k3RQgS6RSmog4V6NQ/K
    WHlrFea5uJIdT5XyE/4E8EOitsBeqv8BebxiEes4nEsKUZW2jgCFf/4HzT4wi05sWId54P
    0j1DieL3G8jZolrRTmurYbxiGc+MKtpzX/Ntd0/xq4EEi/4TO/+yE9E397iQ
X-ME-Proxy: <xmx:4elgakt-HqvS-_awahqElKzvBEEjPyCmN1XStrp0TlyeA62kkXkhbA>
    <xmx:4elgaoaFes39fl52cdt41L4zwmpEgw6DfhMOSg0egH6XVK4YO5GkrQ>
    <xmx:4elgak2QmI64H7tNQQe17cwHkg6ZFDQ4O3lEFdRn3Ydr6X7Q8hXk_w>
    <xmx:4elgauXWTLoRT-wumOjwR44J1Umj7dlDHTwuVQEv9yR7DUvU1tKczw>
    <xmx:4ulgavH_yLbiA0PYMqaT0yDGWjBXZ2_53pwdGTOS4LV1SUVmZSQGhbCV>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A16A92CC0088; Wed, 22 Jul 2026 12:03:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AudyXjUgQ8Ew
Date: Wed, 22 Jul 2026 12:02:24 -0400
From: "John Ericson" <mail@johnericson.me>
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: "David Laight" <david.laight.linux@gmail.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
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
Message-Id: <e4adebd8-181a-47b7-b82b-b6d9baa6b203@app.fastmail.com>
In-Reply-To: <20260722.bfca37efd700@gnoack.org>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
 <20260703073948.2541875-3-John.Ericson@Obsidian.Systems>
 <e6f54c5b-2c92-4772-b2f9-5c21e2ec50a9@app.fastmail.com>
 <20260718215855.07284fb1@pumpkin>
 <85991dc3-6fa5-4466-a0cb-b407291cdb44@app.fastmail.com>
 <9c437c7c-7919-41e2-9161-fc94803a9b34@app.fastmail.com>
 <20260722.bfca37efd700@gnoack.org>
Subject: Re: unix_stream_connect and socket address resolution
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks G=C3=BCnther!

This example makes sense to me. The behavior still feels a little odd to
me, but I can understand the practical benefit of what you describe, and
also why changing it would definitely cause breakage.

I have one addendum to ask then which is: what if before the loop we
pre-resolve the parent directory as a concrete `struct path`, and then
on each iteration of the loop resolve only the final path component to
the socket itself? (That is a single-component lookup relative to the
pre-resolved parent, to be clear.)

Per your example, a legitimate server restart recreates the socket inode
in the same directory, so this still picks up the new socket and
reconnects, while avoiding the effect where a concurrent
ancestor-directory rename causes a wildly different socket to be
resolved. Hopefully this preserves the intended use-case.

Note that this does mean recreating the parent directory itself at the
same path would no longer be followed, and a rename/unlink of the pinned
parent would cause the lookup to fail rather than resolve elsewhere.
That seems like the intended, safer direction to me, but flagging it as
a deliberate semantic change rather than an accident.

If this sounds like an acceptable middle-ground to everyone, I'd be happ=
y to implement it.

Cheers,

John
