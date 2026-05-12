Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC3735839C
	for <linux-security-module@vger.kernel.org>; Tue, 12 May 2026 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778612009; cv=pass; b=nNp+Q60vxly/yJk9oi1vq8/lJ6RbI120Zgx4jA5C47sjjy5Cs+keD1wiU5PJP5LlhlBvDzxAmQW4x63VyFogtlh+5TH/oUYWo1RV+mOgR8uu4E9n3Hdmo/xFCf2g9pc2oPEem6T5Jjm4XmZuponJ3HQ3+iX/BYAnqQKBjke6Rno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778612009; c=relaxed/simple;
	bh=i0w04GxLO4WKxw/OOYd2vO6zt2k0z7rVo2A187IebDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9OsE74ZQTrmu+dnIptHnSGRJfTj2anQBIGPJ3AVMrvlG+IlKb1bYQX0ABF7cyDjh/7dhjnUU+Cwvgx639765MBqgDJnRDTldGpMXnjmi/b0FT5wDNN4Bf8YNPMm/EO4ZiNgGjTpACclnBvlGM87wEXOkS9knvi5/f9ZtdfGghQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vq0Z5Y9I; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vq0Z5Y9I"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so2745e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 12 May 2026 11:53:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778612005; cv=none;
        d=google.com; s=arc-20240605;
        b=h27A3AZieC/ObNLyOCbh1Se4o0loCCnMfCCG/ax8w3ClrXzRs9Akb3nuei45FJo2vT
         0J6zW6R14MZ260fCndmbZssMyqdzZKjr0z8r4nCyo68MT/JpCexHfEk1K54c/Qu2V647
         3Ogqa3la1V+eOObYjRR/zdvz00CQkYIB00j0BB8VLx4mbMUV5dT/x0NFsx3hee1u3efI
         AZAMio5E1VHHTJdEv+1CItLrUbauB9Ni+ZuJrWytqYBKgne7u3ztEKzctzinkcivCBOO
         Gd2rEOSIw+5lcpUZcMGea9GCd6ixJ3pRLsrTTn60u0dPIlogSS79gxcu3buZkwLAK81z
         SIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TrEiWuJQdbxBBI+NqMaHT087xAKAEKai4Pv5jifgOpI=;
        fh=T0WzhSKt6KJ06nec/mrLkyXsfvKOpOTnhG0FmwSyIlI=;
        b=UgdW8mK1ZKSk39VYibWu1hrSvbugKZVCAPELQvxtwXulN4vxd40xanoDxVr9sIL8Yg
         js4YIQMPQa84fHg4UB9PAnqAjB1ke4ovfi0QyfPUHZ6uY22qponsAk+u0Rf8fWXISNQQ
         9UZnZxSDM7QZYxekjIMyPU9zUwHbpk9pt5Q7muiRZ3Zk6pFMR8KWg/wLgimnx6vKiXr5
         ZMZ2Ro/SqJW73sy2/hp+FNyqwH5y0qsddmwlKXsK11F3UynC2XqUM3G3bVQevDyAoJgi
         mIqZCglssn35iEfl6hi6oPq7zNrcIvBnWgurYnkn4854gSPZLUBDuRiyaKFC/KcKjwwC
         833Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778612005; x=1779216805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrEiWuJQdbxBBI+NqMaHT087xAKAEKai4Pv5jifgOpI=;
        b=Vq0Z5Y9I9Ll0yKQ3yi1f35hzP3Q3ZAG1v1VzWEsN/S/cn7df7gZHSmnaPknJZ970ko
         LbpGxZ8b1n+WVxV2I3JBW4eWnYbLmnMvIc1iSEk1nDsb14yojuO7q2pduAvSpmMl/2gP
         1sB/0IRYzpfn+ckeizX0h3P+ag6w4yxu3MJlkSUZ9mFnfzho8uMH2R6w+lb+7aChawN+
         4zYEbPC+wBd6sWtlcyd/ToHJwEcA3d1qn2aIcmA4stpqR2zJCNXWgx7wqg++Xti5kjgK
         QjFl6TmJTkpX4SguIZq/Gm+60ZUsuoBKGBkw7gHdbwQsYemxO5/o9xRWPP+Lkkm4+55T
         k/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778612005; x=1779216805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TrEiWuJQdbxBBI+NqMaHT087xAKAEKai4Pv5jifgOpI=;
        b=fBLqzvEzTVIRedS1r1oo6wK76WoY84pAvah8JQT83qGStqfMgJ/TCJhCYE7UOu1NGF
         Ze8KY/cIK6nAeuDli2AF9ljgmrRgpgHQXrMMnvnRUWlxMPNp4hsNuZVdIvC5IDbFy8wa
         Pc/TRoe5BB8/TBI7kHKNI1D+l+ex+WYck5ePHx4CCn5BXqsZdkGEg7GCdM7wIUF3sZZT
         ugVW/cMSylb+iwdvulz5zcsbE/BitguXUBNSP4A6JCz1skc7smBguo16+wOhH8d3lfrC
         5/bX88oPlLkxSkp1PIfN89kcSWJlHJRiijYOzhBxqtkXa7WstGEQgO30yneFq8RjQZW1
         X5nQ==
