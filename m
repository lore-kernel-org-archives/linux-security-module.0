Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A022D97B7
	for <linux-security-module@vger.kernel.org>; Sun, 11 Oct 2026 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791735373; cv=none; b=X+r8J5JjkG2NUYLkbIgUxGUSaZ+VUEhpIIN6fMvwevZ4Ej28zqCF42jgoGGOyvY14l7Vnq5xWYNwjKm2WQpG4JQBm+S4ML1+4r1GD4MxIzmI1XJ5HdIXf72REizE9ymPnYcB2nszXlG/ZmArcmUcfHav7n0wKdz0sF0xgjRIKQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791735373; c=relaxed/simple;
	bh=0gcbbUhFnkEOAHXcoqrL/nxc87AsWq7hndb/HXSBGPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N59/a2RQ0L7zSXtSalldsR8Sm7WAWG1fOdijgWL0ZcHNIokyaXXfjfZcWKhuvNAhVm6OeVRS4gfm3zJoZx1NE4BBt3Bem8FbR2AZ/VhgX7+xybda5iNhQbbQl3PeSDFmOnPwOWFUziK5Mpjap2ExvI0ykihBV0Vgqa+PdlpMACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xW03SEOM; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xW03SEOM"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j2m1H09kYzMFZ;
	Sun, 11 Oct 2026 18:16:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1791735362;
	bh=LRzweF9m776pC+vECb9bPh0m7QvxZb45aRGomPy602k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xW03SEOMSs7p1YonRCDbrzmipShynfQkQIaP5xc54t5EhvVTF+PSaIAsuAbowWyVn
	 A+BUXH4GV9omNAKetEiPD8mvJ2SXDR/5pzB/+u7iaehWJWPXKYfG7vOxiOdYr1ib+X
	 xSoNggRFlXnMm+0IsfojlvPPfKnfFNXsUmZTY+zc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4j2m1F4Z6QzdsZ;
	Sun, 11 Oct 2026 18:16:01 +0200 (CEST)
Date: Sun, 11 Oct 2026 18:16:00 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
	Bill Wendling <morbo@google.com>, Tingmao Wang <m@maowtm.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] landlock: Move the domain layer counter out of the
 anonymous union
Message-ID: <20261011.Veiquevah3oh@digikod.net>
References: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
 <CAKwvOd=nPgEm=AZbEu12Eb90GtRUThY6YAjSiHHuNVHP8TZHwg@mail.gmail.com>
 <66usntltyie7ii2rrqajy3izxrvwubwf2vqnery552v3akhwo2@xwb4t76d37wx>
 <CAKwvOd=E7wgGPf+kgOY8sGi0xO-cFMAJK4PMBFknoEupJi1CXw@mail.gmail.com>
 <20261009204554.GA778522@ax162>
 <EF8E7F67-39BF-4382-AB18-98E9D6111CA5@kernel.org>
 <CAJJ9bXzLgzZG+836_2+pUVOWzndSFNoOh8Xu8Pw++_i1RMJzOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJJ9bXzLgzZG+836_2+pUVOWzndSFNoOh8Xu8Pw++_i1RMJzOg@mail.gmail.com>
X-Infomaniak-Routing: alpha

Thanks everyone!  We also received another minimal patch that I rebased
and applied.  See the final commit:
https://git.kernel.org/mic/c/3d8cc52db2f86b624308321c58513019f6b21eec

 Mickaël

On Fri, Oct 09, 2026 at 08:02:02PM -0400, Michael Bommarito wrote:
> On Fri, Oct 9, 2026 at 7:52 PM Kees Cook <kees@kernel.org> wrote:
> > I'm still catching up from travel, so apologies if this already got checked, but has this been verified against GCC as well? Is it only a Clang problem?
> >
> > Regardless, if counted_by is not working for a given compiler version we'll need to exclude its use by version. :(
> 
> It is only clang, not gcc.  See my comparison between gcc 15 and clang
> 21.1.8 output in [1].  I didn't test clang
>  20 or 23 like Abel did, but it seems like we can't gate on any
> available clang version.
> 
> [1] https://github.com/llvm/llvm-project/pull/228309#issuecomment-6080475086
> 
> Thanks,
> Mike
> 
