Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595D2DA76F;
	Tue, 18 Nov 2025 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464182; cv=none; b=ijQr+JX95zBytmI/brNbtbbrZxfVywwTzYvGRQWq95NZSQqRfz13h+VSpbEMLUCxS67w7LURvY21cv/y16cx6XslB0YDRHvAiKY0cx0StL/lmoaftxoT1S/MQ322+9mXmZIkUGG3HB2BrwIIDuUkX6SGyplh3M5SINc8XEys9+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464182; c=relaxed/simple;
	bh=uTZCne4q7hwhSlgv1c+tdl662JBPe/6Bs63dHG+VGn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaXLJx+E8qR8VyhxaYUeLlACr7elMSyQ3VcmSH/olswAbRF3iG5T2I+WytF/sOWcl0HnxX4gUtLwkRPN83u/XDdiU7qWiJstK8QdFqLQFsGz4FcvM8PtSlQdx0xNJv1mOYIybAxgeaukRzggJ8HKfppHbo+9Jd5ezfg+zId60C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvoG7miv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvoG7miv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01B2C19423;
	Tue, 18 Nov 2025 11:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763464180;
	bh=uTZCne4q7hwhSlgv1c+tdl662JBPe/6Bs63dHG+VGn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qvoG7mivf2kJkwmtym8zMHqi7e89PlF5arfm49N0GmQLqaUruTynb26uFaGxDhSkq
	 YMv3qEUbRR34tGb9YTL2bCBmtjdLIBp4Bs+M3j0BrTW7CZZcRYFUJKCY3KlXZReqeP
	 XNQcuhk++UMY7EkMGnnIsq3eEkY3ciDpZbSfqngdalzoEn3DV6Mi0RrmpX5Isf6cOc
	 rkOe2Bmvx0+M5m11kUgqK2KlbsKDQJkQEp7kx5oHXDr8Mnfht8GgoA73oin5mMBZnv
	 /VM6UHwqnqNDPACAK7oskmxT+xQSqfawUsXZc0lgXcuDxSgn71P+APkJSnI/zvSuyb
	 ynkLeM1EK7yAw==
Date: Tue, 18 Nov 2025 12:09:35 +0100
From: Helge Deller <deller@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
Message-ID: <aRxT78fdN5v2Ajyl@p100>
References: <20250531150822.135803-1-deller@kernel.org>
 <bc21bee14ca44077ae9323bfc251ad12390fa841.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc21bee14ca44077ae9323bfc251ad12390fa841.camel@physik.fu-berlin.de>

Hi Adrian,

* John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>:
> On Sat, 2025-05-31 at 17:08 +0200, deller@kernel.org wrote:
> > From: Helge Deller <deller@gmx.de>
> > 
> > Two patches which fix unaligned memory accesses in apparmor.
> > Both triggered on the parisc platform, which is much more
> > memory alignment sensitive and will report violations.
> > Please check and apply.
> > 
> > Helge
> > 
> > Helge Deller (2):
> >   apparmor: Fix 8-byte alignment for initial dfa blob streams
> >   apparmor: Fix unaligned memory accesses in KUnit test
> > 
> >  security/apparmor/lsm.c                | 4 ++--
> >  security/apparmor/policy_unpack_test.c | 6 ++++--
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> Thanks for looking into this!
> 
> Unfortunately, the problem still persists on SPARC even with v6.18-rc6:
> 
> [   76.209476] Kernel unaligned access at TPC[8dabfc] aa_dfa_unpack+0x3c/0x6e0
> [   76.301115] Kernel unaligned access at TPC[8dac0c] aa_dfa_unpack+0x4c/0x6e0
> [   76.392697] Kernel unaligned access at TPC[8dacf0] aa_dfa_unpack+0x130/0x6e0
> [   76.485440] Kernel unaligned access at TPC[8dacf0] aa_dfa_unpack+0x130/0x6e0
> [   76.578179] Kernel unaligned access at TPC[8dacf0] aa_dfa_unpack+0x130/0x6e0
> 
> I have documented the problem here [1].
> [1] https://github.com/sparclinux/issues/issues/30
> 
> So, I suspect that your fix is incomplete.

My patch fixed two call sites, but I suspect you see another call site which
hasn't been fixed yet.

Can you try attached patch? It might indicate the caller of the function and
maybe prints the struct name/address which isn't aligned.

Helge


diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index c5a91600842a..b477430c07eb 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -313,6 +313,9 @@ struct aa_dfa *aa_dfa_unpack(void *blob, size_t size, int flags)
 	if (size < sizeof(struct table_set_header))
 		goto fail;
 
+	if (WARN_ON(((unsigned long)data) & (BITS_PER_LONG/8 - 1)))
+		pr_warn("dfa blob stream %pS not aligned.\n", data);
+
 	if (ntohl(*(__be32 *) data) != YYTH_MAGIC)
 		goto fail;
 
