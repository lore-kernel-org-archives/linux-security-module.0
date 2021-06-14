Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974DFC2B9F4
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Jun 2021 18:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76302610A3
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Jun 2021 18:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhFNSGI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Jun 2021 14:06:08 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:36504 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbhFNSGI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Jun 2021 14:06:08 -0400
Received: by mail-lj1-f174.google.com with SMTP id 131so21416636ljj.3
        for <linux-security-module@vger.kernel.org>; Mon, 14 Jun 2021 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hth5OJx5DLnrqVkGsO9sFZaOxm24SUjgcf7q16vYO9k=;
        b=SYh2bWEUABHXqRB6ouYLMnFXIxkuBj3g9OGoJcjymr/uDkZ0b2ocpQIxY7OD3aoqry
         y/WDysWKakiopu5mag8D+4V2VdjD01blp+N5edF/BQ0EXgzT8QLbBsWXILbf7+h84XUb
         ftZIOw1NIhwgxMzRUzmXKeXGQC6u8yO//bp98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hth5OJx5DLnrqVkGsO9sFZaOxm24SUjgcf7q16vYO9k=;
        b=DUWug5xEhfeNZgEMRhSXNRoZlukkoi9gJGudMnY0BQ+ifMZEIsAbUzjiSAMh8MR9aO
         056FhiKhG2hdDH8BIvMdhRKXHZhaYsnREpZPlAFY2vb0g0uJ3jnwgKhITtEZCqTl2STJ
         lyatkdISGkL8gD+Wg4/fNP7ohTGX4UxOvA0sTi02l7zXeudKc3214b9nazfxoOAnKrsW
         5I8n2dYFDSevJSortBgG7QyQquIDMYKKAT6FksjArHjNcENuJ7A7vAP0DyEzLGd+sAoC
         oYvZ8EhyocDrZJutgLwWKOe3LMEGO3kmbC7ICAyXPmZpxP3DKHgFia0KpDzndnqHH7ue
         GhAQ==
X-Gm-Message-State: AOAM530NOrVa41o7gSBgEUMCQX+NzSkEnMfZ9mpnvCv4yd1jqI2C6pTC
        sdvQbLkF20I4zJJO59H+lakxhUBl6bvRpNy5qxM=
X-Google-Smtp-Source: ABdhPJzve0DAaB3i1iNU+6eOd8Eg/bRl33uKHSxb7nk9+oM+HBxVOMJaRKigMxHadEPIWPVKOZFkVQ==
X-Received: by 2002:a05:651c:391:: with SMTP id e17mr14511978ljp.257.1623693783636;
        Mon, 14 Jun 2021 11:03:03 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id m29sm1547462lfp.203.2021.06.14.11.03.02
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 11:03:02 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id f30so22556556lfj.1
        for <linux-security-module@vger.kernel.org>; Mon, 14 Jun 2021 11:03:02 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr12358175lfa.421.1623693782157;
 Mon, 14 Jun 2021 11:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210608171221.276899-1-keescook@chromium.org>
 <20210614100234.12077-1-youling257@gmail.com> <202106140826.7912F27CD@keescook>
 <202106140941.7CE5AE64@keescook>
In-Reply-To: <202106140941.7CE5AE64@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Jun 2021 11:02:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLBq63v_h71YuBM2aNjCSBprkBEO3fevbWnkp8TDeh5g@mail.gmail.com>
Message-ID: <CAHk-=whLBq63v_h71YuBM2aNjCSBprkBEO3fevbWnkp8TDeh5g@mail.gmail.com>
Subject: Re: [PATCH] proc: Track /proc/$pid/attr/ opener mm_struct
To:     Kees Cook <keescook@chromium.org>
Cc:     youling257 <youling257@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, regressions@lists.linux.dev,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 14, 2021 at 9:45 AM Kees Cook <keescook@chromium.org> wrote:
>
>         /* A task may only write when it was the opener. */
> -       if (file->private_data != current->mm)
> +       if (!file->private_data || file->private_data != current->mm)

I don't think this is necessary.

If file->private_data is NULL, then the old test for private_data !=
current->mm will still work just fine.

Because if you can fool kernel threads to do the write for you, you
have bigger security issues than that test.

               Linus
