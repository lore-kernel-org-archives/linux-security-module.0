Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D0F480DC6
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183804; cv=none; b=FrTADvD9R0mRsXjmFdhSKApTpSoKgJCq2iu+U0CsiptmJ1WMGM3zo/WbUcd0sirS5mVeNTKn9p5fx0MCOCJKQ5O901JszPRvjaHWGQcgVRHNYUh3XDz8DKBW49it+4d0gokIuZEl8TzE5VDgL8kZewGSwrQU8ezXE6NCjdTZTPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183804; c=relaxed/simple;
	bh=vupX0NJyQoj+YpsPS+mWEYXWTs2EEV9LxivCpOIjPNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5V5lNtRPzYmVzu04VgVjGmjy7fXUZL1Ktzk6yegZlVLfqwmu6fkWsannazKpIH5pPS/2evS/mJ0SkPGfq1kFqdoTW6jj8UlylswlYWHP32TGE5JokUegy1TeiKNI9lBo1/IOyyOXSwugESKdMeqQCGoz+V9AagXl/+G/B9T9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtLgIlST; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtLgIlST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779183801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5x571feKyCrxAyf039bp6xhn3Td73dplWB4PHAo5Mng=;
	b=TtLgIlSTk0kRO9ZPvkrLDs9bgs97tSEGLHjqELywBE1r1nxKee7tyjOPXl+NA1uniPtiD2
	4n4OEGVnU3vAUFTvOKNO/5yAU3aUkfLHlQsMYidVeWmo7s8vS+gNudIRuY14GHNXKGmwL3
	NXmtRi3LU5+Fy0wTn6VTMlQMNF1t7Pg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-aFbYWzfEPDOWxrc75fFJXA-1; Tue, 19 May 2026 05:43:20 -0400
X-MC-Unique: aFbYWzfEPDOWxrc75fFJXA-1
X-Mimecast-MFC-AGG-ID: aFbYWzfEPDOWxrc75fFJXA_1779183799
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7bd795b6288so47080627b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 02:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183799; x=1779788599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5x571feKyCrxAyf039bp6xhn3Td73dplWB4PHAo5Mng=;
        b=BoCWvrjIJdILxDCPblg24w4Fm8EkNFb7V7xs0pW+oQyQ+6Aq6NM/BXj0TuthGVhLQQ
         AApTEE6sJU+cGzBrn3sMnHJVmmSPnXVG8Ug6QSNvLwcdp9056mUVfCXgu3J1e26ROwYx
         URq53E1q6Kl1Pip/keQ/dxIN4JJFMYKXFN8SAsi8qRhchwRVWCgecXh0g/odTe3FEe1X
         yX3TOF58lGbzGPRfTsTLjoSdnsOTraxtY/zQYnsIL3jsQUX1lizIA6G291/wNkHXHbBI
         as6VX/jOS0mecYHXnD//ESMf5WQiMbNww37xEKw51zhIN9+qaHfN1ilZd9TELfKf0QMi
         0Rjw==
X-Forwarded-Encrypted: i=1; AFNElJ9ml8EdmagQDVWnmHSO2kZ/rKiBTFZAUPTMbv0ukqsydQefN9/fPeWrUvkm+lntuiP+zpOZ8uUK/0bLD/yz0kFaiXoylUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3rEMW1unYYbmTk3DOKKIUheol60GGqygN4EigfNFmf2spa7rT
	q2FhSOnzjp2WM5eLFuUr/p0dy78+cIu/1JbQdT1XJ5ALe1Ys80/ZMVE0Fgpb9gnXymVRrKAG8jV
	fsnjo4jFuDlE3ILzmQoRpePyqhVYRdnpC9W6QppdQvQiFJFc2Ru0q/K9E8Lj3lG/0vF40mI2lwL
	MHMphjY3GLkECt82PSbxEkF1z/kQQL1CwV381CJjv063Qn28/PvEpX
X-Gm-Gg: Acq92OEuDS9HIB4qk51p7n7FANhQcDvFrH4Yj0elYP6yjp4ZZgzGXTvaAGu6oaz58La
	O2h4NrurIC0lO4PZuiiQT0ScdgRXOr40KbS4SRhwH9PGlbd/goAi5COn6SwAdQt2SSpbbLArf2n
	bx6lanC+EIN2p6P5yaxpb6/X/qhw1n/nnuaMZiuOhYi0Sjet+gUsR3hA7XGjdSUOJHH9YG5pYcq
	ktyPw==
X-Received: by 2002:a05:690c:6e81:b0:7bd:a63d:fe69 with SMTP id 00721157ae682-7c7e6586abemr212584657b3.9.1779183799586;
        Tue, 19 May 2026 02:43:19 -0700 (PDT)
