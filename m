Return-Path: <SRS0=lArx=4G=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168FEC34026
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Feb 2020 19:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E163A24125
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Feb 2020 19:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JN0ihHEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgBRTaz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:30:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50102 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTaz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Feb 2020 14:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=LV+MVA27GmERT76AQSFW7+TDX7eGVtFvNiOU/nZfQ3g=; b=JN0ihHEYLrKtAzPlpc2c+kakEP
        AXp0XTtoT01qhyRVDWZ89g6HvK4L3jlP/8BV/rC0S8fh7kKrsJrsjge/9s1Tzbk85tLOvdP/dgdKC
        KtUyXXEhqmdV1Rrf6EvZnq+CRJTgsry5YplZrzyiHGG/bynzIJyBL9/5TNwzqv3HHAF7pfaEcP58h
        VltY5FDyp/4TIIzqDqlWeLyqpTIAiUI5xIVORPsbppF5tdlrOO+ytDl/tiJn9H+5iFXA0Kmnf3YJK
        KyyUiHIu8WC5g6+UIV+/C9tnyoGHjBAephjll88bh39KALFwj8Sac3OgF1HtOsV1W7mJJo4YQcNPn
        jOTObN7A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j48Zu-0007NA-EW; Tue, 18 Feb 2020 19:30:42 +0000
Subject: Re: [RFC PATCH] security: <linux/lsm_hooks.h>: fix all kernel-doc
 warnings
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <fb2c98bd-b579-6ad0-721a-56a4f81f0d6e@infradead.org>
 <ec4e5117-08b6-d4df-fb08-deb553ebdc73@tycho.nsa.gov>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f30f4baf-0929-3438-ffaa-4ffc401c52df@infradead.org>
Date:   Tue, 18 Feb 2020 11:30:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ec4e5117-08b6-d4df-fb08-deb553ebdc73@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/18/20 6:03 AM, Stephen Smalley wrote:
> On 2/16/20 2:08 AM, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix all kernel-doc warnings in <linux/lsm_hooks.h>.
>> Fixes the following warnings:
>>
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_open' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_alloc' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_free' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_read' not described in 'security_list_options'
>> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_write' not described in 'security_list_options'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: John Johansen <john.johansen@canonical.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Micah Morton <mortonm@chromium.org>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> Cc: linux-security-module@vger.kernel.org
>> Cc: Paul Moore <paul@paul-moore.com>
>> Cc: Stephen Smalley <sds@tycho.nsa.gov>
>> Cc: Eric Paris <eparis@parisplace.org>
>> Cc: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
>> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>> Notes:
>> a. The location for some of these might need to be modified.
>> b. 'locked_down' was just missing a final ':'.
>> c. Added a new section: Security hooks for perf events.
>>
>>   include/linux/lsm_hooks.h |   36 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 35 insertions(+), 1 deletion(-)
>>
>> --- lnx-56-rc1.orig/include/linux/lsm_hooks.h
>> +++ lnx-56-rc1/include/linux/lsm_hooks.h
>> @@ -136,6 +140,10 @@
>>    *    @sb superblock being remounted
>>    *    @data contains the filesystem-specific data.
>>    *    Return 0 if permission is granted.
>> + * @sb_kern_mount:
>> + *     Mount this @sb if allowed by permissions.
>> + * @sb_show_options:
>> + *     Show (print on @m) mount options for this @sb.
>>    * @sb_umount:
>>    *    Check permission before the @mnt file system is unmounted.
>>    *    @mnt contains the mounted file system.
> 
> Thanks for doing this.  Note that some of the existing kernel-doc comments for these hooks include a separate line describing each parameter (not just embedded in the function description) and a line describing the return value.  Is that optional for kernel-doc? Obviously what you have added here is an improvement, just wondering whether it suffices or needs further augmentation.

Hi Stephen,

The additional kernel-doc comments that you refer to are obviously Good to Have,
but they are not required.  I didn't feel comfortable or qualified to add
all of that info, but if anyone wants to help/contribute, please do so.

thanks.
-- 
~Randy

