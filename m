Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B531FB4
	for <linux-security-module@vger.kernel.org>; Thu,  3 Oct 2024 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727923917; cv=none; b=KbB7RnJRp9Ct437q0glRZ6UoDWlh7Sbh/1LxXwRR5XkkQdBSzgr4qB3/aPm27NF4aouUrkyoeJlvfohhgp0BVVeJsY7OImVGizAOykaT1biKD7XeKEnEug7D/+i3w5BcKKpQ2vb8c8EOvVnoPA/QojpuuVnPCL3IPAKMEOSVoCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727923917; c=relaxed/simple;
	bh=IB58bIgU9Ne8F5LPKUhNpsQ9HhBDRXALP4rLbhzRpdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2hJDp+Hj4lnChbGAArYGO9TTsexcCOIw+Ob44AddvNKYRIi7VgAuEl3XBydvSUMBd4CZdeHiPXDMO+/gFbfeh+UGbOYpVumtp8B5O4BqJt+Mp5KCKPVh9L+3dBtPRH6RizrjWeKcV8OF3kEOhk/oO7faCU+dua2fHMIMPFLvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 0D4D0815; Wed,  2 Oct 2024 21:51:52 -0500 (CDT)
Date: Wed, 2 Oct 2024 21:51:52 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Fan Wu <wufan@linux.microsoft.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-security-module@vger.kernel.org,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: TOMOYO's pull request for v6.12
Message-ID: <20241003025152.GA834221@mail.hallyn.com>
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <20241003024307.GA833999@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003024307.GA833999@mail.hallyn.com>

On Wed, Oct 02, 2024 at 09:43:07PM -0500, Serge E. Hallyn wrote:
> On Wed, Oct 02, 2024 at 04:12:50PM -0400, Paul Moore wrote:
> > Hi all,
> > 
> > Hopefully by now you've at least seen the TOMOYO v6.12 pull request
> > thread; if you haven't read it yet, I suggest you do so before reading
> > the rest of this mail:
> > 
> > https://lore.kernel.org/all/0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp
> > 
> > Of the three commits in the pull request, the commit which concerns me
> > the most is 8b985bbfabbe ("tomoyo: allow building as a loadable LSM
> > module").  The commit worries me as it brings management of the TOMOYO
> > LSM callbacks into TOMOYO itself, overriding the LSM framework.
> > Jonathan raises a similar point, although his issue is more focused on
> > the symbol export approach itself, rather than conceptual issues
> > relating to the LSM framework.  I will admit there are some high level
> > similarities to this approach and the BPF LSM, but I believe we can
> > say that the BPF LSM exception is necessary due to the nature of BPF,
> > and not something we want to see duplicated outside of that one
> > special case.
> > 
> > As I wrote in my original response to this pull request, this is not
> > something I would accept in a new LSM submission and thus I feel
> > compelled to speak out against this change and submit a revert to
> > Linus.  However, as the LSM framework exists to satisfy the needs of
> > the individual LSMs, I've tried to ensure that significant changes
> > like these are done with support of the majority of LSMs.  I
> > understand that in a case like this, reverting LSM-specific commits,
> > individual LSM maintainers may not want to speak up on the issue so
> > I'm going to let this message sit on-list until Friday morning, unless
> > I see the majority of the LSMs voicing support *against* reverting the
> > TOMOYO commit above (and the other related commit) I will proceed with
> > submitting the revert to Linus on Friday.  I would prefer if all
> > responses are sent on-list, but you can also mail me privately with
> > your objection to the revert and I will include it in the count.
> > 
> > Thanks.
> 
> Huh!  Honestly, when I read the thread, especially Jon's comments, I was
> worried.  But getting a chance to look at the patch now, it actually
> seems good to me.  No one is getting affected unless they enable
> CONFIG_TOMOYO_LKM.  Even those distros which have been enabling TOMOYO
> won't be exporting new hooks without a config change, iiuc.
> 
> -serge

OTOH I am worried about the threatening sentence:

> This backdoor symbol-export mechanism is a transitional hack needed for
> demonstrating that loadable LSM can work. This hack will be replaced with
> proper symbol-export via appropriate trees after this merge window closes.


(in 7dce903c-2f76-43b2-bb6f-808cb50d0696@I-love.SAKURA.ne.jp)

-serge
