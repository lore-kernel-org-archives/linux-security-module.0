Return-Path: <SRS0=SKQR=64=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD47C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 14 May 2020 16:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A99392065F
	for <linux-security-module@archiver.kernel.org>; Thu, 14 May 2020 16:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgENQw5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 May 2020 12:52:57 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:44220 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgENQw4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 May 2020 12:52:56 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jZH6E-0000LW-Og; Thu, 14 May 2020 10:52:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jZH69-0007Jx-TF; Thu, 14 May 2020 10:52:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
        <87eerszyim.fsf_-_@x220.int.ebiederm.org>
        <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
        <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
        <87sgg6v8we.fsf@x220.int.ebiederm.org>
        <202005111428.B094E3B76A@keescook>
        <874kslq9jm.fsf@x220.int.ebiederm.org>
        <CAHk-=wjhmoGLcMgcDB0rT-n6waC+rdnjU3FRKAwSTMSG=gaK9Q@mail.gmail.com>
Date:   Thu, 14 May 2020 11:49:06 -0500
In-Reply-To: <CAHk-=wjhmoGLcMgcDB0rT-n6waC+rdnjU3FRKAwSTMSG=gaK9Q@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 12 May 2020 17:20:00 -0700")
Message-ID: <87zhaaea2l.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jZH69-0007Jx-TF;;;mid=<87zhaaea2l.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/S9hkDbdmo1U/5J47Uj+MjNVaSt5QThaA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, May 12, 2020 at 11:46 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> I am still thinking about this one, but here is where I am at.  At a
>> practical level passing the file descriptor of the script to interpreter
>> seems like something we should encourage in the long term.  It removes
>> races and it is cheaper because then the interpreter does not have to
>> turn around and open the script itself.
>
> Yeah, I think we should continue to support it, because I think it's
> the right thing to do (and we might just end up having compatibility
> issues if we don't).
>
> How about trying to move the logic to the common code, out of binfmt_misc?
>
> IOW, how about something very similar to your "brpm->preserve_creds"
> thing that you did for the credentials (also for binfmt_misc, which
> shouldn't surprise anybody: binfmt_misc is simply the "this is the
> generic thing for letting user mode do the final details").
>
>> Calling fd_install in binfmt_misc still seems wrong, as that exposes
>> the new file descriptor to user space with the old creds.
>
> Right.  And it really would be good to simply not have these kinds of
> very special cases inside the low-level binfmt code: I'd much rather
> have the special cases in the generic code, so that we see what the
> ordering is etc. One of the big problems with all these binfmt
> callbacks has been the fact that it makes it so hard to think about
> and change the generic code, because the low-level binfmt handlers all
> do their own special thing.
>
> So moving it to generic code would likely simplify things from that
> angle, even if the actual complexity of the feature itself remains.
>
> Besides, we really have exposed this to other code anyway thanks to
> that whole bprm->interp_data thing, and the AT_EXECFD AUX entries that
> we have. So it's not really "internal" to binfmt_misc _anyway_.
>
> So how about we just move the fd_binary logic to the generic execve
> code, and just binfmt_misc set the flag for "yes, please do this",
> exactly like "preserve_creds"?
>
>> It is possible although unlikely for userspace to find the file
>> descriptor without consulting AT_EXECFD so just to be conservative I
>> think we should install the file descriptor in begin_new_exec even if
>> the next interpreter does not support AT_EXECFD.
>
> Ack. I think the AT_EXECFD thing is a sign that this isn't internal to
> binfmt_misc, but it also shouldn't be gating this issue. In reality,
> ELF is the only real binary format that matters - the script/misc
> binfmts are just indirection entries - and it supports AT_EXECFD, so
> let's just ignore the theoretical case of "maybe nobody exposes it".
>
> So yes, just make it part of begin_new_exec(), and there's no reason
> to support more than a single fd. No stacks or arrays of these things
> required, I feel. It's not like AT_EXECFD supports the notion of
> multiple fd's being reported anyway, nor does it make any sense to
> have some kind of nested misc->misc binfmt nesting.
>
> So making that whole interp_data and fd_binary thing be a generic
> layer thing would make the search_binary_handler() code in binfmt_misc
> be a pure tailcall too, and then the conversion to a loop ends up
> working and being the right thing.

That is pretty much what I have been thinking.  I have just been taking
it slow so I find as many funny corner cases as I can.

Nothing ever clears the BINPRM_FLAGS_EXECFD so the current code can
not support nesting.

Now I do think a nested misc->misc binfmt thing can make sense in
principal.  I have an old dos spectrum emulator that I use to play some
of the games that I grew up with.  Running that emulator makes me two
emulators deep.  I can also imagine writting a domain specific language
in python or perl, and setting things up so scripts in the domain
specific language can be run directly.

So I think I need to deliberately test and prevent a nested misc->misc,
just so data structures don't get stomped.  If the cases where it could
useful prove sufficiently interesting we can enable them later.

Eric
