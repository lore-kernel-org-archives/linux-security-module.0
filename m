Return-Path: <SRS0=/FKR=AT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3FBC433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 13:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A424520578
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 13:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgGHNLA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:11:00 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59506 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgGHNLA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jul 2020 09:11:00 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jt9qg-0001Ou-4a; Wed, 08 Jul 2020 07:10:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jt9qf-0007c2-4M; Wed, 08 Jul 2020 07:10:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
        <20200702164140.4468-10-ebiederm@xmission.com>
        <20200708063525.GC4332@42.do-not-panic.com>
        <20200708124148.GP13911@42.do-not-panic.com>
Date:   Wed, 08 Jul 2020 08:08:09 -0500
In-Reply-To: <20200708124148.GP13911@42.do-not-panic.com> (Luis Chamberlain's
        message of "Wed, 8 Jul 2020 12:41:48 +0000")
Message-ID: <87y2nugnnq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jt9qf-0007c2-4M;;;mid=<87y2nugnnq.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Pi5oGSWgLXZ5PulbMTr1jaTB3IsDQ56A=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 10/16] exec: Remove do_execve_file
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Wed, Jul 08, 2020 at 06:35:25AM +0000, Luis Chamberlain wrote:
>> On Thu, Jul 02, 2020 at 11:41:34AM -0500, Eric W. Biederman wrote:
>> > Now that the last callser has been removed remove this code from exec.
>> > 
>> > For anyone thinking of resurrecing do_execve_file please note that
>> > the code was buggy in several fundamental ways.
>> > 
>> > - It did not ensure the file it was passed was read-only and that
>> >   deny_write_access had been called on it.  Which subtlely breaks
>> >   invaniants in exec.
>> > 
>> > - The caller of do_execve_file was expected to hold and put a
>> >   reference to the file, but an extra reference for use by exec was
>> >   not taken so that when exec put it's reference to the file an
>> >   underflow occured on the file reference count.
>> 
>> Maybe its my growing love with testing, but I'm going to have to partly
>> blame here that we added a new API without any respective testing.
>> Granted, I recall this this patch set could have used more wider review
>> and a bit more patience... but just mentioning this so we try to avoid
>> new api-without-testing with more reason in the future.
>> 
>> But more importantly, *how* could we have caught this? Or how can we
>> catch this sort of stuff better in the future?
>
> Of all the issues you pointed out with do_execve_file(), since upon
> review the assumption *by design* was that LSMs/etc would pick up issues
> with the file *prior* to processing, I think that this file reference
> count issue comes to my attention as the more serious issue which I
> wish we could address *first* before this crusade.
>
> So I have to ask, has anyone *really tried* to give a crack at fixing
> this refcount issue in a smaller way first? Alexei?
>
> I'm not opposed to the removal of do_execve_file(), however if there
> is a reproducible crash / issue with the existing user, this sledge
> hammer seems a bit overkill for older kernels.

It does not matter for older kernels because there is exactly one user.
That one user is just a place holder keeping the code alive until a real
user comes along.

For older kernels the solution is to just mark the bpfilter code broken
in Kconfig and refuse to compile it.  That is the trivial backportable
fix if anyone wants one.

Eric
