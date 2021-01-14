Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1B3C433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Jan 2021 03:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF7623741
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Jan 2021 03:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbhANDYF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Jan 2021 22:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbhANDX6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Jan 2021 22:23:58 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E608C061795
        for <linux-security-module@vger.kernel.org>; Wed, 13 Jan 2021 19:23:18 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id f17so4886707ljg.12
        for <linux-security-module@vger.kernel.org>; Wed, 13 Jan 2021 19:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FEfB7z2Pg3tEbsUuKrEZpLqRqQiSI7cwvfIpRmMaPsg=;
        b=ERDheW9rkL9QnlcBk+gjMEWNicKOrODmm03n00UhTyuOanz3yIf+tVQ2IhyWO8CwON
         GKpMHZiqMwxQyAHoTp5gWGJ9T/9Cv+QqTqzD/Q0j7l6WJ3FK2LOR2lYJleXMUi/HaPtq
         hAo0tLKKn2Q7t/UBKM4+ZCJT32+rgjpcSTro39e8R9WGksf2PWbqS4pLDiAzVnHdQwFS
         cKqbNI76NaFU69m3LsyPmjdP3CzRq2oPRT9ho+fOAmBKu1eGIxoQiB5laGLfmKCFbLTh
         A+1wPcGioLznXyUUcakh1ovdoJ4a55uHhp/zcRprrvdM7164eLO9rwAW7zpziuw26kme
         wiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FEfB7z2Pg3tEbsUuKrEZpLqRqQiSI7cwvfIpRmMaPsg=;
        b=d5xKsUrkv+exJol5q9omJ6kFL2xJ+eaSkdPP8XZYuSWz/fMbzKhJhtlelWi5uu+ZZ9
         eSBdBrQcyvBn0cWQycNiosQQ4s296ekERzkjE2OE43w+dSPye7zajfRQv5LOFgfescbF
         1DjUPh9eZczOZ49ul5Nb7V4aa/1kDuoOp6vciTUxP2As0yQ3fiuJC1Kq+/D/xt0vB8S3
         vq+dd09mPpWJFJwD3gt0x2Bx0crlEKLOQIz0MSWfvEd1YTyaAWr277aKmFcMEW4IvB81
         gV7GGTavp0xRqt90HM18Q7uLAgzqoCQeXWU4BEMrkDb8EOGAB9AlotMIfqO2AMIvvRbQ
         ELLg==
X-Gm-Message-State: AOAM530zGkGFBjwDIa3aNClM9FujTHhcmyflyvjbLaB50rC7UcX3tcUP
        WOAy2EkJ6vwxr4SLh2k5ZXaaJYx5bN9jGqb+XE2gpw==
X-Google-Smtp-Source: ABdhPJzfRhrd1kMrfF3j3pfT5UxcaTNs6jz7zJ40MKXw+hJC73ejwL+h4IUubxMUXNGPVLdYIr3TdisY3PE9ZGevcmg=
X-Received: by 2002:a2e:593:: with SMTP id 141mr2267937ljf.86.1610594596352;
 Wed, 13 Jan 2021 19:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20201209192839.1396820-1-mic@digikod.net>
In-Reply-To: <20201209192839.1396820-1-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 14 Jan 2021 04:22:50 +0100
Message-ID: <CAG48ez3DE8xgr_etVGV5eNjH2CXXo9MR7jTcu+_LCkJUchLXcQ@mail.gmail.com>
Subject: Re: [PATCH v26 00/12] Landlock LSM
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 9, 2020 at 8:28 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
> This patch series adds new built-time checks, a new test, renames some
> variables and functions to improve readability, and shift syscall
> numbers to align with -next.

Sorry, I've finally gotten around to looking at v26 - I hadn't
actually looked at v25 either yet. I think there's still one remaining
small issue in the filesystem access logic, but I think that's very
simple to fix, as long as we agree on what the expected semantics are.
Otherwise it basically looks good, apart from some typos.

I think v27 will be the final version of this series. :) (And I'll try
to actually look at that version much faster - I realize that waiting
for code reviews this long sucks.)
