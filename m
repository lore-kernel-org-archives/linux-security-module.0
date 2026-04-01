Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D03115A5
	for <linux-security-module@vger.kernel.org>; Wed,  1 Apr 2026 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066286; cv=none; b=bS64moD9ftspU80Ibcy6ew+L+G9xhovLn5rGqfhhfzxg67IDdUuzVw5LTEtZTglijuL0e3oUe8vk4i26xWEFLpP2/Kse0Xu417U3J8FtN/Wz5PK5m6QjqZss+tc21M3QB+lReQL4tXriKVDAFLvIcUt4yyh6VKct9ZZSxAUOc58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066286; c=relaxed/simple;
	bh=MZ6oNDyCZVwdbAO3jiRErfRc1IGaBAObeg4tFYCzlyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL6LsuMYCLsAGLScDfx/jZktBEZ4haZjZnrFQxq3eX2MP9qM3Xe5ELrWbt5worRKOeYFQHU1YmGWqbWSQVB55NONoWuqBbIvhA8rnMVCyOGVXs6go4Jf4TKTMlukrfh73WJ0ZCzNmUxRtlf0EIBhjaBG8fz6LCOwo+O/xFW2Hlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ckjF76zh; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ckjF76zh"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fmCPv4fxQzSBr;
	Wed,  1 Apr 2026 19:57:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775066275;
	bh=L9xLfj48FBQxFm9y4+h5MQ9bi8sQbYKyvD5HE0mDFAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckjF76zhaoA6j8YBXHPuCaIxY9cNUbl1FnGE+lSv9iECFHyzqOzglOUj1PCgxqvgo
	 Dd6B2k9msEL0n4XkGTKkIb2cLIyraTxaQi/uSI87Rsh+ydBUSC3hffARexIQM679Mz
	 AdLXvxvh8rPEp/Ml+LJ8LeFUjbZlIJS3KNPu8p00=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fmCPt3Fcdzff9;
	Wed,  1 Apr 2026 19:57:54 +0200 (CEST)
Date: Wed, 1 Apr 2026 19:57:49 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	kernel test robot <lkp@intel.com>, linux-security-module@vger.kernel.org, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Georgia Garcia <georgia.garcia@canonical.com>
Subject: Re: [PATCH v8 03/12] landlock: Replace union access_masks_all with
 helper functions
Message-ID: <20260401.Re1Eesu1Yaij@digikod.net>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
 <20260327164838.38231-4-gnoack3000@gmail.com>
 <20260330.ohsoe7vu2Nob@digikod.net>
 <20260330.laew6AthooD6@digikod.net>
 <20260330.6229e57c9563@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330.6229e57c9563@gnoack.org>
X-Infomaniak-Routing: alpha

On Mon, Mar 30, 2026 at 09:00:31PM +0200, Günther Noack wrote:
> On Mon, Mar 30, 2026 at 12:53:21PM +0200, Mickaël Salaün wrote:
> > On Mon, Mar 30, 2026 at 11:56:40AM +0200, Mickaël Salaün wrote:
> > > On Fri, Mar 27, 2026 at 05:48:28PM +0100, Günther Noack wrote:
> > > > * Stop using a union for access_masks_all.
> > > > * Expose helper functions for intersection checks and union operations.
> > > > 
> > > > The memory layout of bitfields is only loosely defined by the C
> > > > standard, so our static assertion that expects a fixed size was
> > > > brittle, and it broke on some compilers when we attempted to add a
> > > > 17th file system access right.
> > > > 
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202603261438.jBx2DGNe-lkp@intel.com/
> > > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > > ---
> > > >  security/landlock/access.h  | 21 ++++++++++++++-------
> > > >  security/landlock/cred.h    | 10 ++--------
> > > >  security/landlock/ruleset.h | 13 ++++---------
> > > >  3 files changed, 20 insertions(+), 24 deletions(-)
> > > 
> > > I'd prefer this approach:
> > > 
> > > diff --git a/security/landlock/access.h b/security/landlock/access.h
> > > index 89dc8e7b93da..bc9efbb5c900 100644
> > > --- a/security/landlock/access.h
> > > +++ b/security/landlock/access.h
> > > @@ -50,7 +50,7 @@ struct access_masks {
> > >         access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
> > >         access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
> > >         access_mask_t scope : LANDLOCK_NUM_SCOPE;
> > > -};
> > > +} __packed;
> > 
> > Actually, we can just use '__packed __aligned(sizeof(u32))' and avoid
> > the static_assert change.  That would have no impact on x86, but pack it
> > on m68k.
> 
> Thanks, good catch (and thanks for pushing it to mic-next).
> Fingers crossed that this works on m68k.

So, this works!  I did some experiments with m68k and this architecture
is very special: it packs bitfields at byte granularity, not at
storage-unit granularity, except when the size of a bitfield is a
multiple of 8, in which case it aligns on this size.

I also look at the past versions of Landlock (in the stable branches),
and they are good because struct access_masks (and the related assert)
was introduced in v6.11 and fs was exactly 16 bits, which makes m68k
aligns on 2 bytes and then the size of the struct was 4 bytes.
Switching fs to 17 bits removes this optimization (I guess) and pack
(back) to 3 bytes, so recording more bits can take less space!

That's why we don't need a standalone fix to backport...
