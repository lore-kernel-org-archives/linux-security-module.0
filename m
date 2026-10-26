Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026442;
	b=wX0jVyFJq+zLcIaaznDvButo6llrY9rIfrS1WzCPkc57a6BHZHvvn8Nu27PiDZveK+Jp
	 yNaxn8g5IP5pe2RjHeB/kKyimGFCJO6FdzhuR8YgndthWDBy0wgpH9AZgGbJLf5vDoqCe
	 vdDoUX5ZjxC9d0Zpp+s8H7iEeEgNl91tfSbLy5MoORzeaFbVea8767KuHRiviD2NmEPx3
	 4IWXr+8Fy37lHpXEdEuyDKppPzXApULtF2CZHBl5jm71G3GJGXpGVGP09225iC0XTQ0en
	 O3NPTrJfA6l6yDzqerxDrtIESQ+N8hofwlfhAN89YM840A7WFpBGFD010AqM+Tkwuag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026442;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=OKz8jQo/auRPZNzdWHUdE6yB8Ix7XlP0akY/URWqfWs=;
	b=cT1SIpOPTk6b35JJcpUOUXJlYI5QdhWuoBZnRUmQDUi+cbN0JuSqhW9RVlRUh3g/gmz5
	 j1ocCNKCR+o0W2b9Nl2UGJi+WYkOi88Q1YRfptqjy4lI40aOU3IFmTb3ay6fnMaBYhNFJ
	 tNK19d0D2D6Bhxw75ZJQMPtMEJXWlR3Esx+jmeUXaxj6JqpvS3YADoQIlZVYTn26o8sQL
	 eLcqDfBmNn+Di0DabVECqKKmQ81K7tumZChzmhV8pOqtOFHLISYrbd4ty+NSlmG0SoSPz
	 9Lbw86ngUxf6s/zvxoHOIgs89Xq7SVlpwglBNqAXUX8ZS4zNub+c6jm3ID4dcOHTWvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ERkprg9R;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B5C606A31B
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 14:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57B5C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ERkprg9R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793026440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKz8jQo/auRPZNzdWHUdE6yB8Ix7XlP0akY/URWqfWs=;
	b=ERkprg9RQDF0hLYEQEK6W4YCQtJjEBAQ2TsbjX0HNA7pDMMr9hxWvnDrf1AwjvOcUkPO8A
	i4B0XAr3Rm4srBQh/5THFEiFYLs7Necl9hh9WEIafQRRXJuQAtKtSphr0iU99grbeYdyuW
	Pjp5DevJWYd9DUES5b6nE5M3FfVpMkQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-uO-vwvDDN-2tbRM5yPk83w-1; Mon, 26 Oct 2026 10:53:58 -0400
X-MC-Unique: uO-vwvDDN-2tbRM5yPk83w-1
X-Mimecast-MFC-AGG-ID: uO-vwvDDN-2tbRM5yPk83w_1793026438
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1e489f97fso33424155e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 07:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793026437; x=1793631237;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OKz8jQo/auRPZNzdWHUdE6yB8Ix7XlP0akY/URWqfWs=;
        b=DVbvLCPCmS5mKV6/OtNXtUUAOmOKDj+NINps0htLYBQWrZM5AsWcZmVpLttOj1rinU
         RVwOHhwLH40sD5mIHKtpo2cGlcpQ36t0E94NdU29hRGhnBEwybCDgILYow8i1sTt+sDz
         bzihc3RYq8ViJUHCC6naARU2wPUpatOG3W1SDlcN611IhOvTHwlTAg+PImtFAGouQzbZ
         R78WNT/trsnl2XBg7lJEwoS2KYKRsCU6nore78Z/LhjPtAT1UTQ75KFzlt6/bBO7NXlS
         xpHpQT+mWxOn6e7nbOJq2go6DS3pHe0M5FcADaJk2z4ENIuKw32kKRXmyAAh1+rzCFwg
         Pkqg==
X-Forwarded-Encrypted: i=1; AKwUvBwAz61+YVCfiFBbyRGLX+1ooV+78fui6zjRoTNRK2f6t2A42t9qpCzpRn4RrEiBnGkXDXLLwqaiSlaXlz0DFlr4gkhYUMg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBP7N1J2CfHmwKyTDYrG+0DhCZWI+vQx6hJuB29RuN0CNty5CM
	b52rcmeUG8UnJpJrhvYaXArsVzEW/1ANwhoDYmX/d1IjYO/8Bxno5J7v6ldEzJSiixJnaOy0JQz
	q5xWZEgB6WA1H9J1v7a0NRlzYxxsFD5mu3HiorFiTIeGXe7rrukJWmQNoq+karv+o3X0756BOMB
	/Ynw==
