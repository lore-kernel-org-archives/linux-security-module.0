Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956092;
	b=Gk8W1blDNfCSFVhTZEKoJLxfsJf5BdnlFu8cIOVKPFrKEsYmgFOltw79Nv+hRpYlV1AY
	 DgWrLaRj2ubeU7frFVIXRrwI628KWG1ak9ioNXoYBrtSJ6efG5HDOlOsothO0nvT3b3Dl
	 uH1+R2yCCi+HQ9OWsP6u/RheGwBzYZtR4z6cNWWp8NKlzHZ+EzNidqaSGD2QHv8drLLfu
	 Huy2AY1RGymy7mTV+kW2lijOX4NV7H76jCIhA4QvbZ3RQFrNluGkTNEP08oOw2hEFmCqX
	 2L3dvCdvLAu/B8jGhW+jR7CKAgOY2/xjpLFvUkltMTjBLgfEhPR7g9DBvUyyIOLRCpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=x7mnzARqVOnOj+KyQYPdVsGKtz9mrESSr8dwZPCPrb4=;
	b=X1/4mpRGwbC2vKCxmAQFyLPcFVId2OSVa+SyulzZnf+uL5+7S15NeP97Nku44awCnRX1
	 0HUMLO0oKT2FWZ3RBN/jfhk7MWDXAhhgWdciO0gtGgvp0AJyLS8MbG0XiG+E+KXE4FL95
	 exCACMLR0sIMlIOaI/Sov2KUyrqzh3GqHK2fU3gcEWuYJYp1B5v2RYQwFPabzXKKj8E1X
	 PWHEQVVcy4YDqzlBKKVTDta9nO/BIHbTGAoigMLjA70kSyNldGvfXsaKhWxNlzraWvQ2G
	 d1W2sv9bySshC4iHC/5dgydEcxentkAfQDdU/AMf3G3sqjqZMn40wvBhiq9rMjidxhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=UtNCGZpE;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3869606A885
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 22:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3869606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=UtNCGZpE
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55c38cdd5b7so4074911cf.2
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 14:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794956091; x=1795560891; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7mnzARqVOnOj+KyQYPdVsGKtz9mrESSr8dwZPCPrb4=;
        b=UtNCGZpERg95VgV31TLB6SKqg3O5IY7S5liFSjgST8jxLuBTyzR7elX/LO4B+17kMt
         emUhFzAJ523PtXBWTKI4rJMkk8L8iAvXpxzY9TD8MMNsDMv1FPwo0jiVBLw0TxZJzSRm
         M5cRQRyRj7aHzh2YUb3Vb/bnEnakXFrgtav82xnixUcrNWbKQWH1k3udT/v1VIasKqLO
         uTKsS5k+9nPtBkkZasSNBsAuQHTcOe42csFt9XQI85jVgcm952Uo/h8/s94MGZwEY4QT
         dXQU1KnqOHAYC64PjxxQG6jfuYnQpsTsPvjaGwD16PnS2iNvHPZBi8Zn6I1XhQdylkcD
         T2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794956091; x=1795560891;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7mnzARqVOnOj+KyQYPdVsGKtz9mrESSr8dwZPCPrb4=;
        b=WQpDK+R8jpBTOHVMWbqQPZx+S6jav60iGzsomGngVCTbqYqfltznnRjMSpxEKhaq5b
         9F3Za+Llk7thEUjHZnIrINlIvdlLA4m20U8jcwNmcreemHK5KK4Um9lKNpJQlsPCz4DM
         6666z5LKKK/pSAnmADdsr/Zr2uZrKL8YUpenv/hZNi9IqHAWPT+OZ5B55+e3L6fUV3Q3
         A1Oua+Vhzw5BVA9is3SYtrUGvDypC5srvISy9f8ao8sha5THtbooMcxHYkNydQznEC+o
         B6z78XMgfGXuHuZL+5/z7G0PiI3x88zfCrS0rVGCWy+TLHwF554OKt7Ea6GhjlEz5CLq
         cBrQ==
X-Forwarded-Encrypted: i=1; AL+hErHBvJlL2Y4Vq3VHlPsMG1r7ONJjINhY4cBBwARMRQVEVa3WvGkOWZ8OGXQnWadYeqq0FmK5RDjHjY+oUcNO0UOJtSY4C+w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+gfrEp6sJZikZdX2IwIBQDif8LZbWBrgLdcg7NVcLQnD3/JDB
	c4hVEgTEt4MNHyoFcHYN9lok1ostP8X5UlGH6yXNVbHifekO6BNtSJq3tQaVUEgiRQ==
