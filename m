Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F532A810
	for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945621; cv=none; b=oUs6buGQYlDF8kSmvYyuAXTER0ZbGUtClLDSgapCuNOVQZyMO+C0TLlIzHKwPPw4Ryi7Y0ZRqgd3eeR1T60iQNZGfRyWWlgEPGoj8dEEXh0SzR0FMay7YqdKvko8T1giUm7wODyBhlspnpfTGwPdlyVwtNTfehXNHK4qGGkxkP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945621; c=relaxed/simple;
	bh=mkgMTmzYeY0rzm54yxUzf2TFAaH/EdGznSYD6F61wO0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=i3wojWVlxczTaN5FDSldgxDn8nofuIuMRAEyK4BkAto9U5zSIeHZUmWOzVvfqN9A+ecDNZEwhbRhuf0pcm9CYHFAm+ZQkzS2kvSrzMFqhKvdoIUuiFaGHPQN5TXwPjRBjioVk0knH5KOwRJJEukBiAxbPmlLiDDV4xI+5IRC5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlbwKvVt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlbwKvVt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757945618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVdn0DPWHUbkLEPLdY+zWqs5jFzexOcoSsUmWxZ7iDA=;
	b=VlbwKvVto8BUNYgF0WuSzkTglNqZvMZ4f7RA0ekPT9vJwZKg4qjQJz4g0sIjghMLggLRab
	bpizLI92n+ivNelPHAA0L0gTvg4EmLlBh6VZw51t8IeeT4hsw9bBCiIvWt85vlwhPxhPJA
	u7864aqdqXMfkcEc2iUWlL+qyABICxo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-kfwOASdaPlWjqZgdRrLXGg-1; Mon, 15 Sep 2025 10:13:30 -0400
X-MC-Unique: kfwOASdaPlWjqZgdRrLXGg-1
X-Mimecast-MFC-AGG-ID: kfwOASdaPlWjqZgdRrLXGg_1757945610
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5d58d226cso112959821cf.1
        for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 07:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757945610; x=1758550410;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVdn0DPWHUbkLEPLdY+zWqs5jFzexOcoSsUmWxZ7iDA=;
        b=Ln5W+bJCDav7q07hypVEiuAFRV8K4/irldZs9m0LXoIV3KaCPzwtDCcebtg3C0YcAp
         5Oc2BOMg+y6NaXQniciXLqACuXn7Yj7t54cjTxaAGCaYogK3uA2BmfGRb17Cx5JFhJEn
         X399ayvY6KIoXXCiB58a7XGrDWrZgJPoSWgaIuxssUZ12u2xIa2jqfra5cIP3vb28qfE
         aPKAknHOUn1vRYzgoXyO7pXTO+bIb6ud4DJE7gRzmgC3oP6npkc76tj9SqRDn8KaoEIE
         CTygKESgL+Ld4O/C4r9OAPmFtnsnkVWGd/4oy3NcOvr0kO4ohjIFsyX9hvsI9SrgGoEh
         w+wg==
X-Forwarded-Encrypted: i=1; AJvYcCWVKJbWmQeGzdAEpHbaDbTeeEvGZs9kgO7CfHrItXE1Kbq7b2XXBwf+Vats8xIp5Uo1xXddfQM6abjUCZkJVIZZWKDUpTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoFC57l+YDFvq7AnHSnRJ/KotM/iPC9AoafT4Hohzss5fz2TSK
	RaqyTfY80tq+lA/Z+/GEIkRYQcoRiQ+8TaDBmUG/gMaQ+Ar+Uj9TgwI9GUW6xowffSUw7DBgDbJ
	rTwcUe/W/2iUlkHFJKx7BhAeOWBX1D54ESaoHEhKVRI8AqFJzKZDNR0tWmHlvTtUt4ebGIqd/Zr
	+Z8w==
X-Gm-Gg: ASbGncsUjz0k78/j1K8ZSE4ZRi904H6oYmIPp0u24LREPq8Z0Ou5YqTYBkrBoZcAaDs
	7aHKO4I1qPaMOlg15gZJOzffI8dCUOhheb330n0u8MGkFYEWeGwuAfLUoIa1yAqlJsGAmYKrwiJ
	bAh4NpfWOgabF1ikSliV9ZkQjdQ9SXRBYdxXWB3w7PcgXQlJlmrA71rljPeV2NWvcUMNC3bNIx8
	qxuFT9uh9gHKu8OZN7DsI6aWg/HXTqKZbBFoUjvsGavE+V8xIG7P9wnYGDPh9oL+9DSvD/bmlSi
	WODnAM4yNoHx6WhAHvur34mmrer6THQJG2jTlnT0DUrY4hMzSw3JlwEmyyuAcWsWCqCizvw6fNf
	wm5CyHdyZrg==
X-Received: by 2002:a05:6214:1c48:b0:783:aeed:f585 with SMTP id 6a1803df08f44-783aeedf838mr35483956d6.14.1757945609717;
        Mon, 15 Sep 2025 07:13:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTppRgm9Zr+i6yKV7XaF5zz8E26tx9E9U11cHDaiNozJpKImHlUxPb0H8lw3W3qvOa9oFD+g==
