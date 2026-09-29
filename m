Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BB24DAF8F;
	Tue, 29 Sep 2026 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686929; cv=none; b=KmDWZ7A0eLlxswKT3NUaa3xN52ktZ2aHm9A0mCVEAkT9aXeUWnx/voWbUHd1lpj8cyS3dAGdBld83G1Kv+fTyVlfsulslHR+r9IHRovUdcBe8BIfaOW6l8Y3jyNzu+W4CNuDr9wYPpX2rzuCTWN/yzKLFzSz6v3j6UVakJbs3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686929; c=relaxed/simple;
	bh=80qtXjubZEcllirRIHbrp2kSJnWFpmcmeuc6WFI1pPM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XHamyY5KaipW5ujZnP1ob/ICQRjYz3pMf7ZqW4UmnZ3j6h7eUcgfKvXEFbRJzURM8vvCNGksQ00/7FWnL+PTHDHRYQkeITSpclL5g4qk77RQ2NcZc/vvE8zocy1zICCwttkdA+/VrFmgGJ+x8SbAcpkNYz3l97e1Qci81l2A42k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LIvFe9/k; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LIvFe9/k"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=slvHoTQRjNrntVAntkRlhQEzR8bZ4lJQ4rBgjdoTYUk=;
	b=LIvFe9/kBmoJ4hrz56JZGCTKFzU/k6S+xnzxjEWNqZVNbbVzP/l//oYaAOeYrCv4ysw2/mML2
	21jCkP24AatQFzPskRyO7QJEM0doyCJ71InXIGr964RS8bMi42jLBV0uZqpKxVPfQnoqlrneLuN
	iTQCU2Asc2iiWESsoV4Xgvo=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hvJ104rSSz12LHh;
	Tue, 29 Sep 2026 20:49:56 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A4F440575;
	Tue, 29 Sep 2026 21:01:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 21:01:57 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <serge@hallyn.com>, <kees@kernel.org>, <akpm@linux-foundation.org>,
	<david@kernel.org>, <ljs@kernel.org>, <liam@infradead.org>,
	<vbabka@kernel.org>, <rppt@kernel.org>, <surenb@google.com>,
	<mhocko@suse.com>, <mingo@redhat.com>, <peterz@infradead.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <kprateek.nayak@amd.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <shuah@kernel.org>,
	<oleg@redhat.com>, <brauner@kernel.org>, <alexjlzheng@tencent.com>,
	<jannh@google.com>, <jaime.saguillo@gmail.com>, <elver@google.com>,
	<blbllhy@gmail.com>, <bvanassche@acm.org>, <pjw@kernel.org>,
	<broonie@kernel.org>, <debug@rivosinc.com>, <tglx@kernel.org>,
	<aleksey.oladko@virtuozzo.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, <morgan@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH v2 0/3] security: Add PR_CAPBSET_DROP_MASK
Date: Tue, 29 Sep 2026 21:01:57 +0800
Message-ID: <20260929130200.1638343-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)

PR_CAPBSET_DROP only affects the calling thread, so dropping capabilities
for a whole process means one call per capability per thread.  For a
long-lived, multi-threaded process such as gVisor's sentry this is
stop-the-world signal delivery and costs milliseconds per sandbox on a
many-core host.

This series adds PR_CAPBSET_DROP_MASK, which removes a 64-bit mask of
capabilities from the whole thread group in a single call.  The drop is
recorded per thread group and folded into the bounding set wherever it
gates gaining a capability, so already-running, concurrently-created and
later-created threads -- as well as children forked by a sibling -- all
observe it.

Trimming 41 capabilities in an arm64 KVM guest goes from ~8.5-23.6ms with
the per-thread loop to ~11-14us, independent of the thread count.

Changes in RFC v2:
- Solve concurrently clone and concurrently drop mask problem.
- Solove sashiko problems in [1].
- Link to RFC v1: https://lore.kernel.org/all/20260922095816.1191799-1-ruanjinjie@huawei.com/
[1] https://sashiko.dev/#/patchset/20260922095816.1191799-1-ruanjinjie%40huawei.com

Jinjie Ruan (3):
  capability: Move mk_kernel_cap() to header
  security: Add PR_CAPBSET_DROP_MASK for process-wide bounding-set drops
  selftests: prctl: add process-wide bounding-set drop tests

 fs/proc/array.c                               |   3 +-
 include/linux/capability.h                    |  10 +
 include/linux/sched/signal.h                  |   8 +
 include/uapi/linux/prctl.h                    |   1 +
 kernel/capability.c                           |   5 -
 kernel/fork.c                                 |   1 +
 security/commoncap.c                          |  91 ++-
 tools/testing/selftests/prctl/Makefile        |  12 +-
 .../selftests/prctl/cap-bset-drop-test.c      | 641 ++++++++++++++++++
 9 files changed, 759 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/prctl/cap-bset-drop-test.c

-- 
2.34.1

