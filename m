Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D752D7D47;
	Fri,  9 Oct 2026 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578760; cv=none; b=N0jbfCf89+wGKPCNT72cztdPQS0vGXiLD6SHQoTIMH8g7vCvF5BVDKXBG9WLcx9BX1wtxL03UckXqT8YwUy6/9NShqmgiUHsLSYsi0uLVNlACMgYSewSUux8PIViTlJzq17m73N+6q97tM/KufzPmZYNt1pxLGlKo9jdgPeSnlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578760; c=relaxed/simple;
	bh=J0laJjpqen+ifpy4EjM6q6SNU8g2F7nubNLvor0f12Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td01/3uhnOLuja6j9NrQYb6/M90/X1GtCiMNui1vzYNKKv7C41RTnyc2vtKoVMkEQzIkxUXWLm96XSVMkY7LgXfAbQ1L975nKY4a78JGvfkpcBkjsvvNb85bY9c9M5ChMMI1G7lfg9z0kxT63nBqJRgEyjJeIYpKkU99BwvtU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnwqMlhO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnwqMlhO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986761F000FF;
	Fri,  9 Oct 2026 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791578759;
	bh=yLnE4quCu/z+s+7eheiMwsbmvExqd3PbO4hxQlwTZ0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AnwqMlhO1+U0iH2nYD0P8E9jgTwc0bThkMVWMhSuQ4dc5nn7kuzVWodZ/vpkPeKhd
	 KGqv2IBOoNHJ89isb3SJqAJkls6+QhLHKnot36/3GeFEHQbFrBTsVlDod9lDUti6tH
	 l2uzH6GuRxH+46QKOY8MLJqbOwSUFbIhKG8flE7S6a40PbK8IW/Wb6n7JxfXkOehAd
	 E3DIDQpRzzRehTT8CbLmTnAmSJkvys+WMrdwviWAya09FPkC71tcwuEHsg1jAX9NbS
	 4mr0CC1XrMiD7bFDH/4F12MUPllQ53VyKdr+9Alkql71maWaZfmV5hBBxzz4/Duerb
	 0nxskP23yb/+A==
Date: Fri, 9 Oct 2026 22:45:54 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Bill Wendling <morbo@google.com>, Kees Cook <kees@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	michael.bommarito@gmail.com
Subject: Re: [PATCH] landlock: Move the domain layer counter out of the
 anonymous union
Message-ID: <20261009204554.GA778522@ax162>
References: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
 <CAKwvOd=nPgEm=AZbEu12Eb90GtRUThY6YAjSiHHuNVHP8TZHwg@mail.gmail.com>
 <66usntltyie7ii2rrqajy3izxrvwubwf2vqnery552v3akhwo2@xwb4t76d37wx>
 <CAKwvOd=E7wgGPf+kgOY8sGi0xO-cFMAJK4PMBFknoEupJi1CXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=E7wgGPf+kgOY8sGi0xO-cFMAJK4PMBFknoEupJi1CXw@mail.gmail.com>

On Fri, Oct 09, 2026 at 10:23:14AM -0700, Nick Desaulniers wrote:
> On Thu, Oct 8, 2026 at 4:49 AM Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
> >
> > On 26-10-07 14:49:28, Nick Desaulniers wrote:
> > > Would you consider this a bug in clang, or an error in how the
> > > __counted_by attribute is applied?
> > >
> > It turns out Amaan Qureshi has already reported exactly this Landlock
> > issue and proposed an LLVM fix:
> >
> >   https://github.com/llvm/llvm-project/pull/228309
> 
> In that case, I would _not_ work around the compiler bug like this and
> instead wait for that fix to land in clang, then bump the required
> version of clang for counted-by.
> 
> Kees and Nathan are traveling for LPC, so I don't expect quick
> feedback from them, but they should confirm whether they agree with my
> proposal.

Bill/Kees/Justin should review that patch upstream but bumping the
required version for __counted_by to clang-24 (or maybe 23.1.x if it can
land in release/23.x) kind of sucks :/ but if this is a big enough
footgun that we don't want to continuously workaround, I guess we have
no choice.

-- 
Cheers,
Nathan
