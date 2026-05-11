Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E58382F07
	for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531309; cv=pass; b=a04KeVDYDi+P5BHCr2QAwzmzthuzm+m5UzlFH9pQTblQelzPgPyKNB3aUbLIC/2OoJ+7WSXe07cVRfQrODojWTWZyxfO/VVk0zRcKp+TofOi7kasCncsbt/1TzZrgNHtehA6UwLZA51eXg81FxjdrT983h9kolLW0z9CDjcR0yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531309; c=relaxed/simple;
	bh=hTbYoner07O2PP3jB6etyoj2SkkDIbMpdGA9ETgA8QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKLRC4zdj5w/27PbC06kxEC89bqYx5g6vz3wZ7zDnOODnKC6sye+1op72W9wug5iz/WPd1Y3tJJ4t3JsIuPDmWZ1n1+jolPy2vP8i2c1O3gw0WjekVKPuQa17hzCse+mWdNcRIP6yAuNwHl5EGvFbho1OEnp7eI7k94JKFhCTIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pqf2D/XX; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pqf2D/XX"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bd2087858c4so105271866b.0
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 13:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778531305; cv=none;
        d=google.com; s=arc-20240605;
        b=T9G3Fx0AVkOEhLkgrjTEeccPsP4/Kt2/a4Pxj6hl/gFmidtVDt7fnR7pAmGmVtZVl6
         zASCCehOgIc+olIDgf8tSrgFTt44HpGvfYZadlkOS9M/jjoPWFzV3GlFOEvcBNUcdpfQ
         FzlohMZBZsGI/G5TAW/olWKls7hVHhgAP6RzhDgHz5PYg7JgjTVb6mild7d2WEg6xJCE
         s/jTTaGbE9oXpTMT/254ekiWXf7NhUAq+jCT4zf2oYygL/74js77EK3w+JKF+pIsk25U
         EZAjUIaER3FiRUpeol5MqS6BXKcih+uS6PxgkR1STCXofVFrgMsZikYQbVg+vSLkk+At
         h1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ecxYhhOsIWnMbGYp6OiuSoqJt7k54RRM2T4m9yuOxg8=;
        fh=zWVPjelB58adS4m125mqvv2OHMnCPj9lFVv96QeEEQM=;
        b=edLQPp+9DZdZitCSYFMqJkXSEUaSDYgIgOP12tcniY2q/nU0Qb7vmiL3hK/R6HC4MQ
         QCXHJdD/C99Q093/21BaQIQSne5m/GkVHTLYLU9hOz7voRiY4icrQoiLpRVtID01ZQEo
         vP01hq3R7Jb0ULxCcGddd6VUUBfkTYS7A5wqTCYGJZ48S/H7cGqtLikHDVJdmDh40eHv
         6F7yMF9unsgpN0JrHf/XyGM7+nqgcrydooL6j0wmn/xTQ2Q0B5Zjxcxhest6moIVSCKs
         2+3N51vWxYaiZRx4PMNsCTYY0702VeLJZlk7SBmA1kEo/EimHPHFwQeu7X4D3g+tdqz1
         mF1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778531305; x=1779136105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecxYhhOsIWnMbGYp6OiuSoqJt7k54RRM2T4m9yuOxg8=;
        b=Pqf2D/XXkXoZWPZHQqMY9IBZsTPIzZc2s8hRWTLCIWWh/mCQNnoBCNusWpQOqSxv/M
         30btj8h0UrFnnMsiDnTkMr4mTshByweR1IFq8Cw7xpE5sbpgMjkfIWAIe6bmq2ud60M/
         lWdAm5DtQkIVu7LGk2lBHjld6eiUve2zjik9wv5Je1M48kL8miY1mC8QuCNlg0QUT9c4
         nSZfVBr2RZcJneAM++otv/6PpeB69KFfmV763eRrDzCDclvTtsgmy9FVK0C37xUfOBDB
         +8oxIhRLfsmOVYrtt2u1RAsjRCaJUQTwAW04tUyadp67+w3b8/KYFC5imeXFdAPE+sCl
         n2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778531305; x=1779136105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ecxYhhOsIWnMbGYp6OiuSoqJt7k54RRM2T4m9yuOxg8=;
        b=DX0sj6IoTrkzq0hvU/MzMFBiAHTa6/vkF1YRf9nfICUMokOL4XzYft4n0papC/aiEo
         +0qJAku1bRGovSnSiqJ5rkWoqdVuKua6fYV0ljAgBz+bG+4zdalzfKXHAXmGqpdLP6jx
         52kCH8ofHOsA336bptamEdDCbpzX13LYlrTOu90Ay20mTBVSYiQl4K8KuiSt4sEBtpAm
         /sTKnx/N3iOyJYQzFUUfqlRQA+gwBq6ooDIfVwgv2N9QMk6btqkNKo6TaSF30ganMZQU
         BsJrobZ0SpPBPhAZvv03UYH8XoT32n9BFRgDSzUR4oDRdYDsDq82IkxS20uAg3U6KCwY
         HRzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Bmg52HlGNpz4QeC2paOEvhrWpBXmC1bH8lY2HxCaR5/yTnKZSmXQWySgl0McFgD2TYhP7Mzh8rwFGXpFDl+AaI57S4I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbCkZrCCyQL6yfYzp0bTrHKc9vEjyR5a32woIiNmD5qH74Qjg8
	zoAQEXvv4l3GT3TxpwpS8tANtk2xxJy6wX5xeC1ZT/gOp85R2sWm2U7/TqonCnAfnW7tPk+8173
	y9F50EOy/6W1zWQPWcXBAErBKvCEJKsahpW1OWl9w
