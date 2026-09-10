Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E933A7F54
	for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2026 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027967; cv=none; b=LPQ/YK9eEpP8pUKvUcZ4ypEja7DMB69FVVGFXfh6HzaR4DDyDnqSC+K0ylggafAqmuc/Mt+gDdGJeuXyObT7wyfkmTnjXPYeHSGAZPwVbKjX5P/5KQs/WdjWoNSBWcRM5ojCkaeXoY6mP8oyaZ+hf0BdQ9/2WT43VRfS/eQeWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027967; c=relaxed/simple;
	bh=0Aqymz4SH8EtX2j/M+mZWv2LIN1WctUYM615PbzbH44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk1w0aSUE2TUmXDWrYMcmpU6DCX5ZC7MsU7oGty7vuEUmo8LQY6cxrYi2qB/Pep8lIXTxajn/JeCOlifNPzz6KQVygP+b5FP/jWtGnE41uWlRarDpcFakHUWbwPp9mjTj1pmTfrnFoqSPV8YG+c/ZeoPaQi0JkTPaiDVaU7/gc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BUJTeDO7; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BUJTeDO7"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hgVlh3BTqz6pJ;
	Thu, 10 Sep 2026 10:12:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789027952;
	bh=dwGe9HyyabnkGe1fXD6Rzg1hn+w/5pRkcYvhzHQCogY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUJTeDO7hDPSq0MZCNKyE1hgxahvX61quxoPO1xQ/kbpOAKXOWiOMcPSa5YQFj5GQ
	 R+a54v0Hd3+85nx6BbxeRVtFKGMvM+csJ4A6OvmLOe3V5U256Z6cza9+FwCq+mY02S
	 QIei18WhKs2PZO3YhgLjkCLYXIEIyAerHH5KXW/4=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hgVlf4WPJz9mH;
	Thu, 10 Sep 2026 10:12:30 +0200 (CEST)
Date: Thu, 10 Sep 2026 10:12:25 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Daniel Durning <danieldurning.work@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 3/12] security: Add LSM_AUDIT_DATA_NS for namespace
 audit records
Message-ID: <20260910.Ooph5bing9zu@digikod.net>
References: <20260726161400.3010511-4-mic@digikod.net>
 <5cabf9b33a20f130cedcc423b8b2d151@paul-moore.com>
 <CAHC9VhS_WP-bLgMGiFAfE1MT76iKvVJ-OV5r7xju-KMdrfjssQ@mail.gmail.com>
 <20260909.quahcia8aiF4@digikod.net>
 <CAHC9VhSRV_axaGM0hTZngQY36Jw1ULy_sHHsik0_HCSdVv4P+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSRV_axaGM0hTZngQY36Jw1ULy_sHHsik0_HCSdVv4P+A@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Sep 09, 2026 at 03:49:11PM -0400, Paul Moore wrote:
> On Wed, Sep 9, 2026 at 2:35 PM Mickaël Salaün <mic@digikod.net> wrote:
> > On Mon, Aug 31, 2026 at 05:26:20PM -0400, Paul Moore wrote:
> > > On Tue, Aug 11, 2026 at 4:16 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Jul 26, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> ...
> 
> > > Mickaël, if you would like me to merge the remaining patches in this
> > > patchset into the lsm/dev branch just let me know.
> >
> > I'll send a new patch series soon because this v3 would not apply
> > anymore.
> 
> Okay.
> 
> > I'll include your lsm/dev patches to keep a consistent patch
> > series.
> 
> Please don't as those are already merged.  If you want to stick with
> the same patch series, which is fine, just note that the first three
> patches have already been merged into the LSM tree.  It's not uncommon
> for patchsets to add or drop patches over time as both the patchset
> and the surrounding environment progress.

Yeah, I know, but at the same time are there (merged) users of these
hooks?  Anyway, we should of course avoid to have two commits for the
same patch in different branches (even if that would not be an issue for
Git), but having to handle several origins (e.g. the lsm/dev branch for
new hooks and the master branch for fixes) might lead to an unpleasant
gymnastic.

Another concern is to ease review (for both humans and bots), which
might require a well-known base commit, instead of a (transient?)
merge commit.  That's the reason why I wanted to keep the complete
series, even if when we'll apply it, we can drop the first (already
applied) patches.

My understanding is also that Linus prefers consistent pull requests,
and I'm wondering if that would be ok to send a PR with the lsm/dev (in
flight to be merged in master, but not yet) as origin.  That could still
lead to merge conflicts though...

At least, I think it would help to have these three commits rebased on a
(recent) Linux tag (without other commits in between, like the cred's
one).
