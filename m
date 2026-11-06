Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793928167;
	b=XyjyDSOtCMtsfW/a02nZ91RICrQ05oPPtf3L0Sp1Ya+mswu/XpNoKMwr129Hj2jhU5mY
	 gnFplZNjHDWIfkoOFwBS7antikGx1iN4rfFjcouLLje/xlbTYKlX3oiOIzyY6NreaM3Jd
	 P+H3tn4kAiauiEDwocMtPPnd7sNY+wRUtcTm0gzqILi/LL36eqCmaOgKEHHOCT41GXoPN
	 qYcGRjIJRlzn9b8hX7schRHf67V3aw9ygFVXrHILFBNqt+rBOIfjZtIN8XJpbuYPBzmd1
	 n+Z95o/cnnsvU/LEbGNLfVD+WBeFEytz6TLNP8PAeh9CywLQaRCxP99eFxvRFcvaTZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793928167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
	b=Y9g2riUyyMJ/wdZQ6jjOJQPwIJCxhZ1wf50sOFpjN191aubRC65Uia2si/3TH+q54I3n
	 57Ki21nOVANoUJCkMSFRYjng992as/P73Vu2KXRQjqB+5zxH1mXH8jxhUgnwgy5dKfFzX
	 jWYKJNKf+WTMLULKQuzyhHYnL9m33lfrLNQqr1aBtBsfULD2mjmRmctKjU4NiRSlZbanU
	 lo4nkdHf78sniQL+jtduE+d9yJeg5y1sdq6nRbApIPILhHEIFc2Zc9aBy1oigXRkXRvlB
	 KDTFlhml/HVfKBhTTC5SXKoQj81jXNKBhNn6KKiy2RaYQJQojT/Nm3B0U/90nHhh+9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BXgsLCA5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440FD606A329
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 01:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 440FD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BXgsLCA5
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b271e573adso38516b3a.2
        for <linux-security-module@vger.kernel.org>; Thu, 05 Nov 2026 17:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793928166; cv=none;
        d=google.com; s=arc-20260327;
        b=CH4ekdpgOJ2FfwYcI6YPWmA0rhHMXzsWj28SOVpVyEMV3GkeWvR33Dax2MfcUH2kGj
         GV56CnrtmBJpvkPCWiniDxANGmwmQ+WL9dkkLPBrHclS7CBLHkO4fLOZW1CTaPY9Zt5d
         q/S18rmI/Fmp0DJwYI7TfVR1VEctlYpLXmAwYEe8CJnOcjTHAseJ94WSz6y/2ry2kQIW
         G6AEo05SGkWSr4amuKE0duexk6fJ+e4b7tV+mejNC0msFmPEKvJrTZyUErAtkCc9Q5DB
         Ja3z8TRYStC/iueif1WfvMZ2hATIAm0wVP+Qh1WvhwoR5A/GT9eAESFt2n7XvTXgre0P
         AtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        fh=UGYBIIywlo0Dh+bVx8GK6Nxrsjsl7UdWEdBmktiI+rg=;
        b=DxLVR9ELeyIgZROS4tZLJ9zryGVfQiAp4KsWmP3WZilFwS7wQOGVXPfWkvHC/QxTi/
         W+v9b7uolZSPHqWo/mRAXjVfE32VFCJnB7p7SoAz4p5chacXInB9GREyAIDnLQYaZlD0
         vfdgvJiC4khPFUXXSpDPXvI61FLN75nTC2u7ZSsV2j/sCK+rHC18dw8UzpCu5LGf18qB
         FH1jSnLWvo0pAJCvh5LIZoc3ifcvHpWn0HD0HtDduxAco1yd974PSZAJwIAatFxiDOke
         cLyBl3OhOMWTOeQHkrO/4rqFnmZmxRf1ogiOKYxmrqbWFdvguYpYittl9VnACinBuuaJ
         xnkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793928166; x=1794532966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=BXgsLCA51X5/W48GvZrpBezpY+stGa03fvEbUi2MV56MnNmF4a2PjDTUVnBg0Dwtqe
         Pc0pFbbkVSP0pF2lMOwQEWZuhIoVpWFLaZww3T/CDXUanEMozEFBbg5xukYGZHM3dK7Z
         /fQ7M+BmNkKN//ilq5bRiwTE5y+M3XE5NT96+Mb4FuQk23KwrKKCtl+UAKDpUXGzEGJV
         USSryhSewq0S2ePnFYtulTY16RPJSyBaU+5La6UtGtX/D/3Czi9oUOP9+hhoTJe/0ETl
         gYSYGkR59nTYA3bP+5Nf3SMG0P++deg+hHNjH+z7C7raNaTFT7WIIduRah7XGk96iqIB
         wcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793928166; x=1794532966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=H+7ymWmEZ/o62fZrLWzW3xLawMCrYwouICKeKkY3PE1VBd44EXj4mXYhWdXtxUsNA4
         kvzY9V+POGxNk7mr8hh/6RHhCvbvTSr6SOA8WcESvQ/jnQ+fW4lm0+4/QGv+wwlwrUjR
         WxpzoCzSvzuNnCluOXDPNH+uZEC+1837ksFvxIZTnEes2lPlEFpwIis5Eu1wkjD3b3/G
         lCXiGggPvgAtICJknSJITDMYSGVJOplDPjl34/cjymr9TLEj+hh9RJuxLVLovn9phbKo
         XCfTABXAjPYKNJC4pSKHQVx0e2n1wvLr0ZPTO713F72HCcd5WZ97hWf0EdvEvyfT80od
         rxOA==
