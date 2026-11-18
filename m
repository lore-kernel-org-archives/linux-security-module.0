Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009125;
	b=S3R/j77uBT5FkZCWTWjx8+Now7nvUnYFNG6BjDmb5tBzz5HD5S2zkLRanvEp2bDyXPWe
	 mqlDYiuiciDy1QSWP5fcWdYKXP5Ez2zOUW9NQuMr2nOZMW5dfcz3Ngf5srcY+znr/uCN+
	 VbTR0fcV+6NTY5/+HwviM706ngk6WrI+rUFUHXnS3lzUgPadlJcp+ro67VW0EqOrxzkYv
	 /ppo5EpguSjK/DS8O3ZuJz6XSLkcdyto5pqJrLkueC48qC0mrqQrWQJ4K6f+LewtHjj2v
	 o5zcM1pUUxD7xBeY2zUUJxzjf+ATp265pl+50J4x1ZHozR5VU5DH8Sw+Chub+RpWwPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009125;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=h50xYCZDbBstrT/18dKKndyJ3XtJH6sY5/J/QnXGpDQ=;
	b=V2w6O2W7FoEKMXUOf7mPbvHmOK11OxuRXF5IpVkW0EKrgDtX0EvVXQVEsXSydNy9tYri
	 2DNREttJddT/juL8zwqZ/jr1eGVvaixZtn3fmViYbBB6FEgH20nEmqw9TsIDQtzN/nRZ5
	 xlrAbYgRpzEfs5Omgi4b4MDCGs5aKtULRQ/3ae8zvxriCVcl3yeOs4pezMRtc2sjLFzQS
	 qtxTy2DgBhinpdcwoU5ijokjrUjaRRMC4X2YfzxCueFGeVFzfZZdqEp0KWjSPoSs8GR60
	 hUtibmcknQj7Zl05x1nt1iU9TuBlq1gL0i3dc6xr62iMcpXssTKCxZLzFRFNBnOwO3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fe12Lp1Z;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F5606A331
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 13:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D50F5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fe12Lp1Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795009122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h50xYCZDbBstrT/18dKKndyJ3XtJH6sY5/J/QnXGpDQ=;
	b=fe12Lp1Zrc3jZjKIO/xQJhFxwIRVd/dPqKU5wEIms0tzzRBR8II5lPrHI28IhHdKFK2DU8
	98he96vFnC9Y39yJxeyEhFMnh9ta9GBDAnaJi0ci9FiYJ7s9hYxsXE0FybpETdd3R54uDT
	8JuqUvCNuZf+kVRCHqOTf45HmsJgP38=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-44Z-SUIkPZOumc6RsqK7cA-1; Wed, 18 Nov 2026 08:38:41 -0500
X-MC-Unique: 44Z-SUIkPZOumc6RsqK7cA-1
X-Mimecast-MFC-AGG-ID: 44Z-SUIkPZOumc6RsqK7cA_1795009121
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b18c67095dso13268767b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009121; x=1795613921;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h50xYCZDbBstrT/18dKKndyJ3XtJH6sY5/J/QnXGpDQ=;
        b=uxfar8nIjVGv8KOWwJuZhkp70o03DVrmCmtFKY+w6ePvVKSC/C5N6BR1182LK1aBLy
         adhsbCVyBPRUj7pD1CiytPEcWBcuPRAwocpPdROANG5jR3uXtPntgeayMwONUbEnca3t
         FoFPW+7a+EtyYPz5Xs6+MHej+ySZmAOrjcvaqunDUZ9+RMsUySO6dcg8WseDF0f8eTZh
         yZgdtp92zxnaHgAdfNjFdLHlEPihvOFztQs5ZT2mWrHuxrRi3efSeULoDKcnXuWSmW3B
         1ptHnr0QJvm9mMVjtdvnPl/3kPu/5bTN+KhynD+p6YdW8yveL2EnbZVZrM/gSnAGEyig
         oJpw==
X-Forwarded-Encrypted: i=1; AL+hErFhI6bKcve4PcCMP1yJByLjfj5LXyzMk3ag5ZDw3P7LH1SIcQnarF0/ZrW++t8TyUULZiukP6ZpvF87d5jtVx5y5YN03q8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mc3p+4ciGU2FPez5OOJlqNUXnpXK9XHRIivup2enxyZW4n2HC
	dl63DitjfiIsfOVgUgOEf0+SwEo+JYE1EWVUpMMeOEP090oYpaGEtyHjR4oYbfxeu9h5yE2Sw0q
	XoimjjIJHOjagnrBuhzJ9edQW6McJQV0zbKFwJ3126IQSwO8G5Z8BE0rq+Obgf8kyEpOlSRrsNu
	fkJDBEyE4jsjsm/Iy0DzTKoNBg2D0/u4WxTUJMYpsmx0aedRl2HCfp
