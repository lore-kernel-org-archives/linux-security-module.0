Return-Path: <SRS0=vtOa=7M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EE5C433E0
	for <linux-security-module@archiver.kernel.org>; Sat, 30 May 2020 03:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CCE22076B
	for <linux-security-module@archiver.kernel.org>; Sat, 30 May 2020 03:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgE3D2C (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 May 2020 23:28:02 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:54076 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgE3D2B (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 May 2020 23:28:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jesA5-0006lX-96; Fri, 29 May 2020 21:27:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jesA4-0005Dm-Bt; Fri, 29 May 2020 21:27:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
        <87d06mr8ps.fsf_-_@x220.int.ebiederm.org>
        <877dwur8nj.fsf_-_@x220.int.ebiederm.org>
        <202005291403.BCDBFA7D1@keescook>
Date:   Fri, 29 May 2020 22:23:58 -0500
In-Reply-To: <202005291403.BCDBFA7D1@keescook> (Kees Cook's message of "Fri,
        29 May 2020 14:06:33 -0700")
Message-ID: <87k10unm0h.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jesA4-0005Dm-Bt;;;mid=<87k10unm0h.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18T3f2u8gHGrtWAPt/SgvEWL29Ef0wVq/8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/2] exec: Add a per bprm->file version of per_clear
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Kees Cook <keescook@chromium.org> writes:

> On Fri, May 29, 2020 at 11:46:40AM -0500, Eric W. Biederman wrote:
>> 
>> There is a small bug in the code that recomputes parts of bprm->cred
>> for every bprm->file.  The code never recomputes the part of
>> clear_dangerous_personality_flags it is responsible for.
>> 
>> Which means that in practice if someone creates a sgid script
>> the interpreter will not be able to use any of:
>> 	READ_IMPLIES_EXEC
>> 	ADDR_NO_RANDOMIZE
>> 	ADDR_COMPAT_LAYOUT
>> 	MMAP_PAGE_ZERO.
>> 
>> This accentially clearing of personality flags probably does
>> not matter in practice because no one has complained
>> but it does make the code more difficult to understand.
>> 
>> Further remaining bug compatible prevents the recomputation from being
>> removed and replaced by simply computing bprm->cred once from the
>> final bprm->file.
>> 
>> Making this change removes the last behavior difference between
>> computing bprm->creds from the final file and recomputing
>> bprm->cred several times.  Which allows this behavior change
>> to be justified for it's own reasons, and for any but hunts
>> looking into why the behavior changed to wind up here instead
>> of in the code that will follow that computes bprm->cred
>> from the final bprm->file.
>> 
>> This small logic bug appears to have existed since the code
>> started clearing dangerous personality bits.
>> 
>> History Tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
>> Fixes: 1bb0fa189c6a ("[PATCH] NX: clean up legacy binary support")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Yup, this looks good. Pointless nit because it's removed in the next
> patch, but pf_per_clear is following the same behavioral pattern as
> active_secureexec, it could be named active_per_clear, but since this
> already been bikeshed in v1, it's fine! :)

That plus it is very much true that active_ isn't a particularly good
prefix.  pf_ for per_file seems slightly better.

The only time I can imagine this patch seeing the light of day is if
someone happens to discover that this fixes a bug for them and just this
patch is backported.  At which point pf_per_clear pairs with
cap_elevated.  So I don't think it hurts.

*Shrug*

The next patch is my long term solution to the mess.

> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> I wish we had more robust execve tests. :(

I think you have more skill at writing automated tests than I do.  So
feel free to write some.

Eric
