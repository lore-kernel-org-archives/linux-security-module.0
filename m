Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CF722AE76;
	Tue,  8 Apr 2025 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744144650; cv=none; b=LgDBz/tv6Ey0P9Wau+JUQqrJdKNRVvk4OiufwW/fsjBfM246rko8UrHQlkUY+5KsaGkHIrWz6wJTZrFy/GRov2lGE/+yDYlp0+lq7JKOiXSEVuwmuh/mVw+i3X0m7o0ERJtzFojkVqeW+KPFnMPIz//nDajyKz0mlFBShDTH+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744144650; c=relaxed/simple;
	bh=Jgwkt5NOumKoCt3v7LCMsS2bOUorP3HUBUfty04iFRE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QMGxtI9Xg1T/3mECMauFn2DyadiaJ5WFPsNGyBaSs9sR+YFbBFOy8FHbxqfgjsr0rIGc3J29fKW4NgqBz5Xyz+pkGCDMtU3XNxUWEYXwB2HyAWAhEEnT+nlZrTyyHqos7WfZtyBRXxsH3bDwXPTYiWZ4X6v3J0oasxJEPGwWK0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6R423Vf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6R423Vf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5F6C4CEE5;
	Tue,  8 Apr 2025 20:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744144649;
	bh=Jgwkt5NOumKoCt3v7LCMsS2bOUorP3HUBUfty04iFRE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=U6R423Vf5m5vIXPLlj+iJWAw9EG9Wh/YA+nBLb+ZVkFHwaA8clBjr2KZRXobuOAP7
	 d/vEA7OqfEU36jdvUZBR7GQYmFtGK75P5hNs7nNglFf9NkbJnLBESCV6ap79AW6m83
	 4872B+/AZss3mqrnJBkfpJKzrrol6XN3MVUS7CinRhOlFkLXK1VAtjVAnupSBvI3SE
	 3XabzuYAiCD3JKJowNi8dzuocakioTOX1u90OspM4wAy6CMt+KhXqg0nsn+J7EU5hA
	 qgDAXWoLPPtZmRzskPtI3o55G1atYXe4dxuiMPCKf2JVTLFdCNd08iFC8djvJCIc6f
	 YyQjI9fI/D2Ew==
Date: Tue, 08 Apr 2025 13:37:25 -0700
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
CC: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 =?ISO-8859-1?Q?G=FCnther_Noack?= <gnoack@google.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
User-Agent: K-9 Mail for Android
In-Reply-To: <08393aa3-05a3-4e3f-8004-f374a3ec4b7e@app.fastmail.com>
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org> <CAHk-=wjTbWiYwfj2wF9iP8SSVk2A_cZFDr5hu1bgU_PfxhyiiA@mail.gmail.com> <8cbe0cac-2952-47b6-9b0d-1400aec0bf25@sirena.org.uk> <08393aa3-05a3-4e3f-8004-f374a3ec4b7e@app.fastmail.com>
Message-ID: <482D3DA9-7336-4D36-8758-4F8DB48EA8B9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 8, 2025 2:22:52 AM PDT, Arnd Bergmann <arnd@arndb=2Ede> wrote:
>On Tue, Apr 8, 2025, at 00:02, Mark Brown wrote:
>> On Mon, Apr 07, 2025 at 02:33:40PM -0700, Linus Torvalds wrote:
>>> On Mon, 7 Apr 2025 at 14:10, Mark Brown <broonie@kernel=2Eorg> wrote:
>>
>>> > Arnd bisected this to c56f649646ec ("landlock: Log mount-related
>>> > denials") but that commit is fairly obviously not really at fault he=
re,
>>> > most likely this is an issue in the plugin=2E  Given how disruptive =
having
>>> > key configs like this failing let's disable the plugins for compile =
test
>>> > builds until a fix is found=2E
>>
>>> I'm not against this, but I do want to bring up the "are the plugins
>>> worth having at all" discussion again=2E
>>
>>> They've been a pain before=2E Afaik, the actual useful cases are now
>>> done by actual real compiler support (and by clang, at that)=2E
>>
>>> Who actually *uses* the gcc plugins? They just worry me in general,
>>> and this is not the first time they have caused ICE problems=2E
>>
>> There was a bit of discussion of that on IRC which didn't summon up hug=
e
>> enthusiasm for them=2E  Arnd noted that:
>>
>>     https://github=2Ecom/nyrahul/linux-kernel-configs
>>
>> indicates that Talos 1=2E9=2E1 uses latent_entropy (but we didn't check=
 how
>> accurate that survey is)=2E

The early RNG for small machines remains pretty bad, so I can understand w=
anting to keep that around=2E For bigger machines it's not as much of a ben=
efit=2E

>Talos also uses stackleak=2E I also see that alpine and qubes have the
>same two gcc plugins enabled=2E

Yeah, stackleak has no viable alternative=2E It's effectively init_on_free=
 for stack=2E It's be nice if there were a way to do this with upstream com=
pilers (track call depth)=2E

>On the other hand none of the other 60 distros on that list use any
>plugins, and most of those kernels appear to be built with a compiler
>that doesn't support plugins=2E A few notable ones (Arch, Fedora
>CoreOS 35, RHEL 9) in the list have CONFIG_GCC_PLUGINS=3Dy but then
>don't enable any of them=2E
>
>>  He also noted that GCC_PLUGIN_SANCOV is
>> obsolete as of GCC 6 (!) and both CC_HAVE_STACKPROTECTOR_TLS and
>> GCC_PLUGIN_STRUCTLEAK_BYREF_ALL as of GCC 12, Ard indicated he wasn't
>> worried about loosing CC_HAVE_STACKPROTECTOR_TLS=2E
>
>I've drafted patches to remove these three now: even if we're
>only moving from gcc-5 to gcc-8 as the minimum supported version,
>I don't think there is much intersection between users of those
>plugins and those that are stuck on gcc-11 or earlier=2E

I have no problem removing sanconv (no longer needed), structleak (zero-in=
it is more complete), and stackprot-tls (assuming it really is supported af=
ter GCC 12?)

-Kees

--=20
Kees Cook
