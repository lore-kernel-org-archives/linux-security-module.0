Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044F39E194
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187334; cv=pass; b=IsLgbaON4GMUnsg/SeHeYAeekEqA3bQ7aC6AECHlGrS1uFNML2QSKXYBgiUxmEq/XkI5TahT4aW3iTQCZ5DKf7+QizSc8j8Nd7VzJLoFnUwF6dAlLMVvBAz9Yn9wY2vQKPXZErpdqMi/yD72Wxi4BDMg5m0qLWMeKDRM99oFdXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187334; c=relaxed/simple;
	bh=F0wTGQkkGlxpSFeNyjD6eaC/VlWEy1Nj2KPYSgkBaLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opIBfsnnzAmGJ2cUPMR7H26K0psyW+5GkMM1lR53Wf/fNQqH98QAeVOL+ZTz/60yUsxIcCwjfJ7toq1gFIasBgz+ERwtIr2dgVMPTtZilhwxOBW1ZPNaq74vPim693M30SAEM+FtfSHxBs+K/+H9h4s+I1AGG/bUqcHLCvGOIo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvfEHe85; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvfEHe85"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9159477c893so602282185a.0
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jun 2026 21:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782187328; cv=none;
        d=google.com; s=arc-20240605;
        b=bLn7mQTyQpnD+hBqRFLncLrSi6uzxsQk5iPVgHFaswYZBWt9VaAUEnNqZ5JiCGs1Az
         uD3vV0ETjcJvjlv8h1RQQ0WYPPu5ugdeEur4uPoYXU43hmkdt0wlagNnSLe/ealmaMTt
         lk1CpFMXO3jfCDUqNfNZUwlCTVG4GAsV5t6nr52asRehJOFtNyIV3yr3/+74tqkqwYW1
         t7eZe3GLmkiAU/G1AigUNRV9p40Zj7gghFtWd+bFI1twlGri26V07B5Yvm2ogDkW/vB5
         j42lGMow0u0erVGwECa1j+5E/kXLLd9inKrApDD71IYsyV07JIpmsZH0vKa1XyTPvdZH
         C17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        fh=5/2QtxkCChsun5qiaFAhI6qEBEteyvxEutPuMvGOKbM=;
        b=Xzp2ibVF01p6Xg9ywzV9zlk0V2FFfpB8/Q5odl1MYXZ43C+U+BnyaEQMVqFN8G1IHw
         UZpLLIuba2DUseab9CfHAK6Wq2k73hhtOJKO6B81lzBUZsuadDtDBcB7hmhMwSl6BIrO
         54+g1SE087ExVgTgRb/EycXZZ6PflWfof/CwhTH9TJzfY4wbDlp5XO8kEfl7wiTfHrrg
         hFu6SmcRFV+5ZQGaZwEmvJHEURd6J9q/zfzdLN2//a+TTx//f7Lk3/lMHAofuaDRJ2Jp
         3EgThWfzXxgpn1rsJa7SWOoCdbYYMxu+TAtE6egOKy9EsS/7AwTVTWLLyGoyUn2WFqtF
         8nNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782187328; x=1782792128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        b=kvfEHe85g9lUYBp4b+HBBNOtnEXPs2FhHtjfbueg3OXE/2zsiVDDCk5Sf2KOR1lxib
         zIoQxQiskpChFQyo21WNgATlA1ZTx/GP/aSDvLer8bGK1k/DXX2aghlwkYqQv2pFkyFz
         oked1raJu7gLr0qxR3h80MSU/LFbvjxaK41XdPy0f5iGOahOso5D6brjklO00daNIfq1
         gIxALTWLg3bznUVXFcT2ZVDOgIwpidNjrhE9Sc+zhNk1C8e6f6KiwIxKTskiB6kpTBMK
         w1nNx8ay0Yr5pDD5SIS7zDfDIGIW66P2uO5D9Xu05DDJK12HXpSTUlR+6N1r5JyQ9KZc
         sUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782187328; x=1782792128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        b=Ot4GOhZdNmdJlwuBc8BNhUAxGDyeIaFJqRWtIH6wLRFSV/CW0uc3A3j48lxSulo4BC
         /hedFcj5yLKkrv6xq2f488MpCd3xpH+dOJwV93x9+AYitpKffU8i+1BpFACaiLsiu8dK
         XBzbGS4d704Y71QxpG0Z6NZI0MDyL30iCPwm0iKyPatHd5xfOONet32HdUAguaHMEuT2
         zAwmbhp5A/ZvXOfvxXgFjC/Iwa7CLWoe6q34zcaUWhGwIIRdNz4CP2E+olo68Dk4vKbY
         o/F2hu1DZ54MDhnOh8OXMM48tqK12TmaxObMl1IzjTULw02Qu2ZJypqbDKDj5WojxrJg
         fPWw==