X-Forwarded-Encrypted: i=1; AFNElJ+8BklQnGLhTPoOQiIFHGtZvNUH6Q0RbgF+yAKdk9nItESzxdmj7hRuEJqLyXR3E7lPGM9V7u0uXgP1z0q9kh+n4YgtHvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcY/AF6We1tTzJReR7d4lzxF0gRHvJYAXWOgzJn6yOXI/fNUB
	YYnPKLRccsDZfC3LHc5gij5j1HLYc6GFjLmN4w061seNcW90v3ItNKxGSn7ZHvFA4q9245dsLz3
	K1iSzLf5pUUNNtjWykOLaKuAVqkFneREHzgFSo6Xr
X-Gm-Gg: Acq92OHTw6aw5bjYdMNPGsGWmmJlu85b7fgWezt6BBOjz5Qxt8W0bh1TM5bzyNusYfS
	rGXCXdJmQFaTl3KtXS1iwEw1YOhyi8qxhT4DJUyt96VL9kRP7vw1C68OF1CDnK/uEjWPP14MRXc
	OgBjx0di2qhohE/Z3h4BriW6X9Qt+vqaErZAJQQeApK7QgXJios/N6T+94m/s8OBqOGvMiSh6it
	TDY+TsosCllJvedCtCuCEifvxndpyMXtdsAYGRs8DMkcriU5YT5UcwOA3KVTRG1rCvSROUg0TrO
	lDEssEqmW5jZoK13ugg61XsoA3Sj+YRpy/YktclVcEse+03Ss/nh/lPhan84gVdByJHgmmPQzfB
	XyaXq
X-Received: by 2002:a05:600c:37ce:b0:45f:2940:d194 with SMTP id
 5b1f17b1804b1-48fc912731amr162315e9.2.1778612004394; Tue, 12 May 2026
 11:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com> <8ef38815-6ae9-4359-86d4-042554357639@amd.com>
