Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477743;
	b=1Dls3A2yvxLog/gcUtfLRxQHtWTUsCBDuQP9Jv6ALZYuG8vZX5whhrdVuTI8Mv8PxTe9
	 GDsJHIhFFA2j8UmZ6wLbQJoKfQqY14L07G6hTxN0SVDOVLMhmWvUXYug1PFGXLjzPQND4
	 ANWgwQR9jCuQb15fCj41bjseN+QreOes3bbg1I84e4NNUITKh8uKY2nQ3w8SciyS7cZUz
	 nZDVAz37XBKugMtjib24MAEiyVjjGM1YGXOxlCSR7gXkhSIwphY1YjfoevqVUoqAtRak5
	 Aan42yT+4Wo2kZDe4RIN5d2Nvpq0+njxzX58Hudhz3WFQ8rczzUGpAUNlFrGH7wwGNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477743;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=ku69CJLRXzwwOsA6G2xqy4VdyNyzfbNSiJBSoeXd84w=;
	b=LYKyjcL4M82Gk4sUhnB96VfSeURw/9VYNnmoUkwywEufGjB1/Cv5zEsHCyL8EaAKJP1R
	 TGaYvv17+6LTzqOqiZLVM9Q5iOgjS52XPlVg4NeEgNhxBFbpbLQDrUKtH9Q/dVydXF6lM
	 twCwFviBT18npJjz1PIffADEMXcJonWguglybet6vIs3ukbqm0d8Huwf80lbUMuuIKz4l
	 PyJuhWhUsHeYvzCTH5fisil3zCoAcp8AzFchlesgA/vEwdIRaTDI4DKm7zvlul6OwHLWZ
	 4Lbib2TzXCRUuTb1gfkzWy5AQjWpALVx43Q78dBfRHYnhhp2sueqXaK3wOV6v+tg5fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="eBvXpv/9";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98682606A32E
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 10:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98682606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eBvXpv/9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794477741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ku69CJLRXzwwOsA6G2xqy4VdyNyzfbNSiJBSoeXd84w=;
	b=eBvXpv/91ElvSiIqIDTuwTEIGZodPjBovCs8FY39z63CbvfIma2/9Iveem5jB2BbtFVC/r
	GwI8wwoXqqr1gSjLoUX1r+wcBoIeWsrhAzqWhnssnYiQy5H+WtiERUnocuCAHUqEHHFh8u
	vZpGnbt09LMbf7dEDMg8dAeSKyumEMs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-8mnTrgutMziy9x-0oxF1Cw-1; Thu, 12 Nov 2026 05:02:20 -0500
X-MC-Unique: 8mnTrgutMziy9x-0oxF1Cw-1
X-Mimecast-MFC-AGG-ID: 8mnTrgutMziy9x-0oxF1Cw_1794477739
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4b9f7cace4bso37847075e9.3
        for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 02:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794477739; x=1795082539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ku69CJLRXzwwOsA6G2xqy4VdyNyzfbNSiJBSoeXd84w=;
        b=ba7U49/m2Oj2vHaCS8xdZUZgcR2DCflGL3AhIT1rwbFEl++Q5CgtahcFM1jp9Y/a23
         NxlffLjDz5B+v72hc5iEdLVPRL3OFLSWUAZP8MXreAVVW3LM4MRxSKe/V+SNAIQ+LCiR
         CWXwXywu4SSPQ13BQg3q1h8nEAIFy5J8nq3LXuqKK4dIA7yCJklYuXyVyuvphPfaulyP
         9/CvvllSuxX17aWC241O/k9mlZXTgdHqjTlVd/nlzjOGUkgZFB32H3ocnQXx14lchiDi
         1F9H2om8iOMHPSnn5dbQ9asn9Ldek1V1xdJHOvwFfPD/ieXrrhRmOVWBBIsTwTfAE/B1
         XIXQ==
X-Forwarded-Encrypted: i=1; AL+hErGg1TA0tXoSQIYAlk7cntL2w8ceLzYX5MZ84dTCnbgfZcX5JJ1lO0ututsrNr1nQ3T+b9oQFy+sKBXjLmdHOilKTegek1Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lmcSqF/4sRuQsaFQotWDGgShhe/pOt2dh3rwGChpj3bU71UVC
	kGAhZ4mu0Tyk4jB6Qj7M8XVT80/40rsKbTk9cfMK/nJb0eudZLC5qYoLe/CIYFoSsME4xdxfPT6
	T3mym0IWL7TU9WQ1u0DvexiWaHXpSwnf0ywzFcVHLaB3SPfsCU1wnHI/WLa+PFR2rYrMlr45l/W
	5BpQ==
