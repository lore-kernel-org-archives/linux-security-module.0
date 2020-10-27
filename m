Return-Path: <SRS0=YDB1=EC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6D7C4363A
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 18:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2F02068E
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 18:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827439AbgJ0SYG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Oct 2020 14:24:06 -0400
Received: from relay.sw.ru ([185.231.240.75]:56312 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1827434AbgJ0SYF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Oct 2020 14:24:05 -0400
X-Greylist: delayed 3703 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 14:24:03 EDT
Received: from [192.168.15.231]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kXSfa-006OBT-Fl; Tue, 27 Oct 2020 20:22:02 +0300
Subject: Re: Inconsistent capability requirements for prctl_set_mm_exe_file()
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Adrian Reber <areber@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
References: <7655a573-544f-05a4-36dc-0c84c73ac9ee@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2b66ac32-adfd-de1b-499b-8ba4f7b9bea4@virtuozzo.com>
Date:   Tue, 27 Oct 2020 20:22:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7655a573-544f-05a4-36dc-0c84c73ac9ee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 27.10.2020 15:11, Michael Kerrisk (man-pages) wrote:
> Hello Nicolas, Cyrill, and others,
> 
> @Nicolas, your commit ebd6de6812387a changed the capability 
> requirements for the prctl_set_mm_exe_file() operation from
> 
>     ns_capable(CAP_SYS_ADMIN)
> 
> to
> 
>     ns_capable(CAP_SYS_ADMIN) || ns_capable(CAP_CHECKPOINT_RESTORE).
> 
> That's fine I guess, but while looking at that change, I found
> an anomaly.
> 
> The same prctl_set_mm_exe_file() functionality is also available
> via the prctl() PR_SET_MM_EXE_FILE operation, which was added
> by Cyrill's commit b32dfe377102ce668. However, there the 
> prctl_set_mm_exe_file() operation is guarded by a check
> 
>     capable(CAP_SYS_RESOURCE).
> 
> There are two things I note:
> 
> * The capability requirements are different in the two cases.
> * In one case the checks are with ns_capable(), while in the 
>   other case the check is with capable().
> 
> In both cases, the inconsistencies predate Nicolas's patch,
> and appear to have been introduced in Kirill Tkhai's commit
> 4d28df6152aa3ff.

1)Before my commit there also were different checks

        !capable(CAP_SYS_RESOURCE))
and
	uid_eq(cred->uid, make_kuid(ns, 0)) && gid_eq(cred->gid, make_kgid(ns, 0))

so it is not the initial reason. The commit even decreased the checks difference
and it made both the checks are about capability().


2)As I understand new PR_SET_MM_MAP interface differs in the way, that it allows to batch
a setup of prctl_mm_map parameters. So, instead of 14 prlctl calls with different arguments:
PR_SET_MM_START_CODE, PR_SET_MM_END_CODE, PR_SET_MM_START_DATA, .., PR_SET_MM_ENV_END,
we set then all at once and the performance is better.

The second advantage is that the new interface is more comfortable in case of we set all
of 14 parameters. Old interface requires special order of calls: sometimes you have to
set PR_SET_MM_START_CODE first and then PR_SET_MM_END_CODE second, some times it is vice
versa. Otherwise __prctl_check_order() in validate_prctl_map() will fail.

3)For me it looks like any combinations of parameters acceptable to be set by both interfaces
are the same (in case of we don't see on permissions checks). In case of we can assign a set of
parameters {A} using old interface, we can assign it from new interface and vice versa.
Isn't this so?! If so, we should use the same permissions check.

Kirill
