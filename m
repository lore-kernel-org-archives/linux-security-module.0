Return-Path: <SRS0=w96y=VK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8680C742A7
	for <linux-security-module@archiver.kernel.org>; Sat, 13 Jul 2019 15:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD09320838
	for <linux-security-module@archiver.kernel.org>; Sat, 13 Jul 2019 15:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfGMPIs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 13 Jul 2019 11:08:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbfGMPIs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 13 Jul 2019 11:08:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4999356D2;
        Sat, 13 Jul 2019 15:08:47 +0000 (UTC)
Received: from x2.localnet (ovpn-116-23.phx2.redhat.com [10.3.116.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 197CA5F724;
        Sat, 13 Jul 2019 15:08:42 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, rgb@redhat.com
Subject: Re: Preferred subj= with multiple LSMs
Date:   Sat, 13 Jul 2019 11:08:41 -0400
Message-ID: <2268017.8MBUnBNn7u@x2>
Organization: Red Hat
In-Reply-To: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sat, 13 Jul 2019 15:08:47 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

On Friday, July 12, 2019 12:33:55 PM EDT Casey Schaufler wrote:
> Which of these options would be preferred for audit records
> when there are multiple active security modules?

I'd like to start out with what is the underlying problem that results in 
this? For example, we have pam. It has multiple modules each having a vote. 
If a module votes no, then we need to know who voted no and maybe why. We 
normally do not need to know who voted yes.

So, in a stacked situation, shouldn't each module make its own event, if 
required, just like pam? And then log the attributes as it knows them? Also, 
what model is being used? Does first module voting no end access voting? Or 
does each module get a vote even if one has already said no?

Also, we try to keep LSM subsystems separated by record type numbers. So, 
apparmour and selinux events are entirely different record numbers and 
formats. Combining everything into one record is going to be problematic for 
reporting.

-Steve

> I'm not asking
> if we should do it, I'm asking which of these options I should
> implement when I do do it. I've prototyped #1 and #2. #4 is a
> minor variant of #1 that is either better for compatibility or
> worse, depending on how you want to look at it. I understand
> that each of these offer challenges. If I've missed something
> obvious, I'd be delighted to consider #5.
> 
> Thank you.
> 
> Option 1:
> 
> 	subj=selinux='x:y:z:s:c',apparmor='a'
> 
> Option 2:
> 
> 	subj=x:y:z:s:c subj=a
> 
> Option 3:
> 
> 	lsms=selinux,apparmor subj=x:y:z:s:c subj=a
> 
> Option 4:
> 
> 	subjs=selinux='x:y:z:s:c',apparmor='a'
> 
> Option 5:
> 
> 	Something else.




