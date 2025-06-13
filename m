Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B981C5F35
	for <linux-security-module@vger.kernel.org>; Fri, 13 Jun 2025 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828111; cv=none; b=aDRTGpaEfLMUU1DJxfH2t1NcQyWiHSf6cPG477TQ1fcFkv8r56KodAShLsmVcCDiYHS7Kd1inQMIRBERcuEdTEWBiW+uTxJtUkPPqX9wxIVc5cHIBKnvnSClI0KBf2ZTie58XGjLcOieDz5+EKRsd+QaHEmkZBjU7rIx46rP71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828111; c=relaxed/simple;
	bh=uVB7JqWEdw+CUmYag1IWb5TKX0/wUP6kgR0CS8szMxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0N4PMa8ngPBEfk8h0HgJ/pj22vVaf+mHrIhs8gV1Zu8y2IDOAR9Gau6ETU58UnYcEza6jJboAPAEulOzAmQQVb3h1wacS5/ocF0Mk0+bYdgfvz+Y2P4v+y0zMZ+w187/W25Oplr19xC5rACNb/9iSjzCG3dWcUOdPeh4O6+5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EE2yw+Ki; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EE2yw+Ki"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32adebb15c5so20100741fa.3
        for <linux-security-module@vger.kernel.org>; Fri, 13 Jun 2025 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1749828107; x=1750432907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfchqGq9v7IhyOen8OFPORyNqw+wkP/m7hKYa17CVlk=;
        b=EE2yw+Ki3FsZ0W3mEVa2bh0tm7mpKUvKGCtAaoqRnEYkQyoJk550NvUPDiS+7Pxjyy
         csQ7v9FoLeWCTuFy1TWrcu8Q9TvNR0pfKnnB1kkmXe2f8BOE6bH0LY1xlt2wsj8nvqZ4
         x7eZF+dSrkIBAiTMeGvYeASUjEpb+nCSV0kSL8ONO7td1YsIPVSpdP8LHnMglxw27sr3
         hIjwXvqnGEy6u3RG4z1aFv6GIdegBLcqp3LjkFAxIMg0vGNJCdP8PvSJhhY/+yMjYduE
         p10QAlm/5SvSps+juOqs/PT6vySEYQfPb+nfETE+aC4YYZCx1WSIghgP5KXaWvEOpOpK
         YL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749828107; x=1750432907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfchqGq9v7IhyOen8OFPORyNqw+wkP/m7hKYa17CVlk=;
        b=fVYuH8F6ZgY5OSHGH+I+OyWLMMd6fjZ1C/nXdGPWKVzjVSRro0Hx4tBpy4mVJJz6T0
         0WEiODYD2bN7gXHoeMff4xlADPM7L5899fLjKUMlqbXquWe/4d8D5S/pH7UoXzQ2sbHm
         PYamf1xdoqlJaaW7IOfZlLjJsMC2Z7lgw7n6xMro+4/18oz32dMwHRVVUYzb0atou6bO
         wSw8J6ZQjnEXcHZbE10AWzlRywqZTMcztirno3CI1XCVuSUZ4/tS8ksraKeogpZA7oJD
         qbEP6WhAP33CV2dSrXv6ztJRS+lJnxVnH5PoQYXfEJJj6qLlptbXI21itCE9Nstb4Meh
         JCuA==
X-Forwarded-Encrypted: i=1; AJvYcCUTU5C4QnlOBdyGZ9XK8TXL/jhjBew0DAgb5+NJOGSkt0Y4yJBWUae/k+sfIJyvKF2lB18u3d3k8cBhKgbrJuCJKR4Lx/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6H28XFEBtdKWQSXVQALHemdCJ34lbeC/gF4W1WI3cTuaCm5yj
	bO8CsDyGO2cWJoM2RReUbD+TcEzEfGxiXdTQRK/5Nh/pASGgZdvVf/9eWBKX+D85vl7QB8kT+gL
	4ymgUTN6V9+lQruMow6vqXM5zq/M8BHATK5jsOWZ4ww==
X-Gm-Gg: ASbGncu10OwYCRlwjgcc36+lH+Ug0kiVTcHC9ARG/MAdjVNh/MQOw4+1Qdc7so9EADS
	TKy2JxM3bXGPjaGKyzOhznacXj3lUqN5RQw9MJV3ZvFkB444uHVCxpz+EPAbwYqGDgbxyLsDZZa
	PWWJ803HsQh1Tprpq3VxxQRiDSYCxBBVnwlo6TFGuXZc61V9DjINkupu/ARbn7
