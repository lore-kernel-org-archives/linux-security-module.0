Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623257;
	b=Vk70Fp1BrNQ2Rt0NbX8EJ2ryFcKh1qUXshjRtcqWEJpnQ11ORkkSQhjpO2mP3EfOotbb
	 O63+3aA5hvdOtSfayJfFmsZx5+MsjZfzJ5QDoL1SA0VsA6i/Cv5rZ/NL310yEg3uwESZb
	 hqWyGqNIIZk/LXwib8Juue3O3wySECDWMuAa5krjDL0CzJrbL4fLWBivyj9T9xHZ9nS2F
	 fR9Mzt2nlSdHhesmsqkfyTwDdyT/h1MhlY7FvDEPCqe76r8QeptV38wgZ5y1oliJpCKau
	 9hYTpYZfdQCrJcn6BqoO1uv76HMvloU+yQPvfB3D1E4l5Z0JJVf/+dz3rzPJLdFfXJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623257;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=LdER2mkFO0wbjr2+rc/aRUmp4/Sc5QyLtaG22Ye9JSE=;
	b=YFSwT3deisNy1h5U1CO0iaz3+YHNTOj/OZHOxnnViX1z+4/nGJ0C69hvcyeRaE7Mew9S
	 lmbxk/u9ZQDuY5PrRgDnuCFTEWS4E9rnmTrG3emyn0S7PKTM774dBI5sxYfCUbflj3srF
	 qXqklcAGAMf/kUD6zd5EJ8dYNMqEZNgORMtnEx5gwnbUZenw1Re9MAu4UQS+BRWePkBdS
	 kt6qhF66V8CPkY0YlSZGpnZA8cSDkGVEoKPhnrgpAeSjaBKbjdrSNLsaZFlj5CWBtI1ir
	 ESLQv8R57qZW+2XaPAD6XvpVfjTo+Rzi3zt3aueJe04lbmAK8XWrjf60gckJtkxr8tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtOFRBsC;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05121606A31E
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 16:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05121606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtOFRBsC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795623256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdER2mkFO0wbjr2+rc/aRUmp4/Sc5QyLtaG22Ye9JSE=;
	b=UtOFRBsCKAK3E8Bsu3A8rziiu4/aqAhE/qioSN+enl9xu6asu7MYmZxBpWnwgM6JAJ10eH
	GeuaMt0x+rQF7dmkSzy8byorSs4CqhqwSkdzDKJ4NU36OhlMRXg42v6WqTsD7ri9JlJGwU
	zmrSWBx/pnkzJtxscC6RhgstvSiYf98=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-NpuH4TUKNfexlNF7_a7myg-1; Wed, 25 Nov 2026 16:14:14 +0000
X-MC-Unique: NpuH4TUKNfexlNF7_a7myg-1
X-Mimecast-MFC-AGG-ID: NpuH4TUKNfexlNF7_a7myg_1795623253
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4ad5e0ddc90so5155974fac.2
        for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 08:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795623253; x=1796228053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LdER2mkFO0wbjr2+rc/aRUmp4/Sc5QyLtaG22Ye9JSE=;
        b=i4HKeFKSIx0DFNc/qwmPg5R+SAgRhdTNLbaPK2mFnI3CTItH1MmhFXwKGYLNz2MOFg
         GaXIWAF66jSXsNOSLGfQTK/NkVKAzsLw3TWYXdvkh0uCYV1NGe3GqL1b3fnHvjKBXSD6
         ZwTdA+HhxmuRlNbM8e8EczRGjs8DMe7Zf9LjoZUYDlFV5IOHudpLIeIsa9hBGJy0/5UQ
         ea7IHQW/otHNrsJqal1hz5uRIZGNwoI247V0y+FqqKuDCwSfKXvgwf//RPMEjjHqOtMZ
         j1GajnDS3N8MvytO7fNBkaLHH2Rd3/pxfWJW7SO9qVqy06ZsFm0InV7bKPXtKoFFwHLt
         aJKg==
X-Forwarded-Encrypted: i=1; AL+hErEKgyRHO1nAMwH/Tlfm8Q40srHctsg1wLM1970JyYz1hbZgsmlwg0YM2tFdjhPF40+YLvRFMOV6pAkL0HHKAh2lcXx9pLI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IbyuZaq6uazH0kmYvusavXwZjyoYdf5REzfyVwR2lhLp9jZEO
	QUXCaR42thqchEgL0X3PMWU4OCXs4yiVKhOiggS7VBwn3AJDSvb2piDSp+OObEiDoxQgboS3XCf
	Vf1ZRqMztUGorNIKwZMAcrRGdAuzkSQDoefmbUGYP2ebKynqq9XAWRxhqT33iDXBsvcRWFp+XvL
	X19kRwc5x/1mrqY4WGAvHyNAd7wxpuds7YW9YAp+f0USacejOASu2IyvV9ZG/s
X-Gm-Gg: AZFdTZcHeDg4T6ESkgvNudDSJJTby2Q7SXGsjVLxcXlbUwfU9Id6YYScgOEPfKJ6V8Z
	8bDJbir6/hcyEdt1JGgW/1T+9YKvRX3JfuX7vYfG13KlckDcFNcuRWxivpQVAL5KllnTTFNkeCX
	2bdrHvQCBp04IoqbCbpX1oeeixX8NkokmPpPSLsihhgzX5liGpJgSkTq+R
