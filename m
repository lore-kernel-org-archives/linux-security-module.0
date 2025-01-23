Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7117C91;
	Thu, 23 Jan 2025 01:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596324; cv=none; b=Aq/uVMWhh3P90q0CVyz4DfzX7BSWEmrh+fUNYpQ/EpXyprkvpTVlkTgd91xSTut47j4JwfjDT/i/lYqhK7Xl7eI216zFFU2xRSkoSM5eYn74Ge6Z7I2wZqckVTnjccwlewxiYV4IrAy/Ru1Iliw6x1AZJfWlYo8eOGiNzoRGnKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596324; c=relaxed/simple;
	bh=x4efHS66KyASxBXzZm31vgL988ltZEN4fmkyr/J+R90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9f+UwrqqVD1ScVTrUXgDdq9mT8Dw3BeM6+oasjP/CzaPKytIqB0ocDMC8x2umWlnAeNV5WVs26lLwgtW9nKmCQ/iFN64R3+uvhl3Sl0iYyauxxbqWofLNoF4PEX9FEpH3khH3SO9MSbERyphwPdvkkkjD2yKnDD8DRzEiI+MNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=MsrBf2Gq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=htzxCMEZ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="MsrBf2Gq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="htzxCMEZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 480301140169;
	Wed, 22 Jan 2025 20:38:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 22 Jan 2025 20:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737596321;
	 x=1737682721; bh=HrHQ2CW7Cj1oiYTfKJkC5mojHs2+kIhFGY7OzXviIY8=; b=
	MsrBf2GqdEfe+zePLi4WrCOw8CcH1zB1RxZEpQHyNlonL5vEncls0j3LE/3Av7zo
	RH/3Z+UOTYO0+HqexnwpOrwc39ereL9Bd1ZHZgdhzXzEsC0aN+afBS5Z/sNXhJZF
	bgjMngpca+Wei3v4x3RpipydcQvZIa93SjzK5xnId52mEWCh1/8CL/g3l/HexrEQ
	wwpu1u64srMtlzimVJX2CysKJChEhMREp+9YszZ9To6Ptg5CQkvF9yw+hVvBcrix
	bADm24KCK3OyqzdNFkgWghmtwEfVQkL148cWmm+SHbG0WDg776vbs1a0y5c80xbc
	km3QhYxdkAhPTmYHme/jWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737596321; x=
	1737682721; bh=HrHQ2CW7Cj1oiYTfKJkC5mojHs2+kIhFGY7OzXviIY8=; b=h
	tzxCMEZmuxWW3R+6LfvDts9uP+0AEP3PZnuncRLGmI0Y5sN9FmhOK/uwDKu7c1Yq
	tH+VoO0qLkjtysoO26GBE4dEMcVmBuE/4Woua6TuAItDeDOiDKwA2BPkjyqTkHOa
	AHPRsleCZOdWUZ4OEd4YRpOwQ13Azwq25AmewQgj8HHBxl9Vx4eF4l+oxL+jt8cQ
	RkuSUBrf1yh8Q9PFd8jvShOATG0VTxohNIDtNg+nKuzXsca6Udi2eJvJ8ZZYl/3h
	SBm0l2b0hx0Do4jIQkWLmezQL8eSK7hIZEv54fun0ijlAbYslOIGAjYfNiftzQu3
	O0bNbz3y+78en3vmisusA==
X-ME-Sender: <xms:oJ2RZ3H5C2qo-Ez0SrRYojm7dmtZMaieC_n-iwDNw921nLmOU4ROkw>
    <xme:oJ2RZ0XXViPrLaeOYoxYiqe96P1YpmVWt-l6vRZkEToPRcsGaqw4cIKFxyQSw6zXp
    2bDw2HEFdrj07fFNc0>
X-ME-Received: <xmr:oJ2RZ5L-XVIG5X1uaS6NzNf2ITGMmZcdmL0FRFejLSr_B98h6kMgTfahPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefvhihlvghrucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeeghfeiueehfeektefffeffkeejhffgfeeivdevieeu
    udfgueeffedviefhheeiveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegtohguvgesthihhhhitghkshdrtghomhdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihufhgrnheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphht
    thhopehjmhhorhhrihhssehnrghmvghirdhorhhgpdhrtghpthhtohepshgvrhhgvgeshh
    grlhhlhihnrdgtohhmpdhrtghpthhtohepuggvvhgvnhdruggvshgriheslhhinhhugidr
    mhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehshhihrghmshgrihhniheslhhinh
    hugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhr
    ihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oJ2RZ1H8NxQEyCBvu-kyq4a9dQFvc3P3YVgqPFKwtrij-NTGWuRe7g>
    <xmx:oJ2RZ9X4dv3g-6Cht4XhDGp7WelsrLb1yBhQQsk93Xj5ISNlasGScw>
    <xmx:oJ2RZwPteWqYomAEXScrL8WsBqVKc6aTrBqcBDekQFRBVXyfhpU_lQ>
    <xmx:oJ2RZ80tPGyWIF93uzGMlQ4R3GHR0m2ozwe7NBAEAUJVaBZpIeOUUg>
    <xmx:oZ2RZ5qvsffZNLCLJNZR6RnlRB78c-HlgoYBq9ucAKzvemHgWe01d0qD>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 20:38:39 -0500 (EST)