X-Gm-Gg: Acq92OGCfCrv8YuQpb1GhcAi0CwSkzPxhZpFr3G2kGRd1AzaIBPWl5BBG+60ezNUyU8
	D/ya8geZ1ewNnYJLYB/JA8P61j/71rT+ByuYcyPMJR6AdZc/lRHO6bUue+/o1qFjpVzn0G2afIf
	Mxmza0Iu70it6vdrBbp23ozIhvoh/sgGQYAmuNQIB37Cp+pZCATI6YiuFEor3euLXJhv3Cwn376
	PmdChao/AlqtcW4iaFWp/eozNrC5g1Jslc9Jp683Vo3M92hMokuem41g68JY7Xm5R9iNinPtA+q
	Irb/dHQCSdiLTHzSSA==
X-Received: by 2002:a17:907:782:b0:bba:5bc9:534a with SMTP id
 a640c23a62f3a-bcaac45410dmr950342666b.31.1778531304034; Mon, 11 May 2026
 13:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509213803.968464-1-atomlin@atomlin.com> <20260509213803.968464-4-atomlin@atomlin.com>
In-Reply-To: <20260509213803.968464-4-atomlin@atomlin.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 May 2026 16:28:09 -0400
X-Gm-Features: AVHnY4IuuqYYRw63FqWoEIYPWMqlZqNzlszYso7NSfFe-A6xx0Cnf7u9P8UUKq4
Message-ID: <CAHC9VhQthq7y2akbQSdJwBEex1MQYWG49wcJK3b8gSQuQ_d1cQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tsbogend@alpha.franken.de, jmorris@namei.org, serge@hallyn.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com, 
	casey@schaufler-ca.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, chenridong@huaweicloud.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, omosnace@redhat.com, kees@kernel.org, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, cgroups@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 5:38=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> w=
rote:
>
> At present, the task_setscheduler LSM hook provides security modules
> with the opportunity to mediate changes to a task's scheduling policy.
> However, when invoked via sched_setaffinity(), the hook lacks
> visibility into the actual CPU affinity mask being requested.
> Consequently, BPF-based security modules are entirely blind to the
> target CPUs and cannot make granular access control decisions based on
> spatial isolation.
>
> In modern multi-tenant and real-time environments, CPU isolation is a
> critical boundary. The inability to audit or restrict specific CPU
> pinning requests limits the effectiveness of eBPF-driven security
> policies, particularly when attempting to shield isolated or
> cryptographic cores from unprivileged or compromised tasks.
>
> This patch expands the security_task_setscheduler() hook signature to
> include a pointer to the requested cpumask. Because this is a shared
> hook used for multiple scheduling attribute changes, call sites that do
> not modify CPU affinity are updated to safely pass NULL.
> To protect against unverified dereferences, the parameter is annotated
> with __nullable in the LSM hook definition, ensuring the BPF verifier
> mandates explicit NULL checks for attached eBPF programs.
>
> This change updates all in-tree security modules (SELinux and Smack) to
> accommodate the new parameter mechanically, whilst providing BPF LSMs
> with the necessary context to enforce strict affinity policies.
>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  arch/mips/kernel/mips-mt-fpaff.c | 30 +++++++++++++++++-------------
>  fs/proc/base.c                   |  2 +-
>  include/linux/lsm_hook_defs.h    |  3 ++-
>  include/linux/security.h         | 11 +++++++----
>  kernel/cgroup/cpuset.c           |  4 ++--
>  kernel/sched/syscalls.c          |  4 ++--
>  security/commoncap.c             |  7 +++++--
>  security/security.c              | 11 ++++++-----
>  security/selinux/hooks.c         |  3 ++-
>  security/smack/smack_lsm.c       | 11 +++++++++--
>  10 files changed, 53 insertions(+), 33 deletions(-)

I haven't looked too closely at this patch yet, but based on a quick
glance, can you help me understand why it is included with the other
two patches in one patchset?  The other two patches look like stable
level kernel bug fixes, while this patch introduces functionality to
an existing LSM hook; one of these is not like the others :)

Unless there is something critical that I'm missing here, I would
suggest splitting this patch out from the other two bugfixes for
separate handling.  If there is a patch dependency issue you can
always mention that in the cover letter.

--=20
paul-moore.com
