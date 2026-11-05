Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.216.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793920680;
	b=eUrzoM2LynUlmR7fOfEQ3W6EMlpuGhrYeijfCbLXGrdu1mMHzv8gROAww+HBXWv8tHXj
	 JCrVITx/QY31G1wg/Z9jDAQa8no6afpo3TZ31K3o6U1mANUrJtFk3hI/sG++X8oIwCOQ1
	 vp91pvG86S1gVuJvFkSHchCWoMR4+s78WU7wlYTmI7y4uXbLw4FXIO5cy3Kcd/aAxiMJj
	 wr9ZE5Jnh9KWlqMDE7eQWhR4LlYuhqKOnjeVacUSLoM5GY6A7zmHNKkO9nwiwHM5KzgbF
	 6aAdbyfBj0YuV6E5GoHIZKfv9gCYQ5Beq03cywz5uMqXYDkM6OdzlgOilKMwYGXvBRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
	b=DldHfnsSa2V3dJ+L0g8gH51Y0irRhYvD4rpPzM9/PzPenFzjDP+9XGMq23nItihqFwQI
	 LXNY2x3vEa/eXW8Cm8aGUkSdDnzqfxBT3Y3D7dvYguqCjaONpFc8sENcz805AO3OgJXLv
	 OfB4Lg7l5p69XYTPVpgEcw4vu0eVYukv67KsZNW9mc/eIz1wdo7KiXMBGCkPybrKgE+LO
	 zITgE8G2ybLInIGzizKEIgDKKpxJFKn3i9g/4sflnWhfK+qs+SW8U/ZJGUZNPLehZrzii
	 suw6IJmJmG8LXjVwjPHdc3AYlbxAPXzh/rs8FotHDbN/hY2XiojlU2h7MvfcxuvDq1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=F936vzKm;
	arc=fail smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11846606A32F
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 23:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11846606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=F936vzKm
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso31365a91.2
        for <linux-security-module@vger.kernel.org>; Thu, 05 Nov 2026 15:17:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920679; cv=none;
        d=google.com; s=arc-20260327;
        b=BiAW9yycljycKpQ8L1oYSIz1dBpwWk8PVZISzZbIYBEvePpHUE3c6mRTGu4lUpUAhu
         D2RyBmZZINURmWbXXlq2Y16AVvZRI1FUq/CvjJGRZXklRhfLDzjrAtKB7Cf3PsB9Trw4
         BCOI/bbcWQB0w6T0VUHTkcgE58HYHnlmRrYEmOA4pR21aQt8SDdpZfj1XVjsM8IwFaaN
         YqJx0ZSJlhYInltP5mod8zTCgmYrGVq7/7FFcs3q22COmlLRzxk9p3+ZhfRkep897/J8
         sQak0ndzfcSDtrQ/m4gpaXCmvrG0846dwHpByDpniP/5jgtZ/9On7A81pGnjZLgIL2of
         WUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        fh=wA0fKu29XYJoac6nnGnL828+LuKbmzdiKb9ylmAO8fs=;
        b=bwhk4uF002cpT7JKH1Kk619KbpgyFnE7uSH+B6v/gEzrlyb7hjb735Xw7eMOSTGqwq
         ltzPSyFo/BZaNWKgR78TkaWP5R8/fpYqHXb4hIRK+bCOTfyDEDVVfZjcZR3YRaj1x5d2
         NmpLHsGIXo465GI5F+cYmmrM5cYAEMwzpOsje0kXb9wjSWJ7jY2bLOvisdqKO7I1C3s/
         QIiK9C2B6BPRI9RGnFCQ8a+sEwrjN1pMhjjm2zXWLTPgZApj6UVaw81NFGH53LheWpbC
         Nk64yGLsFtGKudsUYdq5R6XmBtlnlapNhdkh9ypO13bWoaU0/3xAn3EfIHSK0A5j6sq7
         A33g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920679; x=1794525479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=F936vzKmZco1Rg9qiS2Cf7yXwnXt8dn1LQ3YxCN5SMsKSJRTlu37FG2JQnmiZ4tO3q
         ZY7C/eCqTECYbf79gAR8gp3oow9+Ykdrk78RZdAOFLnN4sIU8x8jDIiI/j4+tmIgfhgQ
         Kfc7/iulz45+20nMepsyi2DVKsca2I7vu/IOFa2DSNB+5NoNB+X3xZL+TnSEr5nUJW/0
         t+eWupnUof2Q+Z07m3XUdhgKdmPOk5SNXh4+R1i03zuB5eyYkN5hGGMTpwfL4P3jF/oi
         qjoVjwxKWuHtQbutc+EbzPaNTI2YVJHBnHBIs9egvV2qx2jXIUZICkPleteOCZKku3cJ
         ZAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920679; x=1794525479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=G5kBBby6nx54n4xbEThft2F+Rw6m+qHCpTEizW0bkmpR1M/h5Xj4Va86xtY9ePSOqA
         nnxoQULzDx6aipl4rqiSyM8GlLmPczezYAilm8G3mE/BUmmI8/cgKoQVe2ZK/M5058jt
         nuPFAzauChnPC4TQE9jqeAAEQiir1nvcVKIk0m6qrAPgb4r1OrvjVgPde9z78JLCxk2z
         /ZEYrSOLiswD4/T+exHEoBDqOOE5yBGiAqIY+LQTfQvQJLMM+l1fYPumbKSP00Xr+wk/
         QqGvri0PzEQvb6n8SlGFtrqbbggKsmJqwwcSyk0vxJQuDQ76PcV0XCY1YDW0HzM+EI3P
         AXHg==