In-Reply-To: <8ef38815-6ae9-4359-86d4-042554357639@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 12 May 2026 11:53:12 -0700
X-Gm-Features: AVHnY4JXtRqPsXET8uL03o5gs-ClmvUux85Yh-qyEMDfOBbZC2p2MhMEibIFp7A
Message-ID: <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mripard@kernel.org, echanude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:14=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/12/26 11:10, Albert Esteve wrote:
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
> > Usage examples:
> >
> >   1. Central allocator charging to a client at allocation time.
> >      The allocator knows the client's PID (e.g., from binder's
> >      sender_pid) and uses pidfd to attribute the charge:
> >
> >        pid_t client_pid =3D txn->sender_pid;
> >        int pidfd =3D pidfd_open(client_pid, 0);
> >
> >        struct dma_heap_allocation_data alloc =3D {
> >            .len             =3D buffer_size,
> >            .fd_flags        =3D O_RDWR | O_CLOEXEC,
> >            .charge_pid_fd   =3D pidfd,
> >        };
> >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> >        close(pidfd);
> >        /* alloc.fd is now charged to client's cgroup */
> >
> >   2. Default allocation (no pidfd, mem_accounting=3D1).
> >      When charge_pid_fd is not set and the mem_accounting module
> >      parameter is enabled, the buffer is charged to the allocator's
> >      own cgroup:
> >
> >        struct dma_heap_allocation_data alloc =3D {
> >            .len      =3D buffer_size,
> >            .fd_flags =3D O_RDWR | O_CLOEXEC,
> >        };
> >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> >        /* charged to current process's cgroup */
> >
> > Current limitations:
> >
> >  - Single-owner model: a dma-buf carries one memcg charge regardless of
> >    how many processes share it. Means only the first owner (and exporte=
r)
> >    of the shared buffer bears the charge.
> >  - Only memcg accounting supported. While this makes sense for system
> >    heap buffers, other heaps (e.g., CMA heaps) will require selectively
> >    charging also for the dmem controller.
>
> Well that doesn't looks soo bad, it at least seems to tackle the problem =
at hand for Android and some of other embedded use cases.

Yeah I think this might work. I know of 3 cases, and it trivially
solves the first two. The third requires some work on our end to
extend our userspace interfaces to include the pidfd but it seems
doable. I'm checking with our graphics folks.

1) Direct allocation from user (e.g. app -> allocation ioctl on
/dev/dma_heap/foo)
No changes required to userspace. mem_accounting=3D1 charges the app.

2) Single hop remote allocation (e.g. app -> AHardwareBuffer_allocate
-> gralloc)
gralloc has the caller's pid as described in the commit message. Open
a pidfd and pass it in the dma_heap_allocation_data.

3) Double hop remote allocation (e.g. app -> dequeueBuffer ->
SurfaceFlinger -> gralloc)
In this case gralloc knows SurfaceFlinger's pid, but not the app's. So
we need to add the app's pidfd to the SurfaceFlinger -> gralloc
interface, or transfer the memcg charge from SurfaceFlinger to the app
after the allocation.
It'd be nice to avoid the charge transfer option entirely, but if we
need it that doesn't seem so bad in this case because it's a bulk
charge for the entire dmabuf rather than per-page. So the exporter
doesn't need to get involved (we wouldn't need a new dma_buf_op) and
we wouldn't have to worry about looping and locking for each page.

> I'm just not sure if this is future prove and will work for all use cases=
, e.g. cloud gaming, native context for automotive etc...
>
> Essentially the problem boils down to two limitations:
> 1) a piece of memory can only be charged to one cgroup, the framework doe=
sn't has a concept of charging shared memory to multiple groups

Yup, memcg already has this problem with pagecache and shmem.

> 2) when memory references in the form of file descriptors are passed betw=
een applications we have no way of changing the accounting to a different c=
group
>
> The passing of the memory reference already has a well defined uAPI and i=
f we could solve those two limitations we not only solve the problem withou=
t introducing new uAPI (with potential new security risks) but also solve i=
t for all other use cases which uses file descriptors as well as. E.g. memf=
d, accel and GPU drivers etc...
>
> On the other hand it is really nice to finally see this tackled for at le=
ast DMA-buf heaps.

I have a question about this part. Albert I guess you are interested
only in accounting dmabuf-heap allocations, or do you expect to add
__GFP_ACCOUNT or mem_cgroup_charge_dmabuf calls to other
non-dmabuf-heap exporters?

