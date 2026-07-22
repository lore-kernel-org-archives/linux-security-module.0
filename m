Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870773D955F
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714728; cv=none; b=ue2O8P2Sq5Cbe/iZ69KgSoFz6FSsm3yDg2qIiH/4TiYzbv2YX4vGQ5D5/g6BJp6mDjJ1JdmucoQLtvhK7+zjW2ZX/IWAeVhCSCJoGNTalSzfELY9+G4zhPH1pe+IHyBXWWN40IzMOp/nAD/Rgst6IDGhS/aCLi3BM6pBZ6SWN/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714728; c=relaxed/simple;
	bh=GFOQA5ZaYIdLp7nDVuoMcdf1Qjw6plAGcxortgT6azo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2EcFOZam5/vGBDkgriCqEGGK+NHtjzi4sudmXP2e7c+UWF1fzC9YVyUlQfAbrmhlYhlIITS6mzlCqVia+SnoQ+xSV4iBVA5Gmn1/ObtqU9QMVrx/YTelzHqR4qaCuy6tDkLtj5RGtlcQon8qZxxyOrCFIgMgF0X3Tfg774hGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoSPkqgq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoSPkqgq"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4720f3bf164so3323557f8f.1
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784714725; x=1785319525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KMj9zc3x6l5zmOsetNs8oaLqxVKGtYD0hQY1boXGGc8=;
        b=FoSPkqgqMoWg1IC51NgGXYnL/YOjeOJ/+XXygkEsKAoZIstqxygamqXIo+ZWkPhZQc
         ZeOwa4ihJlvmng/lVJDmwAXW9b0dGX+ft/1uNtnW0uPcOBGNOUlgnzDyHe5cKnhHw8ND
         ozHUYwmgV+pm2jmbFWhzsOVJgJ6R2H8P51K+ILlefStMdsswp2jzx2SY6gWGTrSk4hH5
         D3hXgMh6Vd23g8MxKthhhxrDMowNA1NZUbgymlNOCqYwhs+sPT1Q+Qbr0HZBVwjRNi5+
         Wit7IukaQdZtGCUYTG13opK9UJi+okvXESBNvcSQuAM2zZuWu/hGnkSAo/8UygP+sO1J
         7vfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784714725; x=1785319525;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KMj9zc3x6l5zmOsetNs8oaLqxVKGtYD0hQY1boXGGc8=;
        b=g6BK4la6d7HsJsb74ckrf9+2qHvrI7GXEZ2NAaZw9fphQ7l5i12ypcUnPdwJonX79j
         zDebJys1gB8rQJNl1CLAXbq0eqm/NxtI0bOghfoviYaCWUflUKuXjUuMuSPoAzp7/B+Y
         N/MTn7xF58CU6Wu2sEtavBOK0mRMD8xP1rajjwfFAJH2zZG+ytZ5QiYAaCkQCHuhZR7h
         aVp8pcAia5f9bDjokshir4bjKCTX3vt0Ib0yiBDPoqHt0nPhndHyEqOgrE7tJwNLrQyT
         rv0Foh+wRLNXbGBiUwP8ZHAHnR5qG/Tgy4wcIHjKO59dkRYh8Hd+DAKQ4R82pRVKQYqC
         gd2g==
X-Forwarded-Encrypted: i=1; AHgh+RrJq0V7j9BA78b63GqfFc+pYKmAc9zihVBzHCeACxD11hm95HtVDwumGX5ijryX/IujU+DUSsJBkheYJIHhUcgZJhm/NWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxNv6wcPTM/QXd0cOF9Cokceu5sFFJVQgRr06srWgdpGIfx3L
	Is5lfFLW3hpsMuRn9Jap+aCHlWXyo+1OAvlYrmpY9PeJZDEXaDjf0HosGJGk8IMCvMA=
X-Gm-Gg: AR+sD10fGadeDJ0L1pZcL9+/V0hoNJyrRXRS9MEWibILZxLxt5z3s+p9vThwFf4C5Mh
	R2xtskC41psNsvDaXyvgENCvEdurpzVsdkFQfxknP0NEq5Bs/mhmF2Hm1Oafoz9afJbNJjqBNTV
	TLS97NGoYz0/cZTnE7srRL2BpzlcXpv2WgSSTgFMsuMkfV4NrpGrMyJdU+tT6QzsXMro1Tg6eFw
	DUL3tHEYvNYbpQPNjzBfmyL8OuuDFovBQ/6vXLX+zCzG8GL0LF7fBrZCJjqbgkBGzj7bXMGs7YX
	n1uVG9Xdx2JvquKtWj9wDkePK97rr05VHp4hNAh35NRyXhiPOVFHOq97/4I7fAH6q0/ZCvE94IE
	LLYBbJ9Jn3O4ExVEtdac14w1zBO0AZSsyjKp9uwSiJuIhoBIJIsPDrX0j4pY5SAs3MxSUNsCJCZ
	hKDK/GNFZjPw9qXjYaxfk3tOvks+toZHcZl7FbhFilW53pB4xdLw==
X-Received: by 2002:a05:6000:25ef:b0:47f:7c8a:ede with SMTP id ffacd0b85a97d-47f840a007fmr4146900f8f.5.1784714724465;
        Wed, 22 Jul 2026 03:05:24 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bdac28sm4582498f8f.16.2026.07.22.03.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:05:23 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:05:22 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "John Ericson" <mail@johnericson.me>
Cc: "Kuniyuki Iwashima" <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Cong Wang"
 <cwang@multikernel.io>, "Simon Horman" <horms@kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, "David Rheinsberg" <david@readahead.eu>,
 "Andy Lutomirski" <luto@kernel.org>, "Sergei Zimmerman"
 <sergei@zimmerman.foo>, "network dev" <netdev@vger.kernel.org>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, =?UTF-8?B?R8O8?=
 =?UTF-8?B?bnRoZXI=?= Noack <gnoack@google.com>, "Paul Moore"
 <paul@paul-moore.com>, linux-security-module@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: unix_stream_connect and socket address resolution
Message-ID: <20260722110522.710ced10@pumpkin>
In-Reply-To: <9c437c7c-7919-41e2-9161-fc94803a9b34@app.fastmail.com>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
	<20260703073948.2541875-3-John.Ericson@Obsidian.Systems>
	<e6f54c5b-2c92-4772-b2f9-5c21e2ec50a9@app.fastmail.com>
	<20260718215855.07284fb1@pumpkin>
	<85991dc3-6fa5-4466-a0cb-b407291cdb44@app.fastmail.com>
	<9c437c7c-7919-41e2-9161-fc94803a9b34@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 16:37:07 -0400
"John Ericson" <mail@johnericson.me> wrote:

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

This unlocks the socket - I doubt it makes sense to sleep with it locked.

> +		if (other->dead || other->state != TCP_LISTEN)
> +			return -ECONNREFUSED;

Those look like potential UAF.
Hopefully changed in the current code!

> +		if (flags & O_NONBLOCK)
> +			return -EAGAIN;
> +		interruptible_sleep_on(&unix_ack_wqueue);
> +		if (signal_pending(current))
> +			return -ERESTARTSYS;
> +		goto restart;

Since 'other' was unlocked the search must be repated.

	David

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
> 
> Cheers,
> 
> John
> 

