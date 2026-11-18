Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010139;
	b=5aEWr4hrn3kyxBDCX7P+z/ie+2ohz1lWZbPBuoNTbJLOyYNfCkweJGNEjmwiZhNW+W2p
	 2LMleDHRWsQgGpehfi65b/C0si1fkNEs4+TkHLT+ZvVpxoRTtyoJdW8FsH1Ipwmfa4hpo
	 eEXYQndi7epXm3wMIa6pz5uDk+yRs1+oAH60YZoldR12yYvDP0DAtlOiWrv9kd7QXagob
	 yVTnXRq4PmoL+mya+SBk6C2j7aVqlt+Qduq9G9PsRSIFhW/4726ew8YkQPQ99ZTMQrrvm
	 A2CHTob67u9WYcS54ulWtD/On1QwUs2sPmEX+gqOYbWt8gW46rIcNFsLXQvuScRSdtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010139;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q93IOK+81L655tUS3XT9KzQ8Uws4KOL15ej2huBrpiw=;
	b=HtDMo2oUlBvi3SSiU8k7u1vkJOHfYjg3FSVCQcN3QAiQw3YM53/780FHRc3eG0KqLDUI
	 CpGrTCrrjTapucQMNyYsFK/tlApv5+zT4EvCK+Xvbp70yEygaBz67LJIGMJ73oG9xoKTo
	 w7NGNQtevMbAR2BseatSE8WQg4jXWLYIP15w2I9dgjcfjM/+FnUTSaRFGYr0sS0teHc0m
	 n56LEOAc/rs0FRAIkgK65LapEj7vOG3oyztoLq8YnRT3f0mK7QJGTCoQDwOzniGzt2P9Z
	 JU4L4SK/MDtxO6lNezy1olGF3PQVEcDqycPg2daGYV516TPHcSfiTlR4lwSUWt4A5CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QXfsJqiv;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63BD606A330
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 13:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C63BD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QXfsJqiv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795010137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q93IOK+81L655tUS3XT9KzQ8Uws4KOL15ej2huBrpiw=;
	b=QXfsJqivqBNqfL8AggaLxuMEBU7EfXUwQ79yX9mkY0DsyoJKv14Jj/OiqP17IwmtwHUvtm
	hDttkoYGz0xiCc9jOMzkOF5g6m+QAdI/wa8hDJ5BtVIpXff4tFeOjBu8nPrel8lbwUuT3W
	PR8WTtsSxNEPBpbDUz0KfAdFrL/sUoM=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-ZFOBhtoMNDq0vY7LPN1-8g-1; Wed, 18 Nov 2026 08:55:36 -0500
X-MC-Unique: ZFOBhtoMNDq0vY7LPN1-8g-1
X-Mimecast-MFC-AGG-ID: ZFOBhtoMNDq0vY7LPN1-8g_1795010136
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67bec5d62ebso1419888d50.1
        for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010136; x=1795614936;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q93IOK+81L655tUS3XT9KzQ8Uws4KOL15ej2huBrpiw=;
        b=EAwi3I1J1PsJYgA+V0pOcyYKDjFiosTNdXH0Pn/HtGDgWKP1IN0nieJ9lZjRQeKJTb
         lV+41pu7KxZgnl70lxOc4syRKW3gBLFHwdxsAg5ets0vcrNI1v99Z48F9B3nryLekEg8
         5yEDH2USwBjukIa9SMoU9L8demqYTF7vlWNZq2KXaRd1e8RnhDR7oLVBF2REl5IlcpZ/
         ezcjpf6eRMRe0qvBU2HEHJC0rjZG4IviimXrj3D0nRizkvbRnipsSESFNKsdNEyxV8Yx
         L6+UTWnOwSAAzWgura+XhC6Mz7kEWEBxVj157gJX2rXWZHxpTRhWC1yCfYy+Dd9Cm4Vt
         /fZg==
X-Forwarded-Encrypted: i=1; AL+hErH6J4j1BBTeqXZVH0Bavn6O3BV6VeGl5l/Couhv/q0nRUCwVMW99qhmHjDwxoqgoSKQPXkf+ScKAYS8o0p62dExduqTNGU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PPQrL3ZYV6gv7ufclqJbNzumBeGZN+sZWHvkvq3uwOvA+jSv1
	zHWmIH85dUlx92u72XXVTKFEY31zjNR7QPFewe7dbXshrs2gDdfIsL+drbp9Y+5NnjG1P2c/Odq
	0N0V7x3IXwGLF4b3FR+y8FyyJyZGNDCKFJUlNslfAuB0Jkdt6cyzjiY/fM7g67Jqf6cYrbjjebs
	TeN/Ys1ys34I3SlPCN8Hb6cNGHOZI4a6fCD0N7+mfD3MD6UA94/V2a
X-Gm-Gg: AZFdTZd81fXwHBQyHXH+Obs8MNKk549fC4r3iE5UphwSHQeT3EfFSQmyHqi0k1grZDX
	i8d78dORp4H5V1+JsRZEsZhkeM0S7jT4ZhQiAFivyRvcAzpsaqqAEm3tDI0ijdFJGmaXQ2ApdXV
	kUd4llkJDiu/3prLVIWvpVrRRg0biDo1A8wnr9U7tPrbbCOMqskekD40yH
