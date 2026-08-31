Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B122C027F;
	Mon, 31 Aug 2026 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215699; cv=none; b=oUAMeQhVIpLrVCH7kyW4ZH+u4gX0ppRo/7aoaY3pfHw2/VGVIeYjfahV8sXBdl8BfHtRpPfg5eHRV6MCJhfirvcPZ8CErzWOgF0C6SyM0/1J2kDI6kDDTfg1NuXfodue4/p7UVs46t8PaVxg+BhidYjT0msFF17fJE3rLCBax/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215699; c=relaxed/simple;
	bh=vt5NchZA1XgWNycEvPnbxEdexv1L4NTFVkyLXGNQuR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDgJ9EErWu8PsInimtM5HpBIWAn7NEUy+FlV+iQP+hx9vPnwyDC71byT8UoXty83WfFKtdZrKe6iAy3F60vmDR3EouEkyRhv01lraJeIpqSA614yFVPB/+oZON7X0/78s+9LKVGFbAhgEDdAED0e5qIwnrijjYH2HiqUJQ9EbKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4RIagAe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4RIagAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4F71F000E9;
	Mon, 31 Aug 2026 22:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788215697;
	bh=X4rQ3Bu6ATpqVZSU9Fv27oaY1it5RSb1fSYbuVhOksw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g4RIagAeH7BAEeYC0o2kq1tXrbEXUq5GEFL79+SoGxYA98GH1taQ9HotE9lnLYJz6
	 rwG4s6hQXZ87subHXWMnZjocDIx/tieI/3S27qVWQhJGIm0URirDuNlmyuEQwSDXJU
	 E2P6TZFRn8wOpMi3FIv0pZYqDQf2pRO0kCFhJ/yhxc1eVacNoR3/7+OrJeA4y5BQ8r
	 WOMWxRYISwjzXmtB/kXF2o3SSoBu66lDHVfIDX+2JSotmUwDiwNWnWQgFqecBfx/iS
	 2VoLDY39ZdpGD6efUAxE2tuUMO9FB2so/7IpgldntSF9QFk2C0V6O+wL6HLtjy4fie
	 8VimCPNuHp4eA==
Date: Mon, 31 Aug 2026 15:34:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, Matt Bobrowski
 <matt@bobrowski.net>, John Fastabend <john.fastabend@gmail.com>, Christian
 Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
Message-ID: <20260831153456.5a7d6937@kernel.org>
In-Reply-To: <20260831110934.241898-1-a.s.protopopov@gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 11:09:25 +0000 Anton Protopopov wrote:
> The BPF LSM programs are allowed to attach to LSM hooks. This enables
> operators to mitigate known bugs without a need to reboot or livepatch
> machines.  BPF has shown very useful to create such runtime policies.
> However, many APIs and parts of kernel aren't covered by existing LSM
> hooks and this would be beneficial to extend the coverage.

Dunno. Do you have any reason to believe that any of the CVEs your LLM
gathered for you here are actually getting exploited? Spot checking 
a few they seem to be mostly driver bugs. What security model do you
have in mind? Untrusted/malicious users with physical NIC access?
