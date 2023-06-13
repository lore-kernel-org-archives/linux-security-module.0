Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94506EB64D8
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Jun 2023 19:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbjFMTnM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjFMTnK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Jun 2023 15:43:10 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8835F1BEA
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jun 2023 12:43:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b3a9eae57cso24947765ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jun 2023 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686685385; x=1689277385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=++RlJEGBoYZZIYZsRHYoBMeQspkNZr4R3QmKZH+3SVM=;
        b=H1q3jvV/pyh4iAygQto1xdexTU/nOQVTmlJXFt1V1I4T+zRrPD02k1089dAsxc1QZm
         waIS8XBlYOTH6cQJ3o3yQVaXu3IFlTlHBQEFUUYp9JEwAcf9n+cAWiIML/6H11PZcjZA
         keWtPgaY06BYpTYNOkXy5KeusVGGvYattkCMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686685385; x=1689277385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++RlJEGBoYZZIYZsRHYoBMeQspkNZr4R3QmKZH+3SVM=;
        b=bAXXELXCHUuxLMbuxBP4loTpreu0A8jsZk0gRmMlA/mSwnMFObCQ4t2IbRMcmXwRIU
         N9AF1IX3fnyupJGz2qFPFZOJWwZmH0IagC6HNtEfKSXSlHZNk5JBPgXotXRpd2g4se3n
         XP2zlso+gNCpmoZZMULx5DbWHo60oqwJKkk0qdwrZzXiH3lnMBPnbDa2/CvA1l4tUN4C
         rCBsNsMOMp9NmlI6TQlzftfu8a+nanvkCBXIhyswGpVsi92GRN/e97dd3EMfEDzc5p36
         +7XVjR3sniI13Qh131aDIQGC/Av+EIvBJWQWsZHZ4MjtRvsSjJiJqrodUjq9nHlqnvPO
         UKlA==
X-Gm-Message-State: AC+VfDzZ+jZmgVRoX2CS1IlOVUoV1EfvAQ4p4BDVpJQLk1cZCisKe9Tb
        G6CYQiknbDgM/sSGnRuguQ3yjg==
X-Google-Smtp-Source: ACHHUZ67L+Wg14yMTsPIsgdLxiqL5tLv4Kzz8WcDiTd8p65LBH+CQ9wRhLmwtBJbSj5CJ3as9czIMA==
X-Received: by 2002:a17:903:1103:b0:1af:e302:123 with SMTP id n3-20020a170903110300b001afe3020123mr13915655plh.3.1686685385066;
        Tue, 13 Jun 2023 12:43:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b001ac591b0500sm10599222plq.134.2023.06.13.12.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:43:04 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:43:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        catalin.marinas@arm.com, will@kernel.org, vkoul@kernel.org,
        trix@redhat.com, ojeda@kernel.org, mingo@redhat.com,
        longman@redhat.com, boqun.feng@gmail.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
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
Subject: Re: [PATCH v3 28/57] perf; Simplify event_sched_in()
Message-ID: <202306131242.99E9B4A@keescook>
References: <20230612090713.652690195@infradead.org>
 <20230612093539.537454913@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612093539.537454913@infradead.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 12, 2023 at 11:07:41AM +0200, Peter Zijlstra wrote:
> Use guards to reduce gotos and simplify control flow.

Typoe in Subject: ";" should be ":"

-- 
Kees Cook
