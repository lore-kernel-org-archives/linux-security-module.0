Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342201;
	b=w6f4VYiD2NSRQEXdWgUCTq13PO50CfYbYOa0idi3C5zVfgkeZWJnCbRBPXWMsFi4ZRSS
	 8+B/XFnDRhjHpcuCgZe0MWlJdp0HQ5TA/FIJLRT3VQoaStCP9DVQtUEeCovRKQnchY7zD
	 TcTbJmWbJXRQHZmMHK1P4sCkApMSnEKpVaFyRbIzi1KoHtelHffTcXMiZtQJM69JJAZB+
	 JPFFXU7XXz9jVS2PlzOBRJBJ5+tAEPuAS0d2b+3i753QL8zNqIMKp/AwKeu7IucmwPxLU
	 yRlhhCpc/faB3FtOV/PBTTlLxSr0ihRbm4iGV93dDEopRjaffCBf8TuuGYU/cZCsgkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aNTBUVcEjSCanLMfEBKZfMTj70g+Fn7VorpJWkJr3sM=;
	b=0w1z8/xXg5aJJrAL9KjEr0jKFCjJLKclabR3PSOhmDpIkueBF4wQUXtDkofMUlRkv4V4
	 n4/CPzTZ12d+PeWxCr8T3PYj1h26ECZ3tJV9yNcmsxWuDGUIFV5npI1FI9BQwl0sqkaz4
	 fXWm0u9qESAGKx8ae2wnvofQTrYRNj6FSn7Na4xLOxqmnWGFBxsZ0H+DWQekNE9tvquZ7
	 VaOHdn62CTkyvdXZZB3hYqDE7l2r9dECzaPQPU8rA0u7UhqKsjmlZbWyJkw/yae1xAni7
	 c7fGQdyccwDv+E4/6kVbiG6Ln6bv8hxynZqfAyqvt7TnQ21gc+m74zPQPtvgXqB0xyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="mM7A/PG/";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C5606A326
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E59C5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mM7A/PG/
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so1835998eec.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 12:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1794342200; x=1794947000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aNTBUVcEjSCanLMfEBKZfMTj70g+Fn7VorpJWkJr3sM=;
        b=mM7A/PG/9Uk9fK/Jrh2TfmB/05D9oUgqUkYIaBhm81ACWuHUeGybpd9sjCv2uqxsFp
         hP+54DI+fy9nzJ7v7hk8rjiQQTzmI/zdn5KweGrZN+nSkEMSmd8t9Jd56H2xhGaXXrY9
         FJbpHjyPPembu5gdonohcpyWIvEq9KxR4EbyiR1BdFKe5eJ0c9+UItijTf9oAvxzYNr/
         1brgT+3Ceh+r2Vg6BnjRYRjf//lMIQbSNi7tKUISSKISiKl4mSONNYDdWczzlIWe9wwY
         /OiDzGdaBpreGqIRKhxI81H6efBOTb79xDe+XCS0gMxO2fc0VeJdSAxN25QDOtt4lhe2
         zlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342200; x=1794947000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aNTBUVcEjSCanLMfEBKZfMTj70g+Fn7VorpJWkJr3sM=;
        b=qRq6NMxaWJZGSgQwoS2r+/GrciMUlauIRLIhJchBEIHqVLg2BvnofUQlTb8wFRl5iT
         vEVVn7vPNH1ftKzgfYREUN6nzDnkR8YokblmfrbqCtkeFaKQowjH0HhvqpHQFU33w8Ud
         MCpz3OLn/14yAut32SB4ciqB1aDC3wN+pbaT4FAPEnWvUuV8fGvLcw9DBk8LxH5csLgs
         NJBOCC7ZvutizNnYNPeYKmrCYyWDflhvt1l9u5AaYnFzvr/T4ryxlAIXyp8COMZmwdoq
         r64gu2xgvBgHHxIuhj4yjsBc2Sa7etyi51iH2zTGI8fYWg4AdqfLjPczQiA+vaEv+iVl
         TVvQ==
X-Forwarded-Encrypted: i=1; AL+hErFujKuUp2NMW8Ef2S+siiKGwPP2ucs0i4auebVvBETregHXRkHLCr4wmXibrNEbWQVwM4uYO8YSXQnBozfjwdRlOfl9DZ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TjJ024yNhVd7yPy4rARxAvTyBVFZCTbhMsfS2F5EqvPtQ+B38
	OSUW2sRAISO85AuEhQJ/m5KvZ2dp1fdDr/LUGw33jObisRS8PFbiqQIg5g2YncsBuJxK
