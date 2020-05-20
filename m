Return-Path: <SRS0=Q/5P=7C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C1AC433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 20 May 2020 16:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071D4206F1
	for <linux-security-module@archiver.kernel.org>; Wed, 20 May 2020 16:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgETQJS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 May 2020 12:09:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60054 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETQJR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 May 2020 12:09:17 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbRHM-0002da-JB; Wed, 20 May 2020 10:09:12 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbRHL-00070A-LM; Wed, 20 May 2020 10:09:12 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Rob Landley <rob@landley.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
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
        <87y2poyd91.fsf_-_@x220.int.ebiederm.org>
        <adaced72-d757-e3e4-cfeb-5512533d0aa5@landley.net>
Date:   Wed, 20 May 2020 11:05:29 -0500
In-Reply-To: <adaced72-d757-e3e4-cfeb-5512533d0aa5@landley.net> (Rob Landley's
        message of "Tue, 19 May 2020 16:59:06 -0500")
Message-ID: <874ksaioc6.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jbRHL-00070A-LM;;;mid=<874ksaioc6.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19NAyurH9iGPP/ahHUMxq6hKHYaPv0QJ5Y=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 7/8] exec: Generic execfd support
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Rob Landley <rob@landley.net> writes:

> On 5/18/20 7:33 PM, Eric W. Biederman wrote:
>> 
>> Most of the support for passing the file descriptor of an executable
>> to an interpreter already lives in the generic code and in binfmt_elf.
>> Rework the fields in binfmt_elf that deal with executable file
>> descriptor passing to make executable file descriptor passing a first
>> class concept.
>
> I was reading this to try to figure out how to do execve(NULL, argv[], envp) to
> re-exec self after a vfork() in a chroot with no /proc, and hit the most trivial
> quibble ever:

We have /proc/self/exe today.  If I understand you correctly you would
like to do the equivalent of 'execve("/proc/self/exe", argv[], envp[])'
without having proc mounted.

The file descriptor is stored in mm->exe_file.

Probably the most straight forward implementation is to allow
execveat(AT_EXE_FILE, ...).

You can look at binfmt_misc for how to reopen an open file descriptor.

>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1323,7 +1323,10 @@ int begin_new_exec(struct linux_binprm * bprm)
>>  	 */
>>  	set_mm_exe_file(bprm->mm, bprm->file);
>>  
>> +	/* If the binary is not readable than enforce mm->dumpable=0 */
>
> then

It took me a minute yes good catch.

Eric
