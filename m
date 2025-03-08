Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4251DDC0B
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459815; cv=none; b=kwPCzkz0UE/zI8rD0S7h18fAvwAm1ZzLxp2mfyFbh41mi0jK1XCRqVS3GmyXlB/9OUluSvOzv0rhsJd3qXXLbWlnAiFdDIIzAZebfzsmxjAZvg+wykxGqsepp+8HM2iep9h/sER/5n5mZF1kiEz+7eA8S3jkHmomHhOjjjQC8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459815; c=relaxed/simple;
	bh=KccRmKopDzpzcsIQqux0kM71Ko6yFWLOgpDHgLG/Ooc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsMy8zADnp/h5yE1vew2kpwcL83YFKXRqxDN75TF25e3sZ7bqDoUWTi0CnCpZO2l+0pj/dTR+VB5FAyz3SIS53Xr1hzK+kxpApNtOrlYeaJLpEOtu8rfR1VAp4IqMQ9v0qeBz9YlkCl49K2N+vGs08p18YYwBnhJvqZqQ0Z/144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hENOQpfP; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hENOQpfP"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9BmN3pTzzNwS;
	Sat,  8 Mar 2025 19:40:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459220;
	bh=lTMXco+S8phMp0wJ7FpXrE4IyYLwzV5fOK4aa3aX+EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hENOQpfPaSBEj9lAejXUEN7GW2PBud7EHSSxox4uG20za2u4qWalaIc78GX6u/gJ9
	 DV2NPrHaxT4nuWrURnyQ40GcNlOXxplhssLw+EKdMyUK7efmSSbjHM1cRUCFAzc0xh
	 HTfA3Uxw35FSF0bKp02QmaxIBZ4KuWIXv1tZudRM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9BmM0bNZzq4n;
	Sat,  8 Mar 2025 19:40:19 +0100 (CET)
Date: Sat, 8 Mar 2025 19:40:18 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, 
	Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, 
	Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, 
	Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 02/24] landlock: Add unique ID generator
Message-ID: <20250308.moo2siethohX@digikod.net>
References: <20250131163059.1139617-1-mic@digikod.net>
 <20250131163059.1139617-3-mic@digikod.net>
 <20250307.db38587e80e7@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250307.db38587e80e7@gnoack.org>
X-Infomaniak-Routing: alpha

On Fri, Mar 07, 2025 at 03:15:44PM +0100, Günther Noack wrote:
> On Fri, Jan 31, 2025 at 05:30:37PM +0100, Mickaël Salaün wrote:
> > --- /dev/null
> > +++ b/security/landlock/id.c
> > +static atomic64_t next_id = ATOMIC64_INIT(COUNTER_PRE_INIT);
> > +
> > +static void __init init_id(atomic64_t *const counter, const u32 random_32bits)
> > +{
> > +	u64 init;
> > +
> > +	/*
> > +	 * Ensures sure 64-bit values are always used by user space (or may
> > +	 * fail with -EOVERFLOW), and makes this testable.
> > +	 */
> > +	init = 1ULL << 32;
> > +
> > +	/*
> > +	 * Makes a large (2^32) boot-time value to limit ID collision in logs
> > +	 * from different boots, and to limit info leak about the number of
> > +	 * initially (relative to the reader) created elements (e.g. domains).
> > +	 */
> > +	init += random_32bits;
> > +
> > +	/* Sets first or ignores.  This will be the first ID. */
> > +	atomic64_cmpxchg(counter, COUNTER_PRE_INIT, init);
> 
> It feels like this should always need to succeed.  Or to say it the
> other way around: If this cmpxchg were to fail, the guarantees from
> your commit message would be broken.  Maybe it would be worth handling
> that error case in a more direct way?

This should always succeed and with the current code it always succeed
because there is only one call to this function.  This
atomic64_cmpxchg() is a safeguard to be sure that, even if there are
several calls to this function, the counter will only be initialized
once (i.e. cmpxchg only sets the counter if its value was 0)

We could add a WARN_ON(atomic64_cmpxchg()) but I don't see the point.

> 
> 
> > +static void __init test_init_once(struct kunit *const test)
> > +{
> > +	const u64 first_init = 1ULL + U32_MAX;
> > +	atomic64_t counter = ATOMIC64_INIT(COUNTER_PRE_INIT);
> > +
> > +	init_id(&counter, 0);
> > +	KUNIT_EXPECT_EQ(test, atomic64_read(&counter), first_init);
> > +
> > +	init_id(&counter, ~0);
> > +	KUNIT_EXPECT_EQ(test, atomic64_read(&counter), first_init);
> 
> Maybe we can annotate this with an explanatory message,
> to make it slightly clearer that this is the point of the test:
> 
> KUNIT_EXPECT_EQ_MSG(test, atomic64_read(&counter), first_init,
>     "should still have the same value after the subsequent init_id()");

Yep, good idea.

> 
> –Günther
> 