X-Received: by 2002:a05:6214:1c48:b0:783:aeed:f585 with SMTP id 6a1803df08f44-783aeedf838mr35483486d6.14.1757945609106;
        Mon, 15 Sep 2025 07:13:29 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-78903aec245sm7995186d6.23.2025.09.15.07.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 07:13:27 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <69af79b6-a4f2-4007-aef4-fcaeeadd3f99@redhat.com>
Date: Mon, 15 Sep 2025 10:13:26 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu: Remove redundant rcu_read_lock/unlock() in
 spin_lock critical sections
To: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org
Cc: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-s390@vger.kernel.org, cgroups@vger.kernel.org,
 Hillf Danton <hdanton@sina.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 pengdonglin <pengdonglin@xiaomi.com>
References: <20250915134729.1801557-1-dolinux.peng@gmail.com>
In-Reply-To: <20250915134729.1801557-1-dolinux.peng@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VZTQkHG73NoUvu6rNTCn7cEo5IWGRMkDliVmDEhPDQc_1757945610
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/15/25 9:47 AM, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> Per Documentation/RCU/rcu_dereference.rst [1], since Linux 4.20's RCU
> consolidation [2][3], RCU read-side critical sections include:
>    - Explicit rcu_read_lock()
>    - BH/interrupt/preemption-disabling regions
>    - Spinlock critical sections (including CONFIG_PREEMPT_RT kernels [4])
>
> Thus, explicit rcu_read_lock()/unlock() calls within spin_lock*() regions are redundant.
> This patch removes them, simplifying locking semantics while preserving RCU protection.
>
> [1] https://elixir.bootlin.com/linux/v6.17-rc5/source/Documentation/RCU/rcu_dereference.rst#L407
> [2] https://lore.kernel.org/lkml/20180829222021.GA29944@linux.vnet.ibm.com/
> [3] https://lwn.net/Articles/777036/
> [4] https://lore.kernel.org/lkml/6435833a-bdcb-4114-b29d-28b7f436d47d@paulmck-laptop/
>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
> ---
> Changes in v2:
>    - Clarified commit message to prevent accidental backport to older kernels
>    - Added lockdep_is_held() to avoid false positives
> ---
>   drivers/acpi/apei/ghes.c                        | 2 --
>   drivers/gpu/drm/i915/gt/intel_ring_submission.c | 2 --
>   drivers/net/amt.c                               | 8 --------
>   drivers/net/bonding/bond_3ad.c                  | 2 --
>   drivers/net/wireless/ath/ath9k/xmit.c           | 2 --
>   drivers/s390/crypto/pkey_base.c                 | 3 ---
>   fs/aio.c                                        | 6 ++----
>   fs/nfs/callback_proc.c                          | 2 --
>   fs/nfs/nfs4state.c                              | 2 --
>   fs/nfs/pnfs.c                                   | 9 ---------
>   fs/nfs/pnfs_dev.c                               | 4 ----
>   ipc/msg.c                                       | 1 -
>   ipc/sem.c                                       | 1 -
>   ipc/shm.c                                       | 1 -
>   ipc/util.c                                      | 2 --
>   kernel/cgroup/cgroup.c                          | 2 --
>   kernel/cgroup/cpuset.c                          | 6 ------
>   kernel/cgroup/debug.c                           | 4 ----
>   net/mac80211/cfg.c                              | 2 --
>   net/mac80211/debugfs.c                          | 2 --
>   net/mac80211/debugfs_netdev.c                   | 2 --
>   net/mac80211/debugfs_sta.c                      | 2 --
>   net/mac80211/sta_info.c                         | 2 --
>   net/ncsi/ncsi-manage.c                          | 2 --
>   security/yama/yama_lsm.c                        | 4 ----
>   25 files changed, 2 insertions(+), 73 deletions(-)
>
  ...
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 27adb04df675..9b7e8e8e9411 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4073,7 +4073,6 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>   	struct cpuset *cs;
>   
>   	spin_lock_irqsave(&callback_lock, flags);
> -	rcu_read_lock();
>   
>   	cs = task_cs(tsk);
>   	if (cs != &top_cpuset)
> @@ -4095,7 +4094,6 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>   			cpumask_copy(pmask, possible_mask);
>   	}
>   
> -	rcu_read_unlock();
>   	spin_unlock_irqrestore(&callback_lock, flags);
>   }
>   
> @@ -4168,9 +4166,7 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&callback_lock, flags);
> -	rcu_read_lock();
>   	guarantee_online_mems(task_cs(tsk), &mask);
> -	rcu_read_unlock();
>   	spin_unlock_irqrestore(&callback_lock, flags);
>   
>   	return mask;
> @@ -4265,10 +4261,8 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>   	/* Not hardwall and node outside mems_allowed: scan up cpusets */
>   	spin_lock_irqsave(&callback_lock, flags);
>   
> -	rcu_read_lock();
>   	cs = nearest_hardwall_ancestor(task_cs(current));
>   	allowed = node_isset(node, cs->mems_allowed);
> -	rcu_read_unlock();
>   
>   	spin_unlock_irqrestore(&callback_lock, flags);
>   	return allowed;

For cpuset,

Acked-by: Waiman Long <longman@redhat.com>

