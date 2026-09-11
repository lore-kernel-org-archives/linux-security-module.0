Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527A93BFAD9
	for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113752; cv=none; b=ndTRHr67io3szLgismrW0DUvsN4QBiNB6PYJH1iNYBwdpOzrQpE4GH7a8B8veWsxlNpjK24HT+pqOwzv+1IB/AjPNuMI7dBY4FvxQ3KDGcYz8nRSeSV4bG1eZw03rYaf9KyycvDIIxQmLopXkUn6zHFHJ3hnJMZe81sIqXYEIeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113752; c=relaxed/simple;
	bh=DT3XFpe3pacIAc5YAypwgMYEhUAkDdTmk92G+6zy28I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KccLpeY+HmCWgaho8TQJTchBh5dsCZfCjJ5HWgO1Jv5WZc3amg9dquWaIByVNkic8JiI1sKDZnUxcXU7doM4Fr0RFVr4V3hH/qc0bn2WE/n3wMnplf5jfW1QgA2Z53l+/RiJitraeVPSD3n1xVIXJU0Fb6VSh83J6csX4owrDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=unUKJ8DY; arc=none smtp.client-ip=91.218.175.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="unUKJ8DY"
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DT3XFpe3pacIAc5YAypwgMYEhUAkDdTmk92G+6zy28I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113749; v=1; x=1789718549;
 b=unUKJ8DYrcQ4bToz8c2edIi7z+fgZhzlq1fTA7zcUDp3SrYNjC6l4l89K6tSEwzP26gkF9BA
 URNdaFCPlvukjlJrwvIeVQ+HyByePZMThMsMxspzIvf69MdBtNQFx1nyOB9sP1cyAIOx9WzbW/q
 +x0B4Ox/jB+evgHktfLHQOOQ=
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7ddc78a39b3151cc;
	Fri, 11 Sep 2026 08:02:28 +0000
X-Mizu-Trace-ID: 7ddc78a39b3151cc
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	SJ Park <sj@kernel.org>,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	oleg@redhat.com,
	tglx@kernel.org,
	david@kernel.org,
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
Subject: [PATCH v3 14/15] lib: convert process iterator to for_each_process_rculock
Date: Fri, 11 Sep 2026 15:57:59 +0800
Message-Id: <20260911075800.491472-15-ye.liu@linux.dev>
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
with for_each_process() loop in lib/ with for_each_process_rculock(),
which scopes the RCU read lock to the loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: SJ Park <sj@kernel.org>
---
Changes in v2:
  - Rename *_rcu to *_rculock
 lib/is_single_threaded.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/is_single_threaded.c b/lib/is_single_threaded.c
index 8c98b20bfc41..4e7fe85454ab 100644
--- a/lib/is_single_threaded.c
+++ b/lib/is_single_threaded.c
@@ -26,8 +26,7 @@ bool current_is_single_threaded(void)
 		return true;
 
 	ret = false;
-	rcu_read_lock();
-	for_each_process(p) {
+	for_each_process_rculock(p) {
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
 		if (unlikely(p == task->group_leader))
@@ -48,7 +47,5 @@ bool current_is_single_threaded(void)
 	}
 	ret = true;
 found:
-	rcu_read_unlock();
-
 	return ret;
 }
-- 
2.25.1

