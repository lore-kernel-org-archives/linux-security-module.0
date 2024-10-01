Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F951CCECE
	for <linux-security-module@vger.kernel.org>; Tue,  1 Oct 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817623; cv=none; b=KEX3rM2gW8xVFzRPFIUw0sEvfc8qm9Kw9T8tMpYTta6sGRS+6aI01K/YrgNXkh86U4Q7sTqPd+nBiMJSayEFVe6F+RuqhOD2r4NmjJR3VFNd8gAAvLF6XKfZY6/cUmq1U2VCsSSPZMFk3S2g9iK53pRgblol9y/HvAJXAPi/txY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817623; c=relaxed/simple;
	bh=xWtunizu7sprcSmUlqssyJWt3mWCr9fUw4ZmXM89Ioc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOTX+tlhuGUzeEa3GXIQt5ju5VwN+UcQ5tzVcJWhIC5P8aBc6C71TI7M0NLt6zRURfO+Yh3LURkk2lz/x4dSaTziBL9vwLLQXHMQoAageUlC5SyOCqVOF87mQLJbggv699dsr9Bdzwo5VOEeg2BRFhyEur1ShLKwSMZtJlT96Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 7C8C8677; Tue,  1 Oct 2024 16:20:13 -0500 (CDT)
Date: Tue, 1 Oct 2024 16:20:13 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] capabilities: remove cap_mmap_file()
Message-ID: <20241001212013.GA801783@mail.hallyn.com>
References: <20240925192018.15290-2-paul@paul-moore.com>
 <dd386a1f-9245-45ae-b0fe-d07d1dec5100@schaufler-ca.com>
 <20240926131157.GA683524@mail.hallyn.com>
 <CAHC9VhSyYkq=AxiVkwkuk1jsTTCqt9xypdto5yaX3jdLXy+Xxg@mail.gmail.com>
 <20240926132251.GB683524@mail.hallyn.com>
 <CAHC9VhRj5BvBBir3_sWo5whbpRVmpppYEqrvgRf17mR2-xHdAQ@mail.gmail.com>
 <20240930210801.GA778168@mail.hallyn.com>
 <CAHC9VhQZ1wM-pYW5sPEcP9=uKi4sAFR1nEiEXu-tYypy7feHqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQZ1wM-pYW5sPEcP9=uKi4sAFR1nEiEXu-tYypy7feHqA@mail.gmail.com>

On Tue, Oct 01, 2024 at 10:08:04AM -0400, Paul Moore wrote:
> On Mon, Sep 30, 2024 at 5:08 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Thu, Sep 26, 2024 at 09:24:06AM -0400, Paul Moore wrote:
> > > On Thu, Sep 26, 2024 at 9:22 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > > > On Thu, Sep 26, 2024 at 09:16:04AM -0400, Paul Moore wrote:
> > > > > On Thu, Sep 26, 2024 at 9:11 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > > > > > On Wed, Sep 25, 2024 at 12:45:20PM -0700, Casey Schaufler wrote:
> > > > > > > On 9/25/2024 12:20 PM, Paul Moore wrote:
> > > > > > > > The cap_mmap_file() LSM callback returns the default value for the
> > > > > > > > security_mmap_file() LSM hook and can be safely removed.
> > > > > > > >
> > > > > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > > > >
> > > > > > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > > >
> > > > > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > > > >
> > > > > Thanks Serge.  Any interest in pulling this via the capabilities tree
> > > > > or would you prefer I take this via the LSM tree?
> > > >
> > > > Oh, jinkeys - I guess should take it through the capabilities tree if
> > > > only to check that it still works!
> > >
> > >  :)
> > >
> > > Sounds good, if you change your mind let me know and I'll pick this up.
> >
> > Just got access back to my kernel.org account.  Too late for 6.12 cycle, so
> > I'll keep it ready for 6.13 window.  I suppose I should see about hooking
> > back into the -next kernel for testing.
> 
> Sorry for the delay, network access was spotty over the past few days,
> and what little I did have was just my phone.
> 
> Anyway, yes, this was intended for v6.13 anyway so no harm there.
> Glad you're setup again on kernel.org.
> 
> Hooking up to linux-next is pretty easy, basically just send some
> mail, but if I can offer a suggestion you might want to make your
> linux-next branch a automatically generated "composite" branch so you
> are better able to get both linux-stable and linux-next patches tested
> via the normal linux-next mechanisms.  I'm sure you've seen this
> already, but here is the approach I take with the LSM tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/tree/README.md#n94

Thanks!  I thought in the past there had been "how to best work with
linux-next" guides out there, but I spent some time looking through
linux.git/Documentation, linux-next/, lore.kernel.org, and kernelnewbies
and google and came up with nothing.

-serge
