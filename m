Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E21537A7;
	Sat,  8 Mar 2025 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741454604; cv=none; b=ebhzhtWITTziDGbG/D1fWKqwHlpqq6Et8U6v4vvZ3TMgbwS/XcClRXzzjfoZGO7Ejia5qAmANfcfd3k6FMa0AgJl7kri/5x8JPz20S3yNHzTTdPXGISvT0j9zDuz1Jyvt00MO0LjCF84N5WLpftl0jT7Hm/TIaxL5tLEN45Hdeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741454604; c=relaxed/simple;
	bh=DlQgq+nTfYXehSgy8StfVyl+ry6xsjxTIGAX43yqTC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHIBkEwdzWEar77gr2A0X2Rku3oAfrUePYJQmAYWrXsubhpIpWESdQP0VBwoW2/yFQ6oN/ZVhWTAg+pYhly2SdHHpOrRnKpS+aawMicnGpqKr2WdTAix3M9q4U5pLmM9dXVXM294AolmPfTeR51JA0vkrRHUKD8s8d0OBBtuOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiJIW/mJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiJIW/mJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88377C4CEE0;
	Sat,  8 Mar 2025 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741454603;
	bh=DlQgq+nTfYXehSgy8StfVyl+ry6xsjxTIGAX43yqTC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aiJIW/mJwLF5MpzsSmVgsP0Wj3Q7Qiika82FBziDrgURGrJDS8+yCf87I/dLVmFU2
	 IkR8MpN3500LXKWSbtLPb62jPGkPnsf+9wHGyXtLpzv6e9lYuetUDISBxBsPkvHnKW
	 4TFPQgSrld+8Gr8Rkva6Mwa6PfyVhsMNtevm0c+cRta0X40tuFBn7UdgHZJ8mEAced
	 j8MtkwNiYKlHDwGpKeUPLlUa6Qa6n3myI5eUalzF82s33LKzowhfMRIokG05qMKaxJ
	 ud9PxlVLZXGYtMJLiwsLlqk4jT6DqGmS9y+Wzz7eWoXC8RpT0DRNJsjN9i86jOmgp/
	 dZo+gmdi7SncA==
Date: Sat, 8 Mar 2025 09:23:20 -0800
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 1/2] x86/build: Remove -ffreestanding on i386 with GCC
Message-ID: <202503080922.AB2CF7C9@keescook>
References: <20250308041950.it.402-kees@kernel.org>
 <20250308042929.1753543-1-kees@kernel.org>
 <20250308091746.GA707537@ax162>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308091746.GA707537@ax162>

On Sat, Mar 08, 2025 at 10:17:46AM +0100, Nathan Chancellor wrote:
> On Fri, Mar 07, 2025 at 08:29:25PM -0800, Kees Cook wrote:
> > The use of -ffreestanding is a leftover that is only needed for certain
> > versions of Clang. Adjust this to be Clang-only. A later patch will make
> > this a versioned check.
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> This could also adjust the comment but it is probably not that big of a
> deal since the "temporary" is already pretty stale.

Ah yeah, good call. I'll fix that up locally.

> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thanks!

-Kees

-- 
Kees Cook
