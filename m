Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478070808;
	Sat, 18 Jul 2026 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784404694; cv=none; b=kMv/e2XydLwT7MdG5YsaJDzDKFZKZAcgUG2w92ZjXyBthzk2i1F0xwS66iQYSBRuq0VGltyhREldbZs6APy9ZkBQHxJa5JVJypLn7JrP3PrAkarX0s+YXZnSud0aTAkFqXyOtp0NQ/PGB6Ks230d7p3USoyAyvCrLfOQ7rYNv3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784404694; c=relaxed/simple;
	bh=AsbYFK5rMxDmLypp1JXdseEWT4vMfb7OAC2VHlmQjTo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=H/+XZqWriOirqDGI2dP1enTZXrpkrksWQI9sR68tPj4HjeDHJXS8iCxcLoV8F27WhaIxX6DdhLuPIWoHUaWekMMnKViKY//iMCHWEEurLWCZIVrgSzpl126/l7+8OJHzQiRPTPbBxPQlvqNXY3Cgt5ykd07/hq+XfdfsjObxoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=lNaC9fdL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OuJsv5+P; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnericson.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b="lNaC9fdL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OuJsv5+P"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF0957A005B;
	Sat, 18 Jul 2026 15:58:10 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Sat, 18 Jul 2026 15:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1784404690; x=1784491090; bh=yA/pDagG5EW1A5gChDoOabVGCEGnCcTm
	hBVyMACsinA=; b=lNaC9fdLsbfS9CSsmdDTeTO9uLpO3LmLeuZl3Cd5OsBiHxpC
	uHYcp1riR03koBUFWdK/jy0bkilf1DNuhrBSb8QeMDoiQ1d+IabIRNqLG5Vruo0/
	m1FvXMEHN4xoMV69Ajs4JsnBKKs2cFgSGQp+ykUmDGAc/9xcxAuwOFpRkKw1jDI5
	8fBjsqV4HBsXorHWv8TqhJJHg1YpTbtyElPZOhvzxLXh1VEcsLf6VTbO9gsFyXbz
	4HGfenFJLwb/6BWL4svLCi1HfqUOEvVbvMBnGDaVcL7P1uiZoCsYcYCo2ljknIHa
	BsdQ84QLjXkhGHGeDdVgXRyTYcmTungT1A4u/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784404690; x=
	1784491090; bh=yA/pDagG5EW1A5gChDoOabVGCEGnCcTmhBVyMACsinA=; b=O
	uJsv5+PYyPY0Lvc1NnPgUKiV+QX+e4w1UwBx1B7S0Vd2vJ/gfyOEDrnjHjwQLUY0
	UxApGTrRiwwx7BjRzppYwsbQVvfdQlhxRZniw9KFH6xzVD/R49zwC0SSSpwp3aFn
	/ZPKb2RFjLWuNYRZA4SKKsGA6W7mD94eEeKV26zDC1BgTgz+RALi7P2x67nd6MnO
	Lr/me6N0QRkfCbo8frPfqzjW71kJck8T2OXiMwqr4elZGMKomgOIEXJ6ZuIZ2/KP
	7fDtPjc8WgEqaVa8N32lz+4uaZw72XhPGqUyVdrii/GzBpsYcmxMg+Px7Hk3gmEN
	OJDNDx07Rims+SJCfG2Cw==
X-ME-Sender: <xms:0dpbagV0cDK_T3PBPzx_6vEC-mlyuq3J8r94ch_nZzYUHQOi8Z4zGg>
    <xme:0dpbava3SKhDMoBJ4QvmHJiPsflQGKwqwCAnAkYpVtJluSEI9nTXpI6_4zF3JrF4q
    A8pDyGpdDULhwrpa-RJhqfLr3uiejQDbhNwpS1cHG1DDD8OCObXegQ>
X-ME-Proxy-Cause: dmFkZTEBGZbYUFI/YZJ8UX+h81pT0W1evTXyZFZ3o2bPjucg9g1ZZOOKTZktq4A++8IJZ7
    BOjxZlVDccOalpJRZECCyZrbGy94eoeoXWE5LlST+Rt05PIo131yXIxeavvcTzOKEyHphA
    9IAccCcD33cnkbQ81KqKmIS48mGuHkUDcOKTATfP2MHBOxdXoS6RRI9QirNFioPCTx5Wq+
    7PmLaHpAe8VxZfTrkQv15IjOM8jY294EXqZahEU2wpQBCovr6LXKM/D+PhuDHQw0UqyMSW
    v/Kax6vd6MDN5BTkjvZqPYeqsXtDuAQCk8pFdQJUPnePB9B3qsxRjJIpZG/NRGaAWzvWte
    3IwkrE9IPgzeQ2Ke7I1CuEoIVipsEOg6YBFAIui3F0JI5jgTSkfQ4B13Ibgf46EelEDb9h
    YRp1Jp9I6NxgMEQbv3EnY8wyvf5tMjCvO2UIiRd2k11qxnpK4JUxGn3iP4qUwdCSEGFxX5
    9ItsHKhIDdaA5QzONSCuCXkkVRX9enlwWGEqTZnLt1hc0v6I5Imm0Ow5+D8lOmj7k5JPOj
    Vf3CnBid6Dw+jhm6r5MxupMlmDDPe4kBQYiImz4QfXSqriBWPA03Enq2/CZCB0WGt/5KlH
    ooAFPRznEcQ8kWdHJKv+InDn1ptMuVJ+DIoU1Agj+pHZtli0Z6VEpkv0PYHQ
