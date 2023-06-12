Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2A4C7EE2F
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Jun 2023 16:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjFLQdj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Jun 2023 12:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjFLQdf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Jun 2023 12:33:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBB3119
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 09:33:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9745d99cfccso795425666b.1
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 09:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686587614; x=1689179614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XQ64AB6vFE2gCnLICKj93uVfxKBboA+BfLd8wCYY+0E=;
        b=T8QmECP2E0ANcz2TPhf+TvZP4F7ce5R/zVPT5+xbiur7ADt4dDyVB8jqUqtjJ13W9a
         cWavdlcLATQ7sMOU4IFjuusMvMlY+mOQ3pWNthRTZEQfIJFCLwRJYa4fBWPV1Ua0Y3aN
         4ejLFiEVUki1hCCBYz8lsR27RVO0f4N0Ze+FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587614; x=1689179614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQ64AB6vFE2gCnLICKj93uVfxKBboA+BfLd8wCYY+0E=;
        b=KyYWiYyV9Ubr3VOVYnoqdB7XDHV9nkwRWRFR5iJpwrj6ZNqAfcvCaXGa8qBBqfx+Zl
         F6cVzLkzv9vLOgzkwtpg9cNREYY/6AypqnYKo9auOzjm4mP6Y1KxdeDL0i8Bmy1ZzfpD
         EepVe/vX+Pv/uDromxMa7bgEoKsjtFIqRjZbBnTR4MRVFV/F04+eRKo5c1AS2p20qDao
         Nv/rs8zDBCXzGpcRk+ZaWbvubCmPj5lGS7BDXLx/vGhQGkn6xX2icMgZFi1R+nrCC4LC
         rTi8tSweKFnFMXCmCUy7woEEGP1muNiAGc0HBHcNwhWOBhLVDOB6KGizL4ksM17uPiWp
         UrDA==
X-Gm-Message-State: AC+VfDxWJesNyWfvRySW/IycD1piIyY5JD+xVHFDjMHj7DbuHH6pZe5t
        NQYbFc8ZhlvuWsMH2WBBbTWUWhbMkfZUczf8WG24Cod4
X-Google-Smtp-Source: ACHHUZ4u3eBJgzJGardiicRunr3Fbi4zzUxEaW4sG+05VBCq36+7Oi+Pqh+AzaZNzwpZKYSYD72I9w==
X-Received: by 2002:a17:907:80a:b0:965:9602:1f07 with SMTP id wv10-20020a170907080a00b0096596021f07mr10117448ejb.39.1686587614483;
        Mon, 12 Jun 2023 09:33:34 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090627cd00b0096f6647b5e8sm5419613ejc.64.2023.06.12.09.33.34
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:33:34 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-30fbcfdc7b6so1053194f8f.3
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 09:33:34 -0700 (PDT)
X-Received: by 2002:a05:6402:6d3:b0:514:93b2:f3b1 with SMTP id
 n19-20020a05640206d300b0051493b2f3b1mr5343956edy.40.1686587246075; Mon, 12
 Jun 2023 09:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093539.895253662@infradead.org>
In-Reply-To: <20230612093539.895253662@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:27:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPtj9Y+nkMe+s20sntBPoadKL7GLxTr=mhfdONMR=iZg@mail.gmail.com>
Message-ID: <CAHk-=wgPtj9Y+nkMe+s20sntBPoadKL7GLxTr=mhfdONMR=iZg@mail.gmail.com>
Subject: Re: [PATCH v3 33/57] perf: Simplify perf_adjust_freq_unthr_context()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This seems to have the same pattern that I *think* it's entirely
broken, ie you are doing that

                guard(perf_pmu_disable)(event->pmu);

inside a loop, and then you are randomly just removing the

               perf_pmu_enable(event->pmu);

at the end of the loop, or when you do a "continue"./

That's not right.

The thing does not not go out of scope when the loop *iterates*.

It only goes out of scope when the loop *ends*.

Big difference as far as cleanup goes.

So you have not "simplified" the unlocking code, you've broken it. Now
it no longer locks and unlocks for each iteration, it tries to re-lock
every time.

Or have I mis-understood something completely?

               Linus
