Received: from mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC2434997
	for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113551; cv=none; b=sEtjywbTsP737gO5gOrybwQVGCNqUCkHkDnRZF+PbHta4YpRLofUT75koceEhlCNx0khz0/pn5r93hwQPpqWBVbaibM6zdvXSUQ/q2EUevooCNJbIsbzqkVLsSZRx5XuwM7ai6DWmDrdcMZU78P5vTfbFsR8G5Ws6b4PK4OvNEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113551; c=relaxed/simple;
	bh=QXWV2YjR1N2qilXRn4ZL7vqePEkKN4kK8nW2DqNMaW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZukPqpQgoanWqwcFalkK9wm71zW2NTzTxDvqqkI5ceQzi/0xMYQJLiWXbIJeo+pOacCOSP6TLJ09bKc8RHIqaIpChAKXkZ3R0DsCjsTqjDAB7DrLMu9Rf4SBSCF+yV3LoPIH7M3QjQtegdrXVY2DvCmpc9mhm5FJpXL8GPxbMos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c0Y8MbTy; arc=none smtp.client-ip=91.218.175.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c0Y8MbTy"
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QXWV2YjR1N2qilXRn4ZL7vqePEkKN4kK8nW2DqNMaW0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113546; v=1; x=1789718346;
 b=c0Y8MbTyqfpSZ2DWWP9DK8EZ8QtF2s849JagY4PO/RE9wqhVppJ1E/yY0JVz/zjdRmy2F9zY
 Mu2RRMS1hxZz+253id6FTq1DsfkUAgKRkpc1isSOINba5LI7N/p2QsvYnl6N0pJ1jzDmhCyEyNa
 m5IAgpZM1iVKkwqy5ZmSRadE=
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 70c9cc29d1278767;
	Fri, 11 Sep 2026 07:59:05 +0000
X-Mizu-Trace-ID: 70c9cc29d1278767
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	oleg@redhat.com,
	tglx@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	gnoack3000@gmail.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	will@kernel.org,
	boqun@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	x86@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	pavel@kernel.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	pmladek@suse.com,
	longman@redhat.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	mark.rutland@arm.com,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 03/15] mm/ksm: convert process iterator to for_each_process_rculock
Date: Fri, 11 Sep 2026 15:57:48 +0800
Message-Id: <20260911075800.491472-4-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260911075800.491472-1-ye.liu@linux.dev>
References: <20260911075800.491472-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ye Liu <liuye@kylinos.cn>

Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
with for_each_process() loop in mm/ksm.c with for_each_process_rculock(),
which scopes the RCU read lock to the loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: SJ Park <sj@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Changes in v2:
  - Rename *_rcu to *_rculock
 mm/ksm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 49d48d1e0998..69d30e80a090 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3280,8 +3280,7 @@ void collect_procs_ksm(const struct folio *folio, const struct page *page,
 		struct anon_vma *av = rmap_item->anon_vma;
 
 		anon_vma_lock_read(av);
-		rcu_read_lock();
-		for_each_process(tsk) {
+		for_each_process_rculock(tsk) {
 			struct anon_vma_chain *vmac;
 			const unsigned long addr = rmap_item->address & PAGE_MASK;
 			const unsigned long index = rmap_item->linear_page_index;
@@ -3298,7 +3297,6 @@ void collect_procs_ksm(const struct folio *folio, const struct page *page,
 				}
 			}
 		}
-		rcu_read_unlock();
 		anon_vma_unlock_read(av);
 	}
 }
-- 
2.25.1

