Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1917E11C
	for <linux-security-module@vger.kernel.org>; Tue, 19 Mar 2024 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845737; cv=none; b=ABHeBxkkO9JR+LHFu+1Bxjz0We1DcjFA6GUNbkmNNZM7od2NxPIdQeutt1mBBnW0pyVuqjAtMdDSLqiMerxgVMfRZoGcWQiSldPaoyaoiHcHqgEcoemtGO/XV7W/EtFl7AjrESyOPOhgwxECd+4ReVgChwjHtGE812r+f7MzOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845737; c=relaxed/simple;
	bh=fENQjvqNGOJIElMLG83NAteDijrFr0EuoPVi3ck1bAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xyhi7mj8a8Fy87nIPeMeVd7UbWZuyamxfX22/7ka0BW20qra9vdH0w55Rj0sYVcKFlbXkw3aUSOGLrfbFRfQwX3wmbXNEn66xA4doEwIB7FMAVEV5IMMjlg1TP5+2v6n7sTAbkaZsPXJ9khK61rJ7914v79OWOhkmkbWSNv8KgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=fLP8aoLq; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="fLP8aoLq"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TzT181pX4zLC8;
	Tue, 19 Mar 2024 11:46:36 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TzT171j29zlxf;
	Tue, 19 Mar 2024 11:46:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1710845196;
	bh=fENQjvqNGOJIElMLG83NAteDijrFr0EuoPVi3ck1bAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLP8aoLqfwWxGvgT0LsfcIyzPHD/8iMS/MwlF2Wtg2OuMyi/eTKLveb3Wg61JyEnB
	 mQEIliTADiOnC6WwkYzT3g9X+1A475sCVJIJp5cPychq2M3DrOG1K3HzN8jyJMRwts
	 LbZmsVZgHJCVXOPPBUzCe7GF7aM4Znki8SobB/UQ=
Date: Tue, 19 Mar 2024 11:46:34 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Alejandro Colomar <alx@kernel.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Shervin Oloumi <enlightened@chromium.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 1/2] landlock: Extend documentation for kernel support
Message-ID: <20240319.eeb8tajeiPee@digikod.net>
References: <20240227110550.3702236-1-mic@digikod.net>
 <Zd4OlL1G3t1D3TgC@google.com>
 <20240307.oxQuab5tho0u@digikod.net>
 <ZfgOf2dHBVT4WUcp@debian>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfgOf2dHBVT4WUcp@debian>
X-Infomaniak-Routing: alpha

On Mon, Mar 18, 2024 at 10:50:42AM +0100, Alejandro Colomar wrote:
> Hi Mickaël, Günther,
> 
> Sorry for the delay!
> 
> On Thu, Mar 07, 2024 at 11:21:57AM +0100, Mickaël Salaün wrote:
> > CCing Alejandro
> > 
> > On Tue, Feb 27, 2024 at 05:32:20PM +0100, Günther Noack wrote:
> > > On Tue, Feb 27, 2024 at 12:05:49PM +0100, Mickaël Salaün wrote:
> > > > Extend the kernel support section with one subsection for build time
> > > > configuration and another for boot time configuration.
> > > > 
> > > > Extend the boot time subsection with a concrete example.
> > > > 
> > > > Update the journalctl command to include the boot option.
> > > > 
> > > > Cc: Günther Noack <gnoack@google.com>
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > > ---
> > > > 
> > > > Changes since v1:
> > > > * New patch, suggested by Kees Cook.
> > > > ---
> > > >  Documentation/userspace-api/landlock.rst | 57 +++++++++++++++++++++---
> > > >  1 file changed, 51 insertions(+), 6 deletions(-)
> 
> [...]
> 
> > > > +
> > > > +  lsm=landlock,lockdown,yama,integrity,apparmor
> > > > +
> > > > +After a reboot, we can check that Landlock is up and running by looking at
> > > > +kernel logs:
> > > > +
> > > > +.. code-block:: console
> > > > +
> > > > +    # dmesg | grep landlock || journalctl -kb -g landlock
> > > > +    [    0.000000] Command line: [...] lsm=landlock,lockdown,yama,integrity,apparmor
> > > > +    [    0.000000] Kernel command line: [...] lsm=landlock,lockdown,yama,integrity,apparmor
> > > > +    [    0.000000] LSM: initializing lsm=lockdown,capability,landlock,yama,integrity,apparmor
> > > > +    [    0.000000] landlock: Up and running.
> > > > +
> > > > +Note that according to the built time kernel configuration,
> > > 
> > > s/built time/build time/
> > >                  ^
> > 
> > OK
> 
> Here, this should actually be "build-time" since it works as an
> adjective.

Thanks Alex but this was already merged:
https://git.kernel.org/torvalds/c/35e886e88c803920644c9d3abb45a9ecb7f1e761

Because I picked Günther's below suggestion, it should be good right?

> 
> > 
> > > 
> > > It feels like the phrase "according to" could be slightly more specific here.
> > > 
> > > To paraphrase Alejandro Colomar, "Note that" is usually redundant.
> > > https://lore.kernel.org/all/0aafcdd6-4ac7-8501-c607-9a24a98597d7@gmail.com/
> > > 
> > > I'd suggest:
> > > 
> > >   The kernel may be configured at build time to always load the ``lockdown`` and
> > >   ``capability`` LSMs.  In that case, these LSMs will appear at the beginning of
> > >   the ``LSM: initializing`` log line as well, even if they are not configured in
> > >   the boot loader.
> 
> LGTM
> 
> > 
> > OK, I integrated your suggestion.  I guess `capability` is not really
> > considered an LSM but it would be too confusing and out of scope for an
> > user documentation to explain that.
> > 
> > > 
> > > > +``lockdown,capability,`` may always stay at the beginning of the ``LSM:
> > > > +initializing lsm=`` list even if they are not configured with the bootloader,
> > > 
> > > Nit: The man pages spell this in two words as "boot loader".
> > 
> > OK, I'll use "boot loader" too.
> > 
> > > 
> > > 
> > > > +which is OK.
> > > > +
> > > > +Network support
> > > > +---------------
> > > > +
> > > >  To be able to explicitly allow TCP operations (e.g., adding a network rule with
> > > >  ``LANDLOCK_ACCESS_NET_BIND_TCP``), the kernel must support TCP
> > > >  (``CONFIG_INET=y``).  Otherwise, sys_landlock_add_rule() returns an
> > > > 
> > > > base-commit: b4007fd27206c478a4b76e299bddf4a71787f520
> > > > -- 
> > > > 2.44.0
> > > > 
> > > 
> > > Reviewed-by: Günther Noack <gnoack@google.com>
> > 
> > Thanks!
> 
> Reviewed-by: Alejandro Colomar <alx@kernel.org>
> 
> Have a lovely day!
> Alex
> 
> -- 
> <https://www.alejandro-colomar.es/>
> Looking for a remote C programming job at the moment.


