Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45770431E74
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935359; cv=none; b=O816eq1kNZTKNuPXohMc++hwYXrJh8mPQ/DPyaJUjZB9EgGey5q9LNaQp+B3B7K6Yhg2GSO4iMCDsxU1rFMkiZVMFa7rO2N40pTqNjMiQ1xG9NiY87OdUfxHt5YR1doFgRMJQAreGWNTWe0oGsF03+1EklFlcHTC0/3wTEBCnxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935359; c=relaxed/simple;
	bh=+PO6Jv5aQEC1AdRkFIMezYhDZ32fwd7yteKTu06ncwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7NbQIfYi39aUhxvJTP/rE8rhYMtInpVK+p1AUQ2kxAHmp9RZp61iyRJif+a3SObDlmzsamY5TTqlBoHMTSuovK/9BRGSSPNRhAOWS2GUTWEEnYLPyRwzMcdxdedfX7YnAWQ4HO8CeMLtm5iVBWh3gjbxVAsReXbNezkKGiFc/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=gg9IYyP7; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gg9IYyP7"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gr9ZM3Cfrznpq;
	Wed,  1 Jul 2026 21:49:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1782935355;
	bh=2EXsSe8ptI/Vsy+FKQ/hQBs65YWDNcUEBktyRoWNYiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gg9IYyP7K8PBkSnAyrNffRejOkTywh3/eKAKWOjAzEVDEGFKMtzG3t13YPgLLBzG7
	 bvx/hElNmP+ipI5azlzPBYsnMr9VY7a211TUpFWfaaLfq6O/qsZhoT1iouOFV/J7FX
	 ANOBSeFbqKqziYC4jsHNuRv97P3EQOTPSyhPu2gM=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gr9ZJ44XfzNxF;
	Wed,  1 Jul 2026 21:49:12 +0200 (CEST)
Date: Wed, 1 Jul 2026 21:49:07 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org, 
	john.fastabend@gmail.com, Justin Suess <utilityemal77@gmail.com>, andrii@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, gnoack@google.com, 
	jack@suse.cz, jmorris@namei.org, serge@hallyn.com, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, 
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
Message-ID: <20260701.oTeikequi3ee@digikod.net>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com>
 <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox>
 <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <20260701.jei4Paej3zen@digikod.net>
 <CAHC9VhRzZVUz8icZ2RD9OVvscJdZW3ivPERJLEkNi5poBeguxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRzZVUz8icZ2RD9OVvscJdZW3ivPERJLEkNi5poBeguxw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 01, 2026 at 02:38:08PM -0400, Paul Moore wrote:
> On Wed, Jul 1, 2026 at 2:34 PM Mickaël Salaün <mic@digikod.net> wrote:
> > On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > > On Wed, Jul 1, 2026 at 8:52 AM Justin Suess <utilityemal77@gmail.com> wrote:
> > > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > > > On Wed, Jul 1, 2026 at 6:59 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > > > > > > Create 2 kfuncs exposing control over Landlock functionality to BPF
> > > > > > > callers. Export an opaque struct bpf_landlock_ruleset preventing callers
> > > > > > > from accessing unstable internal Landlock fields.
> > > > >
> > > > > Generally speaking we don't want to provide APIs, either in-kernel or
> > > > > at the userspace/kernel boundary, that are specific to a single LSM,
> > > > > see the LSM syscalls or the security_current_getlsmprop_subj()
> > > > > function as examples.
> >
> > This patch series is not about the LSM framework, only about Landlock
> > and its specific model and use case.  Landlock using some of the LSM API
> > is not relevant here.
> 
> Based on a quick look the patchset enables BPF programs to call
> directly into Landlock.  For the same reason we discourage other parts
> of the kernel to call directly into individual LSMs, we want to
> discourage BPF programs from calling directly into individual LSMs.

We're OK for a dedicated kfunc to call directly into Landlock (with a
tailored interface).  Landlock is designed around its syscall interfaces
(well documented, tailored, tested), and this would be a new user of
almost the same UAPI.
