Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840733EC;
	Sun, 10 May 2026 04:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778385760; cv=none; b=WU60QIwRRZMrSyt8wOpxz0yWnrXrGJGWBRSLLqGoxOR71DRvxml01U/R96N3HB1h3eaZ2bX8X8HLLUuQe3gPsfhtLN+L2tX54KwR9hL+jpaKVsgBl7ViySgcXvFEjkistUzZypbQpZMcvMTyRRCB6d41h0oiNTyHVcFnkp9uIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778385760; c=relaxed/simple;
	bh=BEw1CTy1brhnwKWhO/MSoDJNn4pPxdnVj4m8F46EhBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DW7O8glG5jRNC3S2U5nC4xOoM7z89znTL8E2D32Zg31JU0B0m0eYVzb9aRYmpORiMCzNqPzmXjkXR1o7qKq8WPu2yz1qUeUPyI7hN1AIliOGWS1X7Ot+acBCxiW7lJ+bPfmkFky0kSacw+KJKqn/5bPGhLPQpt9sJnJ0RgT+yVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ikc/odBM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ikc/odBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA58C2BCB8;
	Sun, 10 May 2026 04:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778385760;
	bh=BEw1CTy1brhnwKWhO/MSoDJNn4pPxdnVj4m8F46EhBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ikc/odBManXguIza9TjajNxrUzmqjavTC7CeBrvninNKE5hs8y5fxWfG8qpm9lFUQ
	 AqqAcNXlLp93LMQ7F3hJZTa/amCMGQ79n/XwVC4UxyjLdnHQVxx1QmrXktPl4osroE
	 M/ASwgSDQ2IBfp6k8pb2vnxFyduxp/03D1IqrYND4EDW9QdRwllSUO7vDLJi6rzu+y
	 THYaQwJHOZ0GSRqeRJyDqMfIuy8qfiIY3SiwItLcCkFlvK7cPklodaY8KpCBPuuz6/
	 3h7v077/yUO2dcGkP+y+NwcCCJj1BFzDWkV2diqPwP1B4Jyf1jAdVFEuSUuBrinugn
	 B5R2K1k/H/0sg==
Date: Sun, 10 May 2026 07:02:36 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Moore <paul@paul-moore.com>, Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+liste5004e02dae137bbd339@syzkaller.appspotmail.com>
Subject: Re: [syzbot] Monthly lsm report (Apr 2026)
Message-ID: <agADXEjqD2X8XWN1@kernel.org>
References: <69dde155.050a0220.3030df.004d.GAE@google.com>
 <CAHC9VhS2AaRwAQw1hNcpuGdFSOL7Li9PavKtU7eW-w8eMOFuKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhS2AaRwAQw1hNcpuGdFSOL7Li9PavKtU7eW-w8eMOFuKA@mail.gmail.com>

On Tue, Apr 14, 2026 at 10:02:13AM -0400, Paul Moore wrote:
> > <2> 68      Yes   possible deadlock in keyring_clear (3)
> >                   https://syzkaller.appspot.com/bug?extid=f55b043dacf43776b50c
> 
> Jarkko, David,
> 
> Do we have a fix for the keyring_clear() issue, or is it not a real problem?

Sorry for not meeting the timeline I promised.

Anyhow, let's on the issue.

There's really just two alternatives to resolve [1]:

A. balance_pgdat() acquires keyring semaphore before __fs_reclaim_acquire(),
   and a non-locking-acquiring  aking __keyring_clear() would be called
   inside fscrypt_put_master_key().
B. keyring_clear() is deferred and we accept that quota is not
   immediately released.

Fixing this from the user process side doing kzalloc() is of course unrealistic,
and unstable fix.

So.. I don't think this is keyring issue per se. This is fscrypt issue
mainly, aand depending on whether A or B are used to sort this out,
possibly also kswapd issue.

Or this is my analysis (which could be wrong of course) after couple
hours looking into it.

[1] https://lore.kernel.org/all/68e54915.a00a0220.298cc0.0480.GAE@google.com/T/

BR, Jarkko
