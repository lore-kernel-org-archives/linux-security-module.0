Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C94EB64D9
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jul 2023 00:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjGGAfx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Jul 2023 20:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGGAfw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Jul 2023 20:35:52 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38ED19BD
        for <linux-security-module@vger.kernel.org>; Thu,  6 Jul 2023 17:35:49 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 04D3C645; Thu,  6 Jul 2023 19:35:47 -0500 (CDT)
Date:   Thu, 6 Jul 2023 19:35:47 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Leesoo Ahn <lsahn@wewakecorp.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [LSM Stacking] SELinux policy inside container affects a process
 on Host
Message-ID: <20230707003547.GA507352@mail.hallyn.com>
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jul 06, 2023 at 09:43:01AM -0400, Paul Moore wrote:
> On Thu, Jul 6, 2023 at 1:20 AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
> >
> > Hello! Here is another weird behavior of lsm stacking..
> >
> > test env
> > - Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
> > - boot param: lsm=apparmor,selinux
> > - AppArmor (Host) + SELinux (LXD Container Fedora 36)
> >
> > In the test environment mentioned above and applying selinux policy
> > enforcing by running "setenforce 1" within the container, executing the
> > following command on the host will result in "Permission denied" output.
> 
> SELinux operates independently of containers, or kernel namespacing in
> general.  When you load a SELinux policy it applies to all processes
> on the system, regardless of where they are in relation to the process
> which loaded the policy into the kernel.
> 
> This behavior is independent of the LSM stacking work, you should be
> able to see the same behavior even in cases where SELinux is the only

The real question might be what kind of container was this?  Since it
was allowed to setenforce 1, it must not have been in a user namespace?
Did you do "lxc config set c1 security.privileged true" ?
