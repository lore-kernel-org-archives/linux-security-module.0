Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F720E330;
	Fri, 30 May 2025 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748632153; cv=none; b=Bcun8bsyVA9arzpOv6l5ZU7i1lsx6WFJhWpLLiqmIsiWfkKDnxmH3c8k/JobB537294tB4vcACXvniM0EOitDUysVnwmlJeVZ7nYSd+uKOb2Xhv2/u1fnbPjhB/JLgUVQu3Z4714QH2YL5DkX2OseJrhmfrY80l5dJDkjLCwAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748632153; c=relaxed/simple;
	bh=qY31LCaiezMBi3IDX14BQxlF0vXCVmIFLsnpZNcAFUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tliVZzPS3X5aWWw594fmuONdakYpHMWqzLGXiT1qwoF2AUJXUtPQ1uBpWSR/+pzzhWZaRU6Zh4kSRYcJhJ4RiOItGaWI7Ony8qAcslvsc0KeKW/saAaAETYcAS1OGPwYcerinP1cfkUgzFSX+4Rooxu9dKa7A9q8HSv2NlBEMnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6psXGim; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6psXGim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58297C4CEE9;
	Fri, 30 May 2025 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748632152;
	bh=qY31LCaiezMBi3IDX14BQxlF0vXCVmIFLsnpZNcAFUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6psXGimYJySKWb+ryg947XO2qWUQMqN+Dw0OWn43efhp+7DnVUr1fryj0egd0Dnz
	 lc1hCCSvwgiVdVn/wOT9f0a5wVpzmYwbQHKr5QENtKvwBxINw6dsFdOKDZIkGoGBZd
	 IbR9kfuuudpeA9K5WTPVd2VLe9nGf62rx9jtgppFQHbX3++FPLb00B1ofTFxYo207M
	 NzYaQCh0N7K6mFZuyCXXZJT/TaGgV664Z0FjiMo/s/j72TXF7MNgLtP8PKMH6XTQh1
	 IuaTMPdVugCbClS9diLYbfPZtpahtyApyjTIT/UI//aqqA/hgwD5oMqRS5hdRQReUV
	 ylOwgrCLxpLGg==
Date: Fri, 30 May 2025 12:09:04 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	akpm@linux-foundation.org, arnd@arndb.de, broonie@kernel.org,
	davidgow@google.com, diego.daniel.professional@gmail.com,
	gnoack@google.com, gustavoars@kernel.org, jmorris@namei.org,
	justinstitt@google.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux@treblig.org, llvm@lists.linux.dev, mcgrof@kernel.org,
	mic@digikod.net, morbo@google.com, nick.desaulniers+lkml@gmail.com,
	paul@paul-moore.com, pmladek@suse.com, rmoar@google.com,
	serge@hallyn.com, tamird@gmail.com, wangyuli@uniontech.com
Subject: Re: [PATCH 3/3] Revert "hardening: Disable GCC randstruct for
 COMPILE_TEST"
Message-ID: <20250530190904.GA1159814@ax162>
References: <20250427013836.877214-3-kees@kernel.org>
 <20250530000646.104457-1-thiago.bauermann@linaro.org>
 <202505292153.14B0A688F8@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505292153.14B0A688F8@keescook>

On Thu, May 29, 2025 at 10:12:22PM -0700, Kees Cook wrote:
> On Thu, May 29, 2025 at 09:06:46PM -0300, Thiago Jung Bauermann wrote:
> > This commit was reported by our CI as breaking the allmodconfig build for
> > the arm and arm64 architectures when using GCC 15. This is due to
> > https://github.com/KSPP/linux/issues/367 :
> > 
> > 00:05:08 arch/arm64/kernel/kexec_image.c:132:14: internal compiler error: in comptypes_check_enum_int, at c/c-typeck.cc:1519
> > 00:05:08   132 | const struct kexec_file_ops kexec_image_ops = {
> > 00:05:08       |              ^~~~~~~~~~~~~~
> 
> I'm not able to reproduce this. Which specific version of GCC 15 and
> on what distro are you seeing this?

It looks like this was also reported to Debian (I originally noticed it
in the #gcc channel on OFTC a couple of weeks ago but forgot to mention
it):

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1104745

It looks like the difference might be whether GCC was built with
additional checks or not based on the last couple of comments in that
bug.

Cheers,
Nathan
