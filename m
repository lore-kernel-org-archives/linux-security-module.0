Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CE7C433C1
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Mar 2021 06:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF7C6192E
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Mar 2021 06:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhCaGDi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 31 Mar 2021 02:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbhCaGDM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Mar 2021 02:03:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EBBC06175F
        for <linux-security-module@vger.kernel.org>; Tue, 30 Mar 2021 23:03:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x126so13740708pfc.13
        for <linux-security-module@vger.kernel.org>; Tue, 30 Mar 2021 23:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GmdAprXBSLF+KiQkRQ1q6vYXVXHwCxP7HlnSoKUve+E=;
        b=a72k4tykYSfcww6NBUiHL0zy6aIlNDSB4CejRuiPqncwpwT/iOS2lob/SKlfYsiX8m
         +R6f4d4BT27SSqjP1AKEG+4/D6fahhWMM9Fz8Q+EvonjBqKyTPx8CJQuhUtZ/XUMRAHs
         K1lqi4wk7ikNlzv/JVBK0PZTK2/WB92FEOAUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GmdAprXBSLF+KiQkRQ1q6vYXVXHwCxP7HlnSoKUve+E=;
        b=MX1nnQO9gyPh17XExS0QtJ3K/2OSrcfO0SLuED/4s4GWp+z9O7tW89dnykoXXM0pYx
         BSV6bWxAyIZutHg33ac0Onf33Eu0HSQKCn7N9Stv/8jTJO+LGl36C3wcQprAjshkExZC
         qGltcAhP/ANRuTSa8Jfq5msY41Vbhdm5HZVY+Mtg8FNBbu8JNoKlf85MWYQH0CZzC82n
         ejD7+P2t455kYxUWZw04Dohvrvo9RxBqGpuKYWQcwG//CYKaSuUPPvY/rCmWThT6YUNZ
         lMj2FLUuDSX3vk4fIrP9zal2TswF6lSJrpXiZS3OA/sgPNK8gI2kobDqIq9ctWMHYEdJ
         bi3Q==
X-Gm-Message-State: AOAM533KK92iNAkzKKDCR/YDCbFAP7tdUzfXT8EKsOVV7xx1C029ZyJ7
        PajfIbUayas2fpqcBxQ2YuI6sg==
X-Google-Smtp-Source: ABdhPJxmNy7PylTCLuqIaivE7U+e509y9y5sjk/y3ctOSW8bh+OYWli4WsmRUOoAPXMhkYHa18YcNg==
X-Received: by 2002:a65:6a0e:: with SMTP id m14mr1700967pgu.448.1617170591906;
        Tue, 30 Mar 2021 23:03:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 190sm1107681pgh.61.2021.03.30.23.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 23:03:11 -0700 (PDT)
Date:   Tue, 30 Mar 2021 23:03:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v5 1/1] fs: Allow no_new_privs tasks to call chroot(2)
Message-ID: <202103302249.6FE62C03@keescook>
References: <20210316203633.424794-1-mic@digikod.net>
 <20210316203633.424794-2-mic@digikod.net>
 <fef10d28-df59-640e-ecf7-576f8348324e@digikod.net>
 <85ebb3a1-bd5e-9f12-6d02-c08d2c0acff5@schaufler-ca.com>
 <b47f73fe-1e79-ff52-b93e-d86b2927bbdc@digikod.net>
 <77ec5d18-f88e-5c7c-7450-744f69654f69@schaufler-ca.com>
 <a8b2545f-51c7-01dc-1a14-e87beefc5419@digikod.net>
 <2fcff3d7-e7ca-af3b-9306-d8ef2d3fb4fb@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fcff3d7-e7ca-af3b-9306-d8ef2d3fb4fb@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 30, 2021 at 03:53:37PM -0700, Casey Schaufler wrote:
> If you need to run legitimate SETUID (or file capability enabled) binaries
> you can't use NO_NEW_PRIVS. You can use CAP_SYS_CHROOT, because capabilities
> where designed to work with the UID mechanisms.

All the discussion of "designing a system" around the isolation is
missing the point here: this is designed so that no system owner
coordination is needed. An arbitrary process can set no_new_privs and
then confine itself in a chroot. There is no need for extra privileges,
etc, etc. There shouldn't be a need for a privileged environment to
exist just to let a process confine itself. This is why seccomp is
generally so useful, and why Landlock is important: no coordination with
the system owner is needed to shed attack surface.

> In any case, if you can get other people to endorse your change I'm not
> all that opposed to it. I think it's gratuitous. It irks me that you're
> unwilling to use the facilities that are available, and instead want to
> complicate the security mechanisms and policy further. But, that hasn't
> seemed to stop anyone before.

There's a difference between "designing a system" and "designing a
process". No privileges are needed to use seccomp, for example.

The only part of this design that worries me is that it seems as though
it's still possible to escape the chroot if a process didn't set up its fds carefully, as Jann discussed earlier:
https://lore.kernel.org/lkml/c7fbf088-02c2-6cac-f353-14bff23d6864@digikod.net/

Regardless, I still endorse this change because it doesn't make things
_worse_, since without this, a compromised process wouldn't need ANY
tricks to escape a chroot because it wouldn't be in one. :) It'd be nice
if there were some way to make future openat() calls be unable to
resolve outside the chroot, but I view that as an enhancement.

But, as it stands, I think this makes sense and I stand by my
Reviewed-by tag. If Al is too busy to take it, and James would rather
not take VFS, perhaps akpm would carry it? That's where other similar
VFS security work has landed.

-- 
Kees Cook
