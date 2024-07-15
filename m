Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102A43158;
	Mon, 15 Jul 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059896; cv=none; b=Q7EkbfjewXzAv6pgifm3w4RYEZuwLq8rb/pd0FV0XLH8NyaX7tAJW09YdCYPoqJn3Aj2nfqD5bmFBhne+WZaHUAxR5o7CzvSX1kbH7e1KVTy57JmJsiuoPUB+KkW5RVBlwsw4zpKuPiNb54xss45kF3H9CXycY9MVCplmTBfmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059896; c=relaxed/simple;
	bh=ZNODHTsIH1tP4zxTnnkfGFtWwx4Cm7pw0WpB7OJ/SS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/zOC5EOUiTJbBr9uVSKpm+ORFlX71Gfc2gZlx/zx8O9A9Yq+MuFN7Nvn7WI5wXdeoGMIirkXE/coCCtXP4U8YpPlwP6sOVlcbNn+1ijkJazEGBds/hBiU29MevLVN7cXdFVT2Xen+KkDVirVJG3AK2cCgdTAHD0R88bsjKWV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKMHV9Ch; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKMHV9Ch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98252C4AF0A;
	Mon, 15 Jul 2024 16:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721059895;
	bh=ZNODHTsIH1tP4zxTnnkfGFtWwx4Cm7pw0WpB7OJ/SS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKMHV9ChaoZwtbci9kK4FxHs8MW3hsObwXCnlCHL6oUrYWbxWMWxIT6zv99L23XDs
	 hZib5BUW2Jf1E0lAPr70zt/p8iJCNTxIYBmJJne90sJpjXgpEEt9jNGm/HxG2/hJut
	 VZrxgOBnNasUJIF5P5J1vg5dov1tbQex4R4TokkrkbT7U/okPM3b32WzZTVaKBK0Do
	 QmA5RcLGqnP/ZO8H1LFNfCaOhq5TKJq3GCMM2Ig8SZD6ffdHFvDClnqmx6sZWbSgH0
	 kAHKlEPxQVRZJAgedW/0N3KX7htIZFbXVFoE1kU9JscQzCKx9IZxbmgsqFXDe9B3Qp
	 MLO84fYULHVdw==
Date: Mon, 15 Jul 2024 09:11:35 -0700
From: Kees Cook <kees@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: CVE-2024-40938: landlock: Fix d_parent walk
Message-ID: <202407150908.34E00AAD1@keescook>
References: <2024071218-CVE-2024-40938-1619@gregkh>
 <20240715.aeLiunipi8ia@digikod.net>
 <2024071553-yippee-broadways-8035@gregkh>
 <20240715.Eishohd0ehoo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715.Eishohd0ehoo@digikod.net>

On Mon, Jul 15, 2024 at 02:20:59PM +0200, Mickaël Salaün wrote:
> On Mon, Jul 15, 2024 at 01:16:38PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jul 15, 2024 at 12:37:53PM +0200, Mickaël Salaün wrote:
> > > Hello,
> > > 
> > > AFAIK, commit 88da52ccd66e ("landlock: Fix d_parent walk") doesn't fix a
> > > security issue but an unexpected case.  The triggered WARN_ON_ONCE() is
> > > just a canary, and this case was correctly handled with defensive
> > > programming and didn't allow to bypass the security policy nor to harm
> > > the kernel.  However, this fix should indeed be backported.
> > 
> > If a WARN_ON() is hit, a machine with panic_on_warn enabled will reboot,
> > hence if there is any way that userspace can hit this, it needs to be
> > issued a CVE, sorry.
> 
> OK, I didn't know about this panic_on_warn rule for CVE.  Out of
> curiosity, panic_on_warn is definitely useful for fuzzing and testing,
> but what is the rational to enable panic_on_warn on production systems?
> It literally transforms a warning message into a system DoS (i.e.
> WARN_ON into BUG_ON).  We should explicitly use BUG_ON() if this is a
> critical unhandled case, right?

We need a way to raise WARN to panic for deployments that have tested
their workloads and want FORTIFY_SOURCE and UBSAN_BOUNDS to actually
perform mitigations instead of just warning. Linus rejected all prior
knobs for this and panic_on_warn (or better yet, kernel.warn_limit
syscall) is used for this purpose.

Userspace actions must never be able to reach a WARN or BUG state:
https://docs.kernel.org/process/deprecated.html#bug-and-bug-on

-- 
Kees Cook