X-Gm-Gg: AZFdTZf2jdOMhe6StHmxGX+bsMNgFSWNh2wv8IJuZcdEq3byH+SaITX+G1qW9jfVrme
	W8a1tPG+fiXwDfu21VqBmbfX1NBpCbNBfVZbn/aLm9RwLuipbJFrHlD1N52u0N7PtwdfZLdH8Rd
	Z5MGnY8/jLaKkS4HjHnqp6aguIEt9lF37ILt85a4QUllKgGl1OPeHglIpP
X-Received: by 2002:a05:690c:368a:b0:873:5bb2:6bfd with SMTP id 00721157ae682-8b4fed83351mr10018307b3.39.1795009120759;
        Wed, 18 Nov 2026 05:38:40 -0800 (PST)
X-Received: by 2002:a05:690c:368a:b0:873:5bb2:6bfd with SMTP id
 00721157ae682-8b4fed83351mr10017817b3.39.1795009119849; Wed, 18 Nov 2026
 05:38:39 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
 <4356992ac4fb7876fb5759189ba4b492@paul-moore.com>
In-Reply-To: <4356992ac4fb7876fb5759189ba4b492@paul-moore.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 18 Nov 2026 14:38:28 +0100
X-Gm-Features: Aa3M54php6hihR6Ihi3l34Ri9nQdKaLYB3Ss2kJeRmi5f3v9ab0vBjDa0q2nnvI
Message-ID: <CADSE00JyTwrbNh4r8PZWLqOHWpepyHkaL+9fkc+AbVRmCc-f-g@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] memcg: dma-buf cgroup accounting and charge transfer
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
X-Mimecast-MFC-PROC-ID: vZTkxprCF_ZiIOJ6gvsqWTAHMW6c_TpuHO9sv8HCakA_1795009121
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 11:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Nov 17, 2026 Albert Esteve <aesteve@redhat.com> wrote:
> >
> > Shared-memory allocator services (e.g., Android's gralloc)
> > allocate dma-bufs on behalf of client processes in different
> > cgroups. Today those allocations are charged to the allocator's
> > own cgroup, leaving client cgroups with no visibility into their
> > actual memory consumption and defeating resource limits.
> >
> > This series adds memory cgroup accounting for dma-buf allocations,
> > building on T.J. Mercier's earlier series [1] and incorporating
> > feedback from previous versions and LPC discussions [2].
> >
> > Patch 1 introduces the MEMCG_DMABUF stat and the
> > obj_cgroup_reserve_dmabuf()/obj_cgroup_cancel_dmabuf() and
> > mem_cgroup_commit_dmabuf()/mem_cgroup_uncharge_dmabuf() helpers
> > in mm/memcontrol.c
> >
> > Patch 2 wires up the charging policy: dma_buf_export() stores
> > exp_info.objcg and updates the stat, a new charge_fd field in
> > DMA_HEAP_IOCTL_ALLOC accepts a pidfd or cgroupfd to identify
> > the target cgroup, and __GFP_ACCOUNT is removed from system-heap
> > allocations to avoid double counting.
> >
> > Patch 3 adds DMA_BUF_IOCTL_XFER_CHARGE, a general ioctl on any
> > dma-buf fd to transfer charges post-allocation. This covers the
> > double-hop allocator case (SurfaceFlinger -> gralloc -> kernel)
> > and works for buffers from any exporter that opts in. Charging
> > is gated by dmabuf->objcg being set at export time, ensuring that
> > transfer is only applied for buffers backed by system memory where
> > size reflects actual bytes. If the receiving cgroup lacks capacity
> > for the charge, the ioctl returns -ENOMEM and the original charge
> > is preserved.
> >
> > Patches 4-7 add access control for cross-cgroup charging. Letting
> > userspace decide who to charge needs to be a privileged operation
> > because it has material impact on OOM decision and resource limits.
> > Charging outside the caller's own memcg subtree requires
> > CAP_SYS_RESOURCE. On top of that, LSM hooks gate the two charge_fd
> > flavours: security_memcg_charge_task() gates the pidfd path (target
> > identified by task credentials) and security_memcg_charge_cgroup()
> > gates the cgroupfd path (target identified by cgroup directory label),
> > with SELinux implementations using process2:charge_to and
> > cgroup:charge_to permissions.
>
> I'm probably misunderstanding the description here, but in both cases
> (the pidfd or cgroupfd case), ultimately the cgroup is charged, yes?  In
> the cgroupfd case it is more direct, but in the pidfd case it is still
> the cgroup associated with the process identified by pidfd, yes?

Your understanding is correct here.

>
> If that's the case - and it very well may not be (!) - it probably makes
> more sense to combine the two SELinux access controls into one.  Yes, the
> LSM hooks and callbacks would likely need to be different due to the
> mechanics of it, but the permission check "cgroup/charge" could be the
> same.

Combining SELinux access controls makes sense to me. I kept them split
because I wanted to preserve granularity between the two flavours, and
process2 seemed like a natural fit for the pidfd path, but I guess it
can still be achieved with a single permission through the target
types.

I'll rework for v6. So, in the pidfd case the check target would
remain the process's domain:

   allow allocator_t client_t:cgroup charge_to;

where allocator_t is the domain requesting the charge (i.e., the
central allocator), and client_t is the domain of the process the
pidfd refers to. The groupfd path would check the cgroup directory
label like so:

  allow allocator_t cgroup_t:cgroup charge_to;

Would that be ok?

>
> > Patch 8 adds selftests. The tests and vmtest script were mostly
> > written by an LLM, closely following the style of the surrounding
> > tests and the virtme-ng setup. All code has been reviewed and tested.
>
> I think we need to have selinux-testsuite tests to go along with
> this, especially as this would be the first patchset to add cgroup
> controls.  Historically I've pushed back on piecemeal cgroup additions,
> pushing for some basic design of how to manage access controls for
> resource management first, but since evidently no one wants to do that,
> we really do need tests.
>
> https://github.com/SELinuxProject/selinux-testsuite

Agreed! I was already playing with it between the last version and
this one. I have some tests drafted, more or less. I was unfamiliar
with the testsuite, so instead of offloading the work to an LLM, I
tried to follow along and proceeded too slowly.

I will link a PR when sending the next version.

>
> > Known limitations:
> >
> > - Single-owner model: a dma-buf carries one memcg charge regardless
> >   of how many processes share it.
>
> Once again, I'm sure I'm misunderstanding things, but are you saying
> that multiple cgroups can end up sharing the same dma-buf despite
> only one of the cgroups taking the accounting hit?

Yes, you are correct. A dma-buf (its fd) can be shared by multiple
processes from multiple cgroups, but only one holds the charge. With
this series it can be transferred, but never shared.

Sharing could be a follow-up series. Perhaps splitting the charge
equally? But sharing is a big problem on its own, so I preferred to
keep it out of this series.

>
> Hopefully the charged cgroup is deterministic?

Yes, the charged cgroup is deterministic: it is set at allocation, and
only moves via an explicit ioctl.

>
> > - Only memcg accounting. CMA heaps would additionally need dmem
> >   controller integration.
>
> Do you have a rough idea of how that would work?  I ask only because I'm
> interested in seeing if that would require an additional LSM hook or if
> there is some way we could leverage the same hook(s) used here.

Rough idea, yes. Today, no dma-buf allocation charges dmem at all, and
of course no target charging either. The first goal for CMA is simply
getting those heaps accounted. In that regard, Eric Chanudet has a
series making CMA allocations memcg-accountable with per-area counter
[1], and is working on extending that approach to dmem. It's a bit on
hold waiting for the feedback on this series.

But afaik the cross-cgroup charging and central allocator problem is
mainly a system-memory one. Whether dmem ever needs the same
cross-cgroup attribution (e.g., DRM central allocator wanting to
charge clients' dmem budgets) is not clear to me.

Nonetheless, if it does, the internals should be mostly the same;
everything, including the permission checks is controller-agnostic.
Only the controller performing the charge changes. I expect no
additional hook is required.

[1] https://lore.kernel.org/all/20260821-cma-memcg-regions-v1-0-d21b165b844=
0@redhat.com/

>
> > - If a transfer of an uncharged buffer fails, the buffer remains
> >   charged to the original cgroup. The allocator (userspace) is
> >   expected to handle this (retry, free, ...).
> > - The LSM hooks are intentionally narrow. Broader cgroup access control=
s
> >   (e.g. for the memfd/kexec handover case [2]) could be a separate effo=
rt
> >   reusing the same pattern.
> > - Only system heap sets exp_info.objcg today. Other exporters
> >   (DRM, V4L2, etc.) can opt in by setting it, but are not
> >   covered by this series.
> > - Related to the above: lazy backing-store allocation is not supported.
> >   This can be extended later, e.g., by adding a flag on the dma-buf
> >   struct for explicitly marking when memory is committed.
>
> Similar to the CMA case, any rough ideas on what this would look like?

Yes, again I have a rough idea. We already separate reserve and commit
operations, so the idea is to delay when a charge is committed. For
that we can use a flag in the dma-buf struct to mark when the memory
is committed. The limit is still enforced up front (so a lazy exporter
cannot overcommit), and the stat reflects the actual allocation.

The permission model is also unchanged for this case. The flag only
affects when the stat will reflect the charge.

Thanks!
Albert.

>
> > Note on TTM/GPU accounting [3]: that effort charges system memory
> > allocated for GPU buffers per page, with its own stats (gpu_active
> > and gpu_reclaim). This series charges at the dma-buf level, for
> > memory with no memory.stat category of its own; exporters whose
> > memory is already charged by their allocator must not opt in, so
> > the two do not overlap.
> >
> > [1] https://lore.kernel.org/cgroups/20230109213809.418135-1-tjmercier@g=
oogle.com/
> > [2] https://lpc.events/event/20/contributions/2416/
> > [3] https://lore.kernel.org/all/20260706052330.1110909-1-airlied@gmail.=
com/
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>
> --
> paul-moore.com
>

