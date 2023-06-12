Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92728C88CB6
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Jun 2023 13:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbjFLNva (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Jun 2023 09:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbjFLNv2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Jun 2023 09:51:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3F010F4
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 06:51:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f7f543fe2fso43733915e9.2
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686577884; x=1689169884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VZfZnBRmLxwYvjmW1v2T8ybrzxEz4xOvIMacNwWxuQY=;
        b=q8srpqTZqi249xTO00UoduKcB9900iihCnJBYviZpjnNcdxDOGOLcOvGcyeXpFyVod
         oRWQ9jw9+RwSz0a4PaOsX55oAAxEUe5ScpnndPquxYM7ZouNofJi1OGfLB9nsmDnhORg
         Hu0nbFymp+CI9DOUVBw0BgHWrUAjDFXYAInDfjLg6gq6kBCv4TicOOPN2Mti0kpV2ho1
         sYy7doXiFEZVdKy4U8nLe7igR6vQ/Huqu7k1efZN+LrPR0zG/4amnI1omw9ELT/PIIbW
         a7nJnnYhzULtzCIcs6c6YO5dzMMGhVA2KwZ16xR6lIZya74b+SElUKSVv0lqhZPCU+6q
         8Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686577884; x=1689169884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZfZnBRmLxwYvjmW1v2T8ybrzxEz4xOvIMacNwWxuQY=;
        b=AZnGH2IYfysuKV2RmrE6xZMS4KuTsm/GIT7o0BBXsSBPXKfZ0FvRGIqW3i4KukwmTg
         7dRtSvDal9Ikzv24lHRZCeDNxJ3dUlAxcPU3E0ScbRJph3F8+yNxeK5uubGhWoAlVedQ
         VBPUXep3Q/QyZ/fDU/OWgRuRAkwi3Xs4bkzE8qZFJR3MIkvm/YbbTbkLSdKMmuqECMup
         i19Ns19BTQDjVNPNxeF73SfyE+tss0c/Z6qv/vcI7VB3YnWO03oHgOVuTsSnUJI6U85I
         a6oisF4Rfjzt+uDaHHBpxdsTFMVY6ljZuoy/mS4m2Gpt+v0tbiigndRMJrKOy1C5x46a
         YmOw==
X-Gm-Message-State: AC+VfDzooRY0yCI65ULZJlTxSPz0tLFjZkKe9f9UotwDmnlcllOmlaGY
        796Nun2BMPN+8nxu4+mtzdwn+w==
X-Google-Smtp-Source: ACHHUZ6GVEFGGhIbci6My+kOS3R3jCEaFtz2YTtb+Wgw6JjfF+ccwAH2AZFW+ZiFTHh/32+xMVajYQ==
X-Received: by 2002:a05:600c:2299:b0:3f7:e5a0:c5f1 with SMTP id 25-20020a05600c229900b003f7e5a0c5f1mr7101869wmf.32.1686577883770;
        Mon, 12 Jun 2023 06:51:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s12-20020a7bc38c000000b003f7ba52eeccsm11531482wmj.7.2023.06.12.06.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 06:51:21 -0700 (PDT)
Date:   Mon, 12 Jun 2023 16:51:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com,
        masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, trix@redhat.com, ojeda@kernel.org,
        mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        dennis@kernel.org, tj@kernel.org, cl@linux.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rientjes@google.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        rcu@vger.kernel.org, linux-security-module@vger.kernel.org,
        tglx@linutronix.de, ravi.bangoria@amd.com, error27@gmail.com,
        luc.vanoostenryck@gmail.com
Subject: Re: [PATCH v3 09/57] sched: Simplify ttwu()
Message-ID: <0012d943-6fd0-4b8d-9ec6-3d02aba75dcc@kadam.mountain>
References: <20230612090713.652690195@infradead.org>
 <20230612093538.076428270@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612093538.076428270@infradead.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 12, 2023 at 11:07:22AM +0200, Peter Zijlstra wrote:
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3664,16 +3664,15 @@ ttwu_stat(struct task_struct *p, int cpu
>  		__schedstat_inc(p->stats.nr_wakeups_local);
>  	} else {
>  		struct sched_domain *sd;
> +		guard(rcu)();
>  
>  		__schedstat_inc(p->stats.nr_wakeups_remote);
> -		rcu_read_lock();

We can't put the guard(rcu)(); here?  I have unpublished static analysis
which assumes that the first and last statements guarded by a lock are
important.  But if we always put it at the top of the scope then we
lose that information.

>  		for_each_domain(rq->cpu, sd) {
>  			if (cpumask_test_cpu(cpu, sched_domain_span(sd))) {
>  				__schedstat_inc(sd->ttwu_wake_remote);
>  				break;
>  			}
>  		}
> -		rcu_read_unlock();
>  	}

regards,
dan carpenter

