Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C251C61DA4
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Feb 2023 22:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjBIWVp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Feb 2023 17:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBIWVo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Feb 2023 17:21:44 -0500
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D39DA6ADF2
        for <linux-security-module@vger.kernel.org>; Thu,  9 Feb 2023 14:21:34 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 319ML70Y022738;
        Thu, 9 Feb 2023 16:21:07 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 319ML6Cc022737;
        Thu, 9 Feb 2023 16:21:06 -0600
Date:   Thu, 9 Feb 2023 16:21:06 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH 14/14] Activate the configuration and build of the TSEM LSM.
Message-ID: <20230209222106.GA22543@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-15-greg@enjellic.com> <ca0a230c-7e4f-e8c7-1f7f-53c3b4017e2d@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca0a230c-7e4f-e8c7-1f7f-53c3b4017e2d@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 09 Feb 2023 16:21:07 -0600 (CST)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 08, 2023 at 02:15:26PM -0800, Casey Schaufler wrote:
> On 2/3/2023 9:09 PM, Dr. Greg wrote:
> > Complete the implementation by integrating the LSM into the
> > configuration and kernel build infrastructure.
> >
> > Signed-off-by: Greg Wettstein <greg@enjellic.com>
> > ---
> >  security/Kconfig       | 11 ++++++-----
> >  security/Makefile      |  1 +
> >  security/tsem/Kconfig  | 22 ++++++++++++++++++++++
> >  security/tsem/Makefile |  2 ++
> >  4 files changed, 31 insertions(+), 5 deletions(-)
> >  create mode 100644 security/tsem/Kconfig
> >  create mode 100644 security/tsem/Makefile
> >
> > diff --git a/security/Kconfig b/security/Kconfig
> > index e6db09a779b7..98c538ad6790 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -207,6 +207,7 @@ source "security/yama/Kconfig"
> >  source "security/safesetid/Kconfig"
> >  source "security/lockdown/Kconfig"
> >  source "security/landlock/Kconfig"
> > +source "security/tsem/Kconfig"
> >  
> >  source "security/integrity/Kconfig"
> >  
> > @@ -246,11 +247,11 @@ endchoice
> >  
> >  config LSM
> >  	string "Ordered list of enabled LSMs"
> > -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> > -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> > -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> > -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> > -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
> > +	default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selin
ux,tomoyo,apparmor,bpf,tsem" 

Hi Casey, thanks for the note, I hope your week is going well.

> Better check with the BPF team to see if they're OK with TSEM
> following BPF in loading order.

We can do that, however, as we noted in the documentation, TSEM, being
the first LSM to be based on a narratival security logic philosophy,
should be largely ambivalent with respect to its stacking order.

We would thus, happily, entertain suggestions from the community as to
where it would like us to stand in line.

As an example, without going off into the weeds, since TSEM is a
generic security modeling architecture, it can implement any integrity
policies, including validation of extended security attributes.
Placing it first in line would allow a security workload architect to
reject any modifications to expected MAC security labels as an invalid
security model state point before the event got to the deontological
handlers.

However, being the new kid on the block, we would never presume to be
first or last, given that they may be coveted positions.

So we will remain open to suggestions for the second spin of the
patches.

Have a good afternoon.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
