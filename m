Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956481;
	b=cPVtcYokh37wAtUlqYrDYfoD8YjzavV4LV8Ik0TSm68U0z+9Vvj2RfyMbCJh6N/v/L/J
	 +emLYlY6dZ3urTpiPlOb6LLxBEsvSHN5fe55DPWxPdcxwAM52G5jkHb720U0I7YRcG96P
	 ANSxr/MuIE4INe1O4TtEwYHSoUriEy1Oek9/3QrOlsXXQPkZeiNRWDEGjvaOWoCR/HXVW
	 Pfmwsr/oiQHIe3m/XUDkYo3NfHsvVmV+CzTtCFXMuRHY63M6FoyZ7qQyJCZMI1k2WgODd
	 mXnJmOwEKZ6tp/7y2l9wUviAH1KmfDL8UzUWvFTimhjVktqKoIHzzTfJLQ98vMqC1vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956481;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4S9LHbn3kaZCl2f8o0GIqwvTmJ5pmKm5hhKwjJdY6Ww=;
	b=z6T7ncCsKofdf1K9dF2dRvRwuh4z7MgYxVQLBYIW8UBIdCT+bjqd9QdkITF/PkV0iFKX
	 QCqHZsyuoC2d2v5oVHVjzb/9dYF3EUUcmZeKismcJJhn1w941FJJgAvDBWWh1gJjHQoDz
	 jZImoVrcaIXVw/xWS9lAwY5nM9rIWQNJfWa/vwZM4kHnNyv4y4F+mMt9YiWKbwwWjGTuy
	 4lkbnYwNRyqIQ/6/K64euzWN1E+CP6raD5Es0c8HGbpJ+iE/FyIvS6Z0caUvpmtTPXn/g
	 /yIi+hg0yJtWnzaOZ3Kfpzna5c4U/BMn5xSSPTYi4RcW8BgpmmcwmrVpms1EPY9L82Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpwtKnjE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338A1606A328;
	Fri,  6 Nov 2026 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpwtKnjE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A451F008A3;
	Fri,  6 Nov 2026 09:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793956480;
	bh=4S9LHbn3kaZCl2f8o0GIqwvTmJ5pmKm5hhKwjJdY6Ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IpwtKnjEfNcgA4M7qps6DEOXJ/chF/wtpVphLblnZlDGWb2nLskbnA4rTJzaEjoke
	 Cbtdvl/MIqKPTeLh4bIEYhIBqhXATfWd5Ynp/wYBEBl0jRzEcU/4Q/d/JDFquHs9b1
	 6QJIRLGZWKQk8ZeaO/tOgT2DR98CNcoa6Dg+S7YFVpRNGCGSUXKn7bbN52Yu4Jx0UJ
	 jgfnuGv1mRtBGa4OJ3g6xRHy4xifEbl8OZg5Ul1lv7VR0puuifx+n7871JirY/A8au
	 jwrF0y/h3f3N1rzmkNlmPh3Sd3HnrgxKI7QGFNRrLZw2koMsFfrXcYKydNZimW/PWR
	 ai4EsFy9ojA1g==
Date: Fri, 6 Nov 2026 10:14:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oxana Kharitonova <webprosto@gmail.com>
Cc: mic@digikod.net, viro@zeniv.linux.org.uk, gnoack@google.com, 
	utilityemal77@gmail.com, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, landlock@lists.linux.dev
Subject: Re: [PATCH v2 1/4] ipc: Move MQUEUE_MAGIC to a shared header
Message-ID: <20261106-boxen-maschinen-triumphieren-4672fe45b595@brauner>
References: <20261102144708.920232-1-webprosto@gmail.com>
 <20261102144708.920232-2-webprosto@gmail.com>
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
In-Reply-To: <20261102144708.920232-2-webprosto@gmail.com>

On Mon, Nov 02, 2026 at 02:45:57PM +0000, Oxana Kharitonova wrote:
> Move MQUEUE_MAGIC from ipc/mqueue.c to include/linux/ipc_namespace.h so
> it can be shared by code outside of ipc/mqueue.c without duplicating
> the constant.
> 
> Signed-off-by: Oxana Kharitonova <webprosto@gmail.com>
> ---
>  include/linux/ipc_namespace.h | 2 ++
>  ipc/mqueue.c                  | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
> index 12faca29bbb9..8a15ffe38e9a 100644
> --- a/include/linux/ipc_namespace.h
> +++ b/include/linux/ipc_namespace.h
> @@ -15,6 +15,8 @@
>  
>  struct user_namespace;
>  
> +#define MQUEUE_MAGIC 0x19800202

Should go into include/uapi/linux/magic.h ?
