Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82580C88CB2
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Jun 2023 16:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbjFLQii (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Jun 2023 12:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjFLQih (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Jun 2023 12:38:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67968E4E
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 09:38:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f654d713c0so4946884e87.3
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686587914; x=1689179914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkQkCR0zK+G1VvzG47ybOhl6nFuB5nGWY9v59LgjCEc=;
        b=QfRYTQECfsBgMvyANysDt2RqPFsfrwgoAKZdmqX3rGzWsJ3gsg3tWM3BfT3YO28z7i
         KO8y/9WDuNXKmWoTxT13cai/Wm7m4y6wPY83rl/OQK6dg+xMq3Nnii/t8HGOZfZRERRT
         1ocjt3a3ZtBIwhfj1NR06ypynKgvg6npBjc6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587914; x=1689179914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkQkCR0zK+G1VvzG47ybOhl6nFuB5nGWY9v59LgjCEc=;
        b=lKxBhIDZVSZm6LjrcN7Zlh3s4lYgn8N6jyfmQcgj+IMzQ57+XpVOSrNRe1d4jN8ZCG
         IPkQSyOhd93OXDtJByydi5h/FdymoApzcfGQUdZwJBOJjmBdCmwOfrwH4+F4XGXWiR2o
         t20GqwjVN3Byw9ezReli/dq0PsWuCDEpfqzVATCnGRXryHlQfjce6JFIXZ1D3VnNt0v+
         BR0B70vYLJQgK8QyqlKlo7zo1JjSZZuiWy1F8x4x4zSPknSO7JO7mcx7YFGoZ5EXlNC0
         sCW01WRyV8NwW5PmpGcy74lhJ6Vthet0vqBRyOgPOxYhV4bO8pGBS4vUzIKsoQ/bjJc0
         qmEA==
X-Gm-Message-State: AC+VfDytV3JTIprAWIGTAKa2XAqsRLlF5y12Oa2TaXA2FEubs/iUBSji
        /0fAm4XwMxMKUMX+AcbOkn+5L69cWeLwlK/flEL6h9MT
X-Google-Smtp-Source: ACHHUZ7ISJ/ZjOwm4imUbyfk/HGVyyaHjVwVkVMcCfFILl3zcibBz9eh5B5Sb0YytW7AmMsKBYdsBA==
X-Received: by 2002:a19:e34f:0:b0:4f6:1c08:e9bb with SMTP id c15-20020a19e34f000000b004f61c08e9bbmr3901217lfk.63.1686587914525;
        Mon, 12 Jun 2023 09:38:34 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id i9-20020ac25229000000b004f2b6a203aasm1485082lfl.224.2023.06.12.09.38.33
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:38:33 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f654d713c0so4946831e87.3
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 09:38:33 -0700 (PDT)
X-Received: by 2002:a19:e30c:0:b0:4f6:1779:b1c1 with SMTP id
 a12-20020a19e30c000000b004f61779b1c1mr5015246lfh.48.1686587892415; Mon, 12
 Jun 2023 09:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org>
In-Reply-To: <20230612090713.652690195@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:37:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3jV+v63RA30eVpjHVyrGmmTF7d3ajdV=1wBU=5OHa=A@mail.gmail.com>
Message-ID: <CAHk-=wj3jV+v63RA30eVpjHVyrGmmTF7d3ajdV=1wBU=5OHa=A@mail.gmail.com>
Subject: Re: [PATCH v3 00/57] Scope-based Resource Management
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

On Mon, Jun 12, 2023 at 2:39=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> These are by no means 'complete' convertions, I've mostly focussed on fun=
ctions
> that had 'goto' in them. Since that's a large part of why I started on al=
l this.

So I found what looks like two patches being completely broken because
the conversion was fundamentally misguided.

And honestly, by the end of walking through the patches I was just
scanning so quickly that I might have missed some.

Let's make the rule be that

 - max 10 patches in the series so that I think they were actually
thought about, and people can actually review them

 - only clear "goto out of scope" conversions. When you see a
"continue" or a "goto repeat", you TAKE A BIG STEP BACK.

Because this is all clever, and I am now happy with the syntax, but I
am *not* happy with that 60-patch monster series with what looks like
horrible bugs.

             Linus
