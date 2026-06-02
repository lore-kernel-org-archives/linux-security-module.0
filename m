Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060235B137
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780370766; cv=pass; b=hHdk0E4oR4ffrVYybX2p39T5OobX+NRSu8WMZPXcjQ81afEA1Qo8KAi/y+53o19/mHW0c19PF3ODegks7hKdatFyXpCWlo4E/3BOMsQ2N1VtylG1RwGMk9bFIVFvbVhp7dgXClr7eD0KuVyE/4Cm52VqTtOqVbFnMH1vh4BTBoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780370766; c=relaxed/simple;
	bh=Olae448LRXRz/0p4H3v/zJJ4AUHMR3A3/XiUmgCy0t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7HfJRTYL6O4SmZhqYvonctmkIHs7WqCqcsoBJGH9CSi82Froky0NH0q0tTH+fVnAlGuEK3lMZ89q/qEbC/ccWqwd4JYOj+XuejberTIfvj9nb6Nc4aUFP8NM/QxewaazVd42S0VZSf5O9xJv997v3wU4SQ7guHrPFbRrSkhNaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZX1c27NL; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZX1c27NL"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so801375a91.2
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jun 2026 20:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780370765; cv=none;
        d=google.com; s=arc-20240605;
        b=PoxtDkFA0hLydAYtVt3U20J3g0RPSDJUui588+v0S5JXi1qRDoFGBXj4EWIXgbJR4K
         4K+tzEtvMIZyPsIziWuKnfGXXTl6YzqQmvEt1b8J+v8QWn5YiIWewq2dCmueXPh9P4dK
         riYpt/epFQCQapGcYIHz/oYHrJFEVvbEJ0l/UVP4HKEVZIzJL6+G4njq6Wo6yJsQpG0K
         3zc6CsVOVYymaaT0/dcR4hmx4FVnFrzC+KOw/+UaGPoTB3IVGaRVFhQ8cHJtqrfT84YV
         qUZGeOm67ggyumgARkuGiRHWcRP+GQlrrBOqbBEwgtEhe8mhZYcKJqzMljR99aAxf9G8
         N4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rJZmPOPJOUIzpL+LB1fJWKE2/HEKwbS2/rXfRMCp6eU=;
        fh=ghI5SPQo11AdLtto17J+rgwg4/+tb2tOsIfacDqUlfI=;
        b=abX7RLezCFKEasf+wvMiP0pEBEW6aJj/vfWqWanSvdFDCB3M8t8z/W96UsLOBs10I3
         LEosQOEoLPKzXH+Bta6qCzxjDwsEXjKGMxQFVSw5pnI7WhvVS040ovV16C5y+MBmvELd
         TcUxo9b+NMjE2bL2zL2DTB09N1o2CLAL7lamxPwi2Y5bNnHrbHPk3QIfgWg2kOl+p7l4
         NnHgd1QvfXVa60XZfCuiL4DXpGbwPkc96ZIA6THYOcAJf9xgagKA13zQ60eajM5QrOQT
         RHwNMWN4yA3fnj9hAt8fV+red1f4W70nkOqbeKDxIWcit+r3jbnEFkHjLMAArjzIz0Do
         rSXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780370765; x=1780975565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJZmPOPJOUIzpL+LB1fJWKE2/HEKwbS2/rXfRMCp6eU=;
        b=ZX1c27NLMiU9AEnYGxYnduog1rIPBVqqttV4r+A2e41pBLvoEABZ/B4NWi/OF6v6ns
         plKGldKfSKiOpSi1OCIn9++WkfKPzTOZwrj4RvZGnNNrvDfYYEOykecDfscNzcc5tEpZ
         ulnd+Fp3vixfmBDhr5CsT8X9GujfB5h4EAI5A6fQv/j6EjbZAp9m6DMa7cjvJjh/PaHb
         Ebm3ZwWemzA4AUS5wkRq+TDDMxsZ9iE5OhQuGi3COnaBrb17gQ70i/SSB0LAYlw4XGPX
         E4FYHpcJ9UhJX+99PH9D7g6tp61+MT+P0QgFEdeLWqsBVZtvftLuVXGGC6TWNyyV+J2S
         iDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370765; x=1780975565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJZmPOPJOUIzpL+LB1fJWKE2/HEKwbS2/rXfRMCp6eU=;
        b=AB2kRn5K272IdVxDD1qx9MPSzwXTfUsYGRLfsisFY6dvJsoq2btHXTBI1ZCZAjvyKO
         bMoiBMYr3G+6LdQIUF1a3oZny3GAqU78ZuCMF9sNhkopcvnIOuhbGfwVaRsBXHEnaDzm
         CUjuT7oxK594S97dAs02ApBnsDqA1W1K74wz6wFCUuYqRiLF1QGuXhh7ZY5AEkp0tWBq
         Pern9rej+T/NW/ngLtqyl2pwvRh7SUnfK5xZC0wJFXBsU2XJQHTeduO8hILwwWvExzQh
         zfhkZyV/bg8dOyFKdBPijpuHa7tjisZZutHsJG3JhXv9drJxHSKbKajTpTWVVnxGakOz
         /A0g==
