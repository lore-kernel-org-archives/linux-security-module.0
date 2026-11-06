Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978518;
	b=pCAxkAlzV3Bnx99Eh0XR7USHYDWVzp3XceECt3+wmNEflmSgITf3Z7+/mOwy6y9Cl7nh
	 IVlMIpnZpFNv0DON1YuTUHuNzRWMnyASWZeFn3VFyELFsei7j0x5wDr9Qv4WHxMNoNLUs
	 9mlmdX8eitk4rrWUEooZFQFcJ78AdGxL2YXWh9T0t3EH5LgeKTU9b4/2jITrm7AXQC3FC
	 NFOkNgtzMSMUUGCvgY9HZjRv/xR+ggdM4xFUIi5MHTZREbBZvZiu77spHxCY5Mjm0tE+5
	 jP/B+7fH7lG1A/zyP9qpwQpLwkGszeICm/9rPDwSwfUIKkVdTiUzuNDBP2/C54DVlKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978518;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=1rxOFc+cZPr208SIBHT4IjzKUbYQTfkbGhsqB2LqDE4=;
	b=AG1c9UOmm+QE6ck7AdWRU3KnX91c2Vda2812paGlUksgke12m6eEDc5oRlUOm5D6rLR3
	 BGd79Rf/iSeonOKxmXPUPSEIca3NZSMtVHLL1ha9lSqaTSgujXNPDI4LHYjob+soMVoNy
	 +nLGqQV7UWCmZ6PBBHOSDdfEEeLb8RoIJwWuyuT0+RfKTpBMdzbCCCpui4E25Mee4BGa4
	 nEzH2n2SgmPh9P9WfOE2dsacfJnqDmfmj5SFkRLGkjapf9e6ZcSODSqSPhkJzq9LvUuea
	 mV4vBDIr3YBP48YJWmw7b+JTlQW9jwqg9DFZEE1FxsCf7906UXhCARfZBj1VCY+Pa0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Rk3NA4/h";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D68606A335
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 15:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35D68606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rk3NA4/h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793978517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rxOFc+cZPr208SIBHT4IjzKUbYQTfkbGhsqB2LqDE4=;
	b=Rk3NA4/heY1NOD1ZtAodRhwOGY0RgmwEXwLPxqrrpIvXf7PPr+9lmtBCSDupKv856LrUvg
	3wAxjIh9KoJbY9hFCSAgpgxqW2PuULDoAqIm7OSPgD6PUnoJSNhScMTdIUYt5gM4ODP69I
	7XqJqvWv4rfP6moZMtgTord8cPu0GJs=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-hDNG3inLNpWyGywTKIt2Mw-1; Fri, 06 Nov 2026 10:21:56 -0500
X-MC-Unique: hDNG3inLNpWyGywTKIt2Mw-1
X-Mimecast-MFC-AGG-ID: hDNG3inLNpWyGywTKIt2Mw_1793978512
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-8468290b866so976241a34.1
        for <linux-security-module@vger.kernel.org>; Fri, 06 Nov 2026 07:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978512; x=1794583312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1rxOFc+cZPr208SIBHT4IjzKUbYQTfkbGhsqB2LqDE4=;
        b=pDrGn3xFieRfbsKUExs9lLxFPzaZeC1pGm7ELYkTM84VLAdfIJXM+PqHfHOaU7+36t
         9Myw+9qNhHserM++NuZeEFXY4uLPJjnexQZuMUysI8nJC99JbskloyQUG6uxh1k0+V4D
         sm9r2K5Zm2nJ6p/4UdKGnfv5eRhHQRYM2i5HpKjTD+FIHzdmxVwJexK4EiZVc94mxkQ7
         otjsyms012x6Equ8Y6xIVvSVlkA2aYTU7bqk6VfoEVWJSXq1LRf1Kb7z5CgRd/gMuIIF
         weuImoqXKbrMkOUzmqIyCOtVFNLDNaRYjAm/KeBMP8qplPkrwlJLzZUVryZ4vogM03Yj
         tPVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzi2XC3HFTSMSkXQfzwRXRq7iHIcujFhJOZFxiSCUZMc8Bo+4hWag8D1w78IDpPwX697ahU+sUsl88mYZCNKF1pisfdfso=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CPCSZwIM7pyaNyv0xLWdy3xMAHl6YphnvZS8Z+fM4Z1fVCLGG
	Opzl6PvXadExpqWsRBB8pX+D9dnd2gFGnQqB5sDErPoEUw9AdnmvW42uSz6yaqTdvLjH7i3Pe+V
	CDnQ+uH9XBYRAA5jnKQAtNI5QwswOxMNLW2OdbjBYfNMIwgwiYrmQWnPqjTtBOBGcqENrXkT7hu
	ygDkkJ4HEE2Mj+r99s6uNDfCoAiordcV8MR+LD0TmM1jxgebNUz/ic
