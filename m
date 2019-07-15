Return-Path: <SRS0=DosV=VM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32938C7618F
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9982067C
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 19:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfGOTFH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:05:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbfGOTFH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 15:05:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08093308330D;
        Mon, 15 Jul 2019 19:05:07 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-14.phx2.redhat.com [10.3.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A4775C225;
        Mon, 15 Jul 2019 19:05:00 +0000 (UTC)
Date:   Mon, 15 Jul 2019 15:04:57 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: Preferred subj= with multiple LSMs
Message-ID: <20190715190457.pqlaxjcxhdcosdsz@madcap2.tricolour.ca>
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
 <2268017.8MBUnBNn7u@x2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2268017.8MBUnBNn7u@x2>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 15 Jul 2019 19:05:07 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019-07-13 11:08, Steve Grubb wrote:
> Hello,
> 
> On Friday, July 12, 2019 12:33:55 PM EDT Casey Schaufler wrote:
> > Which of these options would be preferred for audit records
> > when there are multiple active security modules?
> 
> I'd like to start out with what is the underlying problem that results in 
> this? For example, we have pam. It has multiple modules each having a vote. 
> If a module votes no, then we need to know who voted no and maybe why. We 
> normally do not need to know who voted yes.
> 
> So, in a stacked situation, shouldn't each module make its own event, if 
> required, just like pam? And then log the attributes as it knows them? Also, 
> what model is being used? Does first module voting no end access voting? Or 
> does each module get a vote even if one has already said no?
> 
> Also, we try to keep LSM subsystems separated by record type numbers. So, 
> apparmour and selinux events are entirely different record numbers and 
> formats. Combining everything into one record is going to be problematic for 
> reporting.

I was wrestling with the options below and was uncomfortable with all of
them because none of them was guaranteed not to break existing parsers.

Steve's answer is the obvious one, ideally allocating a seperate range
to each LSM with each message type having its own well defined format.

> -Steve
> 
> > I'm not asking
> > if we should do it, I'm asking which of these options I should
> > implement when I do do it. I've prototyped #1 and #2. #4 is a
> > minor variant of #1 that is either better for compatibility or
> > worse, depending on how you want to look at it. I understand
> > that each of these offer challenges. If I've missed something
> > obvious, I'd be delighted to consider #5.
> > 
> > Thank you.
> > 
> > Option 1:
> > 
> > 	subj=selinux='x:y:z:s:c',apparmor='a'
> > 
> > Option 2:
> > 
> > 	subj=x:y:z:s:c subj=a
> > 
> > Option 3:
> > 
> > 	lsms=selinux,apparmor subj=x:y:z:s:c subj=a
> > 
> > Option 4:
> > 
> > 	subjs=selinux='x:y:z:s:c',apparmor='a'
> > 
> > Option 5:
> > 
> > 	Something else.

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
