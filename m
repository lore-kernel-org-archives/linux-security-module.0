Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE8C72607
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094850; cv=none; b=UO3kPovEg8fPGRMErGI4SWE37FnorsPj4e9jiSInXPvZz25Ox91eo9x1YkvSLGj8ruOAya19AnMoIg3Rw8OUCdZWTxo8AdE9XqZlktCcNqdOp1qK5Ib60b1PFk8yJR0lD6KOLuFZroxpKeIAGldSSpRIA6Dhxx4jLP1hdJ/Ij0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094850; c=relaxed/simple;
	bh=w0PWzJYGZyUO7NaF3hKUPKQCpIVIVkYsajHq504Hcsk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyJUbxQ9Csa9+2Jcad1WMXKVZ6oZtyqU54K8xAPwQbRzzYOATsYta7019PAIjFr3zs32+gSY0KW4X2XAFe6wYavFX79M6zBsBphGnDHzdpaouZ8DfHW8fnRrlI3NcLI1WxCi0RsRhuCSqfMPJcPCIxWj2SxKyYvO+VUrY7wUy5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jy7zZHdR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jy7zZHdR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750094847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7AAtsmpqEB0sDxRTXjGqemaYQ70O61wfZxdM4h7t6Ns=;
	b=Jy7zZHdRnZbn88t46eEei7+oysXmMn/qdHtpBncj1aytO0bk5G/XnaMxq0HRCafiay4qrE
	c67U6T/v7/QlBL83pDKhTsoYVzL6EsXi50cuEh1zbEksAeiLS5vwo0qqXFjSZLjhDjLej4
	lI221UIVbuJwl54mvzs19rTuKdM/vIg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-9nptFxQ-NQybED0PlmQSvg-1; Mon, 16 Jun 2025 13:27:26 -0400
X-MC-Unique: 9nptFxQ-NQybED0PlmQSvg-1
X-Mimecast-MFC-AGG-ID: 9nptFxQ-NQybED0PlmQSvg_1750094846
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb3466271fso83395566d6.0
        for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 10:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750094846; x=1750699646;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AAtsmpqEB0sDxRTXjGqemaYQ70O61wfZxdM4h7t6Ns=;
        b=tWjT9bmyqm/s2WuH63N6yYiKcpmmcjQ4q2DXWdMKhj4+tMZgWe2f8iFLNbwbTm4cbq
         q5vf3eCSrGI9dQpe8yLu2T/6Z3iyXXWgz3iR4IV46i9YJ068I21lAqPn1+BBCVsflv9m
         ZoapCLw+38lDg+IlHWc5OsY/8OlEaL9POb3/VokFIIjW9Q9V4YoaKrWu151VhIYbqm5x
         8AbmvpBy2WvP2U4ZMpJM7DeY0q9NA+FDL9VXJ+Sjl1KsgqAbRhXYK5aXqVArYcFRExwK
         kM18ZHCKGbcp4rtYAsRPMMVdFVVexIej2amz2k3AgXHzvKvAteMvsfHGBRL5rVrztIoj
         ZCMw==
X-Forwarded-Encrypted: i=1; AJvYcCX2iorhNPNi7IX6TWTZv6OS9kQuJqAuVI6qPAx50iWWooXtaVSQqLzzKqqPhRZdevaYw5RZJwBYbdJkIbOxTUbDezKQHHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycRcB2azXdJIladHuHJ/aI3yEOKexQgUC+LdVH0E+qIqfqzR1w
	1nXdAqWwwPUO/Szc81DBwjDs+LuocLc6l47LNLhAKvFYxgMLG/Bt0n7qDMbC/1YAEZZ09jGcZnO
	ruIrfR3/B/MyqEtYrAk6v+YRVEIgc2uLNKIG3t7Km2SQTqL+r6B1jCUkLlCmJGzvXuAUXVgfJoH
	9ilg==
X-Gm-Gg: ASbGncs0kW4p3Cl2h+XE8GXHJYCe4AUPyuCo7R1EqcRmthyAc+WHywpU06+c3z0TmSV
	7/a9dH3VyvaU+IBBVYrQBq/AYj1/GD9rx34TmBij3Nfgpc/JgMOi6wcxes8+hdsXj7kZ4IjxCbz
	YnARNw7OM7ZwhKAhdbp6JGefWyzVoNCR0QRCCR/c14nJ1ReVE+EGCh+2mb1hPV9Ed8p6osNJj5C
	6FqTXYRcDAcOK+9TTBTEbdYs0aRXEqZ523u6L17aoByFM1RyT/Rc1EIg4op8RkI5n3RAsdspCh7
	jgpg5o12xkadUA8J
X-Received: by 2002:a05:6214:21cb:b0:6e6:5b8e:7604 with SMTP id 6a1803df08f44-6fb46dd8a7bmr172783926d6.12.1750094845972;
        Mon, 16 Jun 2025 10:27:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+VT874VaDjh9XjdWEtRP/Wjh2i/oUst+fM3UXJE4MF1bffqfULCVs+zkhlO/eICr0H8d4GA==
X-Received: by 2002:a05:6214:21cb:b0:6e6:5b8e:7604 with SMTP id 6a1803df08f44-6fb46dd8a7bmr172783546d6.12.1750094845593;
        Mon, 16 Jun 2025 10:27:25 -0700 (PDT)
