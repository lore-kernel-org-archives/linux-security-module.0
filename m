Return-Path: <SRS0=lXmD=7U=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DABCC433DF
	for <linux-security-module@archiver.kernel.org>; Sun,  7 Jun 2020 19:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB1D206F6
	for <linux-security-module@archiver.kernel.org>; Sun,  7 Jun 2020 19:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591556921;
	bh=aimXNnD+PVaJEw0UQzhYrUjR4ij+FbdM/GXqDgyISfM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=07SXfXbaJgOfKDSOsq+x/Dc/Ov5Ht/lJ5onL8x9glv+JwElLroKaDsdp986rIaIZz
	 t7em2p97bAdS9gAzR06SWcPGC5I6An1k2Ii6AW2gMKWy+/QKsDueMf4E0UBIGsTlvN
	 IArFmG+gWVhmaocdGJtQJAP7NIvfvIYmoWCq+YAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFGTIk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 7 Jun 2020 15:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgFGTIk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 7 Jun 2020 15:08:40 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CCBA206D5;
        Sun,  7 Jun 2020 19:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591556920;
        bh=aimXNnD+PVaJEw0UQzhYrUjR4ij+FbdM/GXqDgyISfM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jvuyLO1ljh8cBnSYm7M6fodXklTc77xJLwa8pAKuyjAjcyReM6xvxvPrh8ZwfwD4b
         /xXmMuV+ffG9xOYKRHXAgMSfgvDERF+SK9+qGfoexGh7o7UINMpLqQQi/0NWXNempY
         TU3m1ybhV3vklUqBBuexkjzzVAcZ3xuAmOcmHRAI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 59EEB35228C7; Sun,  7 Jun 2020 12:08:40 -0700 (PDT)
Date:   Sun, 7 Jun 2020 12:08:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Amol Grover <frextrite@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH RESEND] device_cgroup: Fix RCU list debugging warning
Message-ID: <20200607190840.GG4455@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200406105950.GA2285@workstation-kernel-dev>
 <20200607062340.7be7e8d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607062340.7be7e8d5@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Jun 07, 2020 at 06:23:40AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 6 Apr 2020 16:29:50 +0530 Amol Grover <frextrite@gmail.com> wrote:
> >
> > exceptions may be traversed using list_for_each_entry_rcu()
> > outside of an RCU read side critical section BUT under the
> > protection of decgroup_mutex. Hence add the corresponding
> > lockdep expression to fix the following false-positive
> > warning:
> > 
> > [    2.304417] =============================
> > [    2.304418] WARNING: suspicious RCU usage
> > [    2.304420] 5.5.4-stable #17 Tainted: G            E
> > [    2.304422] -----------------------------
> > [    2.304424] security/device_cgroup.c:355 RCU-list traversed in non-reader section!!
> > 
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > ---
> >  security/device_cgroup.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> > index 7d0f8f7431ff..b7da9e0970d9 100644
> > --- a/security/device_cgroup.c
> > +++ b/security/device_cgroup.c
> > @@ -352,7 +352,8 @@ static bool match_exception_partial(struct list_head *exceptions, short type,
> >  {
> >  	struct dev_exception_item *ex;
> >  
> > -	list_for_each_entry_rcu(ex, exceptions, list) {
> > +	list_for_each_entry_rcu(ex, exceptions, list,
> > +				lockdep_is_held(&devcgroup_mutex)) {
> >  		if ((type & DEVCG_DEV_BLOCK) && !(ex->type & DEVCG_DEV_BLOCK))
> >  			continue;
> >  		if ((type & DEVCG_DEV_CHAR) && !(ex->type & DEVCG_DEV_CHAR))
> > -- 
> > 2.24.1
> > 
> 
> I have been carrying the above patch in linux-next for some time now.
> I have been carrying it because it fixes problems for syzbot (see the
> third warning in
> https://lore.kernel.org/linux-next/CACT4Y+YnjK+kq0pfb5fe-q1bqe2T1jq_mvKHf--Z80Z3wkyK1Q@mail.gmail.com/).
> Is there some reason it has not been applied to some tree?

The RCU changes on which this patch depends have long since made it to
mainline, so it can go up any tree.  I can take it if no one else will,
but it might be better going in via the security tree.

							Thanx, Paul
