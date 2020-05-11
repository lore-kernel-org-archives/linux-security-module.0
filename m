Return-Path: <SRS0=NXRd=6Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF59AC54E8D
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 14:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C470320722
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 14:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbgEKOhH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 May 2020 10:37:07 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54932 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgEKOhG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 May 2020 10:37:06 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jY9Y5-0000jJ-D7; Mon, 11 May 2020 08:36:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jY9Y4-0003I8-ID; Mon, 11 May 2020 08:36:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
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
        <87eerszyim.fsf_-_@x220.int.ebiederm.org>
        <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
        <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
Date:   Mon, 11 May 2020 09:33:21 -0500
In-Reply-To: <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
        (Linus Torvalds's message of "Sun, 10 May 2020 12:38:20 -0700")
Message-ID: <87sgg6v8we.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jY9Y4-0003I8-ID;;;mid=<87sgg6v8we.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/csdb/igOrSyXjCRUr34F0lHFKDweqaq4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, May 9, 2020 at 9:30 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Wouldn't this change cause
>>
>>         if (fd_binary > 0)
>>                 ksys_close(fd_binary);
>>         bprm->interp_flags = 0;
>>         bprm->interp_data = 0;
>>
>> not to be called when "Search for the interpreter" failed?
>
> Good catch. We seem to have some subtle magic wrt the fd_binary file
> descriptor, which depends on the recursive behavior.

Yes.  I Tetsuo I really appreciate you noticing this.  This is exactly
the kind of behavior I am trying to flush out and keep from being
hidden.

> I'm not seeing how to fix it cleanly with the "turn it into a loop".
> Basically, that binfmt_misc use-case isn't really a tail-call.

I have reservations about installing a new file descriptor before
we process the close on exec logic and the related security modules
closing file descriptors that your new credentials no longer give
you access to logic.

I haven't yet figured out how opening a file descriptor during exec
should fit into all of that.



What I do see is that interp_data is just a parameter that is smuggled
into the call of search binary handler.  And the next binary handler
needs to be binfmt_elf for it to make much sense, as only binfmt_elf
(and binfmt_elf_fdpic) deals with BINPRM_FLAGS_EXECFD.


So I think what needs to happen is to rename bprm->interp_data to
bprm->execfd, remove BINPRM_FLAGS_EXECFD and make closing that file
descriptor free_bprm's responsiblity.

I hope such a change will make it easier to see all of the pieces that
are intereacting during exec.

I am still asking: is the installation of that file descriptor useful if
it is not exported passed to userspace as an AT_EXECFD note?


I will dig in and see what I can come up with.

Eric


