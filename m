Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666538;
	b=z+NK1ToVDGy3lR/rTP3xUEgpbgRaShMNhOOeIORY4aKpkYpWm2Xwz9rSZzkTgiGXit/D
	 qUHRZWM64ko9efMZqCXXsXRkOJ12+e4CpcveHd+76jc29P3fEHWO2nD/11Nxq1s95eIPM
	 A4uIfvudyvT07Cv1kuUTY2IrlqpNe1Dwxv3d08PqrF2wK6BURcopkffHpvMi71yDDhk2P
	 kyim09lk7vP+GfNj7yTk7700zhMi/2fM521ZdiqizS6zPE9zsUZDAXrwo3SSajarldJn2
	 x7tVvTdSufHuCKM8aQQ8725HbauwGVwOIo8TfNL0szPXqB/lX/aAXmQfqalwvOGLiQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666538;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=U9s8oisK14CONLCEyU3p3b6b3zng6n1Z90Bnl+NW2HM=;
	b=RqI+JMFYQ6l22k4tHbJe7l5VR5/cHknhRy2vnQZ5iwSPKC6mPUo60smVeY2MZ/7MpZat
	 TYBM4HJrGLNsFHRtIxBhXgy37PVEqxMeTvd1BCzmGK/ylDAFYNIX9S+8hPjpELyjXtshI
	 eUW6hGw/9Ugldjr2vtJ5Jsu9A6H+iJeSny59BOKc6DpctQKiYHWMaypkS4gKSdFl7jodb
	 oymxTzLVBr9+w4bEcq5Ofrl6x4wWmHgeUP2ucpEdHGePMBY1cLbc/4kk8CoOV/TihSc3K
	 R2xyDVlxKEbm1aIcNE7URwCJXO6eV6IrpbAlKHvQMcnHlHLTuvRos5h+x26cym8Q2Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFPsM7IB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 89F38606A324;
	Tue,  3 Nov 2026 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFPsM7IB
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C9DAF1F00919;
	Tue,  3 Nov 2026 00:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793666538;
	bh=U9s8oisK14CONLCEyU3p3b6b3zng6n1Z90Bnl+NW2HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gFPsM7IBoGAxrOn+ndckbhTaOk6LIj9+gOXPwf+y/NUZJ8+2B4nNmjhe82X227XMF
	 MLiJdaG58bAH2Aawm5/jlquJvFxJ9PRmM+k1GEvu6BZhxcT5DZ3D6GPPUvSxu/XSQz
	 FyPz7+dLNJtzigBskKXjBxvOo63GS5XYiPMeI6l3eCfYX9XhBX0TwTc9HVnIg2lJOn
	 lbqr7LhUH0exMrGrvo+S5Q4t/9anDkAS2IS2SklsUSOnU/ygGXaMX4I6TIHkqkdkSg
	 nKgIYdwyFvqzzWU+Guk2a5bchNVHQlWYhZrnaFL3Sh4BDEOGHDqkq/5wqWk60lX4e4
	 hpXEBkQ1TBkcw==
Date: Tue, 3 Nov 2026 02:42:14 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] KEYS: sanitize the garbage collector behavior
Message-ID: <aukt5qJqL6G26HHJ@kernel.org>
References: <20261102121518.1197453-1-jarkko@kernel.org>
 <aukk0VsRnXY9o-kF@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aukk0VsRnXY9o-kF@kernel.org>

On Tue, Nov 03, 2026 at 02:03:33AM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 02, 2026 at 02:15:11PM +0200, Jarkko Sakkinen wrote:
> > 1. Remove key_type_dead and replace it with the regular module semantics.
> > 2. Replace variable size workqueue items with fixed-size 64 key chunks.
> > 
> > The first change has user space visible effect: rmmod semantics will change
> > from always succeeding into returning -EBUSY when keys or restrictions have
> > the LKM pinned.
> > 
> > Jarkko Sakkinen (4):
> >   KEYS: trusted: Disable sysfs bind attributes for TEE driver
> >   KEYS: Pin the backing module for struct key_type
> >   KEYS: Remove key_type_dead
> >   KEYS: key_garbage_collector(): process in chunks
> 
> This turned into patch set consisting of 10 kernel patches. It will
> take a bit to get them out as I'm still polishing them.

At least for me dns_resolver feels like the nastiest corner case (or
perhaps I'm over-complicating it somehow, don't know yet). I have
one patch but I still have ideas left so still experimenting on this
topic a bit, and trying out different approaches.

Br, Jarkko
