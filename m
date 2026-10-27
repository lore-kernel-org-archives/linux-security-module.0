Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120559;
	b=SI7G273g7D/2QKLcKUBCCjgrkh6+mPyObGfg4bHRjz2N2zn4F9DcpzN6BR+RFDt4L1D5
	 CpMPiAr8VDGz3S4n8C0RxQT7LTeIehL7m18IDX13zRS06sxGQAuvI/LQVeZWz0q+CBd0L
	 vWUGxNRVTt+WosKFM9rB9tOO00U4IDP0giK8Axo24jmRY3a9Yig8vYzO0x4mW1S+3tetd
	 kfY4Zeed0aHzts5V2abUkUGOs0r7o3lI8QYbx3lHDrA2/POT8tQ7IJ/0BdUYH0TNLzT/4
	 ru1S7b9urYGnKjnLsVrFcICvEbp2AMyrmHaqVVIzVcvKF0PqvQgWGzFGZBj8GRnbapw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120559;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lz4BcpRRjlIy52XX1xait5NxJ+nHBcl/ZG0w9aFAbtA=;
	b=ocUY50bt2WNfuU6fiPnKl75YJE92p+vP6QqXdAvLmuyNeheJ+kLBxmllJRkEKn3WtjK6
	 4LlM8JzPLDZJVh0vlMFsrpz7fSR2CnRKn9YZsqu9B6zjtbeeq+8QFFrU691xtc2BMO4XK
	 OuWOIOaQcv4s1QAzyk7PwojPo1bCns/nhUWA7irIEk7n9XsnDx0z1JTPX40pVLyC/PiO2
	 44sstKpZATWPOqPyJkpo0ThhnpiKqXbRTqppn413v1e+v95/m9y7v7dhvqFrcjr5BgjLx
	 6k+8o73cthbWRdRGd665bYm80Lu4AmVA3ZAfHLXVgx4yEcd8nrQAaiPxebbRuhXsndg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PGQzzcz9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB614606A31D;
	Tue, 27 Oct 2026 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PGQzzcz9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF001F01825;
	Tue, 27 Oct 2026 17:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793120558;
	bh=lz4BcpRRjlIy52XX1xait5NxJ+nHBcl/ZG0w9aFAbtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PGQzzcz92VDG+hGERDEbtM42qWOa9VrK7DIf7K9SCeXW97YY4peyXBI4up7EhqbXV
	 KlgVEcArAOm4kGLsInP9NvklxuAfceyRq5oQ1nBRDes94GCP3QSHQKr+CjJzGcMSHW
	 SVItdcq1fM/b2Ra8/GmVrZCZjv7GX4YCDO+jQEhPoSokm5mDTkB7E9ltcngSia2SJC
	 p08W7pDUUh7QmG+fpmj4HS8x6+eRK9bZflBASVCHTzd+vBLC4YlOF5zbsqw4EaOcZU
	 n5oybu2SHoVCoiFiyZkCC8EZNGimLCVLxu5dTyqE6NH0erZiY7jMd7IM1bFkAWdYqq
	 oTOelA4zT3wtg==
Date: Tue, 27 Oct 2026 17:02:30 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	Andrey Vagin <avagin@gmail.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/3] selftests/mseal_system_mappings: Test vdso unmap and
 remap
Message-ID: <auDY6bpeuPZ-jc-_@gremlin>
References: <cover.1793094611.git.chris@chrisdown.name>
 <621847973ba2ec49d0a58e0261da35a9f3a97eda.1793094611.git.chris@chrisdown.name>
 <auC7_5XYr31fimvL@gremlin>
 <auDUAN9xAQRQhnCo@chrisdown.name>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auDUAN9xAQRQhnCo@chrisdown.name>

On Wed, Oct 28, 2026 at 12:40:32AM +0800, Chris Down wrote:
> Lorenzo Stoakes (ARM) writes:
> > Sorry, in mm we require commit messages. Even for tests :)
>
> Sure thing, I'll add one.
>
> > On Tue, Oct 27, 2026 at 07:43:25PM +0800, Chris Down wrote:
> > > Signed-off-by: Chris Down <chris@chrisdown.name>
> > > ---
> > >  .../mseal_system_mappings/sysmap_is_sealed.c  | 92 +++++++++++++++++++
> > >  1 file changed, 92 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> > > index ea75ad537620..83b4fadfbfe7 100644
> > > --- a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> > > +++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> >
> > Why on earth does 'mseal_system_mappings' have its own directory...??
> >
> > Ugh I don't know how I let this stuff go on the original series :/
> >
> > Please, for the love of all that's sacred, move these tests over to
> > tools/selftests/mm/. This is an mm feature, for our sins...
> >
> > You can do the move as a prerequisite patch in the series.
>
> Will do, I'll make the move the first patch.
>
> > (And, again, I really do insist on your change doing some cleanup here as
> > well rather than extending this stuff.)
>
> Yep, see my reply to 1/3.
>
> > > @@ -10,6 +10,7 @@
> > >  #include <unistd.h>
> > >  #include <string.h>
> > >  #include <stdbool.h>
> > > +#include <sys/mman.h>
> > >  #include <sys/utsname.h>
> > >  #include <zlib.h>
> > >
> > > @@ -232,4 +233,95 @@ TEST_F(basic, check_sealed)
> > >  	EXPECT_EQ(expected, sealed);
> > >  };
> > >
> > > +static bool find_vdso(unsigned long *start, unsigned long *end)
> > > +{
> > > +	char line[MAX_LINE_LEN];
> > > +	bool found = false;
> > > +	FILE *maps;
> > > +
> > > +	maps = fopen("/proc/self/maps", "r");
> > > +	if (!maps)
> > > +		return false;
> > > +
> > > +	while (fgets(line, sizeof(line), maps)) {
> > > +		if (strstr(line, "[vdso]") &&
> > > +		    sscanf(line, "%lx-%lx", start, end) == 2) {
> > > +			found = true;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	fclose(maps);
> > > +	return found;
> > > +}
> >
> > There's shared code for this kind of thing, please don't duplicate a
> > /proc/self/maps thing if unnecessary. Also there's a nicer ioctl interface for
> > all this.
> >
> > See vm_utils.[ch].
>
> Oh thank you! I will use that.
>
> > I mean arguably this is an mremap test that belongs with mremap? I guess
> > debatable...
>
> Hmm, I'd lean towards keeping it with the sysmap test, since it's really
> testing that the seal is enforced on these mappings rather than anything
> about mremap() itself, but I don't feel strongly if you insist, just let me
> know.

Actually let's keep them together :) It's always a bit blurry...

>
> > This all just seems like work that should have been done in the past when this
> > feature was proposed, and doesn't depend on your changes at all AFAICT? Maybe I
> > missed it though.
> >
> > Valuable in itself, but probably worth sending separately as a result? Otherwise
> > it's a little disconnected from the actual change you're making.
>
> Yeah, it doesn't depend on it. I can send it separately on top of the move
> if you like, I just don't like touching things without tests where possible.

Well that's a good instinct for sure :)

I mean alternatively you could send as patch 1 and explicitly say you're
providing a tested foundation for the other changes.

>
> Thanks for the review!

No worries!

--
Cheers, Lorenzo
