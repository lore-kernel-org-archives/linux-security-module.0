Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D4327602F
	for <linux-security-module@vger.kernel.org>; Thu,  5 Jun 2025 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147814; cv=none; b=WXXMTsM6oHXuY8ypx/H3xdAsnR3pk1wewUAR/uwCHtQa537sKjBGJBrI5Sjuz4Cqdnb1yQj+LCA0dFAPm9tdNhNwyAj+sgWaRXMiAg8Z9lHMFTTAklUJvMm4jMK+MeBqbjVDfrG5lSBUDH4cSbdTlsLSwEcL14PF2NUZET1MTsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147814; c=relaxed/simple;
	bh=R9u39JEZmT18gJLnh4kUm01asal2sR177VJ3UQxdmQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4kAu2YeF6ccBOwrvnPitHUUNF5f6bDw6qING4RkVH6s3NPlPKNCQj1E2XLK343ikMzEMO4tjEOcSZldAW5XLxacmL+mU3TDXLQNb/sMIikNX3kuuUrM3OQ3H4qb6gDjOfVJrh07QptdSGQBIlaNNGHG6a791HAC0B8FZGS2EXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GmiPTg+S; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GmiPTg+S"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e819aa98e7aso809952276.2
        for <linux-security-module@vger.kernel.org>; Thu, 05 Jun 2025 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749147812; x=1749752612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vo6V4Ppsn9eFIGNfpfF7fHNiUwnu2FfDlKV+ixE/pPE=;
        b=GmiPTg+S9V/TuwngsVU3TwLZXGUCX9IP8XbwdfE98zQJZlku1hk2dWz8yApaeKxX9x
         q9acXP6Ev/qFEz71ndH082ZSWUFx42SGeML/4CluZJg4GCMpZGOQPehWOnXSa3jo/Vvp
         eS/kiX905O1jnqNajyM8CzRBX1812uLmuamDSGmgJ7rVv0OVONg0bM6fHG0/2G6mhmj5
         B08W5FTZ8VoBZg6ntlSUb7BFclAwSxydKt7BeCVEXV8ONkuxHiLGK73F9Q+iQuil0ekm
         IFDulSz6ZAcSARj87isu9b4cKvOfpZwQi8DPvBpAfz55vlatOdHdtlTsw6Biz3otyeRQ
         3Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749147812; x=1749752612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vo6V4Ppsn9eFIGNfpfF7fHNiUwnu2FfDlKV+ixE/pPE=;
        b=J3dTNvRnq3XNLvCUNvYoxQsjnV75yOhaSgbzRmo4GHS680tGvMKX+577nl/oEMbO8A
         lZ2xu/yzuE/LcNyFAXKpiLBUlkNSAidBO8cdweXZjcyZ0djUBb52vuibhIbbW+cBfW5w
         bx6HAqiGXwXWVLg8NDo4B+8+VFWB3h8P+LP+1cy1jeSqNoQWtN8H7/P9/Q4CEn9R8ACm
         jYFuxnFem3B9diBm996gWf/n+K2QBQTeHgUYJ/DRoAqeUjMInHwqOTyX4oGZth5XpmEy
         M2i4J0A5JbEQKt5s8tcZLNGY6As+EHOUqc/SZM1Rmj3kLfepMiKlZhcRiVIFrGsyn+mA
         dGtA==
X-Forwarded-Encrypted: i=1; AJvYcCUrhVh384fCNA8SUebg4CIBH/4CS0gLzvrGfn2S9A5usokDb2JGr6btU3uMi3GlWhT9MJkG2I5W2hLEVr8iIySvCVMBoRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+wO68GAcF0x9au76aASHS98Ukst4gRyx4X2QxsnoWNKoDIFEe
	e7qyHkle6FbfGI9g3hriBQhLPLlXyaaLrpzITlKSeORkSzreHdH96/tOIcKDXxp8AOr5gB0v+Lr
	F2BlaSE4IvpWwN/HBo35VfWO/XwgtDCZ1V2J0L1TC
X-Gm-Gg: ASbGnctSgxsovnFjIpjcWN0zT3Ch1F4yI0bvt1fMlNnvYQOjb6rfpTbRuYIJ1LUib8I
	B0+8cfCNSZ3skJ870KuyUgzjfujpUTtRJOvLSh9+54htbPXAXL/paQgjWCN4s0NZBm5x5O6iqP3
	ovELV0Lrd139rxiquXKIsuLLs5cTtd18ux
X-Google-Smtp-Source: AGHT+IFlZbkCKjkkUykBJ3kANNnDocnKVC3Jz2qHpf1mQeqFtAa91potV6f9YRNypDxAi3xWFBKbXGqceEKkdz1Ki5Y=
X-Received: by 2002:a05:6902:2e0d:b0:e81:9a1c:1c0d with SMTP id
 3f1490d57ef6-e81a22847e6mr978672276.7.1749147811619; Thu, 05 Jun 2025
 11:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748890962.git.ackerleytng@google.com> <c03fbe18c3ae90fb3fa7c71dc0ee164e6cc12103.1748890962.git.ackerleytng@google.com>
 <aD_8z4pd7JcFkAwX@kernel.org> <CAHC9VhQczhrVx4YEGbXbAS8FLi0jaV1RB0kb8e4rPsUOXYLqtA@mail.gmail.com>
 <aEEv-A1ot_t8ePgv@kernel.org>
In-Reply-To: <aEEv-A1ot_t8ePgv@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Jun 2025 14:23:20 -0400
X-Gm-Features: AX0GCFuxDKrPh9BVvZ5a1pei5w2LKJ7senFjfBy4ObZ7zkQcfpax-Jaemg5t1J8
Message-ID: <CAHC9VhR3dKsXYAxY+1Ujr4weO=iBHMPHsJ3-8f=wM5q_oo81wA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: Provide function that allocates a secure
 anonymous inode
To: Mike Rapoport <rppt@kernel.org>
Cc: Ackerley Tng <ackerleytng@google.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org, 
	aik@amd.com, ajones@ventanamicro.com, akpm@linux-foundation.org, 
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, bfoster@redhat.com, binbin.wu@linux.intel.com, 
	brauner@kernel.org, catalin.marinas@arm.com, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com, 
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, graf@amazon.com, haibo1.xu@intel.com, 
	hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 1:50=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> secretmem always had S_PRIVATE set because alloc_anon_inode() clears it
> anyway and this patch does not change it.

Yes, my apologies, I didn't look closely enough at the code.

> I'm just thinking that it makes sense to actually allow LSM/SELinux
> controls that S_PRIVATE bypasses for both secretmem and guest_memfd.

It's been a while since we added the anon_inode hooks so I'd have to
go dig through the old thread to understand the logic behind marking
secretmem S_PRIVATE, especially when the
anon_inode_make_secure_inode() function cleared it.  It's entirely
possible it may have just been an oversight.

--=20
paul-moore.com
