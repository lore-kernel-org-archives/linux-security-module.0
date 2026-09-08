Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF4D375F7B
	for <linux-security-module@vger.kernel.org>; Tue,  8 Sep 2026 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849790; cv=none; b=tOgs6qLWlJc+m8WPpzKruOA+6DO6cCKdNA251QDhNrXc0GPhkakN4hWCzjzDTz4IlDeZvm+1gNicYRcg80HIsClKHMkJzMoCEjT+81bDW2uCJIZ2vrt5WXMF+Tn5nanOX5tcE96lM76i6FCcgJgVRWadpOQihGW5cFlW4IZ6K6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849790; c=relaxed/simple;
	bh=r81amRFlPjzeUTmfDZcNSSRmn8+UhK/PkcDEwxOg4Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RSYbrfbV2EJUssaUX5v/e8Z/GHEAzYpYBuoAJFND0ZKuoFh/0PxFCqGCewOSpcxZ0/g8qHibGHY5nA6xvQyAFhVtZ/3ETZ69lzTVlcN3mgQCJCKBIvwXT2H/mYKUUu5opAcQalKHDvmUliT+tEI4XmsnsIlPNlL6SFakfh+pg/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KU5M/3Dr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KU5M/3Dr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788849787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YW1GKuJRhHZmwuIL2WlsvAjfLcvMatnxv0NMJQFIHUY=;
	b=KU5M/3DrhS1HaSOfj92OCd3lfcyN/Kr+j3CCnpGaXYYgoJOzQvTMmoztSBBfzwmPK3S3Sn
	M4vl70MRxHUMrREKPFOvNc9ugE7L05o29FHpvJ1r0WLuYTsVSfzT9+13XyUkzjzFyUjkpT
	NHJEazXtiXwrIBYWcXdE3ms3MJrtQSU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-K15Hh85TMv-qJLfCPFJEfw-1; Tue,
 08 Sep 2026 02:43:04 -0400
X-MC-Unique: K15Hh85TMv-qJLfCPFJEfw-1
X-Mimecast-MFC-AGG-ID: K15Hh85TMv-qJLfCPFJEfw_1788849783
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4D75195E918;
	Tue,  8 Sep 2026 06:43:02 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 59C205B1;
	Tue,  8 Sep 2026 06:42:46 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  8 Sep 2026 08:43:02 +0200 (CEST)
Date: Tue, 8 Sep 2026 08:42:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>, mic@digikod.net, david@kernel.org,
	linmiaohe@huawei.com, nao.horiguchi@gmail.com, gnoack3000@gmail.com,
	ljs@kernel.org, sj@kernel.org, rientjes@google.com,
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, tony.luck@intel.com,
	reinette.chatre@intel.com, x86@kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, pavel@kernel.org,
	lance.yang@linux.dev, pmladek@suse.com, longman@redhat.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, dietmar.eggemann@arm.com, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com,
	babu.moger@amd.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 5/8] kernel: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <ap-uZcmqAr03Xqax@redhat.com>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260907081334.1152889-6-ye.liu@linux.dev>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: PgvXNSE0oo5rV-BwRxp72TbsX60b3DdEB7MFsISB_xk_1788849783
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 09/07, Ye Liu wrote:
>
> From: Ye Liu <liuye@kylinos.cn>
>
> Replace the manual rcu_read_lock()/rcu_read_unlock() and guard(rcu)
> pairs combined with for_each_process(), for_each_thread() and
> for_each_process_thread() loops across kernel/ with the
> for_each_*_rculock() macros, which scope the RCU read lock to the
> loop body via scoped_guard(rcu).
>
> No functional change.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
> Changes in v2:
>   - Rename *_rcu to *_rculock
>   - Rename stale 'unlock:' label to 'out:' in hung_task.c (Günther Noack)
>  kernel/cpu.c             |  4 +---
>  kernel/freezer.c         |  4 +---
>  kernel/hung_task.c       | 11 ++++-------
>  kernel/locking/lockdep.c |  4 +---
>  kernel/rcu/update.c      |  4 +---
>  kernel/sched/core.c      |  3 +--
>  kernel/sched/debug.c     |  4 +---
>  kernel/trace/fgraph.c    |  8 ++------
>  kernel/unwind/deferred.c |  3 +--

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

