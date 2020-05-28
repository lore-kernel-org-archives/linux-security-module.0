Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82409C433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 19:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD52207BC
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 19:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406490AbgE1TZx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 15:25:53 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:38176 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406352AbgE1TZw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 15:25:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeOA2-0003ht-6V; Thu, 28 May 2020 13:25:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeOA1-0008Pm-5i; Thu, 28 May 2020 13:25:49 -0600
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
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
        <87y2pcvz3b.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wiAG4tpPoWsWSqHbyMZDnWR8RHUpbwxB9_tdAqbE59NxA@mail.gmail.com>
Date:   Thu, 28 May 2020 14:21:57 -0500
In-Reply-To: <CAHk-=wiAG4tpPoWsWSqHbyMZDnWR8RHUpbwxB9_tdAqbE59NxA@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 28 May 2020 12:08:02 -0700")
Message-ID: <875zcfvp9m.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeOA1-0008Pm-5i;;;mid=<875zcfvp9m.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/beXd4KA5c+7dsn0MqQrGKegUPWaEyJac=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 09/11] exec: In bprm_fill_uid only set per_clear when honoring suid or sgid
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, May 28, 2020 at 8:53 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> It makes no sense to set active_per_clear when the kernel decides not
>> to honor the executables setuid or or setgid bits.  Instead set
>> active_per_clear when the kernel actually decides to honor the suid or
>> sgid permission bits of an executable.
>
> You seem to be confused about the naming yourself.
>
> You talk about "active_per_clear", but the code is about "per_clear". WTF?

I figured out how to kill active_per_clear see (3/11) and I failed to
update the patch description here.

I think active_ is a louzy suffix but since it all goes away in patch 3
when I remove the recomputation and the need to have two versions of the
setting I think it is probably good enough.

Eric






