Return-Path: <SRS0=coct=7B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74DCC433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 19:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21F62075F
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 19:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgESTHJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 May 2020 15:07:09 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37846 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTHI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 May 2020 15:07:08 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7Zx-0007pH-RU; Tue, 19 May 2020 13:07:05 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7Zw-0008Ly-Mw; Tue, 19 May 2020 13:07:05 -0600
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
        <87o8qkzrxp.fsf_-_@x220.int.ebiederm.org>
        <202005191111.9B389D33@keescook>
Date:   Tue, 19 May 2020 14:03:23 -0500
In-Reply-To: <202005191111.9B389D33@keescook> (Kees Cook's message of "Tue, 19
        May 2020 11:21:34 -0700")
Message-ID: <875zcrpx1g.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jb7Zw-0008Ly-Mw;;;mid=<875zcrpx1g.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19uLsQEsrbyURG9a1RrgL6bJSOQRT5dyK8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 3/8] exec: Convert security_bprm_set_creds into security_bprm_repopulate_creds
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Kees Cook <keescook@chromium.org> writes:

> On Mon, May 18, 2020 at 07:31:14PM -0500, Eric W. Biederman wrote:
>> 
>> Rename bprm->cap_elevated to bprm->active_secureexec and initialize it
>> in prepare_binprm instead of in cap_bprm_set_creds.  Initializing
>> bprm->active_secureexec in prepare_binprm allows multiple
>> implementations of security_bprm_repopulate_creds to play nicely with
>> each other.
>> 
>> Rename security_bprm_set_creds to security_bprm_reopulate_creds to
>> emphasize that this path recomputes part of bprm->cred.  This
>> recomputation avoids the time of check vs time of use problems that
>> are inherent in unix #! interpreters.
>> 
>> In short two renames and a move in the location of initializing
>> bprm->active_secureexec.
>
> I like this much better than the direct call to the capabilities hook.
> Thanks!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> One nit is a bikeshed on the name "active_secureexec", since
> the word "active" isn't really associated with any other part of the
> binfmt logic. It's supposed to be "latest state from the binfmt loop",
> so instead of "active", I considered these words that I also didn't
> like: "current", "this", "recent", and "now". Is "latest" better than
> "active"? Probably not.

I had pretty much the same problem.  Active at least conveys that it
is still malleable and might change.

>> [...]
>> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
>> index d1217fcdedea..8605ab4a0f89 100644
>> --- a/include/linux/binfmts.h
>> +++ b/include/linux/binfmts.h
>> @@ -27,10 +27,10 @@ struct linux_binprm {
>>  	unsigned long argmin; /* rlimit marker for copy_strings() */
>>  	unsigned int
>>  		/*
>> -		 * True if most recent call to cap_bprm_set_creds
>> +		 * True if most recent call to security_bprm_set_creds
>>  		 * resulted in elevated privileges.
>>  		 */
>> -		cap_elevated:1,
>> +		active_secureexec:1,
>
> Also, I'd like it if this comment could be made more verbose as well, for
> anyone trying to understand the binfmt execution flow for the first time.
> Perhaps:
>
> 		/*
> 		 * Must be set True during the any call to
> 		 * bprm_set_creds hook where the execution would
> 		 * reuslt in elevated privileges. (The hook can be
> 		 * called multiple times during nested interpreter
> 		 * resolution across binfmt_script, binfmt_misc, etc).
> 		 */
Well it is not during but after the call that it becomes true.
I think most recent covers the case of multiple calls.

I think having the loop explicitly in the code a few patches
later makes it clear that there is a loop dealing with interpreters.

Conciseness has a virtue in that it is easy to absorb.  Seeing
active says most recent and secureexec does not is enough to ask
questions and look at the code.

Eric

