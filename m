Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434240;
	b=GmuazQ//CNRyhrf1dgNWLyDK7Sr0NgnVqlAtB7l9aLoiB39hjBsCo1AwfIzMoM6Cp0Su
	 e8EahKGZEGDuRnlTufsUDGQ+E5V5s+6BwYzb0rc8mOBnVDY6cOn+U0bh/YGXjAybiWhzR
	 aJTm+GfZc5dzaJDfv2Z/GScWVbKC1Y8Vj+Dw8VarQvoCiPr7HsgG1fLmnzDvbdR7I7Bsx
	 OmyJm9dNV6CfHW4mDFaN3/5dgcD95KrZZoe8z49jRXab0DccFPib6mFI8cEau1sHDRIvc
	 6q8yCGfr/CZYXc5xpidUuTwvtAGY66Bo2MnMsToZhskywO0ZMGRRnYiv5tsppJcMVNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CUCPhF26O34G5hnc4b0my/OnjDHNH9LBcPnQRfSJOAE=;
	b=0qRmqNM07I/hz6HCq7dhFuBnFFMy3uLM8xsDBkvpenfEJtX4r6ETb5ZacScmas7ozPzO
	 YnBPgwCnYmMHLxtPIi5LjFf31/V9eygzhnElRtOcWMv2ju0L9sCXAVxXwsV+uD5REZHsv
	 4fvpqlGeAA5thtyvzx+jbpdy76Ue53P4539qMsE5ycK/yXcEQoOMHKP5SWhs0VSvWtbYq
	 dARMWUr6NwlTqZyafo5ifPijXs7aWt9nOUIXGVCsu6KJhsiKudt6OFyWW0sIEWm3YMLux
	 JOdALS5xkqRc4IT0dzgHybPdZQTxqxBAsU3ewLmUkevF48wGfaEyTVGIeTYSlBgi4WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="UUvr4sN/";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA48606A31F
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 11:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FA48606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UUvr4sN/
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-385c497bf94so1821888eec.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 03:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1795434239; x=1796039039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CUCPhF26O34G5hnc4b0my/OnjDHNH9LBcPnQRfSJOAE=;
        b=UUvr4sN/MtcnZrkf7SSPMNr/15ZxuOgbb28kzZqTuGqQ6LBtQ2ZdNerNQSKpHbc+vD
         D2jOHT1+NPxEkBdh29fuHfYcr5xI45SGAe3t6VudViVvTVVHzT8sgswoZCbfXv6H8ruT
         YSibo2KJHZpVRQonfAn/UYTRI8oHDeSgHUTZIfPzVssz1aLzY4MD0RJWcS1LK04/yvdQ
         r1ey5WaEGoHAM3BA1SgK8xdG435LEglsv+Z8fs9Ap+QPyyg9qwZBX8aq2ob2ZPwZggDq
         92gqK2X82bWDblJ2hcnLjkZzMCALia0f3DfHgkHm6u09MiZrBajP0/xvysUQIzG9vVN2
         ayWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434239; x=1796039039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUCPhF26O34G5hnc4b0my/OnjDHNH9LBcPnQRfSJOAE=;
        b=dCLHNmU0dPNysHtM21LZu98ctblvN5kGZ4+5AB1DT/G7Ic5YngpehVEh9k1+SmZAWo
         3gri3fXn7tnwVjA3G/pYD+W8FN0JFh/tmhYJ6X0tcnlqaRGMjWWzxz8dU3+NEoYfNMBY
         7mPKvoe4h7QRWUmAB1hoONN6x/JsQtgjXuYgXnaUu1VXmAJwmyirxJZz4QXp7gd5qhYm
         hCjqLYHMfbWcX6vUGVMJdQXcNWJXTZfz/osSmv2r0bUw4TY2tne/gHw/Bl0eQkcRAhpQ
         8vH7v68jhYdD2o6IvoecADs6kHuXQUKPkUJ8NcTECQezsauWjO1btD5seigWjAFBSjmH
         F1TQ==
X-Forwarded-Encrypted: i=1; AL+hErEe3yHKW+nrqcBhcgfqYcpyPrLSkJlSzaT/g6Qcydf1G/pf0YQV74meFO/qcZqPyAFIakzTIF4rEJS9TlUfYttgsNox3rw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0Zg/1IskH5neec9caC4CX1AIIkUPhbzN4/xu3SK7jSb7i322R
	hN2f33oLScvAN93B3XbJ9Va39VtFahI3OzwzoL/nhuI6b2gY7fitRAoNTrfn9QUP0KBo
X-Gm-Gg: AZFdTZdzuhMZzary6Kz2TGOGpwqMgyh58qUyutDqAssYMc102i8U/ByCr9ygWlvURYL
	ZXNXeayD1XzYvCwDD3rECGh5mq2OmXpzD0KSiOKuy48KzguJ1QOW0dMgyDdU90cyEO9E1h0eEGz
	KSnJh62nGsZaX6oi7uVBnhcQwPwQ6BUDZ2OTFFzvOkE3n2GvOCjC/y5VGlo+qP9B7Zzt6s26+ks
	KCULHMKXM3Wn86wyvTn+CqYALKt0m/1zpOom41c+y4WcNQyitNg09ms2u04Uw2Af39Luyk7B/m8
	o/ALplzN4oFRBcwpeL7b/igq839SeKAk0TD/SD0HUiANbNjW4m+ImA3NS5S/8bPdgwFDcGuk8T6
	YEkpCI0n0XprcBZPFFTB+n7E0NaZuwOGm0wyfky+MQbN/Q0QC7H3baEtPZGlmRj0E1/1GH7LYQY
	E8D7nqD5XVcV5YzbP7tMDHQyitX+KN/IEUm3Zt3u7GTMLLPyoMuqVTQjF4AaP21Hsxk2Ic4DBID
	4l6IT4RfSCsFNrHjDn0WPqDDVgGrr3B0/4NSMnWviXo+8vNtebYQDV2jChsZ2r117P9fP5ushQy
	bS9GB9/ADZFC8sFWf72WDPlZNLGxrf+W885PSdBS5ehGvs75cIwjsOMNJ7kPPgZ1C96Dnwcq33V
	ssTHyxYiH2mK3qQ1iv7e0il2Gs15CZT5tWnabao+pYZ4s9mqRihHOFg==
