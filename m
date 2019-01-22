Return-Path: <SRS0=9r3I=P6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39807C282C3
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Jan 2019 17:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAD820879
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Jan 2019 17:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=outflux.net header.i=@outflux.net header.b="NmFKduiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfAVRui (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:50:38 -0500
Received: from smtp.outflux.net ([198.145.64.163]:37625 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfAVRui (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Jan 2019 12:50:38 -0500
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 12:50:38 EST
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.15.2/8.15.2/Debian-10) with ESMTP id x0MHfSSC023767;
        Tue, 22 Jan 2019 09:41:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=outflux.net;
        s=2016010; t=1548178888;
        bh=etTpF/fj56IR9BmyMlrU6XXZsWwjQlu3CNNbzIInqcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmFKduiFBlD85VK8SyGsHU0rOE9tjlYeau+e48kib5L4yo0DnyksR14p3YS5fMzP7
         30Yc2EqzJiDQ8Ql5paFf7Yk1tp+Pw+c9JdQZY+vCJKC7bo34qqgmi5hPNZep+qJSw1
         mH8F8hEa84VMRvWNCB2DsZhOLyk/v4j7z8yiSZ2s=
Received: by www.outflux.net (Postfix, from userid 501)
        id 7A055617BF; Tue, 22 Jan 2019 09:41:28 -0800 (PST)
Date:   Tue, 22 Jan 2019 09:41:28 -0800
From:   Kees Cook <kees@outflux.net>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH] apparmor: Adjust offset when accessing task blob.
Message-ID: <20190122174128.GI5875@outflux.net>
References: <201901210125.x0L1PAwO046352@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201901210125.x0L1PAwO046352@www262.sakura.ne.jp>
Organization: Outflux
User-Agent: Mutt/1.9.4 (2018-02-28)
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.83
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jan 21, 2019 at 10:25:10AM +0900, Tetsuo Handa wrote:
> AppArmor will no longer be the only user of task blob
> after TOMOYO started using task blob.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

I just noticed this today too! You beat me to sending the patch. ;)

Fixes: f4ad8f2c4076 ("LSM: Infrastructure management of the task security")
Acked-by: Kees Cook <keescook@chromium.org>

James, this should get into v5.0 fixes tree.

-Kees

> ---
>  security/apparmor/include/task.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
> index 039c1e6..311e652 100644
> --- a/security/apparmor/include/task.h
> +++ b/security/apparmor/include/task.h
> @@ -16,7 +16,7 @@
>  
>  static inline struct aa_task_ctx *task_ctx(struct task_struct *task)
>  {
> -	return task->security;
> +	return task->security + apparmor_blob_sizes.lbs_task;
>  }
>  
>  /*
> -- 
> 1.8.3.1

-- 
Kees Cook                                            @outflux.net
