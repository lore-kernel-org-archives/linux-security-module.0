Return-Path: <SRS0=/FKR=AT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2E4C433E2
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 03:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8567220720
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 03:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgGHDxA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:53:00 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:32788 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgGHDw7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Jul 2020 23:52:59 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jt18d-0004xm-Kc; Tue, 07 Jul 2020 21:52:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jt18c-00011Y-RJ; Tue, 07 Jul 2020 21:52:51 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
        <20200702164140.4468-13-ebiederm@xmission.com>
        <20200703203021.paebx25miovmaxqt@ast-mbp.dhcp.thefacebook.com>
        <873668s2j8.fsf@x220.int.ebiederm.org>
        <20200704155052.kmrest5useyxcfnu@wittgenstein>
        <87mu4bjlqm.fsf@x220.int.ebiederm.org>
        <a84ec1df-dc9b-dd5b-cc34-385fd3ca1da4@iogearbox.net>
Date:   Tue, 07 Jul 2020 22:50:07 -0500
In-Reply-To: <a84ec1df-dc9b-dd5b-cc34-385fd3ca1da4@iogearbox.net> (Daniel
        Borkmann's message of "Wed, 8 Jul 2020 02:05:03 +0200")
Message-ID: <87wo3ek6mo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jt18c-00011Y-RJ;;;mid=<87wo3ek6mo.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+D9EfKJ8jTyPBEpHFcGJQyQvMMwdPPB/0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 13/16] exit: Factor thread_group_exited out of pidfd_poll
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Daniel Borkmann <daniel@iogearbox.net> writes:

> Hey Eric, are you planning to push the final version into a topic branch
> so it can be pulled into bpf-next as discussed earlier?

Yes.  I just about have it ready.  I am taking one last pass through the
review comments to make certain I have not missed anything before I do.

I am hoping I can get it out tonight. Fingers crossed.

Eric