X-Received: by 2002:a05:6808:c3cb:b0:577:2888:47b3 with SMTP id 5614622812f47-57a0ac33d63mr20058870b6e.44.1795623253419;
        Wed, 25 Nov 2026 08:14:13 -0800 (PST)
X-Received: by 2002:a05:6808:c3cb:b0:577:2888:47b3 with SMTP id
 5614622812f47-57a0ac33d63mr20058815b6e.44.1795623252854; Wed, 25 Nov 2026
 08:14:12 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
 <20261124-v2_20230123_tjmercier_google_com-v6-2-dce12fa03ad6@redhat.com> <sashiko-outbox-233444@kernel.org>
In-Reply-To: <sashiko-outbox-233444@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 25 Nov 2026 17:13:58 +0100
X-Gm-Features: Aa3M54qC4BhV46Zvi5xNNVUyWvQwOqnECHDuj67-iKiUZ4P0AUQ6JhGMrN001Kw
Message-ID: <CADSE00KEAYZ+saAoTY81VNhNyevsWFD_nSDNgsPVfvvLBsE5vQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] dma-heap: charge dma-buf memory via explicit memcg
To: sashiko-reviews@lists.linux.dev
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
	Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>, airlied@gmail.com, dri-devel@lists.freedesktop.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	echanude@redhat.com, mripard@kernel.org, media-ci@linuxtv.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nAF17xYm3UCaCn9QsPsiU8w5S1PHTLKyVkpzB-5tvC0_1795623253
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 2:05=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] mm: memcontrol: task_css() race with migration in
>   get_obj_cgroup_from_fd()
> --
>
> commit 62e5304eba9bb9d84f6229eddf1a9273649483b8
> Author: Albert Esteve <aesteve@redhat.com>
>
> dma-heap: charge dma-buf memory via explicit memcg
>
> This commit adds a charge_fd field to struct dma_heap_allocation_data so
> DMA_HEAP_IOCTL_ALLOC can resolve a target cgroupfd or pidfd via
> get_obj_cgroup_from_fd() and charge system heap allocations to that
> cgroup.
>
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e4a9af2fdaa3b..7826bc21bea9e 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> [ ... ]
> > @@ -3171,6 +3172,88 @@ struct obj_cgroup *get_obj_cgroup_from_folio(con=
st struct folio *folio)
> >       return objcg;
> >  }
> >
> [ ... ]
> > +struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
> > +{
> > +     struct cgroup_subsys_state *css;
> > +     struct obj_cgroup *objcg;
> > +     struct mem_cgroup *memcg;
> > +     struct task_struct *task;
> > +     unsigned int pidfd_flags;
> > +
> > +     if (mem_cgroup_disabled())
> > +             return ERR_PTR(-EOPNOTSUPP);
> > +
> > +     CLASS(fd_raw, f)(fd);
> > +     if (fd_empty(f))
> > +             return ERR_PTR(-EBADF);
> > +
> > +     css =3D css_tryget_online_from_dir(fd_file(f)->f_path.dentry,
> > +                                      &memory_cgrp_subsys);
> > +     if (!IS_ERR(css) && !cgroup_on_dfl(css->cgroup)) {
> > +             css_put(css);
> > +             css =3D ERR_PTR(-EBADF);
> > +     }
> > +
> > +     if (IS_ERR(css)) {
> > +             if (PTR_ERR(css) !=3D -EBADF)
> > +                     return ERR_CAST(css);
> > +
> > +             /* fd is a pidfd */
> > +             task =3D pidfd_get_task(fd, &pidfd_flags);
> > +             if (IS_ERR(task))
> > +                     return ERR_CAST(task);
> > +
> > +             rcu_read_lock();
> > +             css =3D task_css(task, memory_cgrp_id);
> > +             put_task_struct(task);
> > +             if (!css || !css_tryget_online(css)) {
> > +                     rcu_read_unlock();
> > +                     return ERR_PTR(-ENOENT);
> > +             }
> > +             rcu_read_unlock();
> > +     }
>
> [Severity: Low]
> Can the pidfd lookup in get_obj_cgroup_from_fd() spuriously fail with
> -ENOENT when the target task is concurrently migrated or has an exited
> thread-group leader?
>
> Between task_css() and css_tryget_online(), the task can be migrated to
> another cgroup and its previous cgroup offlined, causing the one-shot
> css_tryget_online() on the stale css to fail.  Also, pidfd_get_task() on
> a process pidfd returns the thread-group leader, which in a
> multi-threaded process may already have PF_EXITING set and remain
> attached to an offline css even while its obj_cgroup has been reparented
> to an online ancestor that get_obj_cgroup_from_memcg() walks up to:
>
> include/linux/cgroup.h:task_get_css() {
>         rcu_read_lock();
>         while (true) {
>                 css =3D task_css(task, subsys_id);
>                 /*
>                  * Can't use css_tryget_online() here.  A task which has
>                  * PF_EXITING set may stay associated with an offline css=
.
>                  * If such task calls this function, css_tryget_online()
>                  * will keep failing.
>                  */
>                 if (likely(css_tryget(css)))
>                         break;
>                 cpu_relax();
>         }
>         rcu_read_unlock();
>         return css;
> }

Valid. I will apply this for the next version.

>
> Using task_get_css(task, memory_cgrp_id) before put_task_struct(task)
> would avoid both failure modes.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-v2_20230=
123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com?part=3D2
>

