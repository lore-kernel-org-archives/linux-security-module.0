Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C237106A
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781297788; cv=pass; b=eyB9s7npEfonuLmYRNx61xY4icKUD76ZirLIdkv3W6Ra817aIe4aJLSvHTFWwGC0EYVRWggak8/l3MkeIBFBXQXM/LItjd66WVmBUzKbhH7T1EfbjiGyQhtg5dhL2mlQyhxF9MBaa3bcHIr4zeEXphN5QgP2f+3n+8ymGNyQBfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781297788; c=relaxed/simple;
	bh=o1Z98/nJ7jVyyyICngZF6anNq9+HcVEdZSRIzTbN7QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWz3lBG/b2JvvbPKThUL7njA6yie9qX56CKCGH6IyclQbZS1cOvb2WOaTVXxcMNHQhxAf/b/p8fKTy65rXcLV2/q6jTderePpTkI58ln6RYe7vXFtFbrjpJ4PfW3cClWBU9gJFO02AdZRZNGDW/LtXmwBYYBVW66yMUEL6xXvIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Quenqe3n; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Quenqe3n"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso1218806a91.1
        for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 13:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781297785; cv=none;
        d=google.com; s=arc-20240605;
        b=AejdvT6QhxkigqHrbfVXp4kXHrShUaVTzeWm8lBCHRxPdk5ObNxwB2xjK0msdxJfVq
         hveWmrmBPfZHkWhqp8Ab7g8OotXq1xPcp2C8+3lQA+YRrvppbJo1l4c9ZHddci1N9Cky
         kfqd4TcUs30TWdujGuJEjQP/MThvy9MSQzS5hIddOmEqAk8jzKqsEq7A58F6lnPKFNaq
         d0f8ipj9VcrFa/siX6cTgYYTC07cp6mG8ekl+hK7AhKINgQy5iEIybseY5AHJtWNwqhJ
         SCfXxyEgkGdETSjVvFVqEfQdWa1ks1ghrz9M9tMvVE/LkjmsDo/giT2gDJDofQdzp6RQ
         GffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kwWtRMuNkx5q5TeW2ZFjJWS5b24tyd1OJxYTwdo74f4=;
        fh=443548ZdYOa/lNKAthP9i+lTDfCW2BLCMRwxpD1ehFU=;
        b=LO97m2Erv3M/8EWLh7lQdMgk6iRhKhurjmbu239fwhWShXHNZGX0/AJ9Z11xXFmc3q
         1EzimW+nexceFXeE6bS9JOFSpYT3QBeXI346lxUwBK8Xnaj/NBXeSej6Dik6lKfvkir+
         Zyzc5CpWCsf80gszscb+Vth+fR5VfYpp38xHl7x10liqYFpoYHP1E+JegMBIhFR/SdZS
         Xf1aw2zNIo7Tnetj8NGkWOvy4mbWdA5Mw/9D6YPFZOobZhwW26ZfFxHazEnl0OY1pVMj
         5LqSC/t/ugVtdX3R84hH3NGh49IpVF9nGc/wGLF0pCeb6smHi6PaaU/jS/0cf6GZCBCN
         0PEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781297785; x=1781902585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwWtRMuNkx5q5TeW2ZFjJWS5b24tyd1OJxYTwdo74f4=;
        b=Quenqe3nKOIvR/4gjT63yxMHWUINrfZymwxRJAi3G66786g556xI6M17mzCnm9goYO
         bQlTFlpLpSaRGhypv7adpK5+gl2nv3UkYiJ/Oi148FfZ+YQaa2YVF4E/sExf9x0cIfFQ
         VwQwG8/I9rmfIlKhdUz/oyc7VgAEVT10G+w3wKXHaIBn01YPH8F4imWruhz1swsxu9Ng
         KCAB/MqOvinyTSt/wP2kRMwfdU657slXAIPGH/jVh9g6ZM7e4V/4g3pW5wNBKr4Mk7D1
         8VZcKsVYR32ivYerhgWM9DRJtkKf7Af0LsuwEAJiP+Up2z3ZrIfjEx27Ji2W+YBfqQ0/
         MNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781297785; x=1781902585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kwWtRMuNkx5q5TeW2ZFjJWS5b24tyd1OJxYTwdo74f4=;
        b=IJK9hcV6JvR0YOMga2qOsaO9rxdLL2kLTkUswymbZTslDHXYT+YX6zZHoq48UTmglZ
         ae7pK5Cw7fTdg7pZci7eubxCNHjcxCCUIxoj5ylvgzdx9dcfaXcc9SQIuyJMmz3QQqxt
         0gZU7AGSmoltwtdVJfwH92yelEkEBWmVM1MFFTQnFd1h9XXBEpctgAw6c747KcLnHScC
         oeg05UYtvFWGQs1d9q33Zt26n9YHghK/dSP1oHZ9d/VtKJIgWnHLfSKlbVDSRKWlpCk8
         wHlkldvPqWecdymM9RES81b9c1WkWXNDjkfK+rkOpbwSnmNjDKzMbBbP1/O8nfA2cjd6
         fgGg==