X-Received: by 2002:a05:690c:6e81:b0:7bd:a63d:fe69 with SMTP id
 00721157ae682-7c7e6586abemr212584217b3.9.1779183799106; Tue, 19 May 2026
 02:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
 <CADSE00LjJcL8P5M-UPEpzZijU70uEmUirnin29N8YR5W5D-oFg@mail.gmail.com> <CAGsJ_4xwJ7SAhKPJyRtMTw6psTO7H1EcFFpDw0po1W8PX4FE8g@mail.gmail.com>
In-Reply-To: <CAGsJ_4xwJ7SAhKPJyRtMTw6psTO7H1EcFFpDw0po1W8PX4FE8g@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 19 May 2026 11:43:06 +0200
X-Gm-Features: AVHnY4K6WRueJTIRx5g-aAlFuFoKaIp0iRf0U18smAauuYj52IGoBPbNpAKamXc
Message-ID: <CADSE00L00D7yi_DevNsZ8_=VXBVD2eO5FbcM+sv1ZdwgjaiRmg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Barry Song <baohua@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, mripard@kernel.org, 
	echanude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EulNSkSWejG56FSbcx8ycTDvxXyGQJysKxCPYhzh93I_1779183799
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:43=E2=80=AFAM Barry Song <baohua@kernel.org> wro=
te:
>
> On Mon, May 18, 2026 at 8:16=E2=80=AFPM Albert Esteve <aesteve@redhat.com=
> wrote:
> >
> > On Sat, May 16, 2026 at 9:37=E2=80=AFAM Barry Song <baohua@kernel.org> =
wrote:
> > >
> > > On Tue, May 12, 2026 at 5:18=E2=80=AFPM Albert Esteve <aesteve@redhat=
.com> wrote:
> > > >
> > > > On embedded platforms a central process often allocates dma-buf
> > > > memory on behalf of client applications. Without a way to
> > > > attribute the charge to the requesting client's cgroup, the
> > > > cost lands on the allocator, making per-cgroup memory limits
> > > > ineffective for the actual consumers.
> > > >
> > > > Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> > > > a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> > > > memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> > > > inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> > > > the mem_accounting module parameter enabled, the buffer is charged
> > > > to the allocator's own cgroup.
> > > >
> > > > Additionally, commit 3c227be90659 ("dma-buf: system_heap: account f=
or
> > > > system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> > > > page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> > > > twice (once to kmem, once to MEMCG_DMABUF), thus remove it and rout=
e
> > > > all accounting through a single MEMCG_DMABUF path.
> > > >
> > > [...]
> > >
> > > > -               if (mem_accounting)
> > > > -                       flags |=3D __GFP_ACCOUNT;
> > >
> > > Hi Albert,
> > >
> > > would it be better to move this and its description to patch 1? It
> > > looks like patch 1 already introduces the double accounting changes,
> > > and patch 2 is mainly just supporting remote charging.
> >
> > Hi Barry,
> >
> > Thanks for looking into this series! Yes, in my head I was trying to
> > keep patch 1, which was taken from a previous, different series, and
> > then diverge from it starting with patch 2. This would clarify the
> > difference between the two. But I can see it just added some confusion
> > (for example, patch 1 charges on dma_buf_export() and then it is moved
> > to dma_heap_buffer_alloc() in patch 2). I will reorganize it better
> > for the next version, including your suggestion.
>
> Yep, I understand the situation now. I also understand
> that you were referring to T.J.'s patch, which caused
> some back-and-forth confusion for readers when reading
> patches 1 and 2.
>
> >
> > >
> > > Also, mem_accounting is only used by system_heap.c; has this patchset
> > > also eliminated its need?
> >
> > No, mem_accounting is still handled in this patch for the general case
> > where no `charge_pid_fd` is used. See dma_heap_buffer_alloc() code:
> >
> > +       if (memcg)
> > +               css_get(&memcg->css);
> > +       else if (mem_accounting)
> > +               memcg =3D get_mem_cgroup_from_mm(current->mm);
>
> I see. What feels a bit odd to me is that mem_accounting
> could either be dropped (with unconditional charging), or
> it should cover both remote and local charge cases.

Good point. If I understand correctly, looking at patch [1] that
introduced the flag, the shared buffer caveats mentioned there are not
yet covered by this approach, so the flag should stay. I will make it
consistent and cover both remote and local charge cases.

[1] https://lore.kernel.org/all/20260116-dmabuf-heap-system-memcg-v3-1-ecc6=
b62cc446@redhat.com/

>
> I don=E2=80=99t have a strong opinion here=E2=80=94it just feels a bit
> strange, since its description is quite generic for memcg:
>
> "Enable cgroup-based memory accounting for dma-buf heap
> allocations (default=3Dfalse)."
>
> Best Regards
> Barry
>

