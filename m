Return-Path: <SRS0=coct=7B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5552C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 19:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3BC42075F
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 19:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgESTMX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 May 2020 15:12:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39744 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgESTMW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 May 2020 15:12:22 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7ez-0008UU-9H; Tue, 19 May 2020 13:12:17 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7ey-00014b-3r; Tue, 19 May 2020 13:12:16 -0600
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
        <87imgszrwo.fsf_-_@x220.int.ebiederm.org>
        <202005191122.0A1FD07@keescook>
Date:   Tue, 19 May 2020 14:08:34 -0500
In-Reply-To: <202005191122.0A1FD07@keescook> (Kees Cook's message of "Tue, 19
        May 2020 11:27:25 -0700")
Message-ID: <87sgfvoi8d.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jb7ey-00014b-3r;;;mid=<87sgfvoi8d.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/kgQUwX+CSXDS53ITr/pklJfenYpzNP1g=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 4/8] exec: Allow load_misc_binary to call prepare_binfmt unconditionally
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Kees Cook <keescook@chromium.org> writes:

> On Mon, May 18, 2020 at 07:31:51PM -0500, Eric W. Biederman wrote:
>> 
>> Add a flag preserve_creds that binfmt_misc can set to prevent
>> credentials from being updated.  This allows binfmt_misc to always
>> call prepare_binfmt.  Allowing the credential computation logic to be
>
> typo: prepare_binprm()

Thank you.

>> consolidated.
>> 
>> Not replacing the credentials with the interpreters credentials is
>> safe because because an open file descriptor to the executable is
>> passed to the interpreter.   As the interpreter does not need to
>> reopen the executable it is guaranteed to see the same file that
>> exec sees.
>
> Yup, looks good. Note below on comment.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
>> [...]
>> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
>> index 8605ab4a0f89..dbb5614d62a2 100644
>> --- a/include/linux/binfmts.h
>> +++ b/include/linux/binfmts.h
>> @@ -26,6 +26,8 @@ struct linux_binprm {
>>  	unsigned long p; /* current top of mem */
>>  	unsigned long argmin; /* rlimit marker for copy_strings() */
>>  	unsigned int
>> +		/* It is safe to use the creds of a script (see binfmt_misc) */
>> +		preserve_creds:1,
>
> How about:
>
> 		/*
> 		 * A binfmt handler will set this to True before calling
> 		 * prepare_binprm() if it is safe to reuse the previous
> 		 * credentials, based on bprm->file (see binfmt_misc).
> 		 */

I think that is more words saying less.

While I agree it might be better.  I don't see what your comment adds to
the understanding.  What do you see my comment not saying that is important?

Eric