X-Gm-Gg: AYBFou0bspj68ftceeRmN5QrWNMUo8LDizPaN9qMQEwsOzuD/YY7kcpNE10XCWA/zS5
	UaPfH20N+QAzFechGcIfzYkduzvPnfFNdk9OGfffePiiT2BDaxiaFYoRItA95Okrh7kiwiQ94VC
	UQLTxibzJaH/GOVWt9msEagAEwryyehXziul11ztYfiZGOruqmHPPdrag9EBS1BLvvsxvuzx2hw
	Xt3lpMBHlxIHDKUVkAWvoUe6cA0bUE1EtmSWhM6JwM2rnDBsWy+poZVu7XEHEoX+mxwGCjrjPR2
	cmoHIcZzabEdzHLzoGmb3dJrO/x5tTR8Xailvjn9+Jv1zgsBucnocnnYyL95VbtbtPMafwaCJZV
	cYrVA6Tc8EmBkJ7kL9puDH5uG5NZM7RGFX+oNPoA7SuCw+ZN+rkLNQVupzUTnMRwNn1WWWFFBWO
	GbOGZd5hDgqMdFTDcPwfJDAefNxMoAVD1fjg9IgKkGW+uYHOi77Q6hFh7WH1r9+NAnM+P061jit
	VPx6JBioj9T+VAZlF8i76aupxFEg3JVoLvsaU7Qc1uLxDd12B5vZSS88RmpB0TSiXJ6Sz84RBg7
	sajPEViGCF339OADN1rGcnhlGdBTM6ksYHJHoxtXvdzgFjR0EMnRe62lQBIGk4jpE6iTNDchKQ0
	dXBCvSFMnSET6MsFdPqgHReS3BS/YfXCidAcUqzgdenxKfzVCn38=
X-Received: by 2002:a05:622a:1647:b0:535:92a6:22db with SMTP id d75a77b69052e-55d5a36e150mr14373911cf.1.1794956090990;
        Tue, 17 Nov 2026 14:54:50 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d58fea01dsm7818061cf.8.2026.11.17.14.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:54:49 -0800 (PST)
Date: Tue, 17 Nov 2026 17:54:48 -0500
Message-ID: <44c0c45c0e2f47ed77bc45be47ebb3fb@paul-moore.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261117_1552/pstg-lib:20261117_1552/pstg-pwork:20261117_1552
From: Paul Moore <paul@paul-moore.com>
To: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
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
	Philipp Stanner <phasta@kernel.org>
Cc: airlied@gmail.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>, echanude@redhat.com, mripard@kernel.org
Subject: Re: [PATCH v5 4/8] lsm: Add memcg_charge_task LSM hook
References: <20261117-v2_20230123_tjmercier_google_com-v5-4-1ce975f2a9ad@redhat.com>
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-4-1ce975f2a9ad@redhat.com>

On Nov 17, 2026 Albert Esteve <aesteve@redhat.com> wrote:
> 
> Both DMA_HEAP_IOCTL_ALLOC and the new DMA_BUF_IOCTL_XFER_CHARGE ioctl
> accept a charge_fd field that, when set, causes the allocation to be
> charged to an arbitrary process's cgroup rather than the caller's.
> 
> Charging is currently limited to the caller's own memcg subtree unless
> the caller holds CAP_SYS_RESOURCE. But the capability is all-or-nothing.
> A process holding it, along with a dma-heap device node or a dma-buf
> fd can charge unlimited memory to any other process's cgroup, potentially
> exhausting that cgroup's limit and triggering OOM kills independent of
> the victim's own activity or privileges.
> 
> Add security_memcg_charge_task(), called in get_obj_cgroup_from_fd()
> when charge_fd refers to another process. The hook receives
> the credentials of the allocating process (from) and the credentials
> of the process whose cgroup will be charged (to), giving security
> modules a controlled enforcement point for cross-cgroup objcg
> attribution policy.
> 
> When CONFIG_SECURITY is not set the hook compiles to an inline
> returning 0, adding no overhead to the fast path.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  7 +++++++
>  mm/memcontrol.c               | 11 +++++++++++
>  security/security.c           | 15 +++++++++++++++
>  4 files changed, 34 insertions(+)

...

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 03cd90d5e623..2e6fcbe14d43 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -60,6 +60,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/resume_user_mode.h>
>  #include <linux/psi.h>
> +#include <linux/security.h>
>  #include <linux/seq_buf.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/kmemleak.h>
> @@ -3198,10 +3199,12 @@ static bool mem_cgroup_may_charge(struct mem_cgroup *memcg)
>  struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
>  {
>  	struct cgroup_subsys_state *css;
> +	const struct cred *tcred;
>  	struct obj_cgroup *objcg;
>  	struct mem_cgroup *memcg;
>  	struct task_struct *task;
>  	unsigned int pidfd_flags;
> +	int ret;
>  
>  	if (mem_cgroup_disabled())
>  		return ERR_PTR(-EOPNOTSUPP);
> @@ -3226,6 +3229,14 @@ struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
>  		if (IS_ERR(task))
>  			return ERR_CAST(task);
>  
> +		tcred = get_task_cred(task);
> +		ret = security_memcg_charge_task(current_cred(), tcred);

Do you ever envision this "from" cred being something other than
current_cred()?  If the answer is "no", we might want to consider changing
the LSM hook slightly to help prevent misuse in the future:

  int security_current_memcg_charge_task(const struct cred *tcred);

> +		put_cred(tcred);
> +		if (ret) {
> +			put_task_struct(task);
> +			return ERR_PTR(ret);
> +		}
> +
>  		rcu_read_lock();
>  		css = task_css(task, memory_cgrp_id);
>  		put_task_struct(task);

--
paul-moore.com
