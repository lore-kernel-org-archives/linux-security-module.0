Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171735;
	b=0t92Ao26/Z/Ulh4KLTAfZbAFocDQHBMA47ONz4BRJOpuJpBoFrIowR6m/1lrtqgD3oNL
	 YhCYey6A5/XqxluQO3tmS4y45DDI8CPf/KpMbp4J1326Kb0bLSNh2sBZBGGrMgeZ5JNKx
	 dAZOVCB68wyfg8y8s49OgfNqf2IOkgXh+MW7b+4yfjobjewcYOLgJsm1su6v+RRz6L6H1
	 aKAaddZPX0WXjwnCI7bFkgsEyAHMWUHQvrizZwgEJt1h1ckbrTl+X7NbN8gcjv07XdUbr
	 mNnED3CQcStgDe4KT+Bq3cRLPgyusSfQQPUYjNAot45y9On104yQdU39LzYZLRES+Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171735;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=i45mmxtCzqYf5y05NGdxwulHc/vZ1HC5B1d/2UfGHQ0=;
	b=q1Ao2ybk7gQ4Embr/PxOYfYJqbnhX9ST1k672N9Kjm+mCSSG5dSPWEsnQDXOJtX6pQFd
	 R2xLDY8m9GPFc8x8gVnJVgMMOHaYrp9ynTVmY6R8UWvRs6bBC4QXD/OFv2k0a8ezktGw8
	 LftiD3ptQ+qYWlJBk00CDrlAunY0u5bzxFB4hV315zt2Nl1nhN/0BzJ/ahqlIncBtpsmR
	 QHRO2v60IGO+DYBYe+WQFmp6ckCoFfSY0TRRubt10uM7TFNCs1cKLb8lk8gbiP9k+tpuq
	 Jo8D3HliRKDrHzbiWxikH1sXn298LxiPKavmvzwq8Mavets4y8nJxh5SLYQyAdGFenQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnCzUgj9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97BA606A320;
	Fri, 20 Nov 2026 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnCzUgj9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29841F000C4;
	Fri, 20 Nov 2026 10:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795171735;
	bh=i45mmxtCzqYf5y05NGdxwulHc/vZ1HC5B1d/2UfGHQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KnCzUgj91Jx8XYWsvk6YdiJ5m2LR/qMLol07GISACz97SHm2BawWpyeVughd00p28
	 lc2HM0zW6Y+fcC4RscA+qh1Q1Nt4L4evmEBdlbAkZzsH9kXvm4t3sb/RWpDbU+dfrI
	 0u/+8WtRiQqOjBvdmIG7Hi9W8Eq9Bs+JAfAo4p1H0TJsuMUfYkfsnO6Htgbi+Ebj8o
	 FsD2G9knkRXBaRTmun9wdZ/Y0tYdAZjjnTKOFJOA4QjCJ3tFIHnFvyjk7zmfreR+BL
	 0fesBr+RK3SYR3rPnCZW5fwmMjEiMWdrUCRSTOI+zEhh2gRjb62rmn0uFB3FSSatTm
	 /BV8ZFPLRZPLA==
Date: Fri, 20 Nov 2026 11:48:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: Shi Lecun <shilc2025@mail.sustech.edu.cn>, 
	John Johansen <john.johansen@canonical.com>, Georgia Garcia <georgia.garcia@canonical.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Seth Arnold <seth.arnold@canonical.com>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Jan Kara <jack@suse.cz>, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fengwei Zhang <zhangfw@sustech.edu.cn>
Subject: Re: [RFC PATCH 1/2] apparmor: mediate file-generated signals
Message-ID: <20261120-unrentabel-bambus-genuss-0db3576a8f57@brauner>
References: <20261107154928.3519030-1-shilc2025@mail.sustech.edu.cn>
 <B01DC8398B429509+20261107154928.3519030-2-shilc2025@mail.sustech.edu.cn>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B01DC8398B429509+20261107154928.3519030-2-shilc2025@mail.sustech.edu.cn>

On Sat, Nov 07, 2026 at 11:49:27PM +0800, Shi Lecun wrote:
> +static void apparmor_file_set_fowner(struct file *file)
> +{
> +	struct aa_file_ctx *ctx = file_ctx(file);
> +	const struct cred *old;
> +
> +	lockdep_assert_held(&file_f_owner(file)->lock);
> +	old = ctx->fown_cred;
> +	ctx->fown_cred = get_current_cred();
> +	put_cred(old);
> +}

Note that Josef's cred-ids series makes struct fown_struct hold a
reference to the credentials of whoever set the owner.

So you can just use fown->cred in apparmor_file_send_sigiotask() and
drop the file_set_fowner hook and the cred you stash in the file blob.