X-Received: by 2002:a05:7300:26a2:b0:386:b0ea:3263 with SMTP id 5a478bee46e88-386b0ea340cmr2766188eec.40.1795434239138;
        Mon, 23 Nov 2026 03:43:59 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:14e:94e0:654e:d7ff:13d2:447d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm41943583eec.10.2026.11.23.03.43.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 03:43:58 -0800 (PST)
From: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>
To: bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org
Cc: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	David Hildenbrand <david@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jmorris@namei.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kees Cook <kees@kernel.org>,
	Ketan Bhardwaj <ketan@armoriq.io>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: [RFC PATCH v4 0/6] security: introduce Kernel Assurance Plane
Date: Mon, 23 Nov 2026 17:13:02 +0530
Message-ID: <20261123114308.8103-1-harisudhan@armoriq.io>
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
control plane under securityfs. v3 [2] reworked the design document to answer
the v2 review. This version folds in the v3 review: automated review findings
and a request to put a diffstat on the cover letter. The design and the model
are unchanged from v3.

Changes since v3:

* Fixes from automated review (3/6, the LSM). Each was checked against the
  source; findings that did not reproduce were left alone.
  - Fix a use-after-free in the link check: the source parent dentry was read
    and then used across a sleeping allocation and d_path, where a concurrent
    rename could free it. Pin it with dget_parent and release it after.
  - Fix an uninitialised-stack infoleak on a short connect(): the target
    render read the address and port before addrlen was known to cover them.
    Require a family-sized addrlen and otherwise leave the address for the
    protocol layer to reject.
  - Close a fail-open path: when a mapping's backing path cannot be resolved,
    mmap and mprotect now run the execmem predicate with an unresolved target,
    so a revoked or expired igroup still denies rather than allowing the map.
  - Normalise /proc/self to the thread-group leader in the current PID
    namespace (task_tgid_vnr) rather than this thread's global PID.
  - Do not let an exact-path deny be slipped by unlinking the file first:
    d_path renders an unlinked file as "<path> (deleted)", so strip that
    suffix before matching.
  - Match a user-namespace create as "user:create" so a "user:*" allow or
    deny applies, rather than a bare "user" that only matched a wildcard.
  - Guard the transition-sequence parser against u64 overflow.
  - Reject a lineage root that carries control characters or the JSON string
    metacharacters, since it is written verbatim into the kap.events JSON.
* Control plane (4/6, securityfs).
  - kapfs now sets its superblock operations (simple_statfs), block size and
    time granularity.
  - Validate the lineage-root write the same way as above.
* Design document (1/6).
  - Clarify the epoch semantics, which were contradictory: a running task is
    narrowed by installing a new authority at the same epoch, which re-points
    the bound task without interrupting it; raising the epoch is what revokes
    a task, failing its checks closed until it is bound again.
* Cover letter: add the diffstat (thanks, Lorenzo).

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
  QEMU with lock debugging (PROVE_LOCKING and DEBUG_ATOMIC_SLEEP): the control
  plane, file and exec decisions, epoch revocation of a running task and
  kap.default.
* The LSM ID is provisional and is for the LSM maintainers to confirm.

[1] https://lore.kernel.org/linux-security-module/20261021165748.19304-1-ketan@armoriq.io/
[2] https://lore.kernel.org/linux-security-module/20261110202246.274-1-harisudhan@armoriq.io/


HARIHARA SUDHAN. R (6):
  docs: security: Describe the Kernel Assurance Plane design
  security: kap: add the LSM ID and internal headers
  security: add the Kernel Assurance Plane LSM
  security: kap: add the securityfs control plane
  kernel: add KAP checks for unshare and setns
  MAINTAINERS: add an entry for the Kernel Assurance Plane

 Documentation/ABI/testing/securityfs-kap | 111 +++
 Documentation/security/index.rst         |   1 +
 Documentation/security/kap.rst           | 341 ++++++++
 MAINTAINERS                              |  10 +
 include/linux/kap.h                      |  16 +
 include/linux/lsm_count.h                |   9 +-
 include/uapi/linux/lsm.h                 |   1 +
 kernel/fork.c                            |   4 +
 kernel/nsproxy.c                         |   5 +
 security/Kconfig                         |   1 +
 security/Makefile                        |   1 +
 security/kap/Kconfig                     |  14 +
 security/kap/Makefile                    |   2 +
 security/kap/igroup.c                    | 976 +++++++++++++++++++++++
 security/kap/kap.h                       | 160 ++++
 security/kap/kap_lsm.c                   | 903 +++++++++++++++++++++
 security/kap/kapfs.c                     | 530 ++++++++++++
 17 files changed, 3084 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/securityfs-kap
 create mode 100644 Documentation/security/kap.rst
 create mode 100644 include/linux/kap.h
 create mode 100644 security/kap/Kconfig
 create mode 100644 security/kap/Makefile
 create mode 100644 security/kap/igroup.c
 create mode 100644 security/kap/kap.h
 create mode 100644 security/kap/kap_lsm.c
 create mode 100644 security/kap/kapfs.c


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0