X-Forwarded-Encrypted: i=1; AFNElJ82uRpYmUCWFkiUvpYGLkkOqGu29Tq4zWRQYov+EQc/ccDV+dyWItGuYFzoHQiZ7BM4bpw+8kHQRpx5pCZ/Jjk0V5OBzj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvBQvqN3vQ5J/36EGxmZmcfcarjFMPXzdS+XEP3mgcZQOuD5OX
	j/mrgjEPkX41WiIdlUnBU2E7jgiV3x7bRU9qPDgimwXlfgIONhiendlz3N0Pn+frilPj1VsYM/p
	qQ1dlIdUsLsrnCK+A9qcYe5zoiD/ZVA7uwPb7uirH
X-Gm-Gg: Acq92OFbTYd8s9PVLLhr0YX+94vqp/DV5wpA2uMr5yiKAOTQv3pAOYlaIz03o/Hc/Q4
	0AhM2aoRn7V3GDAKW5tseLTwyg8TiWqZkSWV4uWF2L7uJ9C09yvovhkJDeMDsxcJbfPISMOdnIA
	p90YmAiPrDJyt14uwFGmk+516llYIM+Ic0bzt/SfwM/7SdmFdmbu9Zs8WbLyKH7uzzMGwq+qj0I
	RezYEnOQnn2VjZWAg7oWToE7N/g5mXeLZiyGeGcmuygq7oupC7yXd7nLNTqKDP8W/kLnTQyLDUZ
	QxHB2IVb1fKt0hSPFg==
X-Received: by 2002:a17:903:15cf:b0:2c0:c3ac:4af3 with SMTP id
 d9443c01a7336-2c0c3ac4e7cmr107290575ad.15.1780370765003; Mon, 01 Jun 2026
 20:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
 <20260528030915.2654994-2-bboscaccy@linux.microsoft.com> <CAKtyLkEy5QeWmozTr8v_CEFfJTK3WJq3CBr3h_T2=HMr9YfCFA@mail.gmail.com>
In-Reply-To: <CAKtyLkEy5QeWmozTr8v_CEFfJTK3WJq3CBr3h_T2=HMr9YfCFA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 23:25:53 -0400
X-Gm-Features: AVHnY4Luf4wKfT5m7FIOq7efIuUna2VuWCCDDMsqTG6Ml8jbgyyoAzuceKSLttc
Message-ID: <CAHC9VhSt1_XmKfO7SA_5qiUUpq5RWa98yACHSwh9KMMGQTJjbg@mail.gmail.com>
Subject: Re: [PATCH 01/11] hornet: fix TOCTOU in signed program verification
To: Fan Wu <wufan@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
	James.Bottomley@hansenpartnership.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 9:11=E2=80=AFPM Fan Wu <wufan@kernel.org> wrote:
> On Wed, May 27, 2026 at 8:09=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> >
> > The signature verification path was vulnerable to a time-of-check vs
> > time-of-use race at both the program load and program run hook sites:
> > between the moment a map's contents were hashed for signature
> > verification and the moment the program run hook re-verified them, an
> > attacker with sufficient privileges could swap or mutate the map
> > contents.
> >
> > Close the race by snapshotting the map hashes during program load,
> > attaching them to the program, and re-verifying them from the
> > security_bpf_prog hook against prog->aux->used_maps. Because used_maps
> > is the same map set the verifier and runtime resolve against, there is
> > no longer a window in which the verified set and the executed set can
> > diverge.
> >
> > Since we are no longer targeting the fd_array passed in, drop the map
> > index data entirely and check for whether or not the set of requested
> > map hashes is a subset of prog->aux->used_maps.
> >
> > Reported-by: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> > ---
> >  Documentation/admin-guide/LSM/Hornet.rst |  39 +++-----
> >  scripts/hornet/gen_sig.c                 |  17 +---
> >  security/hornet/hornet.asn1              |   1 -
> >  security/hornet/hornet_lsm.c             | 121 +++--------------------
> >  tools/testing/selftests/hornet/Makefile  |   2 +-
> >  5 files changed, 35 insertions(+), 145 deletions(-)

A reminder to please trim your replies.

> > -static int hornet_verify_hashes(struct hornet_maps *maps,
> > -                               struct hornet_parse_context *ctx,
> > -                               struct bpf_prog *prog)
> > -{
> > -       int map_fd;
> > -       u32 i;
> > -       struct bpf_map *map;
> > -       int err =3D 0;
> > -       unsigned char hash[SHA256_DIGEST_SIZE];
> > -       struct hornet_prog_security_struct *security =3D hornet_bpf_pro=
g_security(prog);
> > -
> > -       for (i =3D 0; i < ctx->hash_count; i++) {
> > -               if (ctx->skips[i])
> > -                       continue;
> > -
> > -               err =3D copy_from_bpfptr_offset(&map_fd, maps->fd_array=
,
> > -                                             ctx->indexes[i] * sizeof(=
map_fd),
> > -                                             sizeof(map_fd));
> > -               if (err !=3D 0)
> > -                       return LSM_INT_VERDICT_FAULT;
>
> It seems this verdict is no longer used.
>
> > -
> > -               CLASS(fd, f)(map_fd);
> > -               if (fd_empty(f))
> > -                       return LSM_INT_VERDICT_FAULT;
> > -               if (unlikely(fd_file(f)->f_op !=3D &bpf_map_fops))
> > -                       return LSM_INT_VERDICT_FAULT;
> > -
> > -               map =3D fd_file(f)->private_data;
> > -               if (!READ_ONCE(map->frozen))
> > -                       return LSM_INT_VERDICT_FAULT;
> > -
> > -               if (!map->ops->map_get_hash)
> > -                       return LSM_INT_VERDICT_FAULT;
> > -
> > -               if (map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, has=
h))
> > -                       return LSM_INT_VERDICT_FAULT;
> > -
> > -               err =3D memcmp(hash, &ctx->hashes[i * SHA256_DIGEST_SIZ=
E],
> > -                             SHA256_DIGEST_SIZE);
> > -               if (err)
> > -                       return LSM_INT_VERDICT_UNEXPECTED;
>
> similar above, they should be removed for the header and for the ipe poli=
cy.

I would prefer to see LSM_INT_VERDICT_FAULT preserved as I think it is
good to have a verdict indicating a general error in the integrity
verification code, but I do agree with Fan that removing
VERDICT_UNEXPECTED is probably a good thing to do.

If Fan is insistent on removal of VERDICT_FAULT from the IPE code
that's fine, just leave it in the LSM header.

Can you get a patch out for this ASAP Blaise?

--=20
paul-moore.com