X-Forwarded-Encrypted: i=1; AFNElJ8IBT4z8zD1VATzL0ykoTbsjAw8yVHoPYZjNzt2j5PuTOKvApB5ycT1trPRPr1GYkowO3srx982LQo+jJHh2eQO4F9jQs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLnql32LKUxViGTfVNKe1Ly/fck2LhEMwkvtm856BrXGT2Sv8H
	Lc26i68Y3bxO9+k9jPaOGXG6nfRU/2cTmiunt5wHxq+mPCL64Od6JA6yqAVwor/VFvxuWprCCkG
	ymdxzI4iDPiES1aE03kPmSWH9iyNLPYc=
X-Gm-Gg: AfdE7clKMXEdyaux5l9TAuV1mK1l8SVfrlGEsACgeck5cTXYRjoQs/ToWuG38cbIhD7
	KrYs9ZBKvAMMDtIoqQyvU+ovCsN83iw1jIR5p7N0S02voGHxgqe6JW3BSLaXpFKWQjdOsa6Wiw3
	8UtZqpWOARE6ew2yUMVbv9fyIglUH3hssAES5q2UH8kwzJ8zwzrhe5NNIZ5H5rWZ8+o6/16nWKf
	QnW4019dDsHYrcwb4xRIx94h1NOTaBOlnclyXO72fmCMRQ4Ixy5xiXlYTIhoRUo4cvwWX6XirCK
	PQLTjweg7usSoeR552pZzGmgTSLf0eGSEHaBMQ==
X-Received: by 2002:a05:620a:4808:b0:915:e9c3:f1a0 with SMTP id
 af79cd13be357-9208f05c232mr2733502085a.12.1782187328229; Mon, 22 Jun 2026
 21:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-1-dwindsor@gmail.com> <20260618203411.73917-2-dwindsor@gmail.com>
 <DJFZGYZFMN73.1799LMXW49WZO@gmail.com> <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
 <CAADnVQJsdrL2RjxM4UE1WyWrT9KsprFP+=xLHRtFhUSccDqQcg@mail.gmail.com>
In-Reply-To: <CAADnVQJsdrL2RjxM4UE1WyWrT9KsprFP+=xLHRtFhUSccDqQcg@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 23 Jun 2026 00:01:56 -0400
X-Gm-Features: AVVi8CdBJDCEtsjZ6Cr-k5RWu5qRO4rCaGhk6aOZoAtNJHl7U-y4zrw2gKO9F3E
Message-ID: <CAEXv5_jTxeTRdWpv71=6k_VTN4ZCes30xPs746Frw96fShfe4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	linux-integrity <linux-integrity@vger.kernel.org>, selinux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 11:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> >
> > > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > > index 1a721fc4bef5..b41b02173e24 100644
> > > > --- a/kernel/bpf/trampoline.c
> > > > +++ b/kernel/bpf/trampoline.c
> > > > @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_t=
rampoline *tr,
> > > >       }
> > > >       if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> > > >               return -E2BIG;
> > > > +     if (node->link->prog->aux->attach_limit &&
> > > > +         tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_li=
mit)
> > > > +             return -E2BIG;
> > >
> > > No need. The check inside kfunc is enough.
> > >
> >
> > Paul wanted this check because it occurs at bpf prog attach time,
> > whereas the one in the kfunc is at inode creation time.
>
> Sorry, we're not adding redundant code to the verifier.

Thanks, will send v4 soon.
