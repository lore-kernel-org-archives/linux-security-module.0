Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED96C48BDF
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jun 2021 20:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EDE6611C0
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jun 2021 20:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhFOUm3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Jun 2021 16:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOUm1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Jun 2021 16:42:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1546EC061767
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jun 2021 13:40:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f30so389431lfj.1
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jun 2021 13:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mI+Uy62aXOt4Prq2PUS7VjWc/+uB2vw7iQueiUDdSS8=;
        b=Mh7FeTdwsPNuQXmG7HfR3LIBdVoplRNF5u49c3WP1H7V7D/qBiWT4GvO9Y7dzzPcn+
         ew8Ag5oOZ8bgypyaT2/P1u8tQ5PbJetE4Ut9i9UzFsBjnbjO828Gsuq37QBJEu78eKOt
         Sp3tWASzcB6xeHqyrYFLI808p9ELdvkHism3yPJsmQz8MOMrKe1ixjfHTBXT4yZdKdad
         tmLWT5MqbxYcCWpyR9XO7lri4REO9Y3KpaIZEiuveOuK65fvCplnDv4onYmdaK+gwiIu
         akr9s0n4/tEXQMlUWmPYPh6ACLN6zEHT5SysQUapNW7MvBt2OJGJs8yxLcrVSVFROIPr
         rCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mI+Uy62aXOt4Prq2PUS7VjWc/+uB2vw7iQueiUDdSS8=;
        b=eru38i/rOOEl4qFZrM8bu3UlMruLQ3qTPlA6zVQWdiIQIF6u5yLe2K0Gf9wDSNy5n4
         XA8gmRlKpgEDj4cP3XHnbY0/opezyvCnlsnZ6cToEXgccKM95pYz2zMyxRyAQXr6lTDM
         09pSPPMJW9fzsTGgfaJ1HFWVwZTeMymo6V5mTLSW80SRw61lvzaA3IlUQXmNvNHueVxx
         oXdgs8jLwtWhsiWPH8i0m4qqWq32JEuYMs+ddVKiDMNSRaRwINcwOsxsOxOs1vEpv7Al
         Gmp3oPVQ5P1GDgHB9A7js2UM36HCRBthupWSmna1n0pfzBYk5K9a2PbKzEVIOGZ+q73N
         /snw==
X-Gm-Message-State: AOAM530kx/1K5sAN5SDn/DU0h7iT4/wucIuSi2fTFc482HiBi1l0MJXJ
        NznEhykaoc165Ba61+kNZbYJmGhJZxA0mgqULA4sNg==
X-Google-Smtp-Source: ABdhPJx1gbrC8KfLRm7B88Z6r8LHurBrUrh8s9fWk20QPNqr6pDnATaWEh20Le8JHYfS0fYEB46Ujv1/uF4jUbe2hao=
X-Received: by 2002:a05:6512:3287:: with SMTP id p7mr830016lfe.213.1623789620074;
 Tue, 15 Jun 2021 13:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-9-davidgow@google.com>
In-Reply-To: <20210513193204.816681-9-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 15 Jun 2021 13:40:09 -0700
Message-ID: <CAFd5g46n10ELbGYf8gR_uUT0kfxDDe4nFoGh-t64zzX747pnUA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] apparmor: test: Remove some casts which are
 no-longer required
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 13, 2021 at 12:36 PM David Gow <davidgow@google.com> wrote:
>
> With some of the stricter type checking in KUnit's EXPECT macros
> removed, several casts in policy_unpack_test are no longer required.
>
> Remove the unnecessary casts, making the conditions clearer.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
