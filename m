Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3B369980;
	Sun, 19 Jul 2026 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784475486; cv=none; b=duz64VsNTmLTvlOM3QBtOnqtgakg9250nY6Xwikcj8b8kgsrYR1YxP9qLH52WLONkxG6SbLI28UKAz4il+92MzuO+XqjOnEAhcqdITNVruLOm/7OrpmO/dExOGViY7KpucNo4B+Z9ivivzIV5yWHrASsg26Mj7E9i3l66b4BTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784475486; c=relaxed/simple;
	bh=Zzq/vOwDQwtCsnJCu7PHP0cxdyQVmVT/+otVGtIG2oY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZJO4XIMwRPzU1IuKusNVfJgI6Q1O25A0iMPVZVLmkh97DoXOFAISi61S9C1nkBQ3aeIzqWYcpKX4nyqr2ByCRmt0NoqRhVPYUpjmitKg0AFjYaJyC2Zx6+pNdBzigQb/iPgWutlpBVceXuFM6/J334aFQVFSHsy/sDHKgQzXVuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=bXt/XdEk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NzlO/6aO; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnericson.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b="bXt/XdEk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NzlO/6aO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 487A81D00014;
	Sun, 19 Jul 2026 11:38:03 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Sun, 19 Jul 2026 11:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1784475483; x=1784561883; bh=/0klKgMJWjWTA5IOqL4y9SMRwzyGgO1I
	TdHgj+RFqUo=; b=bXt/XdEkrVOvAK/VV60T1U0+zQPmS+gnRRfWWiqkTvKQpbEX
	+LkPxbSMAjv8LIvkEhQc+7g01TVc/akIv5QlGEn/n1wZ3bCvRnFShjlgNzeoeHTd
	7pmOGekTe+Ac3hSbET2yN0Plw9zuLI5YqC7cV66P+NDrLmOCuuaVQeVbVpBTSNx2
	pxN195Ie2VMXrgE/RVIlZaEtmcijL606y9AmyrGw36A+dGn5C1HFCvbVezEH6xGX
	8ICtijuqMgdsUGcvgW5kVDZsVXK9VHjLxZKBNJpK9Dw9jaq9f9ycfJdt3pGjqGVD
	gn6+7Z/vF13dmwH4FfJSi1fQdySveI+VKQlZSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784475483; x=
	1784561883; bh=/0klKgMJWjWTA5IOqL4y9SMRwzyGgO1ITdHgj+RFqUo=; b=N
	zlO/6aO5ZY3Soy+0/1Z/b0mXxACR3bWeIAJIKMHqVeQIf1XNnvpjKLcnCTb9GgC7
	5q5sRqXqChUpww2AeQ4LRfoqEyQs8Oo1urRGuU5tJJBpCgeIRnH75ewGu9TWcueh
	p75ocGHnkCNH1IuZAagOnA+WoMoXHi8zBsK3deyEK/H0JkUQc89RXfLuUVJDAkv8
	SCdm3QnWY9ZQ8FsU0D7u05Hi2NtmePWrH7AK+zRx4/SFvZD4jQpf4E7nbfR0mXx4
	I74aTLtp0X/iy1ulb27Q6UqrqNrrgGewkzCp8Ssn2kdNy1zpV1p3qPQWLl7yijUC
	IBDsJ2F3SQVcg598bFPDw==
X-ME-Sender: <xms:Wu9cail-Eh1EC_b0cuNd8Lm_FIWY34TLwEbujI8RF1y079Qe-i85fQ>
    <xme:Wu9cakphk7Ur5eA5iwo65XPp1TbU-h86PC4dPhQSXI66bZLSbt6n4tb5rEiXvq-mr
    0K8yWOgwilQgv-mdvfW0xHoIElWvawdIv3CM4nyp5Gu_pQu6W0K5Izl>
