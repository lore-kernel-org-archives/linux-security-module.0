Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF745BEC;
	Thu,  1 Aug 2024 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501293; cv=none; b=grHJdm+5eQsYNNybMYyQSZ16CF5qrZWg1c2nSf3CYjSI8D7wjxyAnmEj+0+2HqnOzyaNXbWxaojC3VFunAj12dBfCC2hG36Krf7O9GYOUCvMV6IikRA+ZI6olenkldAlK9ooVjhqdUDYaO9FsHjfV2Z93fH/MIlKyCKvBJp+cL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501293; c=relaxed/simple;
	bh=vvRDK7yrMlSbmQFm4M7WfzsdhqngmWriUo6pNElTO78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxZBS6/Q+Iuc+0ElzL+Ws9xym8IoE3tugVhayr3y/vQo7Q0QTNUYJULGNwpkwesWwdmw9NaT9MwqInKlSJQRWH5pPFN4dMQd6wWvPSKfmtlpshib2rMnhKyW7KtgE7wuat7Vr/ykN5cPq6a7gUY42RuROnUQOuo3WVpHqrYhmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JZ3y+GEE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JZ3y+GEE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SKxQAqXl5QTdXr+TnhEWvp87ojF3TkgHNCfgBfl0NuU=; b=JZ3y+GEEwFoG6eLzpgVWPPG3On
	tETq8K4UzRdmPrceSoupR1dWOobDY/sOwekx8C3OUxiFezYNl7N6yDbfPwDsU5BeKlssBRp3VMPEr
	NHFuD+AdXUiSzikRpI6/ODtA905w0KZwbs4krXUnNmCqO5fi1jkVEoPkSDxm9cJy20P2v1Pk+bN6y
	kLYAgoK12va1ZmLAbzmBpPPxN16UZr1kReVffOdFuUSzsdXtFFRGhDIMgd/98icAcr+DAHyxiUQTz
	99tZlovyOrbdTIAxlz1Q2fZahuvq6uyrFnlmRP1N1R1/J+wHX0lOOrTZaxPhQKy00ZWIE1z4TScgW
	UjwpJceg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZRGk-00000005PFv-3gQb;
	Thu, 01 Aug 2024 08:34:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B422930074E; Thu,  1 Aug 2024 10:34:41 +0200 (CEST)
Date: Thu, 1 Aug 2024 10:34:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>,
	KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, bp@alien8.de,
	sfr@canb.auug.org.au
Subject: Re: [PATCH] init/main.c: Do jump_label_init before
 early_security_init
Message-ID: <20240801083441.GL33588@noisy.programming.kicks-ass.net>
References: <20240731213429.2244234-1-kpsingh@kernel.org>
 <CAHC9VhQEYutCiAMitEv0JY4PRY4tdLdqEy76qvY1xB5q8Y13mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQEYutCiAMitEv0JY4PRY4tdLdqEy76qvY1xB5q8Y13mg@mail.gmail.com>

On Wed, Jul 31, 2024 at 09:15:04PM -0400, Paul Moore wrote:
> On Wed, Jul 31, 2024 at 5:34 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > LSM indirect calls being are now replaced by static calls, this requires
> > a jumpt_table_init before early_security_init where LSM hooks and their
> > static calls and keys are initialized.
> >
> > Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static calls")
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  init/main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Does this look okay, static call folks?

Are we confused between jump_label/static_branch and static_call ?

> > diff --git a/init/main.c b/init/main.c
> > index 206acdde51f5..5bd45af7a49e 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -922,6 +922,8 @@ void start_kernel(void)
> >         boot_cpu_init();
> >         page_address_init();
> >         pr_notice("%s", linux_banner);
> > +       /* LSM and command line parameters use static keys */
> > +       jump_label_init();
> >         early_security_init();
> >         setup_arch(&command_line);
> >         setup_boot_config();
> > @@ -933,8 +935,6 @@ void start_kernel(void)
> >         boot_cpu_hotplug_init();
> >
> >         pr_notice("Kernel command line: %s\n", saved_command_line);
> > -       /* parameters may set static keys */
> > -       jump_label_init();
> >         parse_early_param();
> >         after_dashes = parse_args("Booting kernel",
> >                                   static_command_line, __start___param,
> > --
> > 2.46.0.rc2.264.g509ed76dc8-goog
> 
> -- 
> paul-moore.com
