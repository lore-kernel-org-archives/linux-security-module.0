Return-Path: <SRS0=bfYL=P7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D62DC282C0
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 09:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B86620861
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 09:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfAWJtg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:49:36 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:36471 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfAWJtg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Jan 2019 04:49:36 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0N9nUKi090262;
        Wed, 23 Jan 2019 18:49:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Wed, 23 Jan 2019 18:49:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0N9nPZD090230
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 23 Jan 2019 18:49:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH v3] tomoyo: Swicth from cred->security to
 task_struct->security.
To:     James Morris <jmorris@namei.org>
References: <1547822987-9401-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1547907100-10438-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-security-module@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <765b2ad7-a6a6-617a-5270-c41b1fe43ad4@I-love.SAKURA.ne.jp>
Date:   Wed, 23 Jan 2019 18:49:25 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547907100-10438-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello.

This is effectively a pull request, for I don't maintain a git tree.
If no questions, please apply to linux-security.git#next-general.

On 2019/01/19 23:11, Tetsuo Handa wrote:
> TOMOYO security module is designed to use "struct task_struct"->security
> in order to allow per "struct task_struct" tracking without being disturbed
> by unable to update "struct cred"->security due to override mechanism.
> 
> Now that infrastructure-managed security blob is ready, this patch updates
> TOMOYO to use "struct task_struct"->security.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/tomoyo/common.c        |   4 +-
>  security/tomoyo/common.h        |  45 ++++--------
>  security/tomoyo/domain.c        |  11 +--
>  security/tomoyo/securityfs_if.c |  21 ++----
>  security/tomoyo/tomoyo.c        | 149 +++++++++++++++++++++-------------------
>  5 files changed, 108 insertions(+), 122 deletions(-)
