Return-Path: <SRS0=JoCX=A2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05798C433DF
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jul 2020 18:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E32942065F
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jul 2020 18:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgGOS0Z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:26:25 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:34524 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgGOS0Y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Jul 2020 14:26:24 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvm6d-0008Fo-UP; Wed, 15 Jul 2020 12:26:11 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvm6U-0003IZ-Lu; Wed, 15 Jul 2020 12:26:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
        <87wo365ikj.fsf@x220.int.ebiederm.org>
        <20200715064220.GG32470@infradead.org>
Date:   Wed, 15 Jul 2020 13:23:11 -0500
In-Reply-To: <20200715064220.GG32470@infradead.org> (Christoph Hellwig's
        message of "Wed, 15 Jul 2020 07:42:20 +0100")
Message-ID: <87lfjk3aeo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvm6U-0003IZ-Lu;;;mid=<87lfjk3aeo.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18nYA25PFlqmd+QJj8Nw4u9gsb6kkHODq4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Christoph Hellwig <hch@infradead.org> writes:

>> +static int count_strings_kernel(const char *const *argv)
>> +{
>> +	int i;
>> +
>> +	if (!argv)
>> +		return 0;
>> +
>> +	for (i = 0; argv[i]; ++i) {
>> +		if (i >= MAX_ARG_STRINGS)
>> +			return -E2BIG;
>> +		if (fatal_signal_pending(current))
>> +			return -ERESTARTNOHAND;
>> +		cond_resched();
>
> I don't think we need a fatal_signal_pending and cond_resched() is
> needed in each step given that we don't actually do anything.

If we have a MAX_ARG_STRINGS sized argv passed in, that is 2^31
iterations of the loop.  A processor at 2Ghz performs roughly 2^31
cycles per second.  So this loop has the potential to run for an entire
second.  That is long enough to need fatal_signal_pending() and
cond_resched checks.

In practice I don't think we have any argv arrays anywhere near that big
passed in from the kernel.  However removing the logic that accounts for
long running loops is best handled as a separate change so that people
will analyze the patch based on that criterian, and so that in the
highly unlikely even something goes wrong people have a nice commit
to bisect things to.

Eric