X-ME-Proxy: <xmx:0dpbam3fhXy20fJ86ScPkZ4PFRTS5WKjjMyDbapAClI5_mKZMsRt0g>
    <xmx:0dpbalbZuXeS15nAVh8Lm1RVxSVTO7T16IO8odDrClXoGWT86LtxIQ>
    <xmx:0dpbaghwopwmj6WBzmByWORe-u-Ron9qoGUD2GvADAd-MdhjBUonxg>
    <xmx:0dpbak-idSLZD5M4h1V0UziEKi-SJUyao7ySV1IAas7lJJ2zbksrMw>
    <xmx:0tpbapxutu4HDd3WqXwNeNK0KNhml5ElWpBWczPI4AxMEw-2VAaqOM5B>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AABB52CC00A1; Sat, 18 Jul 2026 15:58:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AudyXjUgQ8Ew
Date: Sat, 18 Jul 2026 15:55:12 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Kuniyuki Iwashima" <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Cc: "Cong Wang" <cwang@multikernel.io>, "Simon Horman" <horms@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "David Rheinsberg" <david@readahead.eu>, "Andy Lutomirski" <luto@kernel.org>,
 "Sergei Zimmerman" <sergei@zimmerman.foo>,
 "network dev" <netdev@vger.kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 "Paul Moore" <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <e6f54c5b-2c92-4772-b2f9-5c21e2ec50a9@app.fastmail.com>
In-Reply-To: <20260703073948.2541875-3-John.Ericson@Obsidian.Systems>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
 <20260703073948.2541875-3-John.Ericson@Obsidian.Systems>
Subject: unix_stream_connect and socket address resolution
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

In [1] I observed what I considered some odd behavior in unix_stream_connect():

> I was hoping this was going to be a simple matter of factoring out the
> back half of `unix_stream_connect`. No such luck was had, because
> actually instead of `unix_stream_connect` looking up the socket from the
> VFS once, it does it repeatedly in the same loop that is used to deal
> with full listening queues.
> 
> (This behavior is rather surprising to me, because it would allow a
> deleted and recreated socket to be picked up on the next loop iteration.
> But, I don't want to make any UAPI-visible changes in this patch series,
> so I did not consider changing it.)

I had said I didn't want to consider changing this yet in my patch
series, but based on the feedback I received for a second version of
that patch series, I now actually think it is a good idea after all to
discuss this first, and see if it should be changed prior to my patch
series. (This discussion will inform what the code looks like before I
do my v2 patch series, and how big or small that patch series is.)

Here are two scenarios where the current behavior of
`unix_stream_connect` is surprising:

File system version:

1. server binds socket `/foo/bar`

2. clients fill up the accept queue, begin looping

3. `mv /foo /foo2; mkdir /foo`

4. another server binds `/foo/bar`

5. clients connect to the second server instead

The loop in question is within `unix_stream_connect` itself, not in
user code. I consider it very surprising that `/foo/bar` is looked up
multiple times during a single system call.

Abstract socket version:

1. server binds abstract socket `@foo`

2. clients fill up the accept queue, begin looping

3. server closes its socket (or exits), releasing the abstract name

4. another server binds `@foo`

5. clients connect to the second server instead

For abstract sockets we cannot play tricks with `mv`: the first server
does need to relinquish `@foo` itself. But still, the result is the same
where a different socket is resolved on the next loop iteration in
`unix_stream_connect`. I am not sure it is fair to call this a TOCTOU
issue exactly, but it feels very similar to one.

The more natural semantics in my view would be to first resolve the
address to a socket, and then loop holding that resolved socket
constant. With these semantics:

- In the `mv` case, the retrying clients continue to try connecting to
  the original socket, now at `/foo2/bar`.

- In the close case, the retrying clients fail, and do not connect to
  any new socket at the same path or abstract name.

What do you all think? Is this better? If so, is this a security fix
which can be made unconditionally, or, absent a real concrete attack
vector, is this a UAPI-breaking change which is automatically out of
scope, and would thus need an explicit opt-in mechanism?

Looking forward to feedback,

John

[1]: https://lore.kernel.org/all/20260703073948.2541875-3-John.Ericson@Obsidian.Systems/