Received: from m8.users.ipa.redhat.com ([2603:7000:9400:fe80::baf])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c6c54fsm53397876d6.98.2025.06.16.10.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:27:25 -0700 (PDT)
Message-ID: <3d650cc9ff07462e5c55cc3d9c0da72a3f2c5df2.camel@redhat.com>
Subject: Re: Module signing and post-quantum crypto public key algorithms
From: Simo Sorce <simo@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Ignat Korchagin
	 <ignat@cloudflare.com>, David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Stephan Mueller
	 <smueller@chronox.de>, torvalds@linux-foundation.org, Paul Moore
	 <paul@paul-moore.com>, Lukas Wunner <lukas@wunner.de>, Clemens Lang
	 <cllang@redhat.com>, David Bohannon <dbohanno@redhat.com>, Roberto Sassu
	 <roberto.sassu@huawei.com>, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 16 Jun 2025 13:27:24 -0400
In-Reply-To: <69775877d04b8ee9f072adfd2c595187997e59fb.camel@HansenPartnership.com>
References: <501216.1749826470@warthog.procyon.org.uk>
		 <CALrw=nGkM9V12y7dB8y84UHKnroregUwiLBrtn5Xyf3k4pREsg@mail.gmail.com>
		 <de070353cc7ef2cd6ad68f899f3244917030c39b.camel@redhat.com>
		 <3081793dc1d846dccef07984520fc544f709ca84.camel@HansenPartnership.com>
		 <7ad6d5f61d6cd602241966476252599800c6a304.camel@redhat.com>
	 <69775877d04b8ee9f072adfd2c595187997e59fb.camel@HansenPartnership.com>
Organization: Red Hat
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ed-Gj6zR2TRz9Xf52Q39g2avxXeqTOoIkstNmLRMNKo_1750094846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-06-16 at 11:14 -0400, James Bottomley wrote:
> The main worry everyone has is that while it is believed that there's
> not a quantum short cut over classical for lattice algorithms, they
> haven't been studied long enough to believe there's no classical short
> cut to breaking the encryption.  The only real algorithms we're sure
> about are the hash based ones, so perhaps we should start with XMSS/LMS
> before leaping to ML-.  Particularly for kernel uses like modules, the
> finite signatures problem shouldn't be that limiting.

The only case where you can use LMS/XMSS in software is if you perform
exclusively verification, or if you perform a small number of
signatures and then immediately destroy the private key.

LMS/and XMSS absolutely cannot be used as software algorithms to
generate signatures while keeping a key around because ensuring the
status is never reused is fundamentally impossible in software. And a
single reuse in LMS/XMSS means complete breakdown of the crypto-system.

Due to the above in general implementing LMS/XMSS signature generation
in software is a *very bad idea*(TM) because people do not understand
how it can be used safely, and I would seriously discourage it.

The next option in this line of thought is SLH-DSA (which I would favor
if not for the following).

The problems with SLH-DSA are that it has rather large signatures and
is the slowest of all the algorithms and that CNSA 2.0 does not list
SLH-DSA as approved :-(

> > > Current estimates say Shor's algorithm in "reasonable[1]" time
> > > requires around a million qubits to break RSA2048, so we're still
> > > several orders of magnitude off that.
> >=20
> > Note that you are citing sources that identify needed physical qbits
> > for error correction, but what IBM publishes is a roadmap for *error
> > corrected* logical qbits. If they can pull that off that computer
> > will already be way too uncomfortably close (you need 2n+3 error
> > corrected logical qbits to break RSA).
>=20
> The roadmap is based on a linear presumption of physical to logical
> qbit scaling.  Since quantum error effects are usually exponential in
> nature that seems optimistic ... but, hey, we should know in a couple
> of years.

To be honest it does not really matter, either we'll have a workable
quantum computer or not, if we do we do, and the scaling will be rapid
enough that the difference in required bits won't really matter. I find
it very unlikely that we'll find ourselves in a situation where we'll
have a QC that can efficiently performer the Grover's algorithm with
enough bits, and yet implementing Shor's one is too hard and will take
a decade or more to reach.

> >  so it is not really a concern, even with the smallest key sizes the
> > search space is still 2^64 ... so it makes little sense to spend a
> > lot of engineering time to find all places where doubling key size
> > break things and then do a micro-migration to that. It is better to
> > focus the scarce resources on the long term.
>=20
> Well the CNSA 2.0 doc you cite above hedges and does a 1.5x security
> bit increase, so even following it we can't do P-256, 25519 or RSA2048
> we have to move to at least P-384 and X448 (even though it allows
> RSA3072, I don't think we should be supporting that).  So if we're
> going to have to increase key size anyway, we may as well up it to 256
> bits of security.
>=20
> So even if you believe quantum is slightly more imminent than the
> Kazakh Gerbil invasion, we should still begin with the key size
> increase.

What I believe is that we should not worry about Grover, because if we
get a workable Grover implementation that works we'll get Shor's too
which breaks clsssic algorithms entirely. Therefore we better move to
PQ algorithms and not spend time on a "small transition".

Of course we can decide to hedge *all bets* and move to a composed
signature (both a classic and a PQ one), in which case I would suggest
looking into signatures that use ML-DSA-87 + Ed448 or ML-DSA-87 + P-521
,ideally disjoint, with a kernel policy that can decide which (or both)
needs to be valid/checked so that the policy can be changed quickly via
configuration if any of the signature is broken.

This will allow for fears of Lattice not being vetted enough to be
managed as well as increasing the strength of the classic option, while
maintaining key and signature sizes manageable.

--=20
Simo Sorce
Distinguished Engineer
RHEL Crypto Team
Red Hat, Inc

