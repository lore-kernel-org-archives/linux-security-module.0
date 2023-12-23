Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3F48BE5
	for <linux-security-module@vger.kernel.org>; Sat, 23 Dec 2023 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hb55O7vR"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbdd013c68bso1601448276.2
        for <linux-security-module@vger.kernel.org>; Fri, 22 Dec 2023 16:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703290613; x=1703895413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/besZVLQzMROX7KooUJ8sVZ5ZrqGy2MV58aazQPqc2k=;
        b=Hb55O7vRt1n/eb0jOmxu45QTLo5BalNNve6mPoV3LxM4laj4CXpNnrTduVrl/hKox4
         Hte6lVXmmAgc/EnoS4Kixb5IInoNQhQsiLeCfIA3ptL7BkT6sScKWAKwpcu/7rIH1+om
         ct/vLhZicOygAZ9H/w0b0zi6O4Fkuvx9DEvHv32voA0h2JUiAPJncjlfWXAgtKfsMdis
         yfXjZupBwDiQKZrhstodYxsOwLPDepc6yshAPh2GYLDPXHA1qkhFrr7nBTJGFKjUbNmV
         MRVTyif2Rdi/U/XOjmIvyEHO3VYf2xw6B8fFfyssw5dhrGuf59SqIVVp3dhkttxbsbl4
         TFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703290613; x=1703895413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/besZVLQzMROX7KooUJ8sVZ5ZrqGy2MV58aazQPqc2k=;
        b=cGpN2loRfWdeY+FIblGcUNY/b4DQgpbbdoRxu97NkKUFA+0u8YPQxoM5yrzJqetov5
         5Qb6g8U/1Mhk3ohAtm31hUSMIMctPoeMKqzF+aXi/RZ5JtkTW+7em8Qx3BGoF7qLcUhp
         GFzr8GjKcoL+17Z7dQKJEzDfLGv2OeIK4tZ9KuNXozR21H+TljinkaYJhmL9aHqTSMb2
         Cr5zeqamIfMQe5Nw3CpWLagId841X32aEwyLcWBYZp4MGcGxGn3iIQK22cIfR+yhqeNI
         J5YN+4jAcvA4gfjmwB/PnyyvInFqULt5NKJd/T4kaXqERhWV8pRbxZ7wVHPz4FdLxcXW
         jAbQ==
X-Gm-Message-State: AOJu0YyT34QBbtYP4NtaJnmI/w/K5BTYZFGziGto0ZTPPzfjn6yRN94b
	RANygnxQ7RzwkGXUuUe34CFZtYY6Kr+I2jQrc6+HKQWKwCnh
X-Google-Smtp-Source: AGHT+IFtFWTTBJwAWvg/R0L/LFCTPZMk9JdCLjGWegtqmDLOod4jBJr7AZY8F7veqYwFKec4YDsKigBo7Ux3x/p10uA=
X-Received: by 2002:a5b:b12:0:b0:db7:dacf:620e with SMTP id
 z18-20020a5b0b12000000b00db7dacf620emr1679377ybp.96.1703290613247; Fri, 22
 Dec 2023 16:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125033.4158-1-laoar.shao@gmail.com>
In-Reply-To: <20231214125033.4158-1-laoar.shao@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 22 Dec 2023 19:16:42 -0500
Message-ID: <CAHC9VhTs_5-SFq2M+w4SE7gMd3cHXP2P3y71O4H_q7XGUtvVUg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/5] mm, security, bpf: Fine-grained control
 over memory policy adjustments with lsm bpf
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, jmorris@namei.org, serge@hallyn.com, 
	omosnace@redhat.com, casey@schaufler-ca.com, kpsingh@kernel.org, 
	mhocko@suse.com, ying.huang@intel.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 7:51=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In our containerized environment, we've identified unexpected OOM events