X-Gm-Gg: AYBFou37dzwvO2TnOXs2STr769xbnr0d4eCnkD3vEiOkqH00+Un2xkF4aYa9FHVcIpF
	xPEWpwRG/Hu5KXeh/2ECSf6r8UKJ9Rlov1fSruYB/We8s/6noFzAzM+OHAOSmugYX5cEuNrBlnb
	yLSuvjZt7r4Ff63BXeWVArskV3imETPrCEMa4a3fzyjReBhmnyZrTg0s7dHGgVBggyKSA/N0l90
	1MpxFy8oeMzccWH8fSFgYhE7ZOYYhbrLojHzc9AnCeo7zykix8I2XY21X4gTi9K67PK9ZIapXFu
	xKn/f5Las/FScT7fT0U3EDxCO3FOEgzRJmODPWAmaK7eck3b5/OARuYv8KaEqaZrDvmMnjpFYnG
	MsMiSimjysB3ZookBGIEd+fcgQMIr5h2D8BW1eZ3IKLA=
X-Received: by 2002:a05:600c:4f84:b0:4a1:e92b:ae4a with SMTP id 5b1f17b1804b1-4ba093b9a3cmr86690395e9.21.1794477738942;
        Thu, 12 Nov 2026 02:02:18 -0800 (PST)
X-Received: by 2002:a05:600c:4f84:b0:4a1:e92b:ae4a with SMTP id 5b1f17b1804b1-4ba093b9a3cmr86689595e9.21.1794477738330;
        Thu, 12 Nov 2026 02:02:18 -0800 (PST)
