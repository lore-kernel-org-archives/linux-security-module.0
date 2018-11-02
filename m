Return-Path: <SRS0=l7tI=NN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8380DC32789
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Nov 2018 19:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A202082E
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Nov 2018 19:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A202082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbeKCEaw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:30:52 -0400
Received: from mail.hallyn.com ([178.63.66.53]:58646 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725727AbeKCEaw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 3 Nov 2018 00:30:52 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 72FA3413; Fri,  2 Nov 2018 19:22:27 +0000 (UTC)
Date:   Fri, 2 Nov 2018 19:22:27 +0000
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Micah Morton <mortonm@chromium.org>, jmorris@namei.org,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
Message-ID: <20181102192227.GA21498@mail.hallyn.com>
References: <20181031210245.GA3537@mail.hallyn.com>
 <20181101060737.GA7132@mail.hallyn.com>
 <CAJ-EccMaAu+g55Nuh1nZqt3Ld-YEgDiT_ewdQzGtFGmzRgXckw@mail.gmail.com>
 <41daea64-03c0-0970-c405-d1a5ae134181@schaufler-ca.com>
 <CAJ-EccNO8DeER3VUyyxO-CD_qBmzasMvZuUsbdWgcfiAjRcsFw@mail.gmail.com>
 <3a3231b3-44b3-b330-2cda-d4246bca35be@schaufler-ca.com>
 <CAJ-EccMU9mtyA1qwXYEqHP9vXZEBiuCfdG3KTrAA-hQ+Y-CANg@mail.gmail.com>
 <5c7e1a80-c534-6adb-be19-58bb0d97084f@schaufler-ca.com>
 <20181102183056.GA20738@mail.hallyn.com>
 <b1f95526-d0f1-712e-e0a7-9710cae7e1f0@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f95526-d0f1-712e-e0a7-9710cae7e1f0@schaufler-ca.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Quoting Casey Schaufler (casey@schaufler-ca.com):
> On 11/2/2018 11:30 AM, Serge E. Hallyn wrote:
> > Quoting Casey Schaufler (casey@schaufler-ca.com):
> >
> >> Let me suggest a change to the way your LSM works
> >> that would reduce my concerns. Rather than refusing to
> >> make a UID change that isn't on your whitelist, kill a
> >> process that makes a prohibited request. This mitigates
> >> the problem where a process doesn't check for an error
> >> return. Sure, your system will be harder to get running
> >> until your whitelist is complete, but you'll avoid a
> >> whole category of security bugs.
> > Might also consider not restricting CAP_SETUID, but instead adding a
> > new CAP_SETUID_RANGE capability.  That way you can be sure there will be
> > no regressions with any programs which run with CAP_SETUID.
> >
> > Though that violates what Casey was just arguing halfway up the email.
> 
> I know that it's hard to believe 20 years after the fact,
> but the POSIX group worked very hard to ensure that the granularity
> of capabilities was correct for the security policy that the
> interfaces defined in P1003.1. What would CAP_SETUID_RANGE mean?

CAP_SETUID would mean you can switch to any uid.

CAP_SETUID_RANGE would mean you could make the transitions which have
been defined through <handwave> some mechanism.  Be it prctl, or some
new security.uidrange xattr, or the mechanism Micah proposed, except
it only applies for CAP_SETUID_RANGE not CAP_SETUID.

-serge
