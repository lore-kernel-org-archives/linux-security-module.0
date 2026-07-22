Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEED40BCBC
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 07:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705167; cv=none; b=BKpIWm/1mEn0yzf1SytX3gPlHI4CIIXCBYPwFN+gpgryMKFvDW6OwTPAk2Sj6PWE4pZgcr0ZKPxZPGhMu+mlbG/lmWI/Ki1qI49pyhjjSle5+G9/lhZoOO8XMqxt78hwn9gRJjJJiScohcBkiocrYIGNLj9eq/amkxtKoz8/dOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705167; c=relaxed/simple;
	bh=uJIAB5aQK5warnNdya8/fwYBHVjoZDLyZkCYyd2WN6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTwLi12+yV7IH3in8MLvWMf5oR7wxRrln8IHsD0Uaram4bVXlmCOB77ZH7x9RBD1S+nalnLqksfE+v+oc2EPHTP8HgQ6oRqyJ/7oubSwPhISzfDDLHTEytKRCfueOccRhBx5BtM22QuTSRfpZ2GH1oGDVg6nFag9WZoLytDA+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qWpYI3Fz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWpYI3Fz"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493f75f7172so94612855e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 00:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784705162; x=1785309962; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yG1zyrx4ZGGVITfwIyi0juPEmhwYGA6Wx/gAK25GPak=;
        b=qWpYI3FzsSc4fl9eNit1vGBjmgtXAAo2AMeTHowX3HD/5a5GYS9DzsQG+H+zbM651e
         /aetiIvH7fHdxrCSehYgSOfr2XzAek1fl+kSb/oWXrBKpJAFQpT/ybliX19WgnDUTQKQ
         /g04gI/sHhbJ+CXK2ikiAFeagDcRhGyPktXL17xPjMrKN0s9zjSwV9km9ulOpDuHSh50
         pwnjVFrlSShXKOztKBkpduCZhrqbaEA4+CI8icnflU6Feo4qwRDzdjLtae//3wTd3HyQ
         9WGTpSXuVclR3eklCj8nm98E2P71LzXDXYLuzr56EgF/JtZ5duAgLl+qcE7GLz6v+6QN
         4w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784705162; x=1785309962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yG1zyrx4ZGGVITfwIyi0juPEmhwYGA6Wx/gAK25GPak=;
        b=O8fDh/snlHn8srpjWtho/ocTVeO2s2XVaY1g0w01OhhJENiLXeajCYZGCXlmAPtG24
         eEBTOHf5t2xXZB/ALju8yjdsqbX1bdW9cTRbU/jDQoTKyoLySgv3zzJVPhxjt1aWkW2/
         GWiicvWL/6WwNB6Ean5WwIB+h6Dr3DNclee23tI0ojYPHJYVBEBByOqJ4w1PxfPb662h
         Adns+GJSpNOEtbFwyK3T531qwXmKl36VACkeBTylPFqfQMr2ls0hNnRdY1qnzn0KLflj
         GSrpas0Gi7csUw1mIPnIrrA5OlgWkbjX/xlAimykxaIW9dSLE306UgfE116ow9hHWHn1
         scUg==
X-Forwarded-Encrypted: i=1; AHgh+RoogBex3cNMv3uX9uAc7zqADQ6TIpXw3RYDB6WqmVD/k76/wNgodsLxKiFs8T28wbodhVZUaVWiFeTiLP3P6NHkXP9dbRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYIC3cKRD5HCR8iouV2KLswBxenxHkD+5k6c8Iq9wng9lk86fV
	m9REx9fhYejAa6I9Xtaz5fWr0JB+E/zRQ0tnrz+Hi8S/2YBFMqWsA5G7
X-Gm-Gg: AR+sD13UhX8H9G7uVW3DVeox5MaUqPBnkiNPVlr6xaiCTwlBR4TE2p3/EYEthtm5Kpc
	L6MudI/ajtCaifdRnkSPXBVoYeGoStQSPEPJ125qzk7Mt8znT0vG7NKB4S45zJ8qlS9G/0RCwE9
	DbgewZInuGkYfHHOAlGKh0W8EF4b9CrFc1FmwYd36w6jnUF6f4r3LfxKAp67RdJKx86qvztucEC
	98+Kj6vrJFGjE1PN3NWS62MUqNhwnbubBPApAQX/XSawAe+Zgkkbqt1lIBNf5cgwtk/k2eQ/vl1
	gwst7Qw7b/WAB6Vd/w4daRJmlkhlTDIPqNGAcZYJL8G1bX7ImNaB8WLJ7F3Rdpfgh5LR82OlJ+F
	pRPpsP6fzkXyiAijfd/JFKTesHB4WhSjXOKjMcIqydworD7lm3dq1P+gE6KsHWUBsf6wjWK3U88
	r8txB1ykAysAR3H1y/vbAQisA14pTwZAgKxrYgaA==
X-Received: by 2002:a05:600c:c84:b0:495:4689:1e98 with SMTP id 5b1f17b1804b1-4954a3ed426mr236754125e9.10.1784705161604;
        Wed, 22 Jul 2026 00:26:01 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956537c7desm176881885e9.7.2026.07.22.00.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:26:00 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:25:59 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: John Ericson <mail@johnericson.me>
