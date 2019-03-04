Return-Path: <SRS0=S0ZR=RH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CA3C43381
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Mar 2019 23:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F9E206B8
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Mar 2019 23:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfCDX7h (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:59:37 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:16116 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDX7h (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Mar 2019 18:59:37 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x24NxJwY065724;
        Tue, 5 Mar 2019 08:59:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Tue, 05 Mar 2019 08:59:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x24NxJmZ065720;
        Tue, 5 Mar 2019 08:59:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x24NxJwx065719;
        Tue, 5 Mar 2019 08:59:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201903042359.x24NxJwx065719@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] tomoyo: Add a kernel config option for fuzzing testing.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
MIME-Version: 1.0
Date:   Tue, 05 Mar 2019 08:59:19 +0900
References: <19e3dbac-d3ac-53b2-6e98-faf927bc72b3@i-love.sakura.ne.jp> <05b05166-d24a-3c50-6556-472f50a239b9@tycho.nsa.gov>
In-Reply-To: <05b05166-d24a-3c50-6556-472f50a239b9@tycho.nsa.gov>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Stephen Smalley wrote:
> On 3/4/19 8:35 AM, Tetsuo Handa wrote:
> > James, please include this patch for 5.1-rc1, for failing to include
> > this patch will prevent various trees (SELinux/Smack/AppArmor) from
> > proper testing due to this problem because syzbot is enabling both
> > TOMOYO and one of SELinux/Smack/AppArmor via lsm= boot parameter.
> > 
> > By including this patch and building kernels with this config option
> > enabled, syzbot will be able to continue proper testing.
> 
> Could you clarify the status of upstream TOMOYO?  Is its MAINTAINERS 
> entry still accurate?  Is it still actively maintained?

Mainly bugfixes and Q&A phase like
https://osdn.net/projects/tomoyo/lists/archive/users-en/2017-July/000685.html .

Now that TOMOYO can coexist with one of SELinux/Smack/AppArmor, TOMOYO users
can borrow ready-made rules from them and utilize TOMOYO's ability to generate
custom-made rules for things like
https://tomoyo.osdn.jp/1.8/ssh-protection-using-environment.html .

>                                                          Its existing 
> documentation (in-tree and the tomoyo.osdn.jp site) seem to suggest that 
> using the pre-LSM version and/or AKARI are preferred to using the 
> upstream version. Is that still true, and do you envision it changing?

I guess that majority of TOMOYO users are now using the upstream version. But
pre-LSM version and/or AKARI will remain there until LKM-based LSMs becomes
officially supported, for e.g. Fedora/RHEL users will need to use AKARI because
TOMOYO is not available ( https://bugzilla.redhat.com/show_bug.cgi?id=542986 ).
