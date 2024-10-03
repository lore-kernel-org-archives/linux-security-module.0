Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FA0186E3D
	for <linux-security-module@vger.kernel.org>; Thu,  3 Oct 2024 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973736; cv=none; b=DEh60zN0/Un0DBzrahf+xTmq72R9B2DuGFAVQ3FAs3a8c57zJq1JM+6qc1HaFw881m445bij6uicIXAbUG3yLJfh99EOugACF06j2PjOJOhY6qS75GDfuEpHckPM+KS0b56KScSMIKsi+PoDJvgk8/xK0iFhKrqsCENEtiiwMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973736; c=relaxed/simple;
	bh=Ay6RWFq08CJyJLqo2BZoaMR2MOg0DT3tCYulgsHLicI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGxKf97pOb7EinmkgcsIXzD5/XsO3xA2Z4VCLUOVUCkz2ZP72iYAFaRjQGUn+SwCp4f+dBs6t28Ziow8wIZTQs2KAq5gcxxB/0DKn70/Tl4UEaAUEOwhq8UUm1+Fb4lcZ1UxnZixsNalIxcUAcnrLuRRXzfY8wEmpng3TB2Ez+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id DDDAA9DA; Thu,  3 Oct 2024 11:42:11 -0500 (CDT)
Date: Thu, 3 Oct 2024 11:42:11 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Fan Wu <wufan@linux.microsoft.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Micah Morton <mortonm@chromium.org>,
	John Johansen <john.johansen@canonical.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-security-module@vger.kernel.org
Subject: Re: TOMOYO's pull request for v6.12
Message-ID: <20241003164211.GA849107@mail.hallyn.com>
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <f0fc9923-c91a-48b2-ae61-30dd7287ecc2@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0fc9923-c91a-48b2-ae61-30dd7287ecc2@schaufler-ca.com>

On Thu, Oct 03, 2024 at 09:36:00AM -0700, Casey Schaufler wrote:
> On 10/2/2024 1:12 PM, Paul Moore wrote:
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
> 
> We wrangled with the BPF developers over a number of issues,
> and in the end gave them something that's a lot more dangerous
> than I'd like. With that in mind I can argue either of:
> 
> 	Let's not do that again, revert.

Just checking - do you mean revert this, but not BPF LSM?  :)

> 	We need to trust our LSM developers in their own code, keep it.
> 
> What Tetsuo has implemented is a scheme that's been bouncing around for
> some time. It is neither especially novel nor elegant. It is intended to
> solve a particular issue, which is that Redhat distributions don't include
> TOMOYO. [I should be corrected if that statement is not true] When we
> talked about loadable modules in the past it was in the context of a
> general mechanism, which I have always said I don't want to preclude.
> 
> I seriously doubt that this change would achieve the goal of getting
> TOMOYO included in Redhat distributions. It seriously increases the

Right, I think this is the biggest reason to request the revert, unless
Redhat or fedora tells us that they would actually enable it.