> where the OOM-killer terminates tasks despite having ample free memory.
> This anomaly is traced back to tasks within a container using mbind(2) to
> bind memory to a specific NUMA node. When the allocated memory on this no=
de
> is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
> indiscriminately kills tasks.
>
> The Challenge
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In a containerized environment, independent memory binding by a user can
> lead to unexpected system issues or disrupt tasks being run by other user=
s
> on the same server. If a user genuinely requires memory binding, we will
> allocate dedicated servers to them by leveraging kubelet deployment.
>
> Currently, users possess the ability to autonomously bind their memory to
> specific nodes without explicit agreement or authorization from our end.
> It's imperative that we establish a method to prevent this behavior.
>
> Proposed Solution
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - Capability
>   Currently, any task can perform MPOL_BIND without specific capabilities=
.
>   Enforcing CAP_SYS_RESOURCE or CAP_SYS_NICE could be an option, but this
>   may have unintended consequences. Capabilities, being broad, might gran=
t
>   unnecessary privileges. We should explore alternatives to prevent
>   unexpected side effects.
>
> - LSM
>   Introduce LSM hooks for syscalls such as mbind(2) and set_mempolicy(2)
>   to disable MPOL_BIND. This approach is more flexibility and allows for
>   fine-grained control without unintended consequences. A sample LSM BPF
>   program is included, demonstrating practical implementation in a
>   production environment.
>
> - seccomp
>   seccomp is relatively heavyweight, making it less suitable for
>   enabling in our production environment:
>   - Both kubelet and containers need adaptation to support it.
>   - Dynamically altering security policies for individual containers
>     without interrupting their operations isn't straightforward.
>
> Future Considerations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In addition, there's room for enhancement in the OOM-killer for cases
> involving CONSTRAINT_MEMORY_POLICY. It would be more beneficial to
> prioritize selecting a victim that has allocated memory on the same NUMA
> node. My exploration on the lore led me to a proposal[0] related to this
> matter, although consensus seems elusive at this point. Nevertheless,
> delving into this specific topic is beyond the scope of the current
> patchset.
>
> [0]. https://lore.kernel.org/lkml/20220512044634.63586-1-ligang.bdlg@byte=
dance.com/
>
> Changes:
> - v4 -> v5:
>   - Revise the commit log in patch #5. (KP)
> - v3 -> v4: https://lwn.net/Articles/954126/
>   - Drop the changes around security_task_movememory (Serge)
> - RCC v2 -> v3: https://lwn.net/Articles/953526/
>   - Add MPOL_F_NUMA_BALANCING man-page (Ying)
>   - Fix bpf selftests error reported by bot+bpf-ci
> - RFC v1 -> RFC v2: https://lwn.net/Articles/952339/
>   - Refine the commit log to avoid misleading
>   - Use one common lsm hook instead and add comment for it
>   - Add selinux implementation
>   - Other improments in mempolicy
> - RFC v1: https://lwn.net/Articles/951188/
>
> Yafang Shao (5):
>   mm, doc: Add doc for MPOL_F_NUMA_BALANCING
>   mm: mempolicy: Revise comment regarding mempolicy mode flags
>   mm, security: Add lsm hook for memory policy adjustment
>   security: selinux: Implement set_mempolicy hook
>   selftests/bpf: Add selftests for set_mempolicy with a lsm prog
>
>  .../admin-guide/mm/numa_memory_policy.rst          | 27 +++++++
>  include/linux/lsm_hook_defs.h                      |  3 +
>  include/linux/security.h                           |  9 +++
>  include/uapi/linux/mempolicy.h                     |  2 +-
>  mm/mempolicy.c                                     |  8 +++
>  security/security.c                                | 13 ++++
>  security/selinux/hooks.c                           |  8 +++
>  security/selinux/include/classmap.h                |  2 +-
>  .../selftests/bpf/prog_tests/set_mempolicy.c       | 84 ++++++++++++++++=
++++++
>  .../selftests/bpf/progs/test_set_mempolicy.c       | 28 ++++++++
>  10 files changed, 182 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/set_mempolicy.=
c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_set_mempolicy.=
c

In your original patchset there was a lot of good discussion about
ways to solve, or mitigate, this problem using existing mechanisms;
while you disputed many (all?) of those suggestions, I felt that they
still had merit over your objections.   I also don't believe the
SELinux implementation of the set_mempolicy hook fits with the
existing SELinux philosophy of access control via type enforcement;
outside of some checks on executable memory and low memory ranges,
SELinux doesn't currently enforce policy on memory ranges like this,
SELinux focuses more on tasks being able to access data/resources on
the system.

My current opinion is that you should pursue some of the mitigations
that have already been mentioned, including seccomp and/or a better
NUMA workload configuration.  I would also encourage you to pursue the
OOM improvement you briefly described.  All of those seem like better
options than this new LSM/SELinux hook.

--=20
paul-moore.com
