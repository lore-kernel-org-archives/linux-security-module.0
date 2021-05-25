Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C26C47087
	for <linux-security-module@archiver.kernel.org>; Tue, 25 May 2021 21:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A556141C
	for <linux-security-module@archiver.kernel.org>; Tue, 25 May 2021 21:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhEYV0o (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 May 2021 17:26:44 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33102 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbhEYV0n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 May 2021 17:26:43 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lleY0-00HLfp-3h; Tue, 25 May 2021 15:25:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lleXz-0003h6-73; Tue, 25 May 2021 15:25:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Oleg Nesterov <oleg@redhat.com>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <20210525193735.2716374-1-keescook@chromium.org>
        <CAG48ez2PdgpUj3GYRLDJ9MS1uKMZ4SU77i__vhXvmbzqudzuzA@mail.gmail.com>
Date:   Tue, 25 May 2021 16:24:52 -0500
In-Reply-To: <CAG48ez2PdgpUj3GYRLDJ9MS1uKMZ4SU77i__vhXvmbzqudzuzA@mail.gmail.com>
        (Jann Horn's message of "Tue, 25 May 2021 22:49:29 +0200")
Message-ID: <m1r1humrq3.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lleXz-0003h6-73;;;mid=<m1r1humrq3.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18b6GauH7woP0dutn2xuSoDIfadYjyx/GI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] proc: Check /proc/$pid/attr/ writes against file opener
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Jann Horn <jannh@google.com> writes:

> On Tue, May 25, 2021 at 9:37 PM Kees Cook <keescook@chromium.org> wrote:
>> Fix another "confused deputy" weakness[1]. Writes to /proc/$pid/attr/
>> files need to check the opener credentials, since these fds do not
>> transition state across execve(). Without this, it is possible to
>> trick another process (which may have different credentials) to write
>> to its own /proc/$pid/attr/ files, leading to unexpected and possibly
>> exploitable behaviors.
>>
>> [1] https://www.kernel.org/doc/html/latest/security/credentials.html?highlight=confused#open-file-credentials
>>
>> Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  fs/proc/base.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 3851bfcdba56..58bbf334265b 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -2703,6 +2703,10 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>>         void *page;
>>         int rv;
>>
>> +       /* A task may only write when it was the opener. */
>> +       if (file->f_cred != current_real_cred())
>> +               return -EPERM;
>
> With this, if a task forks, the child will then still be able to open
> its parent's /proc/$pid/attr/current and trick the parent into writing
> to that, right? Is that acceptable? If not, the ->open handler should
> probably also check for "current->thread_pid == proc_pid(inode)", or
> something like that?

Currently exec always allocates a new cred.  So you can only ``trick''
another process that was forked from you.  I don't think it counts as
tricking or any kind of danger if you are simply confusing yourself.

Eric

