Return-Path: <SRS0=eT2w=AI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C69C433E2
	for <linux-security-module@archiver.kernel.org>; Sat, 27 Jun 2020 04:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3552081A
	for <linux-security-module@archiver.kernel.org>; Sat, 27 Jun 2020 04:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgF0E0f (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 27 Jun 2020 00:26:35 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41934 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgF0E0e (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 27 Jun 2020 00:26:34 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jp2Q9-0000As-55; Fri, 26 Jun 2020 22:26:29 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jp2Q8-0006eV-CZ; Fri, 26 Jun 2020 22:26:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        <87tuyyf0ln.fsf_-_@x220.int.ebiederm.org>
        <5ce4d340-096a-f468-6719-4c34a951511e@i-love.sakura.ne.jp>
        <87d05lbwt4.fsf@x220.int.ebiederm.org>
        <32604829-35f7-5263-aff1-27808500c1d1@i-love.sakura.ne.jp>
Date:   Fri, 26 Jun 2020 23:21:58 -0500
In-Reply-To: <32604829-35f7-5263-aff1-27808500c1d1@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Sat, 27 Jun 2020 10:26:33 +0900")
Message-ID: <87k0zt87fd.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jp2Q8-0006eV-CZ;;;mid=<87k0zt87fd.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ai6r3uUIOMYaoeZVry/Nrha4UBDRHcgA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 05/14] umh: Separate the user mode driver and the user mode helper support
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
> On 2020/06/27 1:45, Eric W. Biederman wrote:
>> Does this series by using the normal path through exec solve your
>> concerns with LSMs being able to identify these processes (both
>> individually and as class)?.
>
> I guess "yes" for pathname based LSMs. Though, TOMOYO wants to obtain both
> AT_SYMLINK_NOFOLLOW "struct path" and !AT_SYMLINK_NOFOLLOW "struct path"
> at do_open_execat() from do_execveat_common().

Is that a problem with the current do_execveat_common in general?

That does not sound like a problem in the user mode driver case as
there are no symlinks involved.

Eric



