Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062DC449B21
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773752; cv=none; b=QoijKO3BY3cD1YNZ7JaQwb/XwRA4Zhu+0u1IgEtv/HkBkAptWDoq0yfUg+pCVzo8Fp+6mFWdrZdMCMncsFbMmTfRTO+cJ1Tng2W3oJQPiJXlChAN6l0gAw/nFfslPzew4jj/+UQ66wiCGG6PU45GmLUhOT18QgoJnl+gempa9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773752; c=relaxed/simple;
	bh=+1OruMYcQA77jLKl8fk/VE7hjZNXJ6hFvLeuBJHiyjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TLIvTdAG730tyixMkvVtyjF9LCfSRlm1XUoP116iIr3RhzBXSsXAHJvAJv4bxez1sW+YaGSU00uUg+u2BfCXefN+vKaWWaVDBeRuv7Fr1RTY+v2wPGmkqt04tMKBIXf8gKSqZ8vHC7f2D5h1mkr5oFpWZM413pT94YHz86aRFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yof+nleB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yof+nleB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788773749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+1OruMYcQA77jLKl8fk/VE7hjZNXJ6hFvLeuBJHiyjQ=;
	b=Yof+nleBpP2swEpDaNCSG7LEh3TWggh5c1FlkA28pq+iuAeRgx3wxUT4EsKDoGv/orr1nu
	8jw3zkUHv386ggNixvXiU+goEpQ50yYMl5aVEu2OgWd7Sl5W2kShSymXDj6NRDzzGla8dR
	ZTH3JtVOeUXwAZodtV8m17ge7oGPd98=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-U96dqzotMg279n9Gg43hkw-1; Mon,
 07 Sep 2026 05:35:46 -0400
X-MC-Unique: U96dqzotMg279n9Gg43hkw-1
X-Mimecast-MFC-AGG-ID: U96dqzotMg279n9Gg43hkw_1788773744
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E53B1801300;
	Mon,  7 Sep 2026 09:35:43 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EA98D1955F11;
	Mon,  7 Sep 2026 09:35:22 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  7 Sep 2026 11:35:43 +0200 (CEST)
Date: Mon, 7 Sep 2026 11:35:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Marco Elver <elver@google.com>, Ye Liu <liuye@kylinos.cn>,
	Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Yi Tao <escape@linux.alibaba.com>, Michal Hocko <mhocko@suse.com>,
	paulmck@kernel.org, mingo@redhat.com, rostedt@goodmis.org,
	jpoimboe@kernel.org, mic@digikod.net, tglx@kernel.org,
	akpm@linux-foundation.org, david@kernel.org, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, rafael@kernel.org, gnoack3000@gmail.com,
	ljs@kernel.org, sj@kernel.org, rientjes@google.com,
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	pavel@kernel.org, lance.yang@linux.dev, mhiramat@kernel.org,
	pmladek@suse.com, longman@redhat.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, dietmar.eggemann@arm.com, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com,
	babu.moger@amd.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/8] sched: introduce for_each_process_rculock and
 for_each_thread_rculock
Message-ID: <ap6FWZ9FYjkFKoH_@redhat.com>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-2-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260907081334.1152889-2-ye.liu@linux.dev>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: Do90AVIp2Mvg7RRdHYWuVJNnDAU5tTvE4cZ3DrV3_q4_1788773744
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 09/07, Ye Liu wrote:
>
> Introduce for_each_process_rculock(), for_each_thread_rculock() and
> for_each_process_thread_rculock() macros that acquire the RCU read
> lock before the iteration starts and release it when the loop is left,
> so that the RCU read-side critical section is scoped to the loop body
> instead of an externally managed rcu_read_lock()/rcu_read_unlock()
> pair.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks, I personally like the new _rculock suffix more ;)

I see the comments about indentation from Lorenzo, I am fine either way.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

