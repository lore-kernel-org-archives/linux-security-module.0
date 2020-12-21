Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64126C433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Dec 2020 19:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E95B22BF3
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Dec 2020 19:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgLUT4Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:56:25 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:60162 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLUT4Y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Dec 2020 14:56:24 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1krRHT-00CG6m-5k; Mon, 21 Dec 2020 12:55:43 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1krRHS-00GWfl-5v; Mon, 21 Dec 2020 12:55:42 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "SMACK-discuss\@lists.01.org" <SMACK-discuss@lists.01.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>
References: <dacfb329-de66-d0cf-dcf9-f030ea1370de.ref@schaufler-ca.com>
        <dacfb329-de66-d0cf-dcf9-f030ea1370de@schaufler-ca.com>
Date:   Mon, 21 Dec 2020 13:55:01 -0600
In-Reply-To: <dacfb329-de66-d0cf-dcf9-f030ea1370de@schaufler-ca.com> (Casey
        Schaufler's message of "Thu, 17 Dec 2020 17:12:29 -0800")
Message-ID: <877dpbkk8a.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1krRHS-00GWfl-5v;;;mid=<877dpbkk8a.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ZoV3zem0M+sG6nXw/9Ef2BPwgVflGuUk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] Smack: Handle io_uring kernel thread privileges.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Casey Schaufler <casey@schaufler-ca.com> writes:

> Smack assumes that kernel threads are privileged for smackfs
> operations. This was necessary because the credential of the
> kernel thread was not related to a user operation. With io_uring
> the credential does reflect a user's rights and can be used.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/smack/smack_access.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
> index efe2406a3960..7eabb448acab 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -688,9 +688,10 @@ bool smack_privileged_cred(int cap, const struct cred *cred)
>  bool smack_privileged(int cap)
>  {
>  	/*
> -	 * All kernel tasks are privileged
> +	 * Kernel threads may not have credentials we can use.
> +	 * The io_uring kernel threads do have reliable credentials.
>  	 */
> -	if (unlikely(current->flags & PF_KTHREAD))
> +	if ((current->flags & (PF_KTHREAD | PF_IO_WORKER)) == PF_KTHREAD)
>  		return true;
>  
>  	return smack_privileged_cred(cap, current_cred());
