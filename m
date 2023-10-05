Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7982AE772A7
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Oct 2023 16:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbjJEQFP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Oct 2023 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbjJEQEE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:04 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165AD64D4D;
        Thu,  5 Oct 2023 07:51:16 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 395AmOUx096200;
        Thu, 5 Oct 2023 19:48:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Thu, 05 Oct 2023 19:48:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 395AmNh2096197
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 5 Oct 2023 19:48:23 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f6349370-7581-65a6-e10e-1aac86a45d85@I-love.SAKURA.ne.jp>
Date:   Thu, 5 Oct 2023 19:48:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <kees@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <57295dac-9abd-3bac-ff5d-ccf064947162@schaufler-ca.com>
 <b2cd749e-a716-1a13-6550-44a232deac25@I-love.SAKURA.ne.jp>
 <06BC106C-E0FD-4ACA-83A8-DFD1400B696E@kernel.org>
 <51d6c605-25cc-71fc-9c11-707b78297b38@I-love.SAKURA.ne.jp>
 <202310021000.B494D0DD@keescook>
 <CAHC9VhQFywb+CG2hAuHGRkdo3iMEGVogrdV_S6dZhfWJ0ACvOg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhQFywb+CG2hAuHGRkdo3iMEGVogrdV_S6dZhfWJ0ACvOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/10/04 8:39, Paul Moore wrote:
> As far as I can tell this RFC isn't really about dynamically loadable
> LSMs, it's about blocking the LSM syscall work, specifically the LSM
> ID tokens.  As I've said many times before, the LSM ID concept is
> moving forward and if you can't respect that decision, at least stop
> wasting our time.

This RFC is mainly about how do we plan to allow LKM-based LSMs.
Two proposals (LSM ID and elimination of linked list) might damage
LKM-based LSMs.

Regarding LSM ID, I'm asserting that assigning stable LSM ID to every LSM
is the *better* usage, for users can find whatever LSMs like CVE database
and developers can avoid possible collisions in the LSM infrastructure and
developers can avoid writing obvious duplicates (like you want to reject
proposals that are sufficiently "close"). If some ID were assigned to
implementations like https://github.com/linux-lock/bpflock , users can find
implementations that fit their needs more easily...

BTW, is bpflock considered as an LSM module entity that should be recognized
(i.e. assigned a stable LSM ID) so that the LSM syscalls can return "bpflock" ?
If users want to know which hook caused an access request to be rejected,
having the granularity of "bpf" might not be sufficient...

