Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793441513;
	b=voNQRPQxpRtkmIV2AlOspFkDBEs2lqLoty4RjhSHxTH+foCcu/hFuzIS5qlt2mHqm0s6
	 XiPmpnZmy1EMPg8/nCREFCjwDTVGRDCTjLUhya4kWCXSFpdXZh6uDtH8JaeEWVxg/8s3X
	 LSO6Py6AmcbpeTThoE6BqLeBrGd7vSv58dbpFezm+RpuHyVatcoM8H3tX5kYc8EKOz5/E
	 bfjB2gU4XgMM+FFe8+e9rVIkYB/RBGqpSzFobuS83lHkfOA4MeayOMx8Jy/4eBcydjgZC
	 1t5efr5amOwIMvTdd+pcwe4lwOqe0s/XYWAt59WqhFNBzhdVpsc5aSKBClRSycARRaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793441513;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=PUPQWrzH+bOmibwWb9YKOya5jmCEqnTEobsOjXEdjes=;
	b=i0U7K5mdQ1KG5euDdKKfnAzlMg41dpLLt0ahyLzmaMPlqb3Fy+fBqbNRRspkIWiHLbc2
	 R1i79VmUMCrnu1x1RfBos9ScFYjwqHiZYVKx/4qJ2eQK4cqoJUqHdLtqOi7LkM6taZ97q
	 tNRd/Pf2kJanGahJaXUY380uzwQU01FyaXsXxRuk76vqbWokea8Ayj+e/bYH8cIGZk/sF
	 RAKkweyCeLUyTEgZUvOuBoRVkip5f5aQDc+pn02q0IcO6bjseJVbnzxHvGCtn334EJkZk
	 MFH79nIhVuWjlbi3YTxnNx5KCWuaMRGhIrnlKCVcHgGj0AUK1hwzA5bV4xLpw5ZWRUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KGNiNQ14;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1774D606A31A
	for <linux-security-module@vger.kernel.org>; Sat, 31 Oct 2026 10:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1774D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KGNiNQ14
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D48D91595;
	Sat, 31 Oct 2026 03:11:47 -0700 (PDT)
Received: from NH27D9T0LF.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D18693F59E;
	Sat, 31 Oct 2026 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793441511; bh=xAiQwUL+HSIwzi/3Ta0D+1DCjOBAp6eJoqy19IadRf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KGNiNQ143pWGjbVWoobTFLwGX1JUFLmZD4mb/axjcRxssvTiKdi/AbsEGMjcJxaWB
	 enw60j7P30BEoYgWeqsZABcRNl14qHUVVTVkvyL9JNBo9mVNJSRhY1tQiUhS8huJ5F
	 BPJo1HeGmnXT8U28vtEwdji7BZOUoals6SaSJ4jc=
Date: Sat, 31 Oct 2026 11:11:43 +0100
From: Emanuele Rocca <emanuele.rocca@arm.com>
To: Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>,
	John Johansen <john.johansen@canonical.com>
Cc: linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
	Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH] apparmor: fix race on NULL ctx->peer in update_sk_ctx()
Message-ID: <auW-3_OXSxEP5U7c@arm.com>
References: <20261029140643.4092-1-emanuele.rocca@arm.com>
 <sashiko-outbox-189513@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-189513@kernel.org>

On 2026-10-29 02:26, sashiko-bot@kernel.org wrote:
> Does this depend on the prerequisite patch referenced in the Link tag
> (https://lore.kernel.org/all/20260824155822.9214-1-maxime.belair@canonical.com/)
> that adds the NULL checks on ctx->peer under the socket lock?

It does, and Maxime's patch has already been merged into the apparmor
tree, as well as mainline:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4de32fd05ce9e63b492899215ea929e7d306cdab

The patch I'm proposing is still needed to fix the earlier race at the
beginning of update_sk_ctx. 
