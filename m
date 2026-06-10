Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB8B3AB29E
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781135607; cv=pass; b=cc/3oN6wFGbAc5cas4JguOJYFFwsTqrJ9xfErZt6gtxoMq5qpMDx5xRzmhfyuj/uhgsqWAC6qy3LBktqouQH4V8F5PGTeUAAbGUPUrhQhLoehT2MkrQzP70DSUlPPmS2tfcYL0wOQmYqqf43dXnuRdOhIzAcYCRyUAY0OR0Juj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781135607; c=relaxed/simple;
	bh=GzqYRdAmyRinDIbNNPgcUhS0qYvCzRmkXn2WfVxMh+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oU5Z9QCVIxYvPRgwaFo4D4s5qMgjHqTbzh70Oq3HADKY4VgH+YMLtKlryd1dzAISAQow1jTAqvUTG8/vR8HyQyRA46Ym4kUBKfgEvWvqh6h5D3kbK0Og2E2gU7Kz3kZuBJmNbk3nDgZOdQt8fK4pfe9r9fihzJyX7dbQSBREfQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N2nMlXdN; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N2nMlXdN"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so4715962a91.2
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 16:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781135604; cv=none;
        d=google.com; s=arc-20240605;
        b=fN63Etfcbgp+MacGsZftX1u4KDPc9PcsFH6Ee8zEZZgxEnal8Zm7Z/nkn66anGWJVv
         bc3ke5B9+wjaoAwv2CCYeY8GOU0hLhIKABSzYtNBpXfQF7MzEcTYLXbGn5lXwfkhHEK7
         Ai0yEAbTztJq3zW+oTnnv8U6UuCKhQLM+PhgKPcNudElDc/gfe4pPTaRERXqNwMYGHXV
         doFB1RCMNHnD7+RPXkS8TrT/hs2qcigGOODhrFhLJK/2ySZDwH7krkC+gINQCjEmtNsM
         D9FGhUUHwhlDpVzQ1wNYDcLotQDQn21TqIYxwqlwc2kRNswD6whZ+3OqUFt0Fw2H1vii
         2CNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GzqYRdAmyRinDIbNNPgcUhS0qYvCzRmkXn2WfVxMh+Y=;
        fh=as82g7q4ZmIw7hNMfBVOZTxxkO6DEbwlv5hsqsfQo1g=;
        b=BG/UiNQzB1BsWY+P3qzQgl0gfxr9RWK9nN3gpZO96hBpBX7+oTqY4LQ80PJcocycnD
         SuNmTC0unS6H3SYrJE+SMBQdGLTzEFih69V6JA4fQHTgGAD5CaSIB8C25IOGgwr1NHYT
         Ux0mFDbp50uFR/QJktQbOpHpgmIcA4PX8NI5WTDzhg7myrVLs+AFr2w0Q4FRRpHHsqZI
         wHaECjA5/uLOb0AD4gEsaVECuAKADlcZ7OprU5NTMHrHvqMGdmyXQmEddzFiUSKqIinP
         O2hdG9hr/YFvieIsfHScgw+H5onwO7U4XLeMfLRglJvK7HCqEhuEzUS6Qdq6ndmDFZRp
         BBNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781135604; x=1781740404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzqYRdAmyRinDIbNNPgcUhS0qYvCzRmkXn2WfVxMh+Y=;
        b=N2nMlXdNNsHpZGpD1vL3fKsW/gzyHSalppG23OiDdGPJTz7MMhcB52njuEdpwl5Em1
         XGW2+2Ju9CWrgZ0JdejqFvBNYqc+xVo/B8nKVjekgE9eZAz/zFFUvrBJn36kEtHsxJ9a
         Y3bOlrCvYx2IE5L11UMMC0T0+z/AzAQriA9q3nl0qbH6kqkeTDdTHmEaZT1zTLUaYPZ8
         YrMCeZWi0V/5wWaSazcKVr1L+8s3k8YqYwoAk6Yy05WB9PmlM9xKIPLfN4wc7gi18vTV
         lWH8B+8UIOnZx1IwVCfFxEoPDZD8ACFi5c+uwX1N3CFW8RxOeuFTwy25w+A8Cxv4+IFs
         uc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781135604; x=1781740404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GzqYRdAmyRinDIbNNPgcUhS0qYvCzRmkXn2WfVxMh+Y=;
        b=fqXiD1qjGrr3W5BZi64U0Rho4R4A94vdGyU9mFU1Kb2AmpoCcG4z+4SK0/CWMjSzoS
         wmMRWZDx1qqDZ6IwVxPAFeZuYsKWLhL4f4DPaOT97xYhXlF3uMrGdC81EtPdbzz88IMJ
         fmI2xBtLLFe0ykAlAnUWfjG9rF7t2mQwtgrx/yff2tHNz89JqjWisuhit2blPOyjRthd
         DybYYt/kkpi+Fu/3NKDkJnObGxiqMAFUEs3sP+5CUPRQLXZzfqLOK4Nov3U3ZEx9Raxu
         EPjzXwqoW3bboMeYg86rWkNo3J476ETDUSysSB4Pqtc3tnXgrVnlE+oLQiPiVc2mQjtm
         sGTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9tEcPB56PAGhzkWydd0Ab70CGqFmDrrD7avAhuHGyWnrHvfN6X7JONpwO65UZyN6csWza0Zc2IAlMmmCao7cDRfq8bo4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJoRaBM8zNs6kM0BpAV2vcz9xBEGo3JXATo9CrJnQrjqhjAY6c
	aZE6fzeBW5QXDPHyuleHbzftN84j9d+SXwirHAIPnDpCOaV9D8uM/pSkuwQcT9miELKr2czB27l
	mqdaNurLj/oo3Z+J3X1AJQKYR2Z/75MJfmJRWelvz
