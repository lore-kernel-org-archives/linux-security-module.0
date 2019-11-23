Return-Path: <SRS0=ogR9=ZP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EC4C432C0
	for <linux-security-module@archiver.kernel.org>; Sat, 23 Nov 2019 05:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B078B20719
	for <linux-security-module@archiver.kernel.org>; Sat, 23 Nov 2019 05:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfKWFVd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 23 Nov 2019 00:21:33 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61257 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfKWFVc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 23 Nov 2019 00:21:32 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xAN5LRPR078351;
        Sat, 23 Nov 2019 14:21:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Sat, 23 Nov 2019 14:21:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040052248.bbtec.net [126.40.52.248])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xAN5LMq2078325
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 23 Nov 2019 14:21:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v11 02/25] LSM: Create and manage the lsmblob data
 structure.
To:     Casey Schaufler <casey@schaufler-ca.com>
References: <20191123011454.3292-1-casey.ref@schaufler-ca.com>
 <20191123011454.3292-1-casey@schaufler-ca.com>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c5096bce-2d77-3e56-f29c-b4a6188e84f1@i-love.sakura.ne.jp>
Date:   Sat, 23 Nov 2019 14:21:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191123011454.3292-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/11/23 10:14, Casey Schaufler wrote:
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
> 
> The lsmblob structure is currently an array of
> u32 "secids". There is an entry for each of the
> security modules built into the system that would
> use secids if active. The system assigns the module
> a "slot" when it registers hooks. If modules are
> compiled in but not registered there will be unused
> slots.
> 
> A new lsm_id structure, which contains the name
> of the LSM and its slot number, is created. There
> is an instance for each LSM, which assigns the name
> and passes it to the infrastructure to set the slot.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  | 12 ++++++--
>  include/linux/security.h   | 58 ++++++++++++++++++++++++++++++++++++++
>  security/apparmor/lsm.c    |  7 ++++-
>  security/commoncap.c       |  7 ++++-
>  security/loadpin/loadpin.c |  8 +++++-
>  security/safesetid/lsm.c   |  8 +++++-
>  security/security.c        | 28 ++++++++++++++----
>  security/selinux/hooks.c   |  8 +++++-
>  security/smack/smack_lsm.c |  7 ++++-
>  security/tomoyo/tomoyo.c   |  8 +++++-
>  security/yama/yama_lsm.c   |  7 ++++-
>  11 files changed, 142 insertions(+), 16 deletions(-)
>

For TOMOYO part,
 
Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