Received: from localhost ([139.47.30.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983284c99bsm15755230f8f.7.2026.11.12.02.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:02:17 -0800 (PST)
Date: Thu, 12 Nov 2026 11:02:16 +0100
From: Albert Esteve <aesteve@redhat.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org
Subject: Re: [Linaro-mm-sig] [PATCH v4 3/8] dma-buf: transfer memcg charges
 via DMA_BUF_IOCTL_XFER_CHARGE
Message-ID: <avWOqDLI1xmfBqn2@aesteve-thinkpadp1gen8.rmtes.csb>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-3-1819a017000b@redhat.com>
 <b77aecccce2dcf9bc42b1a6fccc62d06ccad4741.camel@linux.intel.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <b77aecccce2dcf9bc42b1a6fccc62d06ccad4741.camel@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JKJn67NIBdv3jW6s-wC3Ekhp0Z-Sahj0YGQxyHgMn20_1794477739
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Nov 12, 2026 at 08:46:02AM +0100, Thomas Hellström wrote:
> On Wed, 2026-11-04 at 12:09 +0100, Albert Esteve wrote:
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
> >   int cg_fd = open("/sys/fs/cgroup/clients/app1", O_RDONLY |
> > O_DIRECTORY);
> > 
> >   struct dma_buf_transfer_charge xfer = {
> >       .charge_fd = cg_fd,
> >   };
> >   ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer);
> >   /* charge now on app1's cgroup */
> >   close(cg_fd);
> > 
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  drivers/dma-buf/dma-buf.c    | 42
> > ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/dma-buf.h      |  3 ++-
> >  include/linux/memcontrol.h   | 13 +++++++++++++
> >  include/uapi/linux/dma-buf.h | 26 ++++++++++++++++++++++++++
> >  mm/memcontrol.c              | 42
> > ++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 125 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 837666273550..3bd26fbb1109 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -540,6 +540,45 @@ static long dma_buf_import_sync_file(struct
> > dma_buf *dmabuf,
> >  }
> >  #endif
> >  
> > +/* Transfer a dma-buf's memcg charge; see struct
> > dma_buf_transfer_charge */
> > +static long dma_buf_xfer_charge(struct dma_buf *dmabuf,
> > +				const void __user *user_data)
> > +{
> > +	struct dma_buf_transfer_charge arg;
> > +	struct mem_cgroup *memcg;
> > +	unsigned int nr_pages = PAGE_ALIGN(dmabuf->size) >>
> > PAGE_SHIFT;
> > +	int ret = 0;
> > +
> > +	if (copy_from_user(&arg, user_data, sizeof(arg)))
> > +		return -EFAULT;
> > +
> > +	if (!IS_ENABLED(CONFIG_MEMCG))
> > +		return 0;
> > +
> > +	if (arg.flags != 0)
> > +		return -EINVAL;
> > +
> > +	memcg = mem_cgroup_get_from_fd(arg.charge_fd);
> > +	if (IS_ERR(memcg))
> > +		return PTR_ERR(memcg);
> > +
> > +	dma_resv_lock(dmabuf->resv, NULL);
> > +
> > +	if (!dmabuf->memcg) {
> > +		ret = -EOPNOTSUPP;
> > +		goto out;
> > +	}
> > +
> > +	if (dmabuf->memcg != memcg &&
> > +	    !mem_cgroup_transfer_charge(&dmabuf->memcg, memcg,
> > MEMCG_DMABUF, nr_pages))
> > +		ret = -ENOMEM;
> > +
> > +out:
> > +	dma_resv_unlock(dmabuf->resv);
> > +	mem_cgroup_put(memcg);
> > +	return ret;
> > +}
> > +
> >  static long dma_buf_ioctl(struct file *file,
> >  			  unsigned int cmd, unsigned long arg)
> >  {
> > @@ -590,6 +629,9 @@ static long dma_buf_ioctl(struct file *file,
> >  		return dma_buf_import_sync_file(dmabuf, (const void
> > __user *)arg);
> >  #endif
> >  
> > +	case DMA_BUF_IOCTL_XFER_CHARGE:
> > +		return dma_buf_xfer_charge(dmabuf, (const void
> > __user *)arg);
> > +
> >  	default:
> >  		return -ENOTTY;
> >  	}
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 85dd747c9b36..b01149d26b44 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -507,7 +507,8 @@ struct dma_buf_attachment {
> >   * @priv:	Attach private data of allocator to this buffer
> >   * @memcg:	memcg to charge for this buffer's memory. Set only
> > for
> >   *		buffers backed by system memory where @size reflects
> > the
> > - *		actual allocation in bytes.
> > + *		actual allocation in bytes. Enables charge transfer
> > via
> > + *		DMA_BUF_IOCTL_XFER_CHARGE.
> >   *
> >   * This structure holds the information required to export the
> > buffer. Used
> >   * with dma_buf_export() only.
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index f8ec751b7d7b..af02d9777fe9 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -676,6 +676,11 @@ struct mem_cgroup *mem_cgroup_get_from_fd(int
> > fd);
> >  bool mem_cgroup_reserve_dmabuf(struct mem_cgroup *memcg, gfp_t gfp,
> >  			       unsigned int nr_pages);
> >  
> > +bool mem_cgroup_transfer_charge(struct mem_cgroup **ptr_memcg,
> > +				struct mem_cgroup *new_memcg,
> > +				enum memcg_stat_item item,
> > +				unsigned int nr_pages);
> > +
> >  void __mem_cgroup_uncharge(struct folio *folio);
> >  
> >  /**
> > @@ -1197,6 +1202,14 @@ static inline void
> > mem_cgroup_cancel_dmabuf(struct mem_cgroup *memcg,
> >  {
> >  }
> >  
> > +static inline bool mem_cgroup_transfer_charge(struct mem_cgroup
> > **ptr_memcg,
> > +					      struct mem_cgroup
> > *new_memcg,
> > +					      enum memcg_stat_item
> > item,
> > +					      unsigned int nr_pages)
> > +{
> > +	return true;
> > +}
> > +
> >  static inline void mem_cgroup_uncharge(struct folio *folio)
> >  {
> >  }
> > diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-
> > buf.h
> > index e827c9d20c5d..0aaf2e7d593b 100644
> > --- a/include/uapi/linux/dma-buf.h
> > +++ b/include/uapi/linux/dma-buf.h
> > @@ -168,6 +168,31 @@ struct dma_buf_import_sync_file {
> >  	__s32 fd;
> >  };
> >  
> > +/**
> > + * struct dma_buf_transfer_charge - Transfer a dma-buf's memcg
> > charge
> > + *
> > + * Any holder of a dma-buf file descriptor can perform a
> > + * DMA_BUF_IOCTL_XFER_CHARGE to attribute the buffer's memory
> > + * cost to a specific cgroup, or move it from one cgroup to
> > + * another.  The ioctl charges the new cgroup before uncharging
> > + * the old one atomically.  On failure the original charge is
> > + * preserved.  If the buffer has no existing memcg charge, the
> > + * ioctl returns -EOPNOTSUPP.
> > + */
> > +struct dma_buf_transfer_charge {
> > +	/** @flags: Reserved, must be zero */
> > +	__u32 flags; /* unused for now */
> > +	/**
> > +	 * @charge_fd: File descriptor identifying the target
> > cgroup.
> > +	 *
> > +	 * May be either a pidfd, in which case the charge moves to
> > the
> > +	 * memory cgroup of the referenced process, or a cgroupfd
> > obtained
> > +	 * by opening a cgroup v2 directory, in which case the
> > charge moves
> > +	 * directly to that cgroup's memory controller.
> > +	 */
> > +	__u32 charge_fd;
> > +};
> > +
> >  #define DMA_BUF_BASE		'b'
> >  #define DMA_BUF_IOCTL_SYNC	_IOW(DMA_BUF_BASE, 0, struct
> > dma_buf_sync)
> >  
> > @@ -179,5 +204,6 @@ struct dma_buf_import_sync_file {
> >  #define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
> >  #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE	_IOWR(DMA_BUF_BASE, 2,
> > struct dma_buf_export_sync_file)
> >  #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE	_IOW(DMA_BUF_BASE, 3, struct
> > dma_buf_import_sync_file)
> > +#define DMA_BUF_IOCTL_XFER_CHARGE	_IOW(DMA_BUF_BASE, 4, struct
> > dma_buf_transfer_charge)
> >  
> >  #endif
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 17fdefc56b97..3e717b5663c8 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5752,6 +5752,48 @@ void mem_cgroup_cancel_dmabuf(struct
> > mem_cgroup *memcg, unsigned int nr_pages)
> >  }
> >  EXPORT_SYMBOL_GPL(mem_cgroup_cancel_dmabuf);
> >  
> > +/**
> > + * mem_cgroup_transfer_charge - move a charge between memcgs
> > + * @ptr_memcg: pointer to the memcg to transfer from
> > + * @new_memcg: target memcg; caller must hold a reference
> > + * @item: stat counter to adjust
> > + * @nr_pages: number of pages to transfer
> > + *
> > + * Transfers @nr_pages of charge from *@ptr_memcg to @new_memcg and,
> > on
> > + * success, stores @new_memcg in *@ptr_memcg.
> > + *
> > + * Updates to *@ptr_memcg must be serialized by the caller.
> > + * Returns %true on success, %false if the charge against @new_memcg
> > + * failed.
> > + */
> > +bool mem_cgroup_transfer_charge(struct mem_cgroup **ptr_memcg,
> > +				struct mem_cgroup *new_memcg,
> > +				enum memcg_stat_item item,
> > +				unsigned int nr_pages)
> > +{
> > +	struct mem_cgroup *old_memcg = *ptr_memcg;
> > +
> > +	if (!new_memcg || mem_cgroup_disabled())
> > +		return true;
> > +
> > +	if (try_charge(new_memcg, GFP_KERNEL, nr_pages))
> > +		return false;
> > +
> > +	mod_memcg_state(new_memcg, item, nr_pages);
> > +	css_get(&new_memcg->css);
> > +	*ptr_memcg = new_memcg;
> > +
> > +	if (old_memcg) {
> > +		/* Uncharge old cgroup */
> > +		mod_memcg_state(old_memcg, item, -nr_pages);
> > +		if (!mem_cgroup_is_root(old_memcg))
> > +			refill_stock(old_memcg, nr_pages);
> > +		mem_cgroup_put(old_memcg);
> > +	}
> > +
> > +	return true;
> > +}
> 
>  
> This has the same lifetime issue as patch 1. After a transfer, the
> buffer pins new_memcg until it is released, and with cross-process
> transfers the target may be removed before the
> buffer is. Since this helper is meant to be reused by other subsystems,
> would it be better to have it take and store an obj_cgroup from the
> start?

Agreed. I will switch to obj_cgroup through the series.

> 
> Thanks,
> Thomas
> 
> 
> > +
> >  /**
> >   * mem_cgroup_uncharge_dmabuf - uncharge a dma-buf from its memcg
> >   * @dmabuf: buffer to uncharge