X-Forwarded-Encrypted: i=1; AKwUvBxMaMvqINUsrAlJulsl3/sl9TIQZGmog/tsdLkHplmPUp3bGR3RHnk9PGo1C/yyYnU+Bo9yeWKbD6a5IWP4TSY0pXbND/g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Q0k+wfKdI4sD4oxR4vh3eHTsSEceTVfiBPsylP0fDknjNMRRj
	ww+lxqBGJ4Sm8amsj5mM434dj+zvTBksjBmX8GPy4ZHGAlDC3yk/H2TjrHGXzBlingR0Y4CSaEv
	X51jqkmrKvJdAU2lQZVP9dPIlvKxDHiQ0127jI1HZ
X-Gm-Gg: AYBFou0jYgG6m6fctARmN3LfjAsa5E1z1tgMqYdzyHAFnR4wgLsaMbRqvWWzxDqxcmR
	OGsf2b2xNT8IaGq909nK8A1NFQBfx8S87yChRmFNF/uqNGwXVk8wE/EJyhniksuEKPBmUznMFzS
	yTH3SZEOHUUL0e6MqnKVkma/cSJIGtH2yBhEDe1FhkbU1KODYL/SrABL543BFmnZH9el7ixYIbk
	c/fw+CEt2W3OjvQM1ZWuedKLHPaRgfaqkVQI0TRGEiXu0jdvYSnH0Q35z+e+yhk4dDWR1t1vS/0
	GvpyGHBrsa3SVzgAdbxf8d0ppdGUHQ9bX8uiNxqF7YYTO6Pd8bd2sSfW7cuMrrYssJyl0+LDGMf
	SG4cbCSmU4JBduRnUy0NIFbEKGhxsrYzzriyFHe5iYCP08x21+zWP+I3YtLQARFyjQsz4
X-Received: by 2002:a17:90b:1dcd:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3b0db703e39mr535625a91.34.1793920679319; Thu, 05 Nov 2026
 15:17:59 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:17:47 -0500
X-Gm-Features: AclHuK_gkg-Hspii6U5_01_jGLQO23B7F4YXuvzvsb53ImE19wnChR3DgLruv6g
Message-ID: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
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

On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/apparmor/lsm.c           |  2 +-
>  security/integrity/ima/ima_main.c |  2 +-
>  security/ipe/hooks.c              |  2 +-
>  security/selinux/hooks.c          | 14 +++++++-------
>  4 files changed, 10 insertions(+), 10 deletions(-)

Similar to the other patchset you just posted, is there any reason why
individual subsystem maintainers can't pick these patches up, or is
there some reason I'm missing and they need to go through a single
tree?

If they can go through multiple trees, can you split this patch up?
AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
different groups/people.

--=20
paul-moore.com
