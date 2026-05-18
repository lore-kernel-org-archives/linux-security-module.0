Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177383FFAA5
	for <linux-security-module@vger.kernel.org>; Mon, 18 May 2026 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106617; cv=none; b=fO5z7lkMQuNyl77K/GBfR+QWdegq7nOTbC9bVb3KPV3thR5WvZQ36f3M4HRH/ChT4qHx3arRD1N4cJK8Tzv68qy6Imsekh5CTfavPCQSz4Jp3YBg+9oTQTzwvG/wQRhblUZJUYqoWuzrCSVIhSD5/6DgjUzEOaw+43rUyq1BM48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106617; c=relaxed/simple;
	bh=GxTu0NfteCWY6YUdX16wT/N4BvT3hXjpZN7hbF/PIrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgNfCuPTIyVgNlvAlpT58SYac/7qLQp3AwqWrjwm+Sj3VFAorPulZRa85tcVhTVgXqh2qNDDGAdv0nqLefwo8I+ZD3hYDSRIBypaeHAZFlhRg2a553GooBkLV0fgLlzmDBN11/9MjvzNYlT+MpXOJsg9tIrhKR1oYNQN5FgMufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhDsoxB7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhDsoxB7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779106614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTNxjctaqLUFv9CjPVEgJLujFyB864ku/zdpEqnLvsc=;
	b=WhDsoxB7L47W8xbX7MDJn5xFkPS7vFUBxSLsjTkdQHpCUvfrZ2macQHMWB5Me9Oz4xFfRy
	rU83cKpB8CWTcAbKWSg8hKQKNCQ8hlhIYhDmkzl2awUlsQhJES36YB3UMNZPoB3GfPhtaw
	3OcK3btvZLxFKGwZt6Fh6qdu7EOZEMI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-3X5xZlZSN9KIELBNPDknlQ-1; Mon, 18 May 2026 08:16:53 -0400
X-MC-Unique: 3X5xZlZSN9KIELBNPDknlQ-1
X-Mimecast-MFC-AGG-ID: 3X5xZlZSN9KIELBNPDknlQ_1779106612
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bd795b6288so25758747b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 18 May 2026 05:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106612; x=1779711412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nTNxjctaqLUFv9CjPVEgJLujFyB864ku/zdpEqnLvsc=;
        b=OplAvYJqsPPjO8j2XcOY9E1UNFDSf+DW8Y7/VCIPIDRdxITpbbcnp4CD83yWaUUhiv
         Le0Jst6rVS77wNpSXJO4+/VHS8R015PbHappFrQwa8gTRzZooVHJ1yJ5VSisW1BlpCng
         bdgiYIW/TEh3udGRbwFHsUfOO7VdfVmPac3f8ES92Tz7PsxIAPtlK11Y2s4IsOyTVwjl
         1tF5oiPGRFYxufDYrfm/w6oTYpAmcAoyRiVQ6zvw77GsmIac84EQXK+3X3ucAa20sb2O
         b2i/kTrwzSAdLMJWXbTljtdLUwnUXeyAwB94xJabpT75R4AwtMmZNJy2yuznTC7Dk0Ns
         fS0A==
X-Forwarded-Encrypted: i=1; AFNElJ8OamZ7cZdvDWtnAraPw63KRWHn+Gw+PMtIHAcm2GK+Of3gDQQzsEttuSbT7GTb63DwAmVM9v+gvJd7dZ28F/JRqQ4IXCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxhCssXGLKO2aAw+gsaEZrawnMawoCFtwXmrzoRbXZawpU2Kzo
	nfs+SjZcGWBzgiGf9p+8M6jiefdfCqIrP3+gVOcZ7EAkuG7haYwT8tM7u/YUMZ7gBwxhAjOXcKq
	d0YtHUAIfxqgCU6Iq1xZFUq5WOXhL5L5dIHzTCw+22ZljvxYkEmZ317nxVmyTp1m98EB6cCNzuY
	5G/y+tK8k//Gm4I0eTwzuK0Hiy6wVrTdiNVndJkAo9SH1SM13XxySn
X-Gm-Gg: Acq92OGuggSN7MzTLqzUF7MAXndtrVIFPY6L1FfB86tOeaU76Yc08kC+ODwZQTtZnNI
	itnp2DOVoWfIdbUpG+xBH8QAKaHVzT7uUCKHrnhNciaaBXCA8EZCkmHAvdKC0uEmSN3MZGUJZ6T
	wGLIbmvIrLAMeMv+rbOtDD75BRiFKhJOqZZgfN4ZtV/USMNqfqJjKA06v3oXy8uzLNE7jV5WOf6
	n9+Xg==
X-Received: by 2002:a05:690c:18:b0:79a:b440:5c8d with SMTP id 00721157ae682-7c94765b6ecmr126201187b3.11.1779106612365;
        Mon, 18 May 2026 05:16:52 -0700 (PDT)
X-Received: by 2002:a05:690c:18:b0:79a:b440:5c8d with SMTP id
 00721157ae682-7c94765b6ecmr126200267b3.11.1779106611396; Mon, 18 May 2026
 05:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com> <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
In-Reply-To: <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 18 May 2026 14:16:37 +0200
X-Gm-Features: AVHnY4KtxiMU87dVIS1J63myR0LimTeIXsyDKnE3-mVGrbnQ2cunkdBN5oMYBbg
Message-ID: <CADSE00LjJcL8P5M-UPEpzZijU70uEmUirnin29N8YR5W5D-oFg@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: uaaclihPtDITgsg1HjrX6qRp-LiKrCb0-YTdxzM-3kc_1779106612
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 9:37=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Tue, May 12, 2026 at 5:18=E2=80=AFPM Albert Esteve <aesteve@redhat.com=
> wrote:
> >
> > On embedded platforms a central process often allocates dma-buf
> > memory on behalf of client applications. Without a way to
> > attribute the charge to the requesting client's cgroup, the
> > cost lands on the allocator, making per-cgroup memory limits
> > ineffective for the actual consumers.
> >
> > Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> > a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> > memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> > inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> > the mem_accounting module parameter enabled, the buffer is charged
> > to the allocator's own cgroup.
> >
> > Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
> > system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> > page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> > twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
> > all accounting through a single MEMCG_DMABUF path.
> >
> [...]
>
> > -               if (mem_accounting)
> > -                       flags |=3D __GFP_ACCOUNT;
>
> Hi Albert,
>
> would it be better to move this and its description to patch 1? It
> looks like patch 1 already introduces the double accounting changes,
> and patch 2 is mainly just supporting remote charging.

Hi Barry,

Thanks for looking into this series! Yes, in my head I was trying to
keep patch 1, which was taken from a previous, different series, and
then diverge from it starting with patch 2. This would clarify the
difference between the two. But I can see it just added some confusion
(for example, patch 1 charges on dma_buf_export() and then it is moved
to dma_heap_buffer_alloc() in patch 2). I will reorganize it better
for the next version, including your suggestion.

>
> Also, mem_accounting is only used by system_heap.c; has this patchset
> also eliminated its need?

No, mem_accounting is still handled in this patch for the general case
where no `charge_pid_fd` is used. See dma_heap_buffer_alloc() code:

+       if (memcg)
+               css_get(&memcg->css);
+       else if (mem_accounting)
+               memcg =3D get_mem_cgroup_from_mm(current->mm);

>
> Thanks
> Barry
>

