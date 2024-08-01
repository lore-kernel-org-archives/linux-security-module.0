Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A7A4503A;
	Thu,  1 Aug 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502094; cv=none; b=vC8obiquNluubemIzrkinKomgJklVHvWTGa9GA/fZFLE9boqAVAZClIfIbtJO35tpkrDQG/7LtnZXVUmBjSqWd0C4VYFrpqxkq6Ii2IN+gCYkg0o7wKjQRp2LaZZ7h8WajbQvFZvIdTGRcm+lx3vPBmPfPqtXvq3PTfQGBJ5tiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502094; c=relaxed/simple;
	bh=oPMWBIGWDnCmP+E/H3DFmJoTlAe3+FB5rBpJ89KabEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILxSe7zCy/VBJbdunJSBw/83xGQVl9BWn0h+/wIOHjRpkv/zDeXmfEkv7KHDeiCpTO+b35maAQGAjuJC+KTlLr1jMGx3X884OoULCxcAy3wBWV3ii7E99DIgJ7NEPqVrP+eKWP7aPB3hnidcM49FfckvZjHgwCpFiu7Dgu+x52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TiGILFWk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TiGILFWk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=B3LosT76rL39d5Z92j2m8ro9TyqY2knJY2I+i8/ybrE=; b=TiGILFWkpqupmuhMWh48DSkH7C
	DfSxDFCCQlGk5mxHs2tzJfxBZAMe41RVl4vaNhDpLUHKgjI3hpAh8WqD7y4IWAaAhuR0UWaZyzbIo
	SxLRjfQpnUI8aOfg/TY94uBwtpLsUb/+E3QXfy33lqACR0Hbxco/K2AyD2we9Jm83x7qdMp71pH9E
	ZSA+PH2c9c/+D0nAMlGPUCmQNcBLFIWl2q8pXSAZUC8OpBS4y0kBbfqYGXlmATRPZZ+JSoOGIca7T
	GuwvPn4fbqwGhInv3wC80dDrq4DLOdkd28XoQ2iUU966K33EklSDV8RTbHRMwzYOys+iuiDC3R/Tm
	9A/uBy8g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZRTf-00000005PUk-3Ywo;
	Thu, 01 Aug 2024 08:48:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7557E30088D; Thu,  1 Aug 2024 10:48:03 +0200 (CEST)
Date: Thu, 1 Aug 2024 10:48:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>,
	KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, bp@alien8.de,
	sfr@canb.auug.org.au, guoren@kernel.org, tsbogend@alpha.franken.de
Subject: Re: [PATCH] init/main.c: Do jump_label_init before
 early_security_init
Message-ID: <20240801084803.GY12673@noisy.programming.kicks-ass.net>
References: <20240731213429.2244234-1-kpsingh@kernel.org>
 <CAHC9VhQEYutCiAMitEv0JY4PRY4tdLdqEy76qvY1xB5q8Y13mg@mail.gmail.com>
 <20240801083441.GL33588@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240801083441.GL33588@noisy.programming.kicks-ass.net>

On Thu, Aug 01, 2024 at 10:34:41AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 31, 2024 at 09:15:04PM -0400, Paul Moore wrote:
> > On Wed, Jul 31, 2024 at 5:34 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > LSM indirect calls being are now replaced by static calls, this requires
> > > a jumpt_table_init before early_security_init where LSM hooks and their
> > > static calls and keys are initialized.
> > >
> > > Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static calls")
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  init/main.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Does this look okay, static call folks?
> 
> Are we confused between jump_label/static_branch and static_call ?
> 
> > > diff --git a/init/main.c b/init/main.c
> > > index 206acdde51f5..5bd45af7a49e 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -922,6 +922,8 @@ void start_kernel(void)
> > >         boot_cpu_init();
> > >         page_address_init();
> > >         pr_notice("%s", linux_banner);
> > > +       /* LSM and command line parameters use static keys */
> > > +       jump_label_init();
> > >         early_security_init();
> > >         setup_arch(&command_line);
> > >         setup_boot_config();
> > > @@ -933,8 +935,6 @@ void start_kernel(void)
> > >         boot_cpu_hotplug_init();
> > >
> > >         pr_notice("Kernel command line: %s\n", saved_command_line);
> > > -       /* parameters may set static keys */
> > > -       jump_label_init();
> > >         parse_early_param();
> > >         after_dashes = parse_args("Booting kernel",
> > >                                   static_command_line, __start___param,

Anyway, the scariest thing jump_label_init() does is
arch_jump_label_transform_static(). Which, IIRC, was used to optimize
NOPs on x86, which we've since removed.

Only csky and mips seem to still implement this hook, and they do
flush_icache() -- as one would expect.

If any of that is affected by the placement you propose, is something
you'd have to ask those architecture maintainers I'm afraid.

Aside from that I don't see a problem :-)
