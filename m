Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E2CC7EE2E
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Jun 2023 18:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjFLS4i (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFLS4i (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Jun 2023 14:56:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F171C189
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 11:56:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so5790077e87.2
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686596195; x=1689188195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yhv8xsO6/cG6/37ib7eGERu4MLsFMvugXkXspF4Zlg=;
        b=a4RZUbAJy4Am1UfDus82nC8KPUnkPpYPtBoxUF2i6ShepOovGUeKy0xlt6CvJ+krmK
         SmXX5gqwjbaIfbtNNrj/xGz13F2Sb4OX+lVP1BTESgRPLcAhRhBKqrtORhi20R+QqM0Q
         SHiNLPlcmr9Yo3sN30f0GyHqTUAjQOPDgSJgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686596195; x=1689188195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yhv8xsO6/cG6/37ib7eGERu4MLsFMvugXkXspF4Zlg=;
        b=SvorwbB+cBstgxR0dJ5xa86oCD83XrpkeZzMpUpmlltwiyZquUVRmFxlp+n2y4zl1S
         eENYvSNm9Ch6CW0/O+z0gnP4vyHllWQJD2aViLYt2eMneo707keZC7kadptrH5eOON92
         k+iBFlXwPeXwYDUDARDbjk8Gs3/9rScWIYfDyHwEOFF0/f5YCVYjshT2BpsnXzHKTVrv
         B7QTQ8cSyfYs1QCUTkNRdf7A3B9bwf/PLXAMOqDe6okr+oJk+uQxtYUhoU08Yok7U7G2
         2+vtlz1V/5Ht5ja/vIT8XJsK1oXL0IQ7cORnCRAu7BmYguMgXkEVT3KhrN8dHBMDlD/V
         c/Ag==
X-Gm-Message-State: AC+VfDwwArXIn808+zj0fsnBdnBhOQSocp0Nl11gl/j3vjXn/PAwva7a
        x7ZTDtfaEz31DUbLZ++9YGk2Glh9gI+QC3PWtNwaJmuh
X-Google-Smtp-Source: ACHHUZ79TxLb8j/8v2+bDdyJ4KmmtD/1N5JlgxC++5gdyK8sYfs+xwCPELTTyeJRvFyspg12Zei3FA==
X-Received: by 2002:ac2:5b9a:0:b0:4f6:47a2:7bb4 with SMTP id o26-20020ac25b9a000000b004f647a27bb4mr4700946lfn.60.1686596195397;
        Mon, 12 Jun 2023 11:56:35 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id g12-20020a19ee0c000000b004f27471e0aesm1504177lfb.79.2023.06.12.11.56.34
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 11:56:35 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f658a17aa4so4693951e87.0
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 11:56:34 -0700 (PDT)
X-Received: by 2002:aa7:d841:0:b0:516:b182:4e58 with SMTP id
 f1-20020aa7d841000000b00516b1824e58mr5590497eds.32.1686596174182; Mon, 12 Jun
 2023 11:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093539.895253662@infradead.org>
 <CAHk-=wgPtj9Y+nkMe+s20sntBPoadKL7GLxTr=mhfdONMR=iZg@mail.gmail.com> <20230612184403.GE83892@hirez.programming.kicks-ass.net>
In-Reply-To: <20230612184403.GE83892@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 11:55:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaSkM4fjdP9dcdXQpLLjxW43ykgLA=FgzyHpyHayz8ww@mail.gmail.com>
Message-ID: <CAHk-=wgaSkM4fjdP9dcdXQpLLjxW43ykgLA=FgzyHpyHayz8ww@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 12, 2023 at 11:44=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> I tried this before I used it and variables inside a for() loop have a
> scope of a single iteration.

Whee. Ok, that surprised me. But I guess that I shouldn't have found
it surprising, since the value doesn't survive from one iteration to
the next.

My mental picture of the scope was just different - and apparently wrong.

But thinking about it, it's not just that the value doesn't survive,
it's also that the "continue" will exit the scope in order to go back
to the "for()" loop.

I guess the "goto repeat" ends up being similar, since - as Ian Lance
Taylor said in one of the earlier discussions - that "__cleanup__"
ends up creating an implicit hidden scope for the variable. So a
'goto' to before the variable was declared implicitly exits the scope.

Ugh. I do really hate how subtle that is, though.

So while it might not be the horrible bug I thought it was, I'd
_really_ like us to not do those things just from a sanity angle.

                 Linus
