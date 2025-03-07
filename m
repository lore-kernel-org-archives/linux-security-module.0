Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C31A23B0;
	Fri,  7 Mar 2025 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384061; cv=none; b=NInKWJkKU1YXSB1IdzKpOPz2as8jZXDLUHQAda/3/YXbryi8oX9Y7v+qCeBj3dd1DIXZXuN8PNOnkrgXeXlTsN2bAom0STj9FHZTQhbJx7K+a5m7O+NDqIMmLpNATM7rdGD2T2h6p4BH+zXjTIiv4BfDfclnVRHljf2BL+sr4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384061; c=relaxed/simple;
	bh=PgozwpVvDw4x6kQAljVRZ/c6g7ZLJ2jt4q+YmNhYcYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvCmBHRPwDpPoJuWCnK5tXVPYnqKTEGAok5UbRwrqiyNy+NcvPHcl94FKD6iEMZrqvdsVIKdQNK54v+0vp+X4SSe0yWqaDxoa8JwOKChXSEUcBZZzs2kcrZuVI4hJNM6g9mYl/2U8i4hy3Med/xzcxDZg9YYQnxc8BuEyiImavQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABFCTAkC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABFCTAkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74122C4CED1;
	Fri,  7 Mar 2025 21:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741384060;
	bh=PgozwpVvDw4x6kQAljVRZ/c6g7ZLJ2jt4q+YmNhYcYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABFCTAkCYJGDl7FT/DQX1FAtSH/kxO34MMqrkJWriQ/XiHRvGlyrvhNCEYYOw4Kwc
	 pAoDJx/I0fmQQoUdmubibw67HoOrTYK7Yi2iZfKIDNNO4QvQWMaxh6AZAjyfRVpzY6
	 BvsOgKcTl0+ct+tyl5HJ0vtFaz4zEAwvR6mQ3QNEFRgMMCMelE74JDdpj3Srx5S1CA
	 8WFjIu1M8gnuHczMjRVGEgtYuhjb6lN/LLqIbo4RZelseSE+XOVlceePJChzCc5HJM
	 lgZcuHK+EnbrCo9xPTNH7z+vZPernPPsD6qo/2e8bOyR+FjsVZxL5X0z6h57p4o5kP
	 akC34nyieVQDA==
Date: Fri, 7 Mar 2025 22:47:34 +0100
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
Message-ID: <20250307214734.GA2871848@ax162>
References: <20250303214929.work.499-kees@kernel.org>
 <174111064321.3934933.4843198067758331073.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174111064321.3934933.4843198067758331073.b4-ty@kernel.org>

On Tue, Mar 04, 2025 at 09:50:44AM -0800, Kees Cook wrote:
> On Mon, 03 Mar 2025 13:49:37 -0800, Kees Cook wrote:
> > The i386 regparm bug exposed with FORTIFY_SOURCE with Clang was fixed
> > in Clang 16[1].
> > 
> > 
> 
> Applied to for-next/hardening, thanks!
> 
> [1/1] hardening: Enable i386 FORTIFY_SOURCE on Clang 16+
>       https://git.kernel.org/kees/c/3e5820429980

Turns out this is actually incomplete based on my testing, I see the
following warnings with ARCH=i386 allmodconfig with all supported clang
versions:

  warning: unsafe strcpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-strcpy-lit.c
  warning: unsafe strcpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-strcpy.c

We also need to drop '-ffreestanding' from arch/x86/Makefile (which Nick
has mentioned in [1]). Time to revive [2]? :) or just do it in this
patch, since it sounds like there was no regression with GCC?

[1]: https://github.com/ClangBuiltLinux/linux/issues/1583#issuecomment-1123016466
[2]: https://lore.kernel.org/20200817220212.338670-5-ndesaulniers@google.com/

Cheers,
Nathan
