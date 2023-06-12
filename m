Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC9CC88CBB
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Jun 2023 16:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjFLQUU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Jun 2023 12:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbjFLQUC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Jun 2023 12:20:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B961A1
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 09:20:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-977d55ac17bso825770766b.3
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686586799; x=1689178799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/KCMaMkVpL2TvKmUhvddPCRbVA7+Ro9TFJ9/0bVSYQ=;
        b=QS16iArfnEEo35M/dWzJydhjNvcABHoFw+HE/iMFYdMiZs3LAjibZnT5JngD2rvJ7S
         y4TYOMP8SpGVlLUi8RdEcxXkR8UPsQdjx4I+qy6dZ1EARWnO5QVn9h+yefN2GTQd9DQ6
         iiRYJVqOVLqmeL1OsUhw7QtbthLEKEagySCWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686586799; x=1689178799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/KCMaMkVpL2TvKmUhvddPCRbVA7+Ro9TFJ9/0bVSYQ=;
        b=Ul42uR4bvcdLcn8rpj0X5ds0m78i8Gqga0FN1lnt8by1Up/8fZC6JNgqRwvkduxPuW
         At/FHf456g4lNzvjUNPOF7wQsxBhGq88PCRMEzXhWLLlVkGWfiAXqxkkeWb2A2uN714o
         9Ppg7opSZOqLYPuoaC4AZxM0Ki3xkvy72kzNXE1ivoFwzgC4K9ZLOfka5OHXuTn+8J24
         rssbxPJB1uayO0IVWGuZjU8aEOePWLS+gkvMLR/QbJ/4DCN/cdLRNc0ZrhQRnhRnzq4J
         KV6+fyHvwI69xkr+Cas2Q9bo5KVaDvOpcG6AStdHgeM2AsipYgy4RDSAcnBH5kQ7XwiK
         OuPg==
X-Gm-Message-State: AC+VfDxxhz0vVZtUVK2TyVKDmAtT+IcpcV29Sd2Hjq5aL56VGeTgTRAL
        09gnO0/HZlBG05iK5vwWQi7p6F1jvaaQII/4CCKe+IfD
X-Google-Smtp-Source: ACHHUZ6cmhKSF1VkbVzFl9ER/GWYzGjEvkDvl5MCEFHyIuLOcW8qWa8+k2446f9zXqYGOH/jYPSLjw==
X-Received: by 2002:a17:907:60cd:b0:982:26c4:e4b0 with SMTP id hv13-20020a17090760cd00b0098226c4e4b0mr1280138ejc.6.1686586798783;
        Mon, 12 Jun 2023 09:19:58 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709066bd000b009596e7e0dbasm5402162ejs.162.2023.06.12.09.19.57
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:19:58 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so32408985e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 12 Jun 2023 09:19:57 -0700 (PDT)
X-Received: by 2002:aa7:d14e:0:b0:50b:c3f0:fb9d with SMTP id
 r14-20020aa7d14e000000b0050bc3f0fb9dmr5534541edo.41.1686586776585; Mon, 12
 Jun 2023 09:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093541.598260416@infradead.org>
In-Reply-To: <20230612093541.598260416@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:19:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6JEk7wYECcMdbXHf5ST8PAkOyUXhE8x2kqT6to+Gn9Q@mail.gmail.com>
Message-ID: <CAHk-=wh6JEk7wYECcMdbXHf5ST8PAkOyUXhE8x2kqT6to+Gn9Q@mail.gmail.com>
Subject: Re: [PATCH v3 56/57] perf: Simplify perf_pmu_output_stop()
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

This patch looks completely broken to me.

You now do

                if (err =3D=3D -EAGAIN)
                        goto restart;

*within* the RCU-guarded section, and the "goto restart" will guard it agai=
n.

So no. Sending out a series of 57 patches that can have these kinds of
bugs in it is not ok. By patch 56 (which just happened to come in
fairly early for me), all sane peoples eyes have glazed over and they
don't react to this kind of breakage any more.

                Linus

On Mon, Jun 12, 2023 at 2:39=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7977,7 +7977,8 @@ static void perf_pmu_output_stop(struct
>         int err, cpu;
>
>  restart:
> -       rcu_read_lock();
> +       /* cannot have a label in front of a decl */;
> +       guard(rcu)();
>         list_for_each_entry_rcu(iter, &event->rb->event_list, rb_entry) {
>                 /*
>                  * For per-CPU events, we need to make sure that neither =
they
> @@ -7993,12 +7994,9 @@ static void perf_pmu_output_stop(struct
>                         continue;
>
>                 err =3D cpu_function_call(cpu, __perf_pmu_output_stop, ev=
ent);
> -               if (err =3D=3D -EAGAIN) {
> -                       rcu_read_unlock();
> +               if (err =3D=3D -EAGAIN)
>                         goto restart;
> -               }
>         }
> -       rcu_read_unlock();
>  }
