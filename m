Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14C1264A9F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Jun 2025 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589015; cv=none; b=gl2TUGzAMgvn23MKYpB3bNFQMCu9Kpou/Pzr4fpE11DrnY+W+/PwxLiFUaLQXO5+5huCE4AaTAbWc0Vez4TpoPu7ElhF1XTKWvt7RR51Y1OQUdjicJOLhUCDt2QYJo9ht5y5jdpdHq4lH9ZYi8uL+CliV0q7lSq9Smw7dBnnAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589015; c=relaxed/simple;
	bh=iENdhX/n9vNKjtwXSctt0rxtIBTyCZxfHPoTZlLnMnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glEKJjkoOgGum23NwCgRK+JNOiOvinN7jQNTUfBcAqBaO3Sc6t+YTiUvMIOxE1JvlNthaGllzGZGAIq8hL2CnhAaHAD646980AoJ2hAFg0HpWR8QG44RiBSx3c/zM4UYKpXjTm5CskDwh9n9o6m7NqOAm4KkcQn6K+nIjyWuUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xzj4WWsH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xzj4WWsH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ABDC4CEF6
	for <linux-security-module@vger.kernel.org>; Tue, 10 Jun 2025 20:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749589014;
	bh=iENdhX/n9vNKjtwXSctt0rxtIBTyCZxfHPoTZlLnMnE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xzj4WWsHmTxqahXQycHAzHP8wFE/tadBlHu+gtxo/qHdjwVQJP88ewlXyQqMGVcLs
	 jNM16MJUsdihb+8Bf5QuBX2RSiA1tT/jWboPLN9FryDeq+dzOXMaXmF4/J1Ny6ECYH
	 wrAUJiP9JJpv3JpBO2LVbhEOhlbBiy+/TE1vQ/OnVvk07mfpnjWciT3qsecXcWRCJ5
	 2ZysoCeiPuH8ey8vmvGAq2RpxwpbYzcECEuLyVq+baIiVWqSGjuqa354OXuzSk5E4l
	 D+SQVAyY88SEZyOAwd6TRC4+XwbP00p6KzS/0xV457z4xpxcTBwzirGnmL99/XKLbU
	 Aabdt9k4zU5Uw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60794c43101so5958151a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Jun 2025 13:56:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXXt61R4ksEc7IN7N5XSG8rjhlpOy11ocW12FgDHVpG/DRj+JI0MbGrGTeHxA40Gakpa4n+2G+GKualJKyzKqVRAS9tL/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrX9YOn0Fy7ptkom6DSjt10PXZbcOzxnbpp7n+wCWbwXSCsoG2
	csXUcBiI4uYp2eVWPelz4ByZG1Kgn1KhgD8mR9c4Jc1YiYVnivBkX+oaWgOfAVpvI6B5TInauKJ
	0vzxWsSgcnKrc31+0QJ4c3xfAXbhbO3tOUfilsciU
X-Google-Smtp-Source: AGHT+IEIfEbfvM0jDQ0GMHtfaLw4xkPFFSb7r2n3N/Un60Nn3bDuCimTf+pBkr2utSBRYq+pVzne/WiC6Gn8eUaW3Ag=
X-Received: by 2002:a05:6402:42c7:b0:607:2417:6ceb with SMTP id
 4fb4d7f45d1cf-60846d3240amr495946a12.34.1749589013128; Tue, 10 Jun 2025
 13:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-11-kpsingh@kernel.org>
 <87qzzrleuw.fsf@microsoft.com> <CACYkzJ6M7kA7Se4=AXWNVF1UyeHK3t+3Y_8Ap1L9pkUTbqys9Q@mail.gmail.com>
 <87o6uvlaxs.fsf@microsoft.com>
