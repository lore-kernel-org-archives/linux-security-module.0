Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74B2877FE
	for <linux-security-module@vger.kernel.org>; Fri,  9 Jan 2026 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972067; cv=none; b=nEJ7ELJWVAsh2qS/+ye6q4GpmR/45oNdQJ+jn4Ea9LFCQq7w4pgoUps62s7FSzXJ7Qhgo1v3z7SpLW77jfAExn6TgcEm8uBvas75paJ9qpSUY8+Pney/FTaOXiWHVKYTWraNpHrBtjFCqUnKv8ATV4r9SJSHnnZHqx3jJ5MztC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972067; c=relaxed/simple;
	bh=AVTpei8gByW8FGSiK+O4/gbpl9lPh38JUWpoUDiMfcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyP6wJr0CCQhguzlzTLVtx1AS+9X7dvphyaOENqTy+zixcDa+yszj9JapQoOQ9wIzlS4nsZO2Sywy07DVlYVF1ecdzmW29FSlVc88Xf176iNc3nD140wE3qlZ3u/Njo2MBFKQ12Z8L0TjRlK5VJxIwfL7EixcHh4DoOAVRBfsfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kLDcI0fX; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kLDcI0fX"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dnlpc3ZpRz8y4;
	Fri,  9 Jan 2026 16:20:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1767972056;
	bh=Gw+dm7Q8zC6wrLQ1iqSf/vhE0jxiMCpVFkC0CEJuF74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLDcI0fXPL0uouvsjznFz+NNpZELI4wZmhzYQ+xD+OYyYz7JmQEvtCc5V5Ce7kNg2
	 /2IvcX2mBTjQrZe8QxwSBJ9pBwbN6t5l+hVXj4FEx+eKHzyWpkOGSa3X5cNNZR97ti
	 tLiMo8pfW5tucpbVrIfKpnQe62oq2zXrrCJnPYOo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dnlpb16GnzVkR;
	Fri,  9 Jan 2026 16:20:55 +0100 (CET)
Date: Fri, 9 Jan 2026 16:20:49 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [RFC PATCH 0/5] landlock: Pathname-based UNIX connect() control
Message-ID: <20260109.aiXa3Iesh5wa@digikod.net>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
 <20260109.she1eg0Ohl4u@digikod.net>
 <20260109.d4c29e22f15f@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109.d4c29e22f15f@gnoack.org>
X-Infomaniak-Routing: alpha

On Fri, Jan 09, 2026 at 03:41:33PM +0100, Günther Noack wrote:
> On Fri, Jan 09, 2026 at 11:37:12AM +0100, Mickaël Salaün wrote:
> > On Thu, Jan 01, 2026 at 02:40:57PM +0100, Günther Noack wrote:
> > > ## Motivation
> > > 
> > > Currently, landlocked processes can connect() to named UNIX sockets
> > > through the BSD socket API described in unix(7), by invoking socket(2)
> > > followed by connect(2) with a suitable struct sockname_un holding the
> > > socket's filename.  This can come as a surprise for users (e.g. in
> > > [1]) and it can be used to escape a sandbox when a Unix service offers
> > > command execution (some scenarios were listed by Tingmao Wang in [2]).
> > > 
> > > These patches are built on Justin Suess's patch which adds the LSM
> > > hook:
> > > https://lore.kernel.org/all/20251231213314.2979118-1-utilityemal77@gmail.com/
> > 
> > As Kuniyuki pointed out [1], we should handle both connect and send.
> > This would be similar to the scoped restriction from Tingmao.  I guess
> > we'll need a similar hook for the send operation.  Because there is no
> > need to differenciate between connected and disconnected unix socket in
> > a security policy, we should have one access right for both.  Any
> > proposal for its name? Something like TRANSMIT_UNIX or EMIT_UNIX?
> > 
> > [1] https://lore.kernel.org/all/CAAVpQUAd==+Pw02+E6UC-qwaDNm7aFg+Q9YDbWzyniShAkAhFQ@mail.gmail.com/
> 
> Ah, thanks for pointing it out.
> 
> The restriction as implemented in this patch set already solves this
> for all the three cases where a Unix socket file is looked up.  I
> believe that it is happening in all the right times (everytime when
> the lookup has to happen).
> 
> The cases where the restriction applies are the following:
> 
> * unix_stream_connect - when calling connect() on a stream socket
> * unix_dgram_connect - when calling connect() on a dgram socket
> * unix_dgram_sendmsg - when calling sendmsg() on a dgram socket
>                        (per-message lookup only)
> 
> You can find the code locations by looking for the call to
> unix_find_other() in af_unix.c.  (That function invokes either
> unix_find_bsd() or the lookup for abstract Unix sockets.)
> 
> In the unix_dgram_sendmsg() case, the lookup is only performed if an
> explicit sockaddr_un was provided together with the arguments to the
> sendmsg().  (And sendto(2) also uses the same code path as
> sendmsg(2).)

Great

> 
> It is true that the current name for the access right is slightly
> misleading.  How about LANDLOCK_ACCESS_FS_UNIX_SEND?  (Like
> "transmit", but a bit closer to the naming of the sendmsg(2)
> networking API?)

We should try to keep the access right naming consistent:
LANDLOCK_ACCESS_FS_<VERB>[_NOUN]

What about USE_UNIX, or FIND_UNIX (closer to the kernel function), or
RESOLVE_UNIX?  It should be clear with the name that it is not about
listening nor receiving from a process outside of the sandbox (which
should have its own access right BTW).

> 
> (I guess the other alternative would be to wire the socket type
> information through to the unix_find_bsd() function and pass it
> through. Would require a small change to the af_unix.c implementation,
> but then we could tell apart LANDLOCK_ACCESS_FS_UNIX_STREAM_CONNECT
> and LANDLOCK_ACCESS_FS_UNIX_DGRAM_SEND). WDYT?

I think the hook should have the same arguments as unix_find_bsd()'s
ones.  This gives the full context of the call.