Date: Wed, 22 Jan 2025 19:38:28 -0600
From: Tyler Hicks <code@tyhicks.com>
To: Fan Wu <wufan@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Deven Bowers <deven.desai@linux.microsoft.com>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipe: Search for the boot policy file in the source tree
Message-ID: <Z5GdlKW09UhO9YYo@redbud>
References: <20250122065740.545042-1-code@tyhicks.com>
 <CAKtyLkG75o=+9UtskB6Qn2ZvzDrzQPi6gBoAYXvio__46Mds8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKtyLkG75o=+9UtskB6Qn2ZvzDrzQPi6gBoAYXvio__46Mds8Q@mail.gmail.com>

On 2025-01-22 10:41:07, Fan Wu wrote:
> Thanks for the fix.
> 
> My only concern here is the use of wildcard. I'm not sure but if
> $(CONFIG_IPE_BOOT_POLICY) is a glob pattern it could match multiple
> files?

Ah, that's a great point. To be honest, I followed the example of
CONFIG_MODULE_SIG_KEY in scripts/Makefile.modinst and didn't consider this
possible issue.

I can reproduce your concern. It doesn't actually cause any problems because
only the first matched file is used for the boot policy but it is potentially
confusing and boot policy is not something that we want to be unsure about.

Let me think of something else. It might be a few days before I get a chance to
send out a v2.

> Other than that I think the doc of security/ipe/Kconfig needs to be
> updated as well to reflect the makefile change.

Were you thinking something like this?

          This option specifies a filepath to an IPE policy that is compiled
	  into the kernel. The filepath can be absolute or relative from either
	  the source tree or the object tree. This policy will be enforced
	  until a policy update is deployed via the
          $securityfs/ipe/policies/$policy_name/active interface.

          If unsure, leave blank.

I doubt any users actually want a relative path from the object tree but that
has been supported since IPE was initially merged so I think it is worth
keeping around.

Tyler

> 
> -Fan
> 
> On Tue, Jan 21, 2025 at 10:58 PM Tyler Hicks <code@tyhicks.com> wrote:
> >
> > Resolve CONFIG_IPE_BOOT_POLICY relative file paths in the source tree if
> > the file was not found within the object tree and is not an absolute path.
> >
> > This fixes an IPE build failure that occurs when using an output directory,
> > such as with the `O=/tmp/build` make option, during a build with the
> > CONFIG_IPE_BOOT_POLICY option set to a path that's relative to the kernel
> > source tree. For example,
> >
> >   $ grep CONFIG_IPE_BOOT_POLICY /tmp/build/.config
> >   CONFIG_IPE_BOOT_POLICY="ipe-boot-policy"
> >   $ touch ipe-boot-policy
> >   $ make O=/tmp/build
> >   make[1]: Entering directory '/tmp/build'
> >     GEN     Makefile
> >     UPD     include/config/kernel.release
> >     UPD     include/generated/utsrelease.h
> >     CALL    scripts/checksyscalls.sh
> >     CC      init/version.o
> >     AR      init/built-in.a
> >     CC      kernel/sys.o
> >     AR      kernel/built-in.a
> >     IPE_POL ipe-boot-policy
> >   An error occurred during policy conversion: : No such file or directory
> >   make[5]: *** [security/ipe/Makefile:14: security/ipe/boot_policy.c] Error 2
> >   make[4]: *** [scripts/Makefile.build:440: security/ipe] Error 2
> >   make[3]: *** [scripts/Makefile.build:440: security] Error 2
> >   make[2]: *** [Makefile:1989: .] Error 2
> >   make[1]: *** [Makefile:251: __sub-make] Error 2
> >   make[1]: Leaving directory '/tmp/build'
> >   make: *** [Makefile:251: __sub-make] Error 2
> >
> > Fixes: ba199dc909a2 ("scripts: add boot policy generation program")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tyler Hicks <code@tyhicks.com>
> > ---
> >  security/ipe/Makefile | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/ipe/Makefile b/security/ipe/Makefile
> > index 2ffabfa63fe9..b54d7b7c9e6d 100644
> > --- a/security/ipe/Makefile
> > +++ b/security/ipe/Makefile
> > @@ -10,8 +10,10 @@ quiet_cmd_polgen = IPE_POL $(2)
> >
> >  targets += boot_policy.c
> >
> > -$(obj)/boot_policy.c: scripts/ipe/polgen/polgen $(CONFIG_IPE_BOOT_POLICY) FORCE
> > -       $(call if_changed,polgen,$(CONFIG_IPE_BOOT_POLICY))
> > +boot-pol := $(if $(wildcard $(CONFIG_IPE_BOOT_POLICY)),,$(srctree)/)$(CONFIG_IPE_BOOT_POLICY)
> > +
> > +$(obj)/boot_policy.c: scripts/ipe/polgen/polgen $(boot-pol) FORCE
> > +       $(call if_changed,polgen,$(boot-pol))
> >
> >  obj-$(CONFIG_SECURITY_IPE) += \
> >         boot_policy.o \
> > --
> > 2.34.1
> >
