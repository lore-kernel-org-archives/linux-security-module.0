Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09147356768
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780372907; cv=none; b=M+0Z+DnbXOVxJZTeIve5PmPl67KF3Q7jLq1z+XezsA0ImiGOxjF5E0ENZn4MxOk6j4opnlNxVMf4pEl1wYbtBQHJGCkjrG9S4w9eI/3aPVIXhlvA7TgStpKtoiyjhQNm0C/HGw38YDvAX38NOLbYI/VII7ZMsB7Csi5FZ/LzPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780372907; c=relaxed/simple;
	bh=gHusxryaWNI8rZYOJ+OP/qxOHsGLOR5VwLH2Gn4uitM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZKicWJG2wdSBlZhEzbhMbC9pnnx1xGR/ag+KIxuvciBoLs15Ifez/+3EjY8waFdqB/EsXBaaM36HfbJTMG0eDymInuYld+tRlGSaGZ4LLRb/CwiQ7E5z93i0DKSYLcnrHbKGyuU8VAf4ufB68jPgnxCw9Qk99fbZXLfj3KVIZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clTGIzEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clTGIzEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA6F1F008A0
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 04:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780372905;
	bh=gHusxryaWNI8rZYOJ+OP/qxOHsGLOR5VwLH2Gn4uitM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=clTGIzEFTy5ehVG8l0Psa/o8ZX9ztugpOK43M3tyZlHebt8LUKH5HShcNERkuHBgM
	 TORFBulkC58jPkxSBRTWBfRc27yaTV6mAlkWkr/WSq1F7hzN44RpraA0/YjNbli9nE
	 twul1KA+dGYidzVgmSylMN9C05pAj7fCB4roaw8fe7TP2Hz3VYro4d4VNL5MCz1k4H
	 V2xLUZpY8gC4rXiJNF+EXxf9b4NM72zVtZbecdC+gJtgdusjdwrd2GaC0sAgwssFdk
	 jnMbJTw0nsu57kBnFam0FuKNtnwol0WhiWxHgWCBXwnojazQtTu8zHkYM5ryShcCtE
	 AUgvq5vsU5+rA==
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137dd523634so3210226c88.1
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jun 2026 21:01:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/RF7y+bLkLchicTHISioPBSDHpepUp0fCU6TysCJ1dB/b0Sk/F6obEjkmr/U3+h1RIUYVzWh5XXhFTaKtZYBkUfiRvzpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFf+OOtTtWcpD6VYX+K55NxeY1RT8hFm3nsvSKf9EoYY67gMEk
	+jA/EOQww3CIZmdHzDlW/M35gMuCAyeEv2TzV8i95f3GRHBY5aDGiI2VsdDcwpXTU3p3DiSmM3h
	XbqrzZiEoeVaBaKDIxDU+xOTyU5J2LzA=
X-Received: by 2002:a05:7022:61b:b0:137:546:9e9d with SMTP id
 a92af1059eb24-137d402821amr5714259c88.23.1780372905239; Mon, 01 Jun 2026
 21:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
 <20260528030915.2654994-2-bboscaccy@linux.microsoft.com> <CAKtyLkEy5QeWmozTr8v_CEFfJTK3WJq3CBr3h_T2=HMr9YfCFA@mail.gmail.com>
 <CAHC9VhSt1_XmKfO7SA_5qiUUpq5RWa98yACHSwh9KMMGQTJjbg@mail.gmail.com>
In-Reply-To: <CAHC9VhSt1_XmKfO7SA_5qiUUpq5RWa98yACHSwh9KMMGQTJjbg@mail.gmail.com>
From: Fan Wu <wufan@kernel.org>
Date: Mon, 1 Jun 2026 21:01:34 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGQgy63gkC6XXK2UZeAa-sq7szV5MhOWQc1tX+dMMQgKw@mail.gmail.com>
X-Gm-Features: AVHnY4Jispc7iq1bNtcfM1iMpCJBMl00ETRVmFzhhHIH6Q7qlNBbKTj_rYy4tE0
Message-ID: <CAKtyLkGQgy63gkC6XXK2UZeAa-sq7szV5MhOWQc1tX+dMMQgKw@mail.gmail.com>
Subject: Re: [PATCH 01/11] hornet: fix TOCTOU in signed program verification
To: Paul Moore <paul@paul-moore.com>
Cc: Fan Wu <wufan@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
	James.Bottomley@hansenpartnership.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 8:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, May 29, 2026 at 9:11=E2=80=AFPM Fan Wu <wufan@kernel.org> wrote:
> > On Wed, May 27, 2026 at 8:09=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> > >
> > > The signature verification path was vulnerable to a time-of-check vs
> > > time-of-use race at both the program load and program run hook sites:
> > > between the moment a map's contents were hashed for signature
> > > verification and the moment the program run hook re-verified them, an
> > > attacker with sufficient privileges could swap or mutate the map
> > > contents.
> > >
> > > Close the race by snapshotting the map hashes during program load,
> > > attaching them to the program, and re-verifying them from the
> > > security_bpf_prog hook against prog->aux->used_maps. Because used_map=
s
> > > is the same map set the verifier and runtime resolve against, there i=
s
> > > no longer a window in which the verified set and the executed set can
> > > diverge.
> > >
> > > Since we are no longer targeting the fd_array passed in, drop the map
> > > index data entirely and check for whether or not the set of requested
> > > map hashes is a subset of prog->aux->used_maps.
> > >
> > > Reported-by: Eric Biggers <ebiggers@kernel.org>
> > > Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> > > ---
...
> > similar above, they should be removed for the header and for the ipe po=
licy.
>
> I would prefer to see LSM_INT_VERDICT_FAULT preserved as I think it is
> good to have a verdict indicating a general error in the integrity
> verification code, but I do agree with Fan that removing
> VERDICT_UNEXPECTED is probably a good thing to do.
>
> If Fan is insistent on removal of VERDICT_FAULT from the IPE code
> that's fine, just leave it in the LSM header.
>
> Can you get a patch out for this ASAP Blaise?
>
> --
> paul-moore.com

I'm good with keeping LSM_INT_VERDICT_FAULT.

-Fan
