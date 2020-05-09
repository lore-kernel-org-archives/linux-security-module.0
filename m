Return-Path: <SRS0=34bQ=6X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68744C54E49
	for <linux-security-module@archiver.kernel.org>; Sat,  9 May 2020 20:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522D720A8B
	for <linux-security-module@archiver.kernel.org>; Sat,  9 May 2020 20:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgEIUPz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 9 May 2020 16:15:55 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:47412 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgEIUPz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 9 May 2020 16:15:55 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVt2-0005eM-E0; Sat, 09 May 2020 14:15:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVt1-0003ZO-Mf; Sat, 09 May 2020 14:15:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        <87k11kzyjm.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wj-Znzqp3xktZ+kERM5cKF-Yh_6XjyGYof6bqPq2T3F5A@mail.gmail.com>
Date:   Sat, 09 May 2020 15:12:22 -0500
In-Reply-To: <CAHk-=wj-Znzqp3xktZ+kERM5cKF-Yh_6XjyGYof6bqPq2T3F5A@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 9 May 2020 13:07:48 -0700")
Message-ID: <878si0yijd.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jXVt1-0003ZO-Mf;;;mid=<878si0yijd.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19cvWMPbuGySDS9RKEj6OOfBZhbGqCVxX0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/5] exec: Directly call security_bprm_set_creds from __do_execve_file
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, May 9, 2020 at 12:44 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Now that security_bprm_set_creds is no longer responsible for calling
>> cap_bprm_set_creds, security_bprm_set_creds only does something for
>> the primary file that is being executed (not any interpreters it may
>> have).  Therefore call security_bprm_set_creds from __do_execve_file,
>> instead of from prepare_binprm so that it is only called once, and
>> remove the now unnecessary called_set_creds field of struct binprm.
>
> Ahh, good, this patch removes the 'called_set_creds' logic from the
> security subsystems.
>
> So it does half of what I asked for: please also just rename that
> "security_bprm_set_creds()" to be "security_primary_bprm_set_creds()"
> so that the change of semantics also shows up that way.
>
> And so that there is no confusion about the fact that
> "cap_bprm_set_creds()" has absolutely nothing to do with
> "security_bprm_set_creds()" any more.

I agree something needs to be renamed, to remove confusion.

I am off for a nap now, and tomorrow is Mother's day so I probably won't
be back to this seriously until Monday.  But please disect these patches
and I will address any problems.

Eric


