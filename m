Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2940BCB0
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099065; cv=none; b=QBOsBJFfU5UEhJr/HRGduKFDJ0mX1nsrA88SDXiTyPXR6wAyc07djWJT0BOBbBuV6G2Mo0MFNo/ZjrGR+YfFZDFgH73eYO3XBazlGN4Io4szjlJ+sIT2HEtWUPFpwjMYS9SxpS4Fh/V62rrXXZmTByw6ABf1dyVZ8PBKiExhkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099065; c=relaxed/simple;
	bh=b2fhGiQ39RkywcTGxw+njGWY7y2Oau+k+W96Snq3Vqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFpICrN2mrl7kPML3W/ikTFh9PVWKD+jACL5UeN7YZ6FjJeC61icyngq4lUjS4L5uvjDs7aJKaJFRtlNHxo/zMOCFk5gT0rjyT1vxSa/Cwk+PlDQfwRIunGTeM4DQFLU/7ZxsRd9l/Hd6ckiZRLlvT5XVRTl8uOvY47sZRZjVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ljVR4W93; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ljVR4W93"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gb6Sv3zngzWwy;
	Wed, 10 Jun 2026 15:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781099055;
	bh=tGvIv1PxKFKgMNI7mBH6ThJt1/SyIN0WohknYnyxHjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljVR4W93Ob1T/vqPxgcZjPH5QgfhhEY7BBDE8CvredZKItvZ8OvJf/fsEbliI9X1B
	 /k/6ROazvuSLULGSj8uH0SuPMLwDXp0eglHwd24D4dAYpIJnUVvFPC/KcACKZk2V2e
	 UXdwyQtyKFmhzNSEphz9oNkUDyBNmJLveNoKYp34=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gb6St5Z2gzXc9;
	Wed, 10 Jun 2026 15:44:14 +0200 (CEST)
Date: Wed, 10 Jun 2026 15:44:14 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v4 0/7] landlock: Add UDP access control support
Message-ID: <20260610.Civ6WieCupei@digikod.net>
References: <20260502124306.3975990-1-matthieu@buffet.re>
 <20260522.saibiuZ5ailo@digikod.net>
 <ed2805ed-72cf-4277-993e-8a0ca73e65ee@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed2805ed-72cf-4277-993e-8a0ca73e65ee@buffet.re>
X-Infomaniak-Routing: alpha

On Sat, Jun 06, 2026 at 07:01:24PM +0200, Matthieu Buffet wrote:
> Hi Mickaël, Günther,
> 
> Thank you both for your reviews, I will follow up with these last fixes in a
> v5.
> 
> On 5/22/2026 11:08 PM, Mickaël Salaün wrote:
> > > I'm just not super happy about the clarity of logs generated for denied
> > > autobinds ("domain=xxxxxx blockers=net.bind_udp"), due to the fact that
> > > addresses and ports are currently only logged if they are non-0. A later
> > > (coordinated LSM-wide) patch could improve readability by replacing != 0
> > > checks with new booleans in struct lsm_network_audit.
> > 
> > Do you plan to send such patch after this series?  I guess we could add
> > has_{port,addr} fields to lsm_network_audit and handle AF_UNSPEC too?
> 
> I have not come up with anything better than adding boolean fields, so if
> you're in, I will draft a proposition along these lines (and cc: LSM
> subsystem maintainers to synchronize the change across LSMs, I guess)

This sounds good to me.

> 
> > > I'm also not
> > > exactly happy with the integration in existing TCP selftests, but
> > > refactoring them has already been discussed earlier.
> > 
> > Can you remind us what was your concern and the potential fix?
> 
> Regarding TCP selftests, I was referencing that discussion about readability
> (length, and usage of conditionals in what are already test variants) :
> https://lore.kernel.org/linux-security-module/22dcebae-dc5d-0bf1-c686-d2f444558106@huawei-partners.com/
> Nothing blocking, refactoring can be done when things are less busy.

Yes, let's keep that in mind and discuss it once this patch series is
merged.

> 
> -- 
> Matthieu
> 
