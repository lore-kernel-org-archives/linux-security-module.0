Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9B241CA3;
	Tue,  8 Apr 2025 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744155149; cv=none; b=nkL7TBtNlkUjOeoOIm8iXweYKW7ObXuBxU7AG2yxWQJz5QKni1NIpLhZ06a9eLEAd6XZvubKJ0Na+sHk4Bs0lMJbLSLCLyGTR+wxDtFztaYm+3HKKxSFYWN/JjPgwTzUCvk0d+w0jqyEDXXao1ZeTs7YUVCQD2HwlI5f1Czqykc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744155149; c=relaxed/simple;
	bh=Q+AcuJne3fhoPeKc78N+Oumu9qRoE+Wd2GfNYZkijHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZSg5oOn4sa9N5iwVBiX274/kbkTyv+pqIKWvp2JRK9rwOAgu/S6Tmh9KBLQSXZgSRWSjAy75P/ntNVBYklpJw+Ip6H2Hrbp+BoVevF+j00WFIOnc7EdkvxmRtKdIrelRjDsSxY1lt2IIyzxUMhIhzZddSRCbVQTGxj3L3iU5g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKoXifSR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKoXifSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B07EC4CEE5;
	Tue,  8 Apr 2025 23:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744155149;
	bh=Q+AcuJne3fhoPeKc78N+Oumu9qRoE+Wd2GfNYZkijHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKoXifSRxYmM9ZjShK1Gpp6l3RTgqw77F2Tf22/m2hoM0a4/AUXqrLSUetAVjKPk4
	 hKy44VWLbZoq6vX/fPN25Xw7AL+CiCOMfRMlTj8PhWXhEFhP4xD1W69ZMmjNo8XH5d
	 uepYNkKKeuwwZvTKE7jzsG4f+QACbf8RYDwsrtVnr/WNzt8dhN9nj4TzVPsLJDXXYw
	 gXP1hdam+4dmoKxnBA1nX3MAqNe/Z1RoRDRh04Cbfu+elRDvCdYzui4bsdetNYhndK
	 OLlAEPwbKyoNTeMGQBwDAWUA3QCDxHG2biv63GW09N7aMvAkyq44gEaPDUhs2hB/p+
	 KnY0WpO2EnO1A==
Date: Tue, 8 Apr 2025 16:32:24 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
Message-ID: <202504081630.4CE88E855@keescook>
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>

On Mon, Apr 07, 2025 at 09:57:32PM +0100, Mark Brown wrote:
> In current mainline x86_64 allmodconfig builds done with tuxmake GCC 13
> and GCC 14 toolchains (which are Debian ones packaged up into containers)
> generate ICEs in landlock:
> 
> Event                            | Plugins
> PLUGIN_FINISH_TYPE               | randomize_layout_plugin
> PLUGIN_FINISH_DECL               | randomize_layout_plugin
> PLUGIN_ATTRIBUTES                | latent_entropy_plugin randomize_layout_plugin
> PLUGIN_START_UNIT                | latent_entropy_plugin stackleak_plugin
> PLUGIN_ALL_IPA_PASSES_START      | randomize_layout_plugin
> /build/stage/linux/security/landlock/fs.c: In function ‘hook_file_ioctl_common’:
> /build/stage/linux/security/landlock/fs.c:1745:61: internal compiler error: in c
> ount_type_elements, at expr.cc:7075
>  1745 |                         .u.op = &(struct lsm_ioctlop_audit) {
>       |                                                             ^
> 
> Arnd bisected this to c56f649646ec ("landlock: Log mount-related
> denials") but that commit is fairly obviously not really at fault here,
> most likely this is an issue in the plugin.  Given how disruptive having
> key configs like this failing let's disable the plugins for compile test
> builds until a fix is found.

Looks like this is a randstruct bug. We'll need to disable that one for
now (rather than all plugins).

I can reproduce this for GCC 14, but I can't reproduce this with GCC
13. Which minor release is failing for you? My GCC 13 is:
gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0

-Kees

-- 
Kees Cook
