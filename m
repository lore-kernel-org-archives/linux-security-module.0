Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FBA513569;
	Tue, 29 Sep 2026 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686930; cv=none; b=oOM+XPBwgId/HhBCqpYQDEh1XxxfDtyzGBGPtTfZFgIqfxCSiDlE/46oMgAUb8cLTtH6xixtOKTAwOGuhwOkd8HYs825XolJAN/FUxmiuEfiyMeMVsV9F2Um113ucq8sog+QsVH8nUh1ILdGDS/TwEFWvCXRPezzkCushTuDYKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686930; c=relaxed/simple;
	bh=vWWpkl+p9WQndRxxpmp3BPhrd7Yqi2bkIyGLpseGKWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cp+qdG9cdX0OksIIc3ZwsHjeBXwz7LgToQWdQrJBoRGavQBaNcfZU/p4rQvCH+FeLWdnNf6TUOBpzVW4knSUwYmnjX6xpcsnu+gSYzVMOODxslN2hpPpHlyseO6vZvkZTozBSdRdG+maoyTw+rKlzfEZCdgBdfrFZFE+s2Nx+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=D0NnwpBx; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="D0NnwpBx"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IH3o9e+vD8Px+iIdA7cBn3J/yVBD/sCiedYGk0wkQTE=;
	b=D0NnwpBx5zTGe8VHlNO8c/QFIbn902yh15sAVzZTxzb8XlhLuTho8hCCofUfsw3B7KpRLY6um
	svb5EszooI6FJX2O/wnUXwctWb/Gyrfk8+n+Yuwlf4djI9aJfbi4ttPlUx3FruRnm5MikT/WXH6
	srtRmPfCc9xqSfu44COtnO4=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hvJ0v0kYqz1K96s;
	Tue, 29 Sep 2026 20:49:51 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 6862340561;
	Tue, 29 Sep 2026 21:02:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 21:01:59 +0800
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
Subject: [RFC PATCH v2 1/3] capability: Move mk_kernel_cap() to header
Date: Tue, 29 Sep 2026 21:01:58 +0800
Message-ID: <20260929130200.1638343-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929130200.1638343-1-ruanjinjie@huawei.com>
References: <20260929130200.1638343-1-ruanjinjie@huawei.com>
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

Move mk_kernel_cap() from capability.c to the capability header file
so that it can be reused by other security modules.

No functional change.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/capability.h | 5 +++++
 kernel/capability.c        | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index f8532d92fcad..7921a0b3b04a 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -114,6 +114,11 @@ static inline bool cap_issubset(const kernel_cap_t a, const kernel_cap_t set)
 	return !(a.val & ~set.val);
 }
 
+static inline kernel_cap_t mk_kernel_cap(u32 low, u32 high)
+{
+	return (kernel_cap_t) { (low | ((u64)high << 32)) & CAP_VALID_MASK };
+}
+
 /* Used to decide between falling back on the old suser() or fsuser(). */
 
 static inline kernel_cap_t cap_drop_fs_set(const kernel_cap_t a)
diff --git a/kernel/capability.c b/kernel/capability.c
index 90e6ab62f6db..0b8ec26ead0e 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -190,11 +190,6 @@ SYSCALL_DEFINE2(capget, cap_user_header_t, header, cap_user_data_t, dataptr)
 	return 0;
 }
 
-static kernel_cap_t mk_kernel_cap(u32 low, u32 high)
-{
-	return (kernel_cap_t) { (low | ((u64)high << 32)) & CAP_VALID_MASK };
-}
-
 /**
  * sys_capset - set capabilities for a process or (*) a group of processes
  * @header: pointer to struct that contains capability version and
-- 
2.34.1