X-Gm-Gg: AYBFou3RI52TAslA5sjVhTdocLpph8vKgeTZ/eOonxx+5jy3rcQzSoFDzW0pR5ZoEuE
	Yh4FLqkYvx6d7FLad5EKGkdEbFhSYrdM3j8gP71cNum06fLym+qvJYQLCAi20QIvekpwFQ/9LBu
	kYKnPVPLVGN4DRyriokrjth8ltAQXu0e/5LnzXHmKakbSFQ1RcIPGj36pLaCzxIez5lOAF+gFIq
	oxZ41BxH4JeE+lbx3F1BerSzKFTOYFCA4+KlOKDmJNXMjg/SJ8t9M8tjx5cjvkiGlwviT1RmyyN
	qY0XbW5cses8Pzq6Ntd+WOA/9pWpWgTQHEL06HEcRwDWKxxaI26SjuBGVZwkpbDRmic=
X-Received: by 2002:a05:600c:3487:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4a35ac8c231mr138381565e9.9.1793026437535;
        Mon, 26 Oct 2026 07:53:57 -0700 (PDT)
X-Received: by 2002:a05:600c:3487:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4a35ac8c231mr138381105e9.9.1793026437038;
        Mon, 26 Oct 2026 07:53:57 -0700 (PDT)
