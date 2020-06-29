Return-Path: <SRS0=lc+5=AK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE98C433E2
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Jun 2020 20:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D436620656
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Jun 2020 20:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgF2UYm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:24:42 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46406 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730311AbgF2UYk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Jun 2020 16:24:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq0KS-0008Ab-2k; Mon, 29 Jun 2020 14:24:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq0KM-0006dY-76; Mon, 29 Jun 2020 14:24:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
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
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <40720db5-92f0-4b5b-3d8a-beb78464a57f@i-love.sakura.ne.jp>
        <87366g8y1e.fsf@x220.int.ebiederm.org>
        <aa737d87-cf38-55d6-32f1-2d989a5412ea@i-love.sakura.ne.jp>
        <20200628194440.puzh7nhdnk6i4rqj@ast-mbp.dhcp.thefacebook.com>
        <c99d0cfc-8526-0daf-90b5-33e560efdede@i-love.sakura.ne.jp>
Date:   Mon, 29 Jun 2020 15:19:59 -0500
In-Reply-To: <c99d0cfc-8526-0daf-90b5-33e560efdede@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Mon, 29 Jun 2020 11:20:14 +0900")
Message-ID: <874kqt39qo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jq0KM-0006dY-76;;;mid=<874kqt39qo.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/d3NN0BDGHtc/aZ8NKVRKAhcNPeBHT1DI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 00/14] Make the user mode driver code a better citizen
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> On 2020/06/29 4:44, Alexei Starovoitov wrote:
>> But all the defensive programming kinda goes against general kernel style.
>> I wouldn't do it. Especially pr_info() ?!
>> Though I don't feel strongly about it.
>
> Honestly speaking, caller should check for errors and print appropriate
> messages. info->wd.mnt->mnt_root != info->wd.dentry indicates that something
> went wrong (maybe memory corruption). But other conditions are not fatal.
> That is, I consider even pr_info() here should be unnecessary.

They were all should never happen cases.  Which is why my patches do:
if (WARN_ON_ONCE(...))

That let's the caller know the messed up very clearly while still
providing a change to continue.

If they were clearly corruption no ones kernel should ever continue
BUG_ON would be appropriate.

>> I would like to generalize elf_header_check() a bit and call it
>> before doing blob_to_mnt() to make sure that all blobs are elf files only.
>> Supporting '#!/bin/bash' or other things as blobs seems wrong to me.

I vote for not worry about things that have never happened, and are
obviously incorrect.

The only points of checks like that is to catch cases where other
developers misunderstand the interface.  When you get to something like
sysfs with lots and lots of users where it is hard to audit there
is real value in sanity checks.  In something like this with very few
users. Just making the code clear should be enough for people not to do
ridiculous things.


In any case Tetsuo I will leave futher sanity checks for you and Alexei
to work out.  It is beyond the scope of my patchset, and they are easy
enough to add as follow on patches.

Eric