X-Forwarded-Encrypted: i=1; AKwUvBznXNXLvNwDSpawqwF8v03/KnUM+HedPdvioYGQXOT2uCBLW7ylKla5IFOGssd2L2dmTs3od3buPH/7+gcu+gs3OJT+ooo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+IT4ojS73ZfIkURCzMrwHQke8idW7OJzRZJQUBms2GDi4sb4j
	PbZDfPYjz7Cu+hDBD5CiaaLfnA8X6EdZmrbTlsP6r2bv4I7pfiqYa9U3IOhG4LWee5xGm3EBWG3
	/lqEiGjLqqrZVOQgo1it35bRSN6ivPq8vu6kKIUlb
X-Gm-Gg: AYBFou1a+XeNDGDiStVt1cE1x8a+bpCiND2vVRn0dmk/++LvImBb4V4GVShzm+7U/Gv
	/AzYFdVBgiVU72YKuWHFQNEqht8CTw+UtNIEtmlkgQBs1uRqz73wZRv9O5YHQEDfZwK2n9voiT3
	ZUVvntfkujs7cebYpNP2+KwPirt9BE7uTTGzegz+nVTHsX3QYTe2GH8cnqJnEVRW8H3FHakRQ1f
	XiTydRlpDahbX8kgzbKMlX4BNsNMefHPFfdb4L9x8Cg61QHMhZ6MpCHrdQ7k+sC1Y7IX0/7xhC3
	XEbvW6n9hWmwZOb9Il7Yw7ezUJ218Imi8R2gmqeJYIhBdYz14j7HH+M/ACfctAS6G3hUofUXVsx
	lQQgaclTqz+PsgbPl6ng9oeWQrxmpL/r0uMXJAqPQ5e3pwzUmmK/FTc4iVS9UlFptWu7/
X-Received: by 2002:a05:6a00:4f82:b0:87d:e8a0:2389 with SMTP id
 d2e1a72fcca58-8b37b37d233mr903874b3a.21.1793928166471; Thu, 05 Nov 2026
 17:22:46 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org> <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 20:22:34 -0500
X-Gm-Features: AclHuK_C6UmASiuiBuBvumlcrlzJEUCTa0-vZyEfxhlZIjAFaCskKj-ONE1360g
Message-ID: <CAHC9VhRDVz4M-m_4UZZDKMgs4uc+j-+-jwYEdBDfSD0rtd-1Og@mail.gmail.com>
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes <rientjes@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
> >
> > Replace use of the legacy vm_flags_t flags with vma_flags_t values in t=
he
> > mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  security/apparmor/lsm.c           |  2 +-
> >  security/integrity/ima/ima_main.c |  2 +-
> >  security/ipe/hooks.c              |  2 +-
> >  security/selinux/hooks.c          | 14 +++++++-------
> >  4 files changed, 10 insertions(+), 10 deletions(-)
>
> Similar to the other patchset you just posted, is there any reason why
> individual subsystem maintainers can't pick these patches up, or is
> there some reason I'm missing and they need to go through a single
> tree?
>
> If they can go through multiple trees, can you split this patch up?
> AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
> different groups/people.

Since there seems to be a desire to bypass normal procedure in favor
of speed (surely that will never backfire), the SELinux changes look
fine to me, but please do wait to hear from the AppArmor, IMA, and IPE
maintainers before merging this patch.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
