Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62433136E1D;
	Thu, 13 Jun 2024 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309414; cv=none; b=S9We/C6ePQwR/IhGnL5jlIh8I/3MYwE7px9K7muH+xuOuGHQPSpV7q9JTR1eMQf46TIW9wa0kiTd7xLWzMnm+IaUupunbd3ID0qfjfM71pJHhA6/V1LG1rCIfyGmTqlJWZAUywqUxYRNqucj4BNfDNK2ToxR+PI7OhNfE/4lDbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309414; c=relaxed/simple;
	bh=IjmHMXcphwekH/gLOJkQYvaNS+ZdtxIQCAgnq4I7qjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/ElfHe7xdpVECcZuxP3hHfM6WDggO8bIucTLBRlTKN2TCe/vcCHn5V7V2xd7tuisjliNsVGKwfdWUe747pVcCg0CzkPt96BEvUBK3lTDSMatzW2q+e2jdCx1ph0jfGrYhUtK9O7yOVgLChgkSQlzedAEDIEPcFJfzKi/h2GiiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794DDC2BBFC;
	Thu, 13 Jun 2024 20:10:13 +0000 (UTC)
Date: Thu, 13 Jun 2024 16:10:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] linux++: delete some forward declarations
Message-ID: <20240613161012.1dd2ff60@rorschach.local.home>
In-Reply-To: <20240613130420.a62ed8965a73b0f8d35890d4@linux-foundation.org>
References: <5ad5556c-7c32-45b7-89cf-f723c9d7332b@p183>
	<20240613153402.3b067d4b@rorschach.local.home>
	<20240613130420.a62ed8965a73b0f8d35890d4@linux-foundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jun 2024 13:04:20 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 13 Jun 2024 15:34:02 -0400 Steven Rostedt <rostedt@goodmis.org> w=
rote:
>=20
> > On Thu, 13 Jun 2024 22:22:18 +0300
> > Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >  =20
> > > g++ doesn't like forward enum declarations:
> > >=20
> > > 	error: use of enum =E2=80=98E=E2=80=99 without previous declaration
> > > 	   64 | enum E; =20
> >=20
> > But we don't care about g++. Do we? =20
>=20
> It appears that g++ is a useful enum declaration detector.
>=20
> I'm curious to know how even the above warning was generated.  Does g++
> work at all on Linux?
>=20
> > I would make that a separate patch. =20
>=20
> What are you referring to here?

The enum change should be separate from the struct changes.

>=20
> > >=20
> > > Delete those which aren't used.
> > >=20
> > > Delete some unused/unnecessary forward struct declarations for a chan=
ge. =20
> >=20
> > This is a clean up, but should have a better change log. Just something
> > simple like:
> >=20
> >   Delete unnecessary forward struct declarations. =20
>=20
> Alexey specializes in cute changelogs.

eh

>=20
> I do have a concern about the patch: has it been tested with all
> possible Kconfigs?  No.  There may be some configs in which the forward
> declaration is required.
>=20
> And...  I'm a bit surprised that forward declarations are allowed in C.
> A billion years ago I used a C compiler which would use 16 bits for
> an enum if the enumted values would fit in 16 bits.  And it would use 32
> bits otherwise.  So the enumerated values were *required* for the
> compiler to be able to figure out the sizeof.  But it was a billion
> years ago.

Well, I only looked at the one change in ftrace.h which has a
"struct seq_file;" that is not used anywhere else in the file, so that
one definitely can go.

-- Steve
