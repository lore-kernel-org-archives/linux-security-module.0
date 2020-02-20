Return-Path: <SRS0=0oss=4I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8BCC11D00
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Feb 2020 23:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82776207FD
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Feb 2020 23:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582239766;
	bh=TOgbi4H7jr3CTpsBJz1bxAgngam40J5kb7Ppjs26TvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RDz7ou5cYLZZPHCPmDX5rYo6VQA/bhBpwYV0OI5KTDUs8+uqWq98LtXAmWOSyFjJR
	 1Fy/QZ5+e+QJ8763HEArlxKRa12EpuhKmwHkuLG+YoS4agJxNRtkr72yT/M1gmLsuv
	 +ZQKgtzKLY6Huq6zbz3fY4aGa6RpeTbIAymL5ntE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBTXCp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:02:45 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39068 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgBTXCn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Feb 2020 18:02:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id t23so44115lfk.6
        for <linux-security-module@vger.kernel.org>; Thu, 20 Feb 2020 15:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oe6NGrWHTfgph3/inQD25AzfwK01P8Rirv0Se4y4rY=;
        b=eERYNg5pIV17feq4MuZzbw+6+6UOz8wPDMox8sHvl6LW5lyeCJiNPLjaaiAnC6tgNr
         k4eFpoUVZrOY+nWuuaeOf69/y2kMFcR2Xyd4iQCdWpyjSB4kE6JLltV8O5wbI2adfQ2q
         gkwegZ8+VoH9h8WqrHWMh85pZ16PVGc+EW3II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oe6NGrWHTfgph3/inQD25AzfwK01P8Rirv0Se4y4rY=;
        b=f6M409dZJoZe/IwB95kLYPE4Pa1893v3sh6Hhw2QFTD1UlCSDWQNRPY0m+yhZWIFy4
         fCLCkjONMvbhoAAk/q6DYnoWa+8f1fB/UGtP8zrBkPkc7rW3wTJRYHE+Kol2nDvbXyCj
         /nk11e7VetUWM0hv/grS/C44cW76oC/xWFUKFjuYtSu7lAQdujjPW6tK78IuUfhbMC+b
         KNAVqzSy9U3KB6WeJQSwMzMmzuWFMBgjpsUesG1xwIbQBj7r9wJXNp4qRS+zGcFdySvs
         hONsjEu2FskS0LckMb9EtXVBCvukuheUVhXMEvzTn+JBLmuUeArkfRz8QZkb/wqeWItS
         fFyw==
X-Gm-Message-State: APjAAAXEeJBU/nh0YN/YzcmcHUFDPZ7qH7fSNVOj4EM4pMCFdlIOnb/1
        UrBLjXllAjXZ1g7aFWV6A4HJ+/fp2hY=
X-Google-Smtp-Source: APXvYqwHQfGsqUUioRen2cClup7XkqgGUwNUTAVxWcjBC4dwf18Se5wALtbCGqWwZ4J3Ktd3YX0jog==
X-Received: by 2002:a05:6512:467:: with SMTP id x7mr3139586lfd.177.1582239760223;
        Thu, 20 Feb 2020 15:02:40 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id y8sm440473lji.56.2020.02.20.15.02.38
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 15:02:39 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id h23so193096ljc.8
        for <linux-security-module@vger.kernel.org>; Thu, 20 Feb 2020 15:02:38 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr19768759ljj.241.1582239758414;
 Thu, 20 Feb 2020 15:02:38 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org> <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 15:02:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whX7UmXgCKPPvjyQFqBiKw-Zsgj22_rH8epDPoWswAnLA@mail.gmail.com>
Message-ID: <CAHk-=whX7UmXgCKPPvjyQFqBiKw-Zsgj22_rH8epDPoWswAnLA@mail.gmail.com>
Subject: Re: [PATCH 0/7] proc: Dentry flushing without proc_mnt
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 20, 2020 at 12:48 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Linus, does this approach look like something you can stand?

A couple of worries, although one of them seem to have already been
resolved by Al.

I think the real gatekeeper should be Al in general.  But other than
the small comments I had, I think this might work just fine.

Al?

           Linus
