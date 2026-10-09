Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC49B497B88;
	Fri,  9 Oct 2026 23:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791589949; cv=none; b=Sf6FtRW9fikSFKGwLlDmkz2r6Qpft7tEDxkovfOT9hl6H9q/5u6kg8li+RN1zaaMradVTLQWzhrxVHD1UgI6x5mdHiLoglPh7qCZ26cW1inEkCcQNhgh7pDGk6VnBXoSARkIxl+qPc4D7Z9ZmJo+Tre/ULLqKm6c9OXk7L5RbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791589949; c=relaxed/simple;
	bh=0rX668ssqaTJGdN6tZAXjyniXgmiQ0A+ZljUjfEVTH8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dD3nOkXPZfpD179S471hB6DJ4YvRe8K+tdzkpcn6rlmpiVce5IUrj0cjbmzS9So74u8qc+K1EcHyC0PIbW7Y+ta5wNVESIB3wAPRwWNqFgFC6Yf3yT0QSywq4y5/+ZwnRUVBShLRtCFTSQJUxVSctEltXgONJLuz6kz5vpPByNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WU0Cfv6e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WU0Cfv6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E0E1F000FF;
	Fri,  9 Oct 2026 23:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791589948;
	bh=QOyR2wzQX5F16zI7w1wBHqwvXHPsPL0DrGCxPm2PHy0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=WU0Cfv6eCvB/nsvhThv5tFbOcqtGP3njYstGZmpbkgKxmXUHgPdzzz/xuIXA2YfaO
	 xSSFurMVf0VmzUsQ44deyY+sOlSBCKmY+/yYMJLqUm/m1e47Q5W/XP+dQU8T9JPMP/
	 32R04NLM15ge2xxQXsEibb1umC0xHwZgz2x6jTn2YfWQwjI3VGjoj3vDd8Erp4U6rG
	 I2DYvCUvwXypHlC+G3XVmNS9MQ/o2wE/2K6HRyp7zK3Vw4lT93opD02P4OYzQC5cO7
	 39RL1uxmc61zQUZA3IBCg+v1iFzEiAJ2SUHPqWM15n4MrZljcCC/97yUPuA05AEPmY
	 Xcvnof81HlTfg==
Date: Fri, 09 Oct 2026 16:52:24 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>
CC: Abel Vesa <abel.vesa@oss.qualcomm.com>, Bill Wendling <morbo@google.com>,
 Tingmao Wang <m@maowtm.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Justin Stitt <justinstitt@google.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 michael.bommarito@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_landlock=3A_Move_the_domain_l?=
 =?US-ASCII?Q?ayer_counter_out_of_the_anonymous_union?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20261009204554.GA778522@ax162>
References: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com> <CAKwvOd=nPgEm=AZbEu12Eb90GtRUThY6YAjSiHHuNVHP8TZHwg@mail.gmail.com> <66usntltyie7ii2rrqajy3izxrvwubwf2vqnery552v3akhwo2@xwb4t76d37wx> <CAKwvOd=E7wgGPf+kgOY8sGi0xO-cFMAJK4PMBFknoEupJi1CXw@mail.gmail.com> <20261009204554.GA778522@ax162>
Message-ID: <EF8E7F67-39BF-4382-AB18-98E9D6111CA5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 9, 2026 1:45:54 PM PDT, Nathan Chancellor <nathan@kernel=2Eorg>=
 wrote:
>On Fri, Oct 09, 2026 at 10:23:14AM -0700, Nick Desaulniers wrote:
>> On Thu, Oct 8, 2026 at 4:49=E2=80=AFAM Abel Vesa <abel=2Evesa@oss=2Equa=
lcomm=2Ecom> wrote:
>> >
>> > On 26-10-07 14:49:28, Nick Desaulniers wrote:
>> > > Would you consider this a bug in clang, or an error in how the
>> > > __counted_by attribute is applied?
>> > >
>> > It turns out Amaan Qureshi has already reported exactly this Landlock
>> > issue and proposed an LLVM fix:
>> >
>> >   https://github=2Ecom/llvm/llvm-project/pull/228309
>>=20
>> In that case, I would _not_ work around the compiler bug like this and
>> instead wait for that fix to land in clang, then bump the required
>> version of clang for counted-by=2E
>>=20
>> Kees and Nathan are traveling for LPC, so I don't expect quick
>> feedback from them, but they should confirm whether they agree with my
>> proposal=2E
>
>Bill/Kees/Justin should review that patch upstream but bumping the
>required version for __counted_by to clang-24 (or maybe 23=2E1=2Ex if it =
can
>land in release/23=2Ex) kind of sucks :/ but if this is a big enough
>footgun that we don't want to continuously workaround, I guess we have
>no choice=2E

I'm still catching up from travel, so apologies if this already got checke=
d, but has this been verified against GCC as well? Is it only a Clang probl=
em?

Regardless, if counted_by is not working for a given compiler version we'l=
l need to exclude its use by version=2E :(

-Kees


--=20
Kees Cook
