Return-Path: <SRS0=Tuew=EE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46254C4363A
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Oct 2020 01:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EEF20790
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Oct 2020 01:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ug/McNP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgJ2BIv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730865AbgJ2BGK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 28 Oct 2020 21:06:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3508DC0613D6
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2020 18:06:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c21so1320679ljj.0
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2020 18:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GGrU2z1MQIER/cvvO+UmfkeQMG5BianEcYdHiHe9qyQ=;
        b=Ug/McNP55t1xm6mf6Z65dD0d/4XLutY+oae+4KAHg9dQk7Ug4H28uN0ZtA6M7NgpbT
         I76xZ2T09J5d7Ybn9ysY9RjSdQylACxpwnNQDr/Whe2xhZiOlFqCT3OIsA9q6zLzDeCR
         81KtjKOTYR80DEEdXwrEXNgjq/YrpBGqKd9yqxwWPNsE3aR79VfrgmiIiCuvt0LOqp4p
         g9SdQ3WjkMfuDJcu5J+Ntpja9H+lqlKUJo2zM/NDZEiWEQKPOjO10MeAjoZ8CaD+3oKL
         C211FUrW1ORwXJZC8XlCmBgNTqf5GZzQLzPlE4Pp9aFCrQeZrd63oWztHdhVhAjJQL1T
         dF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GGrU2z1MQIER/cvvO+UmfkeQMG5BianEcYdHiHe9qyQ=;
        b=l02nKt2xIn8sGdqKmWbP6fos/ewHVAamr0GgzSeDR9SsPxucLDQSnbTv1Ls3V3ui3A
         nodLac7r5WGvQhNbToK8/hd/8EPOFi5X+A20vTpsPzWWAcK7iS4EwcoWnfsVojbiCYv6
         07la9rpNi21qFStB+InhYw5Il+t3a04MGJhVHkC+a+nNj15bDoh+z0SnNgv/Zy1HEU5V
         /k4sl/HFYZLHIMH0un7R5ejcJSECt4zQmWHJif46bPhK6GsMI3rUy2fIv+rY0SOmOpvf
         +7SihEOCwiSitJ8pl2dfldZOSRvsbey5e7S1gpi8TrS7RukEekKAaxBTAkJ4Tt0tJ2oj
         ChQQ==
X-Gm-Message-State: AOAM531se/1Zbiq6jXNkcxJkyemwZnq1mMt8l0dUcMmI5JjEScrh858n
        tka8LlL5MUoDeFKJGtFYZmlGIImWBvYAeoQ6umwxfw==
X-Google-Smtp-Source: ABdhPJwED9L0K+8kxvJCn6lQw5MHjDYLpGe4e16Gh7aY6DgACpmCDb7qbKA88fIn4deadsqcNqBfZ2vFqTocP7vkRyk=
X-Received: by 2002:a2e:9f13:: with SMTP id u19mr725677ljk.160.1603933566252;
 Wed, 28 Oct 2020 18:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201027200358.557003-1-mic@digikod.net>
In-Reply-To: <20201027200358.557003-1-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 02:05:39 +0100
Message-ID: <CAG48ez31oct9c8fkgFHQVb5u-o5cmwdNe2pJnmitnKcidNgfzw@mail.gmail.com>
Subject: Re: [PATCH v22 00/12] Landlock LSM
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

On Tue, Oct 27, 2020 at 9:04 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> This new patch series improves documentation, cleans up comments,
> renames ARCH_EPHEMERAL_STATES to ARCH_EPHEMERAL_INODES and removes
> LANDLOCK_ACCESS_FS_CHROOT.

Thanks for continuing to work on this! This is going to be really
valuable for sandboxing.

I hadn't looked at this series for a while; but I've now read through
it, and I don't see any major problems left. :) That said, there still
are a couple small things...