X-Gm-Gg: AYBFou1jajGGmj1NWql0eye8sbrJ3Vl8OwzVpPENI9ddDK2Kf2j3Hox562nZPCV3Xr7
	kFtEcG+veC74+JUeg+IZNPV+WifnNyfE9GtxZaUTfZYpsXQuhkwGwp+Nu2MkuZlyaDr7+V+LmNM
	5vujzP6IE8Ia2u8O8KZ/KUXf70S7mIjc2Gy/oMZC5dRt0mPRkm+Nd2POMXYdpiAQjpLIi6qlHnH
	rdwgdxEAMtFvqJAdiKHI6RODGTih0aWK7IUKynCwSCeNjCcgw7jeoaHKBJTVHE0wlB7lF5kBL2O
	oZSMvslGEb5YV4ENPiOg1cyZ8kIUO+G3swiNUcRoUL1jDLzw05+F7YRtHSesq+4UlpqrU/C3Nh7
	cCJamMWEU+/UdXnu4quM4D36AXvwH3wPEs8PqRQpSROX2f98Q54w1gVuYg+VKvHwuulK25XQ8Xn
	lhsvzW8Kj7JSTzbth7/2T9OXDRae5/z6mtpuBPyzj6pKtDKVElGJhulZ0yqxk6mjEK8RtFBu6js
	Y0cDpTTd4YsnnaxXnvfrOh876CRmTqf71bcVBh5jwSuLk8YH6a9v2+aFK4ewXNUTvPDFQp+nvfE
	k5/V2/IEmTZ3d38QMssLxiT5LgUUdIt50dW6X8UmNaori1P/daBmZuDiK3ljcMUSA36sk8vRl/7
	lYL42HyitclAZcxSm/wK9ob3O/Ckt4/RYoYPfqGxgZ3FY8rXOCdrUIQ==
X-Received: by 2002:a05:693c:8955:20b0:36f:26a7:968e with SMTP id 5a478bee46e88-37686a4510dmr514261eec.40.1794342199582;
        Tue, 10 Nov 2026 12:23:19 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:147:2742:6545:702a:2431:7dca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe29fsm10076615eec.21.2026.11.10.12.23.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 12:23:19 -0800 (PST)
From: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>
To: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Kees Cook <kees@kernel.org>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mel Gorman <mgorman@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ketan Bhardwaj <ketan@armoriq.io>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	"HARIHARA SUDHAN . R" <harisudhan@armoriq.io>
Subject: [RFC PATCH v3 0/6] security: introduce Kernel Assurance Plane
Date: Wed, 11 Nov 2026 01:52:40 +0530
Message-ID: <20261110202246.274-1-harisudhan@armoriq.io>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel Assurance Plane (KAP) adds an objective-scoped authority context as a
kernel object. An Intent Lineage Group (igroup) is that object: an externally
managed authority whose lifetime is tied to an objective rather than to a
process, a thread group or a sandbox, that a trusted controller can update or
revoke in place while unmodified worker tasks keep running.

v1 [1] was the design document. v2 added the implementation and moved the
control plane under securityfs. This version answers the v2 review.

The review asked, in several forms, why this needs a new LSM rather than
Landlock or a BPF LSM. The short answer, now the spine of the design document,
is that path and syscall mediation is not the distinction: Landlock and seccomp
already do that, often better. What they do not provide is an authority context
that an outside controller can narrow or revoke, per objective, for a task that
is already running, while a second objective beside it is untouched. The
document opens with that and gives a two-objective example.

Changes since v2:

* Design document (1/6) reworked to answer the review:
  - leads with the authority-lifecycle distinction and the two-objective
    example, and states plainly that the mediation overlaps Landlock;
  - raises the central question (question 1): should KAP be a minimal
    authority-lifecycle facility that composes with Landlock and existing hooks
    for enforcement, rather than a self-contained LSM with its own mediation;
  - drops the incorrect "cgroup membership cannot follow setns" claim and
    reframes the cgroup and BPF-LSM rationales around which lifecycle semantics
    should be a shared contract, not which mechanism enforces;
  - states the JSON subset is a prototype wire form, not the model;
  - narrows the net (connect only), ipc (coarse Unix, no SysV confinement),
    descriptor (file_receive only), procfs and io_uring claims to what is
    implemented;
  - adds the deployment and privilege model and the lineage-root trust
    boundary (opaque, not kernel-verified in this version);
  - reframes question 5 to prefer existing namespace-transition hooks where
    the target tree has them.
* Code (4/6): the only code change is removing an unused securityfs dentry that
  the kernel test robot flagged (-Wunused-but-set-global). The code is otherwise
  identical to v2.

The prototype runs as the guest kernel of Kata microVMs (Linux 6.18) and of
Docker Sandboxes (Linux 7.0). In a Kata guest under nested virtualization,
running the same binary unbound and then bound, enforcement adds 154 ns to a
read and 787 ns to an open, while the unhooked getpid control does not move. On
Docker Sandboxes, allow, deny and revoke were exercised on a real agent.

Known gaps, where feedback is welcome:

* Whether KAP should keep its own mediation or compose with Landlock and
  existing hooks is open and is question 1; the current series is the
  self-contained form.
* The authority wire form is a strict subset of JSON and is experimental.
* Decisions are serialized by one spinlock, and those that resolve a path
  allocate a PATH_MAX buffer before taking it. Both are prototype choices.
* igroups cannot be removed yet, and kap.procs keeps the pids written to it
  after those tasks exit. A task's binding lives in its task blob and is
  released with it.
* A thread created while its process is being bound can miss the binding.
  cgroups closes the same race with cgroup_threadgroup_rwsem; KAP does not yet.
* Control writes need CAP_SYS_ADMIN. CAP_MAC_ADMIN may be the better fit.
* unshare and setns call KAP directly because they have no LSM hook in this
  base (question 5 in the document).
* There are no selftests in this series yet. It was built with and without KAP
  and with networking, namespaces and io_uring disabled, and boot tested in
  QEMU with lock debugging: the control plane, file and exec decisions, epoch
  revocation of a running task and kap.default.
* The LSM ID is provisional and is for the LSM maintainers to confirm.

[1] https://lore.kernel.org/linux-security-module/20261021165748.19304-1-ketan@armoriq.io/

Base commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907 (Linux 7.3-rc7)
