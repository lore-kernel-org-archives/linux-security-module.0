Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839D352FB5;
	Mon, 19 Jan 2026 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814004; cv=none; b=eI6MknFTNqtn6M2RnQmdk3N/D5EoWvGpD2pmCnMpRJFnKwOuZ9ph8faWrNz53BPOCTOmQo0T+bfAA/iU4CoxWxguPD2bXHpjVW+btEm0zZCwj4w9kRwXNoSsogMBMLOJjEoijSo+X+sZoNURMQptOz5+s3e9K5gGPDAujnqvK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814004; c=relaxed/simple;
	bh=VOmu5hgdvMz2x1pVn8Fxo8oFgrwats5PgHA4H3LVeO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBeUwv6Hi2RozVIqeNCuYEZERyFNnecvnFHFCL0RLQm1pEli+vDypE8EPc0TG7O/uwzPnaqoz6e1Vi876nus0NAy1SACUedbYQopjc7A0tTqBno2LLvHs+nN3+TQTq0FxTUqJhYfAZU3WewQdtsSSqgQKT+pxOGb8ZLvCSx6wOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MXX9yCaN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MXX9yCaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A930C16AAE;
	Mon, 19 Jan 2026 09:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768814004;
	bh=VOmu5hgdvMz2x1pVn8Fxo8oFgrwats5PgHA4H3LVeO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXX9yCaNwfSoOum65MfiPpL9wdubsm/oxvK3qrrKzobWaEGC6sn7C26qlQKJyrpv5
	 1gla8J2MPQvbBocs2NikO0xRd2m0ij+TatK1mAZ4asWYaN2lbHl+6p3UX4nM7Zk92J
	 sXL9OGj807WihAqidl3I2/GWUmASrerWumXRVaqE=
Date: Mon, 19 Jan 2026 10:13:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Carlos Llamas <cmllamas@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: export binder symbols
Message-ID: <2026011958-evasion-villain-0ef2@gregkh>
References: <20260119085109.2238878-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119085109.2238878-1-aliceryhl@google.com>

On Mon, Jan 19, 2026 at 08:51:07AM +0000, Alice Ryhl wrote:
> To enable building Rust Binder (possibly also C Binder) as a module,
> export these symbols.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  security/security.c | 4 ++++
>  1 file changed, 4 insertions(+)

We need this as a patch series that actually uses these symbols from a
module please.

thanks,

greg k-h