In-Reply-To: <87o6uvlaxs.fsf@microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 10 Jun 2025 22:56:42 +0200
X-Gmail-Original-Message-ID: <CACYkzJ69eo_mNrTDLNH3wqL1ukW-onfA577EipjuPBG6U8jdBQ@mail.gmail.com>
X-Gm-Features: AX0GCFsyYTiUhCmh697oTAVUFev_onbi8OqFN_k6sIDoOMotXq-VgisXuAUSrxM
Message-ID: <CACYkzJ69eo_mNrTDLNH3wqL1ukW-onfA577EipjuPBG6U8jdBQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] libbpf: Embed and verify the metadata hash in the loader
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, kys@microsoft.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 8:16=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> KP Singh <kpsingh@kernel.org> writes:
>
> [...]
>
> >>
> >> The above code gets generated per-program and exists out-of-tree in a
> >> very unreadable format in it's final form. I have general objections t=
o
> >> being forced to "trust" out-of-tree code, when it's demostrably trivia=
l
> >
> > This is not out of tree. It's very much within the kernel tree.
>
> No, it's not.
>
> Running something like
>
> bpftool gen skeleton -S -k <private_key> -i <identity_cert>
> fentry_test.bpf.o
>
> will yield a header file fentery_test.h or whatever. That header file
> contains a customized and one-off version of the templated code in this
> patch. That header file and the resultant loader it gets compiled into
> exists out-of-tree.

Please read the cover letter and the patches, the
bpf_object__gen_loader generates the loader program that you sign,
this is not in bpftool but in libbpf which is core to using BPF, but
not your only option. Here are the many options that this gives to the
various use-case the community has and these are also available to
you:

 * You can use bpftool
 * You can choose to not use bpftool and avoid this generated header
file and use libbpf i.e. bpf_object__gen_loader.
 * You can choose to not bpf_object__gen_loader and use your loader
program that has more logging around the check, calls audit (which we
can expose via BPF kfuncs).
 * You can choose to have a trusted user-space loader that can load
unsigned BPF programs.
 * You can choose to have a trusted loader that uses a derived
credential to sign the BPF program after the instruction buffer is
stable (then you don't need the loader meta program).

You can also choose to continue arguing for your specific
implementation without providing any constructive collaboration. But
that won't help anyone.

- KP

>
> >
> >> to perform this check in-kernel, without impeding any of the other
> >> stated use cases. There is no possible audit log nor LSM hook for thes=
e
> >> operations. There is no way to know that this check was ever performed=
.
> >>
> >> Further, this check ends up happeing in an entirely different syscall,
> >> the LSM layer and the end user may both see invalid programs successfu=
lly
> >> being loaded into the kernel, that may fail mysteriously later.
> >>
> >> Also, this patch seems to rely on hacking into struct internals and
> >> magic binary layouts.
> >
> > These magical binary layouts are BPF programs, as I mentioned, if you
> > don't like this you (i.e an advanced user like Microsoft) can
> > implement your own trusted loader in whatever format you like. We are
> > not forcing you.
> >
> > If you really want to do it in the kernel, you can do it out of tree
> > and maintain these patches (that's what "out of tree" actually means),
> > this is not a direction the BPF maintainers are interested in as it
> > does not meet the broader community's use-cases. We don=E2=80=99t want =
an
> > unnecessary extension to the UAPI when some BPF programs do have
> > stable instructions already (e.g. network) and some that can
> > potentially have someday.
> >
>
> Yes, you are forcing us. Saying we are only allowed to use "trusted"
> loaders, and that no one is allowed to have any in-kernel, in-tree code
> that inspects user inputs or target programs directly is very
> non-consentual on my end. This is a design mandate, being forced upon
> other people, by you, with no concrete reasons, other than vague statemen=
ts
> around UAPI design, need or necessity.
>
> -blaise
>
> > RE The struct internals will be replaced by calling BPF_OBJ_GET_INFO
> > directly from the loader program as I mentioned in the commit.=E2=80=9D
> >
> >
> > - KP
> >
> >
> >>
> >> -blaise
> >>
> >> >  void bpf_gen__record_attach_target(struct bpf_gen *gen, const char =
*attach_name,
> >> >                                  enum bpf_attach_type type)
> >> >  {
> >> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> >> > index b6ee9870523a..084372fa54f4 100644
> >> > --- a/tools/lib/bpf/libbpf.h
> >> > +++ b/tools/lib/bpf/libbpf.h
> >> > @@ -1803,9 +1803,10 @@ struct gen_loader_opts {
> >> >       const char *insns;
> >> >       __u32 data_sz;
> >> >       __u32 insns_sz;
> >> > +     bool gen_hash;
> >> >  };
> >> >
> >> > -#define gen_loader_opts__last_field insns_sz
> >> > +#define gen_loader_opts__last_field gen_hash
> >> >  LIBBPF_API int bpf_object__gen_loader(struct bpf_object *obj,
> >> >                                     struct gen_loader_opts *opts);
> >> >
> >> > --
> >> > 2.43.0