X-Forwarded-Encrypted: i=1; AFNElJ9ehVWDxASeYUkTd3BEJHtxoysHUzuKVoG2ORjdGUG+tlldCknvfsN2ixfwB76UQsiEe9/VOH45EW/Bum2MIX+BBaCPZvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztItCIxaL6MCYqGseVHwjqJ59BhNGYYFzDV2Sb952T4KK+uUp0
	ITmUIwQZv9Ud7eSkBsoRdBXD2QRBTp2XuR3dVeixAa6NMGQOM9x8r8IQ8jA72c10SuvjgTmEC9r
	jApVHNJwYvL8s1KL8dNbePnKkzoG2NUL1R+75W7Tk
X-Gm-Gg: Acq92OFBbITERK8sL5yNAdWEWrCCxXfoI2JRhl8BP9Eg2xcUmrtQ2UYlIvhX0Bo/NcV
	UMswxppR8Hsv/jUdUPUayyJbE5yul4tZCwW6Q3ufyCvNunp7KwjaIx3YXmNMsM4Uq0GA44wZZeE
	DvVcZ4znJ0ZNOjXTNlMLmwarSDu+J+os805J0bK7HjP7EmYf87lEPeYxUQBLojG+zkTtRvD78CJ
	gAXxYWbg0wUFWxCCygIMbdrZErmCoNKdPdUttrvH4EGAJsIC+qAfr1dt293iljB5GZMQFp2C4aP
	LHdPi6axLoJeWGCM5w==
X-Received: by 2002:a17:90b:5588:b0:367:d850:6a5f with SMTP id
 98e67ed59e1d1-37c2bd79bc6mr790240a91.25.1781297784696; Fri, 12 Jun 2026
 13:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610230329.727075-1-daniel@iogearbox.net> <CAHC9VhTA7tOp16wGzb1QYnkJsVz1X3oNcmT6bb_9334=B2smEw@mail.gmail.com>
 <78107b57-5f4e-42b8-b780-5aebf7362de2@iogearbox.net>
