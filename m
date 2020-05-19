Return-Path: <SRS0=coct=7B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5FEC433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 19:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED884206C3
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 19:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgESTA4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 May 2020 15:00:56 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60704 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgESTA4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 May 2020 15:00:56 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7Tu-00039F-E2; Tue, 19 May 2020 13:00:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7Tt-0007tH-FD; Tue, 19 May 2020 13:00:50 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <871rng22dm.fsf_-_@x220.int.ebiederm.org>
        <202005191101.1D420E03@keescook>
        <CAHk-=wjeoeh-F-PJmpYRpR_HoiB4r4qYgd3U6igtrUD6q5d_cg@mail.gmail.com>
Date:   Tue, 19 May 2020 13:57:07 -0500
In-Reply-To: <CAHk-=wjeoeh-F-PJmpYRpR_HoiB4r4qYgd3U6igtrUD6q5d_cg@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 19 May 2020 11:28:14 -0700")
Message-ID: <87k117pxbw.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jb7Tt-0007tH-FD;;;mid=<87k117pxbw.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19MrUcNnkuFTMNeQJe1Nc0NOcGbTYorMS0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 1/8] exec: Teach prepare_exec_creds how exec treats uids & gids
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, May 19, 2020 at 11:03 AM Kees Cook <keescook@chromium.org> wrote:
>>
>> One question, though: why add this, since the repeat calling of the caps
>> LSM hook will do this?
>
> I assume it's for the "preserve_creds" case where we don't even end up
> setting creds at all.
>
> Yeah, at some point we'll hit a bprm handler that doesn't set
> 'preserve_creds', and it all does get set in the end, but that's not
> statically all that obvious.
>
> I think it makes sense to initialize as much as possible from the
> generic code, and rely as little as possible on what the binfmt
> handlers end up actually doing.

Where this initially came from was I was looking at how to clean up the
case of no_new_privs/ptrace of a suid executable when we don't have
enough permissions.   Just being able to create creds that kept
everything as they were looked very useful and there was just this one
little bit missing.

I included the change to prepare_exec_creds in this patchset to
emphasize that neither security_bprm_creds_for_exec nor
security_bprm_repopulate_creds need to do anything if there is nothing
special going on.

At the very least that helps me think through what the LSMs are required
to do, and what those hooks are for.  AKA privilege changing execs.

So I was thinking rely on the LSMs as little as possible rather than
rely on the binfmt handlers as little as possible.  But it is the same
idea.

And yes it makes everything easier to analyze if everything starts off
in a known good state.

Eric