X-Gm-Gg: AYBFou3aP3nbn3TC3LRBcuhX9PR0koOtb8ZTeReLkjHmZc/s+W8w+ESsBLQ78WvcZ4P
	JvS9FwawUTj4egqloR1fhoQEyAF1v2kRDW3zNbxEuYBue4ellBXATnAnE8U8rsX7l2XkDpyqguJ
	4ffdcI2ODoxQ0L7B+1WqS98xuINPvPMThVtHF9maQmg5v7grGpejcw5BjU
X-Received: by 2002:a05:6808:181f:b0:4d7:17d5:6c9b with SMTP id 5614622812f47-567e098b040mr2230448b6e.9.1793978512017;
        Fri, 06 Nov 2026 07:21:52 -0800 (PST)
X-Received: by 2002:a05:6808:181f:b0:4d7:17d5:6c9b with SMTP id
 5614622812f47-567e098b040mr2230427b6e.9.1793978511464; Fri, 06 Nov 2026
 07:21:51 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-3-1819a017000b@redhat.com> <fb40349c-18d2-45d6-9278-8f20e1b8dc74@amd.com>
In-Reply-To: <fb40349c-18d2-45d6-9278-8f20e1b8dc74@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 6 Nov 2026 16:21:40 +0100
X-Gm-Features: AclHuK8xPUV12Kp92h3MGmY0EG1MyX4e69V4l27RPz6qll1dAX1c6CSJcZPwZjc
Message-ID: <CADSE00+NL-tyQVaTiS0Xdin7f-P_2c84P0qs-X66VqYze0-kGQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] dma-buf: transfer memcg charges via DMA_BUF_IOCTL_XFER_CHARGE
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gsc5tvmDBTjUVn-xhyPjhpyRLJg8Q4hKykVaYJCzoFw_1793978512
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 2:52=E2=80=AFPM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 11/4/26 12:09, Albert Esteve wrote:
> > dma-heap already supports charging a specific cgroup at allocation
> > time via charge_fd in DMA_HEAP_IOCTL_ALLOC. However, dma-bufs can
> > originate from any exporter (DRM, V4L2, etc.), and the allocator may
> > not know the final owner at allocation time.
> >
> > Add DMA_BUF_IOCTL_XFER_CHARGE to transfer a dma-buf's memcg charge
> > to a different cgroup after allocation. The target is identified by
> > charge_fd, which may be a cgroupfd or a pidfd.
> >
> > The transfer charges the new cgroup before uncharging the old one,
> > preserving the original charge on failure. Concurrent transfers are
> > serialized by the dma-buf reservation lock, so lockdep covers the
> > locking order of the charge path early. The transfer implementation
> > is generic (mem_cgroup_transfer_charge) and not dma-buf specific, so
> > it can be reused by other subsystems.
> >
> > Not all dma-buf exporters back their buffers with reclaimable system
> > memory. Some represent device registers, VRAM, or carved-out pools
> > where size is not a meaningful memory cost. The xfer ioctl returns
> > -EOPNOTSUPP for buffers whose memcg is not set. Exporters opt in by
> > passing a memcg through dma_buf_export_info at export time. Currently
> > only the system heap sets it, other exporters can opt in as needed.
> >
> > Usage example:
> >   int cg_fd =3D open("/sys/fs/cgroup/clients/app1", O_RDONLY | O_DIRECT=
ORY);
> >
> >   struct dma_buf_transfer_charge xfer =3D {
> >       .charge_fd =3D cg_fd,
> >   };
> >   ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer);
> >   /* charge now on app1's cgroup */
> >   close(cg_fd);
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  drivers/dma-buf/dma-buf.c    | 42 ++++++++++++++++++++++++++++++++++++=
++++++
> >  include/linux/dma-buf.h      |  3 ++-
> >  include/linux/memcontrol.h   | 13 +++++++++++++
> >  include/uapi/linux/dma-buf.h | 26 ++++++++++++++++++++++++++
> >  mm/memcontrol.c              | 42 ++++++++++++++++++++++++++++++++++++=
++++++
> >  5 files changed, 125 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 837666273550..3bd26fbb1109 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -540,6 +540,45 @@ static long dma_buf_import_sync_file(struct dma_bu=
f *dmabuf,
> >  }
> >  #endif
> >
> > +/* Transfer a dma-buf's memcg charge; see struct dma_buf_transfer_char=
ge */
> > +static long dma_buf_xfer_charge(struct dma_buf *dmabuf,
> > +                             const void __user *user_data)
> > +{
> > +     struct dma_buf_transfer_charge arg;
> > +     struct mem_cgroup *memcg;
> > +     unsigned int nr_pages =3D PAGE_ALIGN(dmabuf->size) >> PAGE_SHIFT;
> > +     int ret =3D 0;
> > +
> > +     if (copy_from_user(&arg, user_data, sizeof(arg)))
> > +             return -EFAULT;
> > +
> > +     if (!IS_ENABLED(CONFIG_MEMCG))
> > +             return 0;
> > +
> > +     if (arg.flags !=3D 0)
> > +             return -EINVAL;
> > +
> > +     memcg =3D mem_cgroup_get_from_fd(arg.charge_fd);
> > +     if (IS_ERR(memcg))
> > +             return PTR_ERR(memcg);
> > +
> > +     dma_resv_lock(dmabuf->resv, NULL);
> > +
> > +     if (!dmabuf->memcg) {
> > +             ret =3D -EOPNOTSUPP;
> > +             goto out;
> > +     }
> > +
> > +     if (dmabuf->memcg !=3D memcg &&
> > +         !mem_cgroup_transfer_charge(&dmabuf->memcg, memcg, MEMCG_DMAB=
UF, nr_pages))
>
> Please move the calculation of nr_pages after taking the dma_resv_lock().
>
> We currently don't have anybody dynamically changing DMA-buf sizes but ju=
st to be on the save side.

Sounds like a good defensive option. I was also tempted to move it.
Will do for v5.

>
> With that done Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.co=
m>

Thanks!

BR,
Albert.

>
> Regards,
> Christian.
>
> > +             ret =3D -ENOMEM;
> > +
> > +out:
> > +     dma_resv_unlock(dmabuf->resv);
> > +     mem_cgroup_put(memcg);
> > +     return ret;
> > +}
> > +
> >  static long dma_buf_ioctl(struct file *file,
> >                         unsigned int cmd, unsigned long arg)
> >  {
> > @@ -590,6 +629,9 @@ static long dma_buf_ioctl(struct file *file,
> >               return dma_buf_import_sync_file(dmabuf, (const void __use=
r *)arg);
> >  #endif
> >
> > +     case DMA_BUF_IOCTL_XFER_CHARGE:
> > +             return dma_buf_xfer_charge(dmabuf, (const void __user *)a=
rg);
> > +
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 85dd747c9b36..b01149d26b44 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -507,7 +507,8 @@ struct dma_buf_attachment {
> >   * @priv:    Attach private data of allocator to this buffer
> >   * @memcg:   memcg to charge for this buffer's memory. Set only for
> >   *           buffers backed by system memory where @size reflects the
> > - *           actual allocation in bytes.
> > + *           actual allocation in bytes. Enables charge transfer via
> > + *           DMA_BUF_IOCTL_XFER_CHARGE.
> >   *
> >   * This structure holds the information required to export the buffer.=
 Used
> >   * with dma_buf_export() only.
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index f8ec751b7d7b..af02d9777fe9 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -676,6 +676,11 @@ struct mem_cgroup *mem_cgroup_get_from_fd(int fd);
> >  bool mem_cgroup_reserve_dmabuf(struct mem_cgroup *memcg, gfp_t gfp,
> >                              unsigned int nr_pages);
> >
> > +bool mem_cgroup_transfer_charge(struct mem_cgroup **ptr_memcg,
> > +                             struct mem_cgroup *new_memcg,
> > +                             enum memcg_stat_item item,
> > +                             unsigned int nr_pages);
> > +
> >  void __mem_cgroup_uncharge(struct folio *folio);
> >
> >  /**
> > @@ -1197,6 +1202,14 @@ static inline void mem_cgroup_cancel_dmabuf(stru=
ct mem_cgroup *memcg,
> >  {
> >  }
> >
> > +static inline bool mem_cgroup_transfer_charge(struct mem_cgroup **ptr_=
memcg,
> > +                                           struct mem_cgroup *new_memc=
g,
> > +                                           enum memcg_stat_item item,
> > +                                           unsigned int nr_pages)
> > +{
> > +     return true;
> > +}
> > +
> >  static inline void mem_cgroup_uncharge(struct folio *folio)
> >  {
> >  }
> > diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.=
h
> > index e827c9d20c5d..0aaf2e7d593b 100644
> > --- a/include/uapi/linux/dma-buf.h
> > +++ b/include/uapi/linux/dma-buf.h
> > @@ -168,6 +168,31 @@ struct dma_buf_import_sync_file {
> >       __s32 fd;
> >  };
> >
> > +/**
> > + * struct dma_buf_transfer_charge - Transfer a dma-buf's memcg charge
> > + *
> > + * Any holder of a dma-buf file descriptor can perform a
> > + * DMA_BUF_IOCTL_XFER_CHARGE to attribute the buffer's memory
> > + * cost to a specific cgroup, or move it from one cgroup to
> > + * another.  The ioctl charges the new cgroup before uncharging
> > + * the old one atomically.  On failure the original charge is
> > + * preserved.  If the buffer has no existing memcg charge, the
> > + * ioctl returns -EOPNOTSUPP.
> > + */
> > +struct dma_buf_transfer_charge {
> > +     /** @flags: Reserved, must be zero */
> > +     __u32 flags; /* unused for now */
> > +     /**
> > +      * @charge_fd: File descriptor identifying the target cgroup.
> > +      *
> > +      * May be either a pidfd, in which case the charge moves to the
> > +      * memory cgroup of the referenced process, or a cgroupfd obtaine=
d
> > +      * by opening a cgroup v2 directory, in which case the charge mov=
es
> > +      * directly to that cgroup's memory controller.
> > +      */
> > +     __u32 charge_fd;
> > +};
> > +
> >  #define DMA_BUF_BASE         'b'
> >  #define DMA_BUF_IOCTL_SYNC   _IOW(DMA_BUF_BASE, 0, struct dma_buf_sync=
)
> >
> > @@ -179,5 +204,6 @@ struct dma_buf_import_sync_file {
> >  #define DMA_BUF_SET_NAME_B   _IOW(DMA_BUF_BASE, 1, __u64)
> >  #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE       _IOWR(DMA_BUF_BASE, 2, st=
ruct dma_buf_export_sync_file)
> >  #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE       _IOW(DMA_BUF_BASE, 3, str=
uct dma_buf_import_sync_file)
> > +#define DMA_BUF_IOCTL_XFER_CHARGE    _IOW(DMA_BUF_BASE, 4, struct dma_=
buf_transfer_charge)
> >
> >  #endif
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 17fdefc56b97..3e717b5663c8 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5752,6 +5752,48 @@ void mem_cgroup_cancel_dmabuf(struct mem_cgroup =
*memcg, unsigned int nr_pages)
> >  }
> >  EXPORT_SYMBOL_GPL(mem_cgroup_cancel_dmabuf);
> >
> > +/**
> > + * mem_cgroup_transfer_charge - move a charge between memcgs
> > + * @ptr_memcg: pointer to the memcg to transfer from
> > + * @new_memcg: target memcg; caller must hold a reference
> > + * @item: stat counter to adjust
> > + * @nr_pages: number of pages to transfer
> > + *
> > + * Transfers @nr_pages of charge from *@ptr_memcg to @new_memcg and, o=
n
> > + * success, stores @new_memcg in *@ptr_memcg.
> > + *
> > + * Updates to *@ptr_memcg must be serialized by the caller.
> > + * Returns %true on success, %false if the charge against @new_memcg
> > + * failed.
> > + */
> > +bool mem_cgroup_transfer_charge(struct mem_cgroup **ptr_memcg,
> > +                             struct mem_cgroup *new_memcg,
> > +                             enum memcg_stat_item item,
> > +                             unsigned int nr_pages)
> > +{
> > +     struct mem_cgroup *old_memcg =3D *ptr_memcg;
> > +
> > +     if (!new_memcg || mem_cgroup_disabled())
> > +             return true;
> > +
> > +     if (try_charge(new_memcg, GFP_KERNEL, nr_pages))
> > +             return false;
> > +
> > +     mod_memcg_state(new_memcg, item, nr_pages);
> > +     css_get(&new_memcg->css);
> > +     *ptr_memcg =3D new_memcg;
> > +
> > +     if (old_memcg) {
> > +             /* Uncharge old cgroup */
> > +             mod_memcg_state(old_memcg, item, -nr_pages);
> > +             if (!mem_cgroup_is_root(old_memcg))
> > +                     refill_stock(old_memcg, nr_pages);
> > +             mem_cgroup_put(old_memcg);
> > +     }
> > +
> > +     return true;
> > +}
> > +
> >  /**
> >   * mem_cgroup_uncharge_dmabuf - uncharge a dma-buf from its memcg
> >   * @dmabuf: buffer to uncharge
> >
>

