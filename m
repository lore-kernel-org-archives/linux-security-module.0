Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42D19DF4F
	for <linux-security-module@vger.kernel.org>; Mon, 30 Sep 2024 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730493; cv=none; b=rfv6asF55zL+N5Iwh0Q7Rdvjsq7X/ZCSOlbMhHyFpy0fG0GgPvSh/+rgfoUMviNdnjEodBNvcTjtg9yMQ7rohoWH0DyzkNqBPwyP86zrg5t1iisCqmFkb/CrvEMLREVoCVG/+dRR3uUQjqSh/FLkXZsQupQSRie/H44RIVQ/36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730493; c=relaxed/simple;
	bh=3VDtNdtnzpBKoOJECrRjXc9HY/aedLoQpBUyg7df6io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRxcHwVIJ8w3UDP3Tiarzc0bnC49hCdFmQdnmEyXs1PbkSL/JdYRWGWA55ZIUQEvbzihZMOkwXIjGNbARz8mXemIcsAWhZLytthHwneClWElg+DHa1aDAzE5hOSWLZ9tRAe6ySdx2jfL43n2SS065m5Ikj71vPnT0iiGFLU10B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id EE55F81E; Mon, 30 Sep 2024 16:08:01 -0500 (CDT)
Date: Mon, 30 Sep 2024 16:08:01 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] capabilities: remove cap_mmap_file()
Message-ID: <20240930210801.GA778168@mail.hallyn.com>
References: <20240925192018.15290-2-paul@paul-moore.com>
 <dd386a1f-9245-45ae-b0fe-d07d1dec5100@schaufler-ca.com>
 <20240926131157.GA683524@mail.hallyn.com>
 <CAHC9VhSyYkq=AxiVkwkuk1jsTTCqt9xypdto5yaX3jdLXy+Xxg@mail.gmail.com>
 <20240926132251.GB683524@mail.hallyn.com>
 <CAHC9VhRj5BvBBir3_sWo5whbpRVmpppYEqrvgRf17mR2-xHdAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRj5BvBBir3_sWo5whbpRVmpppYEqrvgRf17mR2-xHdAQ@mail.gmail.com>

On Thu, Sep 26, 2024 at 09:24:06AM -0400, Paul Moore wrote:
> On Thu, Sep 26, 2024 at 9:22 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Thu, Sep 26, 2024 at 09:16:04AM -0400, Paul Moore wrote:
> > > On Thu, Sep 26, 2024 at 9:11 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > > > On Wed, Sep 25, 2024 at 12:45:20PM -0700, Casey Schaufler wrote:
> > > > > On 9/25/2024 12:20 PM, Paul Moore wrote:
> > > > > > The cap_mmap_file() LSM callback returns the default value for the
> > > > > > security_mmap_file() LSM hook and can be safely removed.
> > > > > >
> > > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > >
> > > > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > >
> > > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > >
> > > Thanks Serge.  Any interest in pulling this via the capabilities tree
> > > or would you prefer I take this via the LSM tree?
> >
> > Oh, jinkeys - I guess should take it through the capabilities tree if
> > only to check that it still works!
> 
>  :)
> 
> Sounds good, if you change your mind let me know and I'll pick this up.

Just got access back to my kernel.org account.  Too late for 6.12 cycle, so
I'll keep it ready for 6.13 window.  I suppose I should see about hooking
back into the -next kernel for testing.