X-Google-Smtp-Source: AGHT+IGhbT0KIAwzD8LitDpsZIDQI/jceYs7SmyyfGe8Qi870ifYMH6IWcfgYNPDngg1R6c//N8Xv0NkIVOZ9UG2OJs=
X-Received: by 2002:a05:651c:4005:b0:32b:3c33:2b2c with SMTP id
 38308e7fff4ca-32b3eb840c7mr5515541fa.40.1749828106551; Fri, 13 Jun 2025
 08:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <501216.1749826470@warthog.procyon.org.uk>
In-Reply-To: <501216.1749826470@warthog.procyon.org.uk>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Fri, 13 Jun 2025 16:21:35 +0100
X-Gm-Features: AX0GCFtTTDGSnh9mGuiJh4V_OMLcbYtlhgcof7sEKmJZK1pQvYqN2rFCLHpFf18
Message-ID: <CALrw=nGkM9V12y7dB8y84UHKnroregUwiLBrtn5Xyf3k4pREsg@mail.gmail.com>
Subject: Re: Module signing and post-quantum crypto public key algorithms
To: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Stephan Mueller <smueller@chronox.de>, 
	Simo Sorce <simo@redhat.com>, torvalds@linux-foundation.org, 
	Paul Moore <paul@paul-moore.com>, Lukas Wunner <lukas@wunner.de>, Clemens Lang <cllang@redhat.com>, 
	David Bohannon <dbohanno@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Jun 13, 2025 at 3:54=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi,
>
> So we need to do something about the impending quantum-related obsolescen=
ce of
> the RSA signatures that we use for module signing, kexec, BPF signing, IM=
A and
> a bunch of other things.

Is it that impending? At least for now it seems people are more
concerned about quantum-safe TLS, so their communications cannot be
decrypted later. But breaking signatures of open source modules
probably only makes sense when there is an actual capability to break
RSA (or ECDSA)

> From my point of view, the simplest way would be to implement key verific=
ation
> in the kernel for one (or more) of the available post-quantum algorithms =
(of
> which there are at least three), driving this with appropriate changes to=
 the
> X.509 certificate to indicate that's what we want to use.
>
> The good news is that Stephan Mueller has an implemementation that includ=
es
> kernel bits that we can use, or, at least, adapt:
>
>         https://github.com/smuellerDD/leancrypto/
>
> Note that we only need the signature verification bits.  One question, th=
ough:
> he's done it as a standalone "leancrypto" module, not integrated into cry=
pto/,
> but should it be integrated into crypto/ or is the standalone fine?
>
> The not so good news, as I understand it, though, is that the X.509 bits =
are
> not yet standardised.

Does it matter from a kernel perspective? As far as I remember we just
attach the "plain" signature to binary. Or is it about provisioning
the key through the keystore?

>
> However!  Not everyone agrees with this.  An alternative proposal would r=
ather
> get the signature verification code out of the kernel entirely.  Simo Sor=
ce's
> proposal, for example, AIUI, is to compile all the hashes we need into th=
e
> kernel at build time, possibly with a hashed hash list to be loaded later=
 to
> reduce the amount of uncompressible code in the kernel.  If signatures ar=
e
> needed at all, then this should be offloaded to a userspace program (whic=
h
> would also have to be hashed and marked unptraceable and I think unswappa=
ble)
> to do the checking.

Can indeed work for modules, but with our limited deployment of IMA in
production with many services even with the current approach we get
some complains:
  * verification takes too long for some binaries (which were not
stripped for example)
  * just hashing the binaries over and over burns some CPU and
actually burns only 1 CPU at a time (stalling it)

We need to consider cases, for example, when a python script calls
some binaries via system(3) or similar in a tight loop. Yes, with IMA
we would verify only once, but still there are cases, when software
updates happen frequently or config management "templates" the
binaries, so they change all the time.

> I don't think we can dispense with signature checking entirely, though: w=
e
> need it for third party module loading, quick single-module driver update=
s and
> all the non-module checking stuff.  If it were to be done in userspace, t=
his
> might entail an upcall for each signature we want to check - either that,=
 or
> the kernel has to run a server process that it can delegate checking to.

Agreed - we should have an in-kernel option

> It's also been suggested that PQ algorithms are really slow.  For kernel
> modules that might not matter too much as we may well not load more than =
200
> or so during boot - but there are other users that may get used more
> frequently (IMA, for example).

Yep, mentioned above.

>
> Now, there's also a possible hybrid approach, if I understand Roberto Sas=
su's
> proposal correctly, whereby it caches bundles of hashes obtained from, sa=
y,
> the hashes included in an RPM.  These bundles of hashes can be checked by
> signature generated by the package signing process.  This would reduce th=
e PQ
> overhead to checking a bundle and would also make IMA's measuring easier =
as
> the hashes can be added in the right order, rather than being dependent o=
n the
> order that the binaries are used.

This makes it somewhat similar to UEFI secure boot trusted signature
DB, where one can have either a trusted public key to verify the
signature or a direct allowlist of hashes

> David
>

Ignat