X-Gm-Gg: Acq92OFm1G665Nr8x34gACQp2xyp8wEQzfU4vobeGxP4s6H4SHBbpRqGABapQvxEv7A
	J7q0E7npdXYHTubWaAx5WLHr8AiBEy4PQbS3R/hY2nxdGPH/w4oAuyRn0ohItSw+nRerG1/74vY
	6n5HmEBLzmjaFwhYNvhbOSWyoW8Lyqxp143HXoyfbjLfxca4UjKuJytc0dQ+1INFZDinn3ZCFd8
	Yem7yUNPfaKhB8y26YNumAi0T7oaTcTfeZ35cSRD9NnLMn7GBDl/f93Jwye8G8eAhrSyMC29UnE
	7eNvmuyfM0b6y8+O7A==
X-Received: by 2002:a17:90a:e7ce:b0:36a:3176:ad08 with SMTP id
 98e67ed59e1d1-377a88f36f7mr462729a91.25.1781135604415; Wed, 10 Jun 2026
 16:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606142558.13809-1-med08elkadiri@gmail.com>
 <202606101345.D1BDA8BBE2@keescook> <CAAMeuQSZdNiCaAMYOnQE3q-Y9325PAbwVsJmTmKSS9a=NG7wcQ@mail.gmail.com>
 <202606101510.7F6F4118@keescook>
In-Reply-To: <202606101510.7F6F4118@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jun 2026 19:53:10 -0400
X-Gm-Features: AVVi8CeOOqdcqGiFd33pM820VoFXm9ZxQxdj69FsQwoNu813yloEA_3c0GRimBA
Message-ID: <CAHC9VhTnPK8rkoCtNuvSG+nteGc_Cg4DgnyWyRnUb5h_o7ic5A@mail.gmail.com>
Subject: Re: [PATCH] cred: prevent slab cache merging for cred_jar
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Serge Hallyn <sergeh@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	linux-security-module@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 6:11=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Jun 10, 2026 at 10:07:24PM +0100, Mohammed EL Kadiri wrote:
> > Hi Kees,
> >
> > Thanks for the review!
> > Following Vlastimil and Jarkko's feedback on the key_jar patch, should
> > I send a v2 here as well with similar commit message modification:
> > removing CVE references, dropping the skbuff comparison, and framing
> > it as hardening?
>
> It wouldn't hurt, yeah. I have that kind of already in my head while I
> read these patches, but it would be better for other folks to see it
> framed more accurately.

Just as an FYI, the patch seems reasonable to me, but considering
where we are in the dev cycle I figured it best to wait until after
the upcoming merge window to do anything with it.

> > On Wed, Jun 10, 2026 at 9:45=E2=80=AFPM Kees Cook <kees@kernel.org> wro=
te:
> > >
> > > On Sat, Jun 06, 2026 at 03:25:58PM +0100, Mohammed EL Kadiri wrote:
> > > > The cred_jar slab cache holds struct cred objects, which contain
> > > > process credentials: uid, gid, euid, egid, and capability sets.
> > > > Overwriting any of these fields is sufficient for privilege escalat=
ion.
> > > >
> > > > On a default Ubuntu 6.17.0-23-generic system, cred_jar (named "cred=
"
> > > > in sysfs) has 2 aliases, meaning 2 unrelated object types share its
> > > > slab pages (object_size=3D184, objs_per_slab=3D42).
> > > >
> > > > Cross-cache heap exploitation relies on slab cache merging to achie=
ve
> > > > type confusion between unrelated kernel objects. CVE-2022-29582
> > > > demonstrates this technique: an io_uring use-after-free is leverage=
d
> > > > across cache boundaries through page-level reallocation, ultimately
> > > > achieving root. struct cred is a primary target in this class of
> > > > attacks due to the direct privilege escalation that results from
> > > > corrupting any of its identity or capability fields.
> > > >
> > > > Add SLAB_NO_MERGE to ensure cred_jar receives dedicated slab pages,
> > > > so that freed credential slots can only be reallocated as struct cr=
ed
> > > > objects. The memory overhead is minimal: one struct cred exists per
> > > > task, and with 42 objects per slab page, the cost of dedicated page=
s
> > > > is negligible. There is zero performance impact on the allocation
> > > > hot path.
> > > >
> > > > This follows the precedent set by skbuff_head_cache (net/core/skbuf=
f.c)
> > > > and key_jar (security/keys/key.c) which use SLAB_NO_MERGE for simil=
ar
> > > > isolation requirements.
> > > >
> > > > Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> > >
> > > Yes please. :)
> > >
> > > Reviewed-by: Kees Cook <kees@kernel.org>

--=20
paul-moore.com
