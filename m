Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C2208989;
	Fri,  7 Mar 2025 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389047; cv=none; b=RP3MySUK8QV45g1Uk81Q6bAjTwqNJYbLUK1AmEcA7Dg8+PG3KJ7aBr8/896hLQr9NvaJCXkHzBBrDz+sDCQ5FIbpGTLVW1YCWSO//9kh5EO0XaaV8FyTaLVt8w75y8OAOg4hrc5KYYGnRgLkjPYwHLRyReTAgtwrZJuO9hzOeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389047; c=relaxed/simple;
	bh=YFT39thg2XHkVHDteMaAtDbnY6Oej5FI0CRdhjyQPVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGPMT81hfIa8l5h+6tDKfmy2Y10leAmVg1NPAN4aIbVdBECQsPX4Bzhh1qtoBJLVq3vSTfmEvrPjd6p0CZNZfiLQxGGvOGlZVQIpBrUh0QV255CBi7YSNrdaTYtHGaD3LDrT9cFd6Dr6aQM9OeETgBRUijJDkbYk1aXS6FurQnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8ueOOKy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8ueOOKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA55C4CED1;
	Fri,  7 Mar 2025 23:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741389047;
	bh=YFT39thg2XHkVHDteMaAtDbnY6Oej5FI0CRdhjyQPVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q8ueOOKyrdJ0vvXa199ajzvH+l/vBJr+s/gRVNSKKGynnMhWW8seIXYXQvUX1Zs4b
	 YhPPgdHMzCeQb5YB7EKDFwVpC9tx8qcvgbffT8iSH1XUG5oaD3R+CnzRgXBwe0QrGf
	 dAUDFWezgDTTnOyw388HgSnVGpMKUwObWl8LUqKBQSA8TmkHuNpumQvLOVFzOgYE8/
	 EVGHWKwC0rjr6zxrXIUK+6Uz+/i/SKqtuFF5YNyv7vp2qKzO7kwg6MPYrjXbnQ2qwm
	 kvNH3FeHMAnuCJpzZfZfoqy0GANGnsiB6PPLxL+yqAL/GZm0hIExNWK6lf23/y4jHx
	 7vyBnuCWGnYOQ==
Date: Sat, 8 Mar 2025 00:10:41 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] hardening: Enable i386 FORTIFY_SOURCE on Clang 16+
Message-ID: <20250307231041.GA2911050@ax162>
References: <20250303214929.work.499-kees@kernel.org>
 <174111064321.3934933.4843198067758331073.b4-ty@kernel.org>
 <20250307214734.GA2871848@ax162>
 <F8636F62-BF8F-4485-826B-83951ACB53A3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F8636F62-BF8F-4485-826B-83951ACB53A3@kernel.org>

On Fri, Mar 07, 2025 at 02:57:06PM -0800, Kees Cook wrote:
> 
> 
> On March 7, 2025 1:47:34 PM PST, Nathan Chancellor <nathan@kernel.org> wrote:
> >On Tue, Mar 04, 2025 at 09:50:44AM -0800, Kees Cook wrote:
> >> On Mon, 03 Mar 2025 13:49:37 -0800, Kees Cook wrote:
> >> > The i386 regparm bug exposed with FORTIFY_SOURCE with Clang was fixed
> >> > in Clang 16[1].
> >> > 
> >> > 
> >> 
> >> Applied to for-next/hardening, thanks!
> >> 
> >> [1/1] hardening: Enable i386 FORTIFY_SOURCE on Clang 16+
> >>       https://git.kernel.org/kees/c/3e5820429980
> >
> >Turns out this is actually incomplete based on my testing, I see the
> >following warnings with ARCH=i386 allmodconfig with all supported clang
> >versions:
> >
> >  warning: unsafe strcpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-strcpy-lit.c
> >  warning: unsafe strcpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-strcpy.c
> >
> >We also need to drop '-ffreestanding' from arch/x86/Makefile (which Nick
> >has mentioned in [1]). Time to revive [2]? :) or just do it in this
> >patch, since it sounds like there was no regression with GCC?
> >
> >[1]: https://github.com/ClangBuiltLinux/linux/issues/1583#issuecomment-1123016466
> >[2]: https://lore.kernel.org/20200817220212.338670-5-ndesaulniers@google.com/
> 
> Oh good catch! Probably I need to do this in two patches just to be safe:
> - make -ffreestanding be Clang only
> - switch to version checks for FORTIFY and freestanding
> 
> That will split the changes for GCC and Clang into separate patches. Or maybe that's overkill?

No, I think that is reasonable, as any regressions with GCC would be
noticed by the first change, rather than being mixed in with the second.
It should also make it easier to drop that when the minimum version of
clang gets bumped to 16 (either for the whole kernel or just x86, like
the bump to 15 this dev cycle for the recent stack protector fixes in
-top).

Cheers,
Nathan