Received: from localhost ([46.6.57.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0bac37sm213564065e9.6.2026.10.26.07.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:53:56 -0700 (PDT)
Date: Mon, 26 Oct 2026 15:53:54 +0100
From: Albert Esteve <aesteve@redhat.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
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
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	mripard@kernel.org, echanude@redhat.com
Subject: Re: [PATCH RFC v2 7/8] dma-buf: transfer memcg charges via
 DMA_BUF_IOCTL_XFER_CHARGE
Message-ID: <at9pgl9sC8__GHlZ@aesteve-thinkpadp1gen8.rmtes.csb>
References: <20261021-v2_20230123_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com>
 <20261021-v2_20230123_tjmercier_google_com-v2-7-ef6ee2dd8c5c@redhat.com>
 <9e54354d-b037-47e1-9390-86d5e25444a7@amd.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <9e54354d-b037-47e1-9390-86d5e25444a7@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uTIuhA3chsVOXxo0e2EODEyVb9_omhRF3rhrNyfRUjU_1793026438
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Oct 22, 2026 at 12:23:57PM +0200, Christian König wrote:
> On 10/21/26 17:42, Albert Esteve wrote:
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
> > preserving the original charge on failure. An atomic cmpxchg on
> > dmabuf->memcg prevents races with concurrent transfers.
> > 
> > Usage example:
> >   int cg_fd = open("/sys/fs/cgroup/clients/app1", O_RDONLY | O_DIRECTORY);
> > 
> >   struct dma_buf_transfer_charge xfer = {
> >       .charge_fd = cg_fd,
> >   };
> >   ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer);
> >   /* charge now on app1's cgroup */
> >   close(cg_fd);
> > 
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  drivers/dma-buf/dma-buf.c    | 77 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/memcontrol.h   |  9 ++++++
> >  include/uapi/linux/dma-buf.h | 26 +++++++++++++++
> >  mm/memcontrol.c              | 40 +++++++++++++++++++++++
> >  4 files changed, 152 insertions(+)
> > 
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index f31f49ebd0af..7fa607d9bf65 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -540,6 +540,80 @@ static long dma_buf_import_sync_file(struct dma_buf *dmabuf,
> >  }
> >  #endif
> >  
> 
> A single line code comment what this is all about would be nice to have.
> 
> Some note to look at struct dma_buf_transfer_charge for details is most likely good enough.

Sure, will add it for next version.

> 
> > +static long dma_buf_xfer_charge(struct dma_buf *dmabuf,
> > +				const void __user *user_data)
> > +{
> > +	struct cgroup *cgrp;
> > +	struct cgroup_subsys_state *css;
> > +	struct dma_buf_transfer_charge arg;
> > +	struct mem_cgroup *memcg;
> > +	struct task_struct *task;
> > +	const struct cred *tcred;
> > +	unsigned int pidfd_flags;
> > +	int ret = 0;
> > +
> > +	if (copy_from_user(&arg, user_data, sizeof(arg)))
> > +		return -EFAULT;
> > +
> > +	if (!IS_ENABLED(CONFIG_MEMCG))
> > +		return 0;
> > +
> > +	if (arg.__padding != 0)
> > +		return -EINVAL;
> > +
> > +	cgrp = cgroup_get_from_fd(arg.charge_fd);
> > +	if (!IS_ERR(cgrp)) {
> > +		/* charge_fd is a cgroupfd */
> > +		rcu_read_lock();
> > +		css = cgroup_css(cgrp, &memory_cgrp_subsys);
> > +		if (!css || !css_tryget_online(css)) {
> > +			rcu_read_unlock();
> > +			cgroup_put(cgrp);
> > +			return -ENOENT;
> > +		}
> > +
> > +		memcg = mem_cgroup_from_css(css);
> > +		rcu_read_unlock();
> > +
> > +		ret = security_dma_buf_charge_cgroup(current_cred(), cgrp);
> > +		cgroup_put(cgrp);
> > +		if (ret) {
> 
> 
> > +			mem_cgroup_put(memcg);
> > +			return ret;
> 
> Maybe use goto skip_transfer; instead?

Yeah. This is a copy from the ALLOC part sharing this logic.
I will refactor all this logic (extracting memcg from the fd)
into a function in memcontrol to clean up this mess.

> 
> > +		}
> > +	} else {
> > +		/* charge_fd is a pidfd  */
> > +		task = pidfd_get_task(arg.charge_fd, &pidfd_flags);
> > +		if (IS_ERR(task))
> > +			return PTR_ERR(task);
> > +
> > +		tcred = get_task_cred(task);
> > +		ret = security_dma_buf_charge_task(current_cred(), tcred);
> > +		put_cred(tcred);
> > +		if (ret) {
> > +			put_task_struct(task);
> > +			return ret;
> > +		}
> > +
> > +		memcg = get_mem_cgroup_from_mm(task->mm);
> > +		put_task_struct(task);
> > +	}
> > +
> > +	if (dmabuf->memcg == memcg)
> > +		goto skip_transfer;
> > +
> > +	if (!mem_cgroup_transfer_dmabuf_charge(dmabuf, memcg)) {
> > +		ret = -ENOMEM;
> > +		goto skip_transfer;
> > +	}
> > +
> > +	return 0;
> > +
> > +skip_transfer:
> > +	mem_cgroup_put(memcg);
> > +	return ret;
> > +}
> > +
> >  static long dma_buf_ioctl(struct file *file,
> >  			  unsigned int cmd, unsigned long arg)
> >  {
> > @@ -590,6 +664,9 @@ static long dma_buf_ioctl(struct file *file,
> >  		return dma_buf_import_sync_file(dmabuf, (const void __user *)arg);
> >  #endif
> >  
> > +	case DMA_BUF_IOCTL_XFER_CHARGE:
> > +		return dma_buf_xfer_charge(dmabuf, (const void __user *)arg);
> > +
> >  	default:
> >  		return -ENOTTY;
> >  	}
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index aa08fbb0c26c..3a6acfda1423 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -674,6 +674,9 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, unsigned short id,
> >  bool mem_cgroup_charge_dmabuf(struct dma_buf *dmabuf, struct mem_cgroup *memcg,
> >  			      gfp_t gfp_mask);
> >  
> > +bool mem_cgroup_transfer_dmabuf_charge(struct dma_buf *dmabuf,
> > +				       struct mem_cgroup *new_memcg);
> > +
> >  void __mem_cgroup_uncharge(struct folio *folio);
> >  
> >  /**
> > @@ -1183,6 +1186,12 @@ static inline bool mem_cgroup_charge_dmabuf(struct dma_buf *dmabuf,
> >  	return true;
> >  }
> >  
> > +static inline bool mem_cgroup_transfer_dmabuf_charge(struct dma_buf *dmabuf,
> > +						     struct mem_cgroup *new_memcg)
> > +{
> > +	return true;
> > +}
> > +
> >  static inline void mem_cgroup_uncharge(struct folio *folio)
> >  {
> >  }
> > diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
> > index e827c9d20c5d..4970a7b8e08e 100644
> > --- a/include/uapi/linux/dma-buf.h
> > +++ b/include/uapi/linux/dma-buf.h
> > @@ -168,6 +168,31 @@ struct dma_buf_import_sync_file {
> >  	__s32 fd;
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
> > + * preserved.  If the buffer has no existing charge, a new
> > + * charge is established.
> > + */
> > +struct dma_buf_transfer_charge {
> > +	/**
> > +	 * @charge_fd: File descriptor identifying the target cgroup.
> > +	 *
> > +	 * May be either a pidfd, in which case the charge moves to the
> > +	 * memory cgroup of the referenced process, or a cgroupfd obtained
> > +	 * by opening a cgroup v2 directory, in which case the charge moves
> > +	 * directly to that cgroup's memory controller.
> > +	 */
> > +	__u32 charge_fd;
> > +	/** @__padding: Reserved, must be zero */
> > +	__u32 __padding;
> 
> Maybe rename to flags, put before charge_fd and add "/* unused for now */".

Agreed.

> 
> > +};
> > +
> >  #define DMA_BUF_BASE		'b'
> >  #define DMA_BUF_IOCTL_SYNC	_IOW(DMA_BUF_BASE, 0, struct dma_buf_sync)
> >  
> > @@ -179,5 +204,6 @@ struct dma_buf_import_sync_file {
> >  #define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
> >  #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE	_IOWR(DMA_BUF_BASE, 2, struct dma_buf_export_sync_file)
> >  #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE	_IOW(DMA_BUF_BASE, 3, struct dma_buf_import_sync_file)
> > +#define DMA_BUF_IOCTL_XFER_CHARGE	_IOW(DMA_BUF_BASE, 4, struct dma_buf_transfer_charge)
> >  
> >  #endif
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e94222237d31..d994a4b2d35e 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5688,6 +5688,46 @@ bool mem_cgroup_charge_dmabuf(struct dma_buf *dmabuf, struct mem_cgroup *memcg,
> >  	return true;
> >  }
> >  
> > +/**
> > + * mem_cgroup_transfer_dmabuf_charge - move a dma-buf charge
> > + * @dmabuf: buffer to transfer charge
> > + * @new_memcg: target memcg; caller must hold a reference
> > + *
> > + * Transfers the charge for @dmabuf to @new_memcg and, on
> > + * success, stores @new_memcg in @dmabuf->memcg.
> > + * Returns %true on success, %false if the charge against @new_memcg
> > + * failed or a concurrent transfer raced on @dmabuf->memcg.
> > + * On failure the caller retains its reference to @new_memcg.
> > + */
> > +bool mem_cgroup_transfer_dmabuf_charge(struct dma_buf *dmabuf,
> > +				       struct mem_cgroup *new_memcg)
> > +{
> > +	struct mem_cgroup *old_memcg = READ_ONCE(dmabuf->memcg);
> > +	unsigned int nr_pages = PAGE_ALIGN(dmabuf->size) >> PAGE_SHIFT;
> 
> That doesn't work as easily as this.
> 
> DMA-buf can contain litterally *anything*, ranging from system memory over device memory all the way to functional HW blocks. In other words doorbell, GWS, GDS, OA, I2C, I2S, any random data consuming or providng HW block...
> 
> For memory the "size" is the actually number of bytes the buffer represents, but for everything else it is just an arbitary number given by the exporter. In most cases just 1 or actually number of HW blocks/channels, but for GDS for example it is actually a pretty large number.

I don't think I was completely aware of all these uses for dma-bufs and
the specific meanings of the size for all them. Thanks for pointing this
out.

> 
> Saying that you most likely need some flag from the exporter if charging and/or the changing of charging should be possible or not. Otherwise you can potentially do quite a bunch of nonsense with that.

Yes, a flag seems to be simple solution for the problem at hand. I can
focus on the system heap for now, and it can be easily extended in the
future for other allocators as needed.

> 
> Regards,
> Christian.
> 
> > +
> > +	if (!mem_cgroup_disabled() && try_charge(new_memcg, GFP_KERNEL, nr_pages))
> > +		return false;
> > +
> > +	if (cmpxchg(&dmabuf->memcg, old_memcg, new_memcg) != old_memcg) {
> > +		if (!mem_cgroup_is_root(new_memcg))
> > +			refill_stock(new_memcg, nr_pages);
> > +		return false;
> > +	}
> > +
> > +	mod_memcg_state(new_memcg, MEMCG_DMABUF, nr_pages);
> > +
> > +	if (old_memcg) {
> > +		/* Uncharge old cgroup */
> > +		mod_memcg_state(old_memcg, MEMCG_DMABUF, -nr_pages);
> > +		if (!mem_cgroup_is_root(old_memcg))
> > +			refill_stock(old_memcg, nr_pages);
> > +		/* unref from buffer - buffer keeps new ref to new_memcg */
> > +		mem_cgroup_put(old_memcg);
> > +	}
> > +
> > +	return true;
> > +}
> > +
> >  /**
> >   * mem_cgroup_uncharge_dmabuf - uncharge a dma-buf from its memcg
> >   * @dmabuf: buffer to uncharge
> > 
> 

