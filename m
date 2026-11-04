Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804974;
	b=XIsDRE2eLXmhoTirYUBfoyIOSKiC/7t9d2GUq20ZDt63Hi6sxMAR92F6FAmAPI2uVVAB
	 HGu/cDZueRcMoa1vg+EbAbMzzc+SlKfIUlfROnctnA3bd2rnj7mvXgyXTPzwrjhQtD7eM
	 Ekryj2s2S2wHea5vcWaApAtjIm3qLca/XoLTgZj338mmQNQDF+3PFyIescYkfnq6jMnug
	 mQvr4CyS4/U6f2qcsU27m3IjJp+4fGmgTd3urh1SimMbqBAvAy9QURWgFKdfJPBpOoQ0X
	 l4qjW0fJx5hteUIQt1VTdkAvk1Hn2JI/xNq+OMVPJ/E3uoGAeCakK75ediRJxBqZ8TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804974;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=SEVP++FtTKspoMovyygBHK7EPH7hZew39sqwyYOV9RwHOxBjS9URqrEuY69ycTozE4UC
	 xv88JhnfBn0x9OqC1TX5kGCMYH7ppoYqe/0z95zVYGaHpCst6IbEqOwAQjJJRrpR7Nbpv
	 Qv4nEKUIKn8E6X7HkGjQ06TiYFdmr/kC6MpQuOKEowkUVcOoh8jnjdjw6Fa2j7r3uuvB2
	 rElTgihMg8B6Cc1ZdnEazUZdU/g9Lq8KUyLHXqqGfTW8LWdiWWy+xs39D4/PVQ2F4lM71
	 aSu9Qh2rUcnkn3RLU1o3YJw5I3iiUmPDA1gkq9xavVat/22DgEVbfh6vbk2cePrv94w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWFSl19Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99343606D818;
	Wed,  4 Nov 2026 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWFSl19Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E710C1F00A15;
	Wed,  4 Nov 2026 15:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804974;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nWFSl19QKSA4kfi/atm0vkp+BfeJzNrF+NgHoKJ/4gZP/ScFIenJfTKk2JPpyVUJj
	 QEE4MFEs6M/y+/OuCIWwJB6yoXR0pmV7M+8cD3xqWgyIHUmRk/LAK3bacCHHB6neHA
	 P1+lHGSb/wSfS8Z0Z7AymbsH946eJ+7LLEuFZwhFg6isrwW28VsKqJgcuggysvzQrC
	 YJsNskFUrh1DHhRBFRGAdRlxWGv8EHCCGKJxGCB3tXi/XtHRlvpo0ALlUYFJYJPHVL
	 RKYuJH6XDhPXGgHWNqC6gpwoFpsxx47ytWWAoxF43AhFVALmCp/KGqrQI6HRamUO/c
	 VG9eHGTjfCxwQ==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paul Moore <paul@paul-moore.com>,
 linux-security-module@vger.kernel.org
Subject: 
 Re: [PATCH net] calipso: do not charge request socket options to the listener
Date: Wed, 04 Nov 2026 15:09:33 +0000
Message-ID: <179380497346.488859.11994675633273087642@kernel.org>
In-Reply-To: <20261104150318.1156620-1-edumazet@kernel.org>
References: <20261104150318.1156620-1-edumazet@kernel.org>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