In-Reply-To: <78107b57-5f4e-42b8-b780-5aebf7362de2@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 12 Jun 2026 16:56:13 -0400
X-Gm-Features: AVVi8CdDtTUe3VufUawx7sJnkop42oj_PCA47xW0_AHIqO4_wsh5Db2iGbZWPGc
Message-ID: <CAHC9VhQQKNvP1Who0DdUc0EsVYd_JoSneyzOHZ=Q0MP2qQndCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] Verify BPF signed loader at load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 5:33=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
> On 6/12/26 12:56 AM, Paul Moore wrote:
> > On Wed, Jun 10, 2026 at 7:03=E2=80=AFPM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >>
> >> The BPF signing scheme signs a light skeleton's loader program and let=
s
> >> the loader vouch for everything else: bpftool bakes the SHA256 of the
> >> metadata map into the loader's instructions, signs the instructions, a=
nd
> >> the loader compares the (frozen, exclusive) map against that hash from
> >> within BPF once it runs. The construction is sound as a trusted hash
> >> chain, but the kernel itself never attests the metadata, and that spli=
t
> >> has been the recurring objection from the LSM / integrity side since t=
he
> >> scheme was proposed.
> >>
> >> This proposal closes both gaps by having the kernel verify the metadat=
a
> >> at BPF_PROG_LOAD time, before the LSM admission hook and before the
> >> verifier, /without/ growing the UAPI. A signed loader binds its metada=
ta
> >> map(s) through the existing fd_array/fd_array_cnt, and exclusive maps
> >> are already bound to the loader's digest via excl_prog_hash. When a
> >> signature is present, the kernel collects the exclusive maps from the
> >> fd_array and appends their frozen contents to the instructions before
> >> PKCS#7 verification, so the signature covers ...
> >>
> >>      insns || metadata_0 || metadata_1 || [...]
> >>
> >> ... in fd_array order. The in-loader hash check is dropped from the
> >> gen_loader entirely: generated loaders carry no verification logic
> >> anymore, and signing or verifying a skeleton becomes an ordinary CMS
> >> operation over bytes that sit verbatim in the skeleton, reproducible
> >> offline. A signed program is either BPF_SIG_UNSIGNED or BPF_SIG_VERIFI=
ED
> >> with nothing in between.
> >
> > I'll be honest and say I'm a bit surprised to see this patchset,
> > especially since KP and Alexei argued so strongly against this
> > signature scheme, preferring KP's scheme where the loader verified the
> > maps.  I'd be curious to hear the reason for the change of heart if
> > you can share it.  Regardless of the motivation for this change, I
> > obviously think this is a significant improvement over KP's signature
> > scheme which shipped in Linux v6.18.
> >
> > I also think it is worth mentioning the similarities to work Blaise
> > did before the most recent Hornet version:
> >
> > https://lore.kernel.org/linux-security-module/20250929213520.1821223-1-=
bboscaccy@linux.microsoft.com/
> >
> > While Blaise's patchset added to the UAPI, that was done simply to
> > retain compatibility with KP's signature scheme; your patchset does
> > without any UAPI additions, but loses compatibility with existing
> > signed lskels.  Beyond that, the basic signature scheme between
> > Blaise's patchset and what you are proposing appears the same ...
> > which is a good thing as far as I'm concerned.
>
> For the rework, I've mainly been looking at KP's most recent series as
> well as some of the past discussions. Mainly trying to see if we can get
> away with a simpler model and without having to pull in BTF support for
> the signed loader just for the extra kfunc. Over the last couple of weeks=
,
> I've also build user space tooling on my side to experiment with some
> real world application which the signed loader would have to deal with.

Out of curiosity, have you discussed these changes with Alexei and/or
KP?  You surely know the history here, and as I mentioned above,
you're basically proposing the same signature scheme that Blaise
proposed last September and we all know how Alexei and KP reacted.  I
believe that Blaise's signature scheme, which you've adopted, is the
better option so I'm happy to see you move forward with this patchset.
However, I don't want to see you spend a lot of time on this if Alexei
and KP are going to react with the same attacks as last September.

> For sending a v2, I'll have to move this slightly deeper into verifier
> side but before the main verifier work happens in order to solve the
> exclusive map race issue, and additionally we could also utilize the
> verifier log to tell the user that the signature validation failed.
>
> I think a couple of things would still stand out imo: i) we sign over the
> raw bytes, not the derived hash anymore, so the hashing is only used in t=
he
> context to tie the map to the loader prog, but not anymore for the signat=
ure.

The important part is that the PKCS7 signature covers both the loader
and the maps and it is verified in the native kernel code without
relying on any actions in the loader.

> ii) its one single scheme and not a parallel branch, so the main loader i=
s
> built upon the updated signing scheme rather than having this as an optio=
n
> on the side; iow this replaces the in-loader check and there's a single P=
KCS#7-
> over-bytes path, not an 'if (signature_maps_size)' fork

I think if you look back at Blaise's early efforts you will see that
we've always favored a single signature scheme.  Blaise's various
patchsets only shifted to parallel/compatible mechanisms when it
became clear that Alexei had no interest in anything other than KP's
signature scheme.  We didn't want to remove KP's signature scheme
because we believed that would be a non-starter for any patchset; this
is one of the reasons why I'm so surprised to see KP's signature
scheme completely removed in your patchset.

I'm happy to see someone in BPF land come around to supporting
Blaise's signature scheme, I only wish it happened a little sooner, we
likely could have saved everyone a lot of time and stress.

> iii) given we
> expose the verification result in the BPF prog, we also don't need a new =
LSM
> hook and can just piggy back on the existing security_bpf_prog() which al=
so
> has the possibility to still reject late at this point.

If you look at Blaise's patchset from last September (the one I linked
in my previous email) you will notice he didn't add any additional
hooks either.

--=20
paul-moore.com