X-Received: by 2002:a05:690e:1387:b0:67b:f249:5b16 with SMTP id 956f58d0204a3-67dd3fdee8amr1338620d50.55.1795010135898;
        Wed, 18 Nov 2026 05:55:35 -0800 (PST)
X-Received: by 2002:a05:690e:1387:b0:67b:f249:5b16 with SMTP id
 956f58d0204a3-67dd3fdee8amr1338592d50.55.1795010135440; Wed, 18 Nov 2026
 05:55:35 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-v2_20230123_tjmercier_google_com-v5-4-1ce975f2a9ad@redhat.com>
 <44c0c45c0e2f47ed77bc45be47ebb3fb@paul-moore.com>
In-Reply-To: <44c0c45c0e2f47ed77bc45be47ebb3fb@paul-moore.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 18 Nov 2026 14:55:24 +0100
X-Gm-Features: Aa3M54okPSWfJ_g3ixS3iw1yy5owTDFGTKhnOXZ64bND8Gaqu8R-9XYtSNGyOOw
Message-ID: <CADSE00LVsFVOmezzLgPrPWDd+L+SSGzGvqKTiX25waxRnVPh9Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] lsm: Add memcg_charge_task LSM hook
To: Paul Moore <paul@paul-moore.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian Brauner <brauner@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>, airlied@gmail.com, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	echanude@redhat.com, mripard@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ac_XI0QPW6yAA6zJjBtT7Xl5mdehJW--vh3k4_gTgcw_1795010136
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 11:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Nov 17, 2026 Albert Esteve <aesteve@redhat.com> wrote:
> >
> > Both DMA_HEAP_IOCTL_ALLOC and the new DMA_BUF_IOCTL_XFER_CHARGE ioctl
> > accept a charge_fd field that, when set, causes the allocation to be
> > charged to an arbitrary process's cgroup rather than the caller's.
> >
> > Charging is currently limited to the caller's own memcg subtree unless
> > the caller holds CAP_SYS_RESOURCE. But the capability is all-or-nothing=
.
> > A process holding it, along with a dma-heap device node or a dma-buf
> > fd can charge unlimited memory to any other process's cgroup, potential=
ly
> > exhausting that cgroup's limit and triggering OOM kills independent of
> > the victim's own activity or privileges.
> >
> > Add security_memcg_charge_task(), called in get_obj_cgroup_from_fd()
> > when charge_fd refers to another process. The hook receives
> > the credentials of the allocating process (from) and the credentials
> > of the process whose cgroup will be charged (to), giving security
> > modules a controlled enforcement point for cross-cgroup objcg
> > attribution policy.
> >
> > When CONFIG_SECURITY is not set the hook compiles to an inline
> > returning 0, adding no overhead to the fast path.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  7 +++++++
> >  mm/memcontrol.c               | 11 +++++++++++
> >  security/security.c           | 15 +++++++++++++++
> >  4 files changed, 34 insertions(+)
>
> ...
>
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 03cd90d5e623..2e6fcbe14d43 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -60,6 +60,7 @@
> >  #include <linux/lockdep.h>
> >  #include <linux/resume_user_mode.h>
> >  #include <linux/psi.h>
> > +#include <linux/security.h>
> >  #include <linux/seq_buf.h>
> >  #include <linux/sched/isolation.h>
> >  #include <linux/kmemleak.h>
> > @@ -3198,10 +3199,12 @@ static bool mem_cgroup_may_charge(struct mem_cg=
roup *memcg)
> >  struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
> >  {
> >       struct cgroup_subsys_state *css;
> > +     const struct cred *tcred;
> >       struct obj_cgroup *objcg;
> >       struct mem_cgroup *memcg;
> >       struct task_struct *task;
> >       unsigned int pidfd_flags;
> > +     int ret;
> >
> >       if (mem_cgroup_disabled())
> >               return ERR_PTR(-EOPNOTSUPP);
> > @@ -3226,6 +3229,14 @@ struct obj_cgroup *get_obj_cgroup_from_fd(int fd=
)
> >               if (IS_ERR(task))
> >                       return ERR_CAST(task);
> >
> > +             tcred =3D get_task_cred(task);
> > +             ret =3D security_memcg_charge_task(current_cred(), tcred)=
;
>
> Do you ever envision this "from" cred being something other than
> current_cred()?

Good point. No, I do not.

> If the answer is "no", we might want to consider changing
> the LSM hook slightly to help prevent misuse in the future:
>
>   int security_current_memcg_charge_task(const struct cred *tcred);

Agreed. I'll apply the same to the cgroupfd variant for symmetry (its
"from" is also always current_cred()).

BR,
Albert.


>
> > +             put_cred(tcred);
> > +             if (ret) {
> > +                     put_task_struct(task);
> > +                     return ERR_PTR(ret);
> > +             }
> > +
> >               rcu_read_lock();
> >               css =3D task_css(task, memory_cgrp_id);
> >               put_task_struct(task);
>
> --
> paul-moore.com
>

