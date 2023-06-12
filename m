Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7BDC7EE2E
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Jun 2023 17:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjFLRv0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Jun 2023 13:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjFLRvZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Jun 2023 13:51:25 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02B8A1
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 10:51:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1b66a8fd5so54632871fa.0
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686592283; x=1689184283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFrxTaZ+omQeBxjp+PSzN1QlslHiKSQMtm5xmMsMGf8=;
        b=hBBoXRvA1cihAJDhyiMdjkwCFWLPAF9Df1Z1Anr0U8IF2+aJsIrPMddU1d8DDJQf6y
         sHguGeozzaVG76GbFnOvYU6Lx9PeXjOB8BJO9GmIrspUGTdW13iQLy06QGTfgbmfC4hG
         ai95/2T3VipxlfkR+FE/DPsquTqBr7B8b89GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592283; x=1689184283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFrxTaZ+omQeBxjp+PSzN1QlslHiKSQMtm5xmMsMGf8=;
        b=XJ4ytygSsIk24ljn7TgmdmxO4MoYVEofqBnyR5DyRAHq8xlXYoCVSy2aC3WNzUHlGH
         5N7Yp2+118dI12LEQ6xqtH2a30O3AumCtHWsI/b/B+1goYEGuzAcXGZusX21lETxcsoo
         3o7T7E+U+7hv109/L/X5gViqPbVic5Fbv2BkY/ZWhJNLHl1WpweGZuPVfGEgb0ucza33
         Raq4qnzlndeVv2ztMB/z12dLZFYZ90AlWv9sbIWdk0xqfhjsv8/d9jODLEZ2nHv6OClz
         PNkKRazhhRUf2vufp++do9OQ798leDE/up+m1fNpbGxL5P0ngffK+QmmgUa1DnCl0zh0
         CVNw==
X-Gm-Message-State: AC+VfDwb2HlZnM/vkGGweBlqWTkQoKl9Z4nMibsMqjtcSJBvdjeMlYfJ
        dQDtV5WlhWdfecPKL//07N/ZX9dKp+H/TS12KtAHJpGG
X-Google-Smtp-Source: ACHHUZ7za3RWqYVNP69hrAgqFxV2+J1/7Ceaaf9kI3UXMkzH2wyRx7znVUNmNYsMpWuYs9CiX90gRQ==
X-Received: by 2002:a05:651c:d2:b0:2ad:d2d1:bbae with SMTP id 18-20020a05651c00d200b002add2d1bbaemr3205036ljr.45.1686592282757;
        Mon, 12 Jun 2023 10:51:22 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id e8-20020a2e9e08000000b00295a96a0f6csm1796187ljk.102.2023.06.12.10.51.22
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 10:51:22 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f658a17aa4so4596952e87.0
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 10:51:22 -0700 (PDT)
X-Received: by 2002:a05:6402:399:b0:516:afe9:f6f9 with SMTP id
 o25-20020a056402039900b00516afe9f6f9mr5415434edv.35.1686591835245; Mon, 12
 Jun 2023 10:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093541.598260416@infradead.org>
 <CAHk-=wh6JEk7wYECcMdbXHf5ST8PAkOyUXhE8x2kqT6to+Gn9Q@mail.gmail.com> <ZIdR18xG1jy8WdEp@google.com>
In-Reply-To: <ZIdR18xG1jy8WdEp@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 10:43:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGypJwDLvTVbYENicw85n0gbxO7JXjiv9_a+95Br+UTg@mail.gmail.com>
Message-ID: <CAHk-=wjGypJwDLvTVbYENicw85n0gbxO7JXjiv9_a+95Br+UTg@mail.gmail.com>
Subject: Re: [PATCH v3 56/57] perf: Simplify perf_pmu_output_stop()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 12, 2023 at 10:12=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> What if we require that all guarded sections have explicit scoping?  E.g.=
 drop
> the current version of guard() and rename scoped_guard() =3D> guard().  A=
nd then
> figure out macro magic to guard an entire function?

Hmm. I didn't love the excessive scoping, but most of the cases I was
thinking about were for the freeing part, not the locking part.

I agree that explicit scoping might be a good idea for locks as a
rule, but that "entire function" case _is_ a special case, and I don't
see how to do it sanely with a scoping guard.

Unless you accept ugly syntax like

    int fn(..)
    { scoped_guard(rcu)() {
         ...
    }}

which is just a violation of our usual scoping indentation rules.

Of course, at that point, the "scoped" part doesn't actually buy us
anything either, so you'd probably just be better off listing all the
guarding locks, and make it be

    int fn(..)
    { guard(rcu)(); guard(mutex)(&mymutex); {
         ...
    }}

or whatever.

Ugly, ugly.

End result: I think the non-explicitly scoped syntax is pretty much
required for sane use. The scoped version just causes too much
indentation (or forces us to have the above kind of special "we don't
indent this" rules).

> IIUC, function scopes like that will be possible once
> -Wdeclaration-after-statement goes away.

Well, "-Wdeclaration-after-statement" already went away early in
Peter's series, because without that you can't sanely do the normal
"__free()" cleanup thng.

But no, it doesn't help the C syntax case.

If you were to wrap a whole function with a macro, you need to do some
rather ugly things. They are ugly things that we already do: see our
whole "SYSCALL_DEFINEx()" set of macros, so it's not *impossible*, but
it's not possible with normal C syntax (and the normal C
preprocessor).

Of course, one way to do the "whole function scope" is to just do it
in the caller, and not using the cleanup attribute at all.

IOW, we could have things like

   #define WRAP(a,b,c) \
        ({ __typeof__(b) __ret; a; __ret =3D (b); c; __ret; })

and then you can do things like

   #define guard_fn_mutex(mutex, fn) \
        WRAP(mutex_lock(mutex), fn, mutex_unlock(mutex))

or

   #define rcu_read_action(x) WRAP(rcu_read_lock(), x, rcu_read_unlock())

and now you can easily guard the call-site (or any simple expression
that doesn't include any non-local control flow). Nothing new and
fancy required.

But when you don't want to do the wrapping in the caller, you do want
to have a non-scoping guard at the top of the function, I suspect.

                 Linus