Cc: David Laight <david.laight.linux@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Cong Wang <cwang@multikernel.io>, Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Andy Lutomirski <luto@kernel.org>,
	Sergei Zimmerman <sergei@zimmerman.foo>,
	network dev <netdev@vger.kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: unix_stream_connect and socket address resolution
Message-ID: <20260722.bfca37efd700@gnoack.org>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
 <20260703073948.2541875-3-John.Ericson@Obsidian.Systems>
 <e6f54c5b-2c92-4772-b2f9-5c21e2ec50a9@app.fastmail.com>
 <20260718215855.07284fb1@pumpkin>
 <85991dc3-6fa5-4466-a0cb-b407291cdb44@app.fastmail.com>
 <9c437c7c-7919-41e2-9161-fc94803a9b34@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c437c7c-7919-41e2-9161-fc94803a9b34@app.fastmail.com>

Hello John!

On Tue, Jul 21, 2026 at 04:37:07PM -0400, John Ericson wrote:
> In case this is useful or interesting to anyone, I deep a some history
> spelunking, and the restart logic in question seems to date back to
> Import 2.2.4pre6:
> 
> https://github.com/tbodt/linux-history/commit/7d4fc34b9bbc0a14d3e5f6b2f978373422e1ca8a#diff-0553d076c243e06ae312480cb8cb52f1cebe1d80fc099d3842593e12c9e0d4f3
> 
> ---
> @@ -673,9 +703,25 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>  	   we will have to recheck all again in any case.
>  	 */
>  
> +restart:
>  	/*  Find listening sock */
>  	other=unix_find_other(sunaddr, addr_len, sk->type, hash, &err);
>  
> +	if (!other)
> +		return -ECONNREFUSED;
> +
> +	while (other->ack_backlog >= other->max_ack_backlog) {
> +		unix_unlock(other);
> +		if (other->dead || other->state != TCP_LISTEN)
> +			return -ECONNREFUSED;
> +		if (flags & O_NONBLOCK)
> +			return -EAGAIN;
> +		interruptible_sleep_on(&unix_ack_wqueue);
> +		if (signal_pending(current))
> +			return -ERESTARTSYS;
> +		goto restart;
> +        }
> +
>  	/* create new sock for complete connection */
>  	newsk = unix_create1(NULL, 1);
>  
> @@ -704,7 +750,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>  
>  	/* Check that listener is in valid state. */
>  	err = -ECONNREFUSED;
> -	if (other == NULL || other->dead || other->state != TCP_LISTEN)
> +	if (other->dead || other->state != TCP_LISTEN)
>  		goto out;
>  
>  	err = -ENOMEM;
> ---
> 
> My question can be basically restated: why should the `restart` label
> not go *after* the `unix_find_other` call?

To elaborate on David Laights answer -- the classic way of restarting
a Unix Domain socket server is that the server unlink(2)s the socket
file and then bind(2)s the address again.  In other words, when the
server restarts, the new instance offers the service on a socket file
with the same name but it's technically a *fresh* socket file.  So a
"normal" server restart is not technically that different to the
example you gave in your earlier mail (the "File system version").

Another variant of this is one where the server uses rename(2) to
switch out the socket file atomically during restart.

I was not around when that af_unix code was written, and cannot
guarantee that by interpretation is correct, but in the hope that
someone will point it out if it's totally bogus: My interpretation is
that the "goto restart" loop in af_unix.c is designed to smoothen the
server restart cases in a way so that the client doesn't have to deal
with manual system call restarts.  That loop needs to include the
repeated vfs lookup so that it actually gets the socket that belongs
to the fresh socket file.  (Otherwise it would just observe the same
SOCK_DEAD socket from the old server process again. - The new server
serves from a new struct socket.)

Example Scenario, where a client connect(2) races with the shutdown of
an old server during an "atomic" (rename(2)) server restart:

* Old server process serves on /foo/bar.sock
* New server process starts up
* New server process binds (and creates) /foo/bar.sock.tmp
* Client runs connect(2) to /foo/bar.sock,
  does the unix_find_other lookup, getting the old server's socket
* New server process renames /foo/bar.sock.tmp to /foo/bar.sock
* Old server process shuts down, socket transitions to SOCK_DEAD
  through unix_release() -> unix_release_sock() -> sock_orphan()
* Client connect(2) syscall checks the socket and discovers the
  SOCK_DEAD state, because it still holds a pointer to the old server
  socket.

To recover from this, connect(2) does the VFS lookup again, because
the already looked up dead socket isn't coming back.  The connect(2)
function pretends that it ran a tiny bit later and only observed the
new socket.

In this scenario, the userspace server is already going to great
lengths to make the switch atomic - it would be surprising IMHO if the
connect(2) operation could still return errors to userspace due to
race conditions in that case.

Again, this is just my own interpretation.  I also did not find any
better documentation on this.  If I am wrong, I am more than happy to
be corrected. :)

–Günther