X-ME-Proxy-Cause: dmFkZTGytmkIp3YDmkKGkFBaMZag7I5G4FGu7nR72Crousbk4TSMw8VARR+wEIc7VVhwTT
    KNsixzGOcTif8stQUZVOrlUrikkJUh9WkS8V7EUZd7ab2bA4sW6077Vlm/6Mx/f5ze8AEU
    aIv/Z4kIuIz3byCkzJq+E4lH+Nayx0EERgvt9YJn7bB29mP7X32bkM2F3jgiMYMf53Boy+
    kNvRQU4UM4H9PFhHtO/ohToimqc1mdtHeJK4iwNDpc7jL4lmoGpwQESEgTHJHYn25FnndL
    /6wqPdlk172CBnWG8KFZg/mokaAma0Olm/kwx4NhJ57ktBKJB8BrCiabj1vS+JdTsazRqP
    yZhTmonOi6Ps88adMIx4SChbuUNA9BgzTv9LhQXcODEeys/ABXazXGM7Qxnxd6qCqjtSPV
    8WiX4Vl4p5iQdPvFBPv/GdlKdxsHBzXuDU1/1Hot0YWAeRNFXAa0RS/n5a48ArKtzRTlYV
    znRItKxRorvl6keFk/RNhIizh6LObzznd4/K/m1gIy8wzM1/MWlPTX2rcuzNysVQWEC4T2
    BbnF+UIKRxwWyRnJA3vKj8Q+VpC0wNpCFQSQ2e7P+qgLQ+qVXkaGOQxN0Q9x62xs8C/X8t
    BinWO3KaUyUW7uJGLKltgPU4QH19ARr8HgKTuUTeLBb5VtcEopOmAL+gTRMw
X-ME-Proxy: <xmx:Wu9caiLa-UQSVU9nm1dm6FYoTMBb2erqb-tbYJBoB8xSgQV8Yw1UGw>
    <xmx:Wu9cai4I3QhnLfTzwo-GSZgToGgFzVdc94DIm0dH8R7QJV-Ha-UnPg>
    <xmx:Wu9cahbvfBSm8ZEjDRYLjJfGoCehWE_ZvvkhCvwywMyAw4p7ZMVyFQ>
    <xmx:Wu9capwnYtYDGc2ksSnMLMTVT2MWxzQP5K0Z8Ci2gVVpJMO4BPuv2g>
    <xmx:W-9car7RnRyQ295EMu1o8QealTMaKNse6o9SDrPG8Iqz2FGobBbIEp8u>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B9862CC00A1; Sun, 19 Jul 2026 11:38:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AudyXjUgQ8Ew
Date: Sun, 19 Jul 2026 11:37:41 -0400
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
Message-Id: <85991dc3-6fa5-4466-a0cb-b407291cdb44@app.fastmail.com>
In-Reply-To: <20260718215855.07284fb1@pumpkin>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
 <20260703073948.2541875-3-John.Ericson@Obsidian.Systems>
 <e6f54c5b-2c92-4772-b2f9-5c21e2ec50a9@app.fastmail.com>
 <20260718215855.07284fb1@pumpkin>
Subject: Re: unix_stream_connect and socket address resolution
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi David,

On Sat, Jul 18, 2026, at 4:58 PM, David Laight wrote:
> My $0.02

Thanks for weighing in here.

> If you assume that the client isn't responsible for restarting the server,
> then there is no strong timing relation between creating a new server
> (by any means) and the connect request from the client.
> In other words both the above are very similar to the client being
> preempted at the start of the connect() system call.
> 
> What you need to do is hard link foo to foo1, create the new
> socket at foo2/bar then mv foo2 to foo so that it is atomic.
> But I suspect hard links to directories aren't allowed any more :-(
> (Creating 'random' hard links to directories used to be 'fun',
> you could get 'find' in a right mess.)
> 
> David

I think I am a little confused by your answer. I am not trying to do
anything in particular in userland relating to dying and restarting
servers. Rather, I am wondering why it was decided (long ago, pre the
current repo's git history) for connect to re-resolve the path every
loop iteration.

I am working on a series of related af_unix refactors, and it would
simplify things a lot if I could make `unix_stream_connect` just resolve
the path once before the loop, but I do not know if that is an
acceptable change in behavior.

I was justifying the change in terms of the resolve-once behavior being
less surprising in my original email, since that reason stands on its
own, with or without my other planned work, but the truth is both that
and the ease of refactoring with that change are my motivations.

Hope that clarifies things,

John