> On the GPU side I have seen just another try of a driver doing some kind =
of special driver specific accounting to solve this just a few weeks ago. A=
nd to be honest such single driver island approach have the tendency to bre=
ak more often that they are working correctly.
>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  5 ++--
> >  drivers/dma-buf/dma-buf.c               | 16 ++++---------
> >  drivers/dma-buf/dma-heap.c              | 42 +++++++++++++++++++++++++=
+++++---
> >  drivers/dma-buf/heaps/system_heap.c     |  2 --
> >  include/uapi/linux/dma-heap.h           |  6 +++++
> >  5 files changed, 53 insertions(+), 18 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 8bdbc2e866430..824d269531eb1 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1636,8 +1636,9 @@ The following nested keys are defined.
> >               structures.
> >
> >         dmabuf (npn)
> > -             Amount of memory used for exported DMA buffers allocated =
by the cgroup.
> > -             Stays with the allocating cgroup regardless of how the bu=
ffer is shared.
> > +             Amount of memory used for exported DMA buffers allocated =
by or on
> > +             behalf of the cgroup. Stays with the allocating cgroup re=
gardless
> > +             of how the buffer is shared.
> >
> >         workingset_refault_anon
> >               Number of refaults of previously evicted anonymous pages.
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index ce02377f48908..23fb758b78297 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -181,8 +181,11 @@ static void dma_buf_release(struct dentry *dentry)
> >        */
> >       BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
> >
> > -     mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size=
) / PAGE_SIZE);
> > -     mem_cgroup_put(dmabuf->memcg);
> > +     if (dmabuf->memcg) {
> > +             mem_cgroup_uncharge_dmabuf(dmabuf->memcg,
> > +                                       PAGE_ALIGN(dmabuf->size) / PAGE=
_SIZE);
> > +             mem_cgroup_put(dmabuf->memcg);
> > +     }
> >
> >       dmabuf->ops->release(dmabuf);
> >
> > @@ -764,13 +767,6 @@ struct dma_buf *dma_buf_export(const struct dma_bu=
f_export_info *exp_info)
> >               dmabuf->resv =3D resv;
> >       }
> >
> > -     dmabuf->memcg =3D get_mem_cgroup_from_mm(current->mm);
> > -     if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->s=
ize) / PAGE_SIZE,
> > -                                   GFP_KERNEL)) {
> > -             ret =3D -ENOMEM;
> > -             goto err_memcg;
> > -     }
> > -
> >       file->private_data =3D dmabuf;
> >       file->f_path.dentry->d_fsdata =3D dmabuf;
> >       dmabuf->file =3D file;
> > @@ -781,8 +777,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf=
_export_info *exp_info)
> >
> >       return dmabuf;
> >
> > -err_memcg:
> > -     mem_cgroup_put(dmabuf->memcg);
> >  err_file:
> >       fput(file);
> >  err_module:
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index ac5f8685a6494..ff6e259afcdc0 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -7,13 +7,17 @@
> >   */
> >
> >  #include <linux/cdev.h>
> > +#include <linux/cgroup.h>
> >  #include <linux/device.h>
> >  #include <linux/dma-buf.h>
> >  #include <linux/dma-heap.h>
> > +#include <linux/memcontrol.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/err.h>
> >  #include <linux/export.h>
> >  #include <linux/list.h>
> >  #include <linux/nospec.h>
> > +#include <linux/pidfd.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/xarray.h>
> > @@ -55,10 +59,12 @@ MODULE_PARM_DESC(mem_accounting,
> >                "Enable cgroup-based memory accounting for dma-buf heap =
allocations (default=3Dfalse).");
> >
> >  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> > -                              u32 fd_flags,
> > -                              u64 heap_flags)
> > +                              u32 fd_flags, u64 heap_flags,
> > +                              struct mem_cgroup *charge_to)
> >  {
> >       struct dma_buf *dmabuf;
> > +     unsigned int nr_pages;
> > +     struct mem_cgroup *memcg =3D charge_to;
> >       int fd;
> >
> >       /*
> > @@ -73,6 +79,22 @@ static int dma_heap_buffer_alloc(struct dma_heap *he=
ap, size_t len,
> >       if (IS_ERR(dmabuf))
> >               return PTR_ERR(dmabuf);
> >
> > +     nr_pages =3D len / PAGE_SIZE;
> > +
> > +     if (memcg)
> > +             css_get(&memcg->css);
> > +     else if (mem_accounting)
> > +             memcg =3D get_mem_cgroup_from_mm(current->mm);
> > +
> > +     if (memcg) {
> > +             if (!mem_cgroup_charge_dmabuf(memcg, nr_pages, GFP_KERNEL=
)) {
> > +                     mem_cgroup_put(memcg);
> > +                     dma_buf_put(dmabuf);
> > +                     return -ENOMEM;
> > +             }
> > +             dmabuf->memcg =3D memcg;
> > +     }
> > +
> >       fd =3D dma_buf_fd(dmabuf, fd_flags);
> >       if (fd < 0) {
> >               dma_buf_put(dmabuf);
> > @@ -102,6 +124,9 @@ static long dma_heap_ioctl_allocate(struct file *fi=
le, void *data)
> >  {
> >       struct dma_heap_allocation_data *heap_allocation =3D data;
> >       struct dma_heap *heap =3D file->private_data;
> > +     struct mem_cgroup *memcg =3D NULL;
> > +     struct task_struct *task;
> > +     unsigned int pidfd_flags;
> >       int fd;
> >
> >       if (heap_allocation->fd)
> > @@ -113,9 +138,20 @@ static long dma_heap_ioctl_allocate(struct file *f=
ile, void *data)
> >       if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> >               return -EINVAL;
> >
> > +     if (heap_allocation->charge_pid_fd) {
> > +             task =3D pidfd_get_task(heap_allocation->charge_pid_fd, &=
pidfd_flags);
> > +             if (IS_ERR(task))
> > +                     return PTR_ERR(task);
> > +
> > +             memcg =3D get_mem_cgroup_from_mm(task->mm);
> > +             put_task_struct(task);
> > +     }
> > +
> >       fd =3D dma_heap_buffer_alloc(heap, heap_allocation->len,
> >                                  heap_allocation->fd_flags,
> > -                                heap_allocation->heap_flags);
> > +                                heap_allocation->heap_flags,
> > +                                memcg);
> > +     mem_cgroup_put(memcg);
> >       if (fd < 0)
> >               return fd;
> >
> > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heap=
s/system_heap.c
> > index 03c2b87cb1112..95d7688167b93 100644
> > --- a/drivers/dma-buf/heaps/system_heap.c
> > +++ b/drivers/dma-buf/heaps/system_heap.c
> > @@ -385,8 +385,6 @@ static struct page *alloc_largest_available(unsigne=
d long size,
> >               if (max_order < orders[i])
> >                       continue;
> >               flags =3D order_flags[i];
> > -             if (mem_accounting)
> > -                     flags |=3D __GFP_ACCOUNT;
> >               page =3D alloc_pages(flags, orders[i]);
> >               if (!page)
> >                       continue;
> > diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-hea=
p.h
> > index a4cf716a49fa6..e02b0f8cbc6a1 100644
> > --- a/include/uapi/linux/dma-heap.h
> > +++ b/include/uapi/linux/dma-heap.h
> > @@ -29,6 +29,10 @@
> >   *                   handle to the allocated dma-buf
> >   * @fd_flags:                file descriptor flags used when allocatin=
g
> >   * @heap_flags:              flags passed to heap
> > + * @charge_pid_fd:   optional pidfd of the process whose cgroup should=
 be
> > + *                   charged for this allocation; 0 means charge the c=
alling
> > + *                   process's cgroup
> > + * @__padding:               reserved, must be zero
> >   *
> >   * Provided by userspace as an argument to the ioctl
> >   */
> > @@ -37,6 +41,8 @@ struct dma_heap_allocation_data {
> >       __u32 fd;
> >       __u32 fd_flags;
> >       __u64 heap_flags;
> > +     __u32 charge_pid_fd;
> > +     __u32 __padding;
> >  };
> >
> >  #define DMA_HEAP_IOC_MAGIC           'H'
> >
>
