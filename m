Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBEC18BC36;
	Fri,  7 Mar 2025 22:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388227; cv=none; b=Fs4OBa35ZuuI7IR0YZ89l+zieTiSY0RnKQHqnCrp3YrScZdkFYNEc5idusg0pXkZL3tfuUcZnxOmhwgMkBtzBIeiUq4kaFqOI7TXLyAy8WJJKyQTJcazdCsGe893HHanIcggdvHVx9t1fVyU3AFlgiFGjF06yNSdQtL6nYyLZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388227; c=relaxed/simple;
	bh=faabc9m9uPxQtgKRC+DivTBLvntW27eLE3A5nEZFZHI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dXAoe04WusNqJADLVpECj2SZBdOxcry2w87BVMFEVe2vQkwBxLVR3EpTeiRW/m/sYcPFkKh07U+ojx/GUgN6eP6ejMZHaOjsNNkm5VoBjQeD2zbGKUWldEGfljjT27wTyfLEVnzXb1zmD6+etyWQmC04q2je6+3m3pfv/Br8dEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4fGlQvE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4fGlQvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD40C4CED1;
	Fri,  7 Mar 2025 22:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741388227;
	bh=faabc9m9uPxQtgKRC+DivTBLvntW27eLE3A5nEZFZHI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=k4fGlQvEDCyy06S9nfFcXx+TiunjbbSWtAj2yb0cFfzy6wqXqg7YXDWVad/ydKZve
	 FJZSZOUSxFte1lWBmLGPP4piTjbunRlor6EKR05MUMWrqZZIVDRyPXYL028v23/Ily
	 oiRVzkIb1b0MJcq8DWavMfNiFx4biuWMhIvk7ehbV16aJs3vOlnsky5LmBll59nKER
	 /OMw5w+NwExtmVCmqnlFTaHgt+4iebaSlHtpoHjGXmM9/EaX+VckmPsP98RPAlGS+P
	 0ciTeNfVxQcElqTl9W7vfGNzoSIRNEChnyibrPXZHdxXuDjaww755H+N2so1bFkFhX
	 +jYySf1FjEhmQ==
Date: Fri, 07 Mar 2025 14:57:06 -0800
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
CC: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] hardening: Enable i386 FORTIFY_SOURCE on Clang 16+
User-Agent: K-9 Mail for Android
In-Reply-To: <20250307214734.GA2871848@ax162>
References: <20250303214929.work.499-kees@kernel.org> <174111064321.3934933.4843198067758331073.b4-ty@kernel.org> <20250307214734.GA2871848@ax162>
Message-ID: <F8636F62-BF8F-4485-826B-83951ACB53A3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 7, 2025 1:47:34 PM PST, Nathan Chancellor <nathan@kernel=2Eorg> w=
rote:
>On Tue, Mar 04, 2025 at 09:50:44AM -0800, Kees Cook wrote:
>> On Mon, 03 Mar 2025 13:49:37 -0800, Kees Cook wrote:
>> > The i386 regparm bug exposed with FORTIFY_SOURCE with Clang was fixed
>> > in Clang 16[1]=2E
>> >=20
>> >=20
>>=20
>> Applied to for-next/hardening, thanks!
>>=20
>> [1/1] hardening: Enable i386 FORTIFY_SOURCE on Clang 16+
>>       https://git=2Ekernel=2Eorg/kees/c/3e5820429980
>
>Turns out this is actually incomplete based on my testing, I see the
>following warnings with ARCH=3Di386 allmodconfig with all supported clang
>versions:
>
>  warning: unsafe strcpy() usage lacked '__write_overflow' symbol in lib/=
test_fortify/write_overflow-strcpy-lit=2Ec
>  warning: unsafe strcpy() usage lacked '__write_overflow' symbol in lib/=
test_fortify/write_overflow-strcpy=2Ec
>
>We also need to drop '-ffreestanding' from arch/x86/Makefile (which Nick
>has mentioned in [1])=2E Time to revive [2]? :) or just do it in this
>patch, since it sounds like there was no regression with GCC?
>
>[1]: https://github=2Ecom/ClangBuiltLinux/linux/issues/1583#issuecomment-=
1123016466
>[2]: https://lore=2Ekernel=2Eorg/20200817220212=2E338670-5-ndesaulniers@g=
oogle=2Ecom/

Oh good catch! Probably I need to do this in two patches just to be safe:
- make -ffreestanding be Clang only
- switch to version checks for FORTIFY and freestanding

That will split the changes for GCC and Clang into separate patches=2E Or =
maybe that's overkill?

-Kees

--=20
Kees Cook
