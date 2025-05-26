Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ECA16EB7C;
	Mon, 26 May 2025 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284693; cv=none; b=TZ/HR29lKtXhLGUuDVNyNrs257mGrHv/A2fLEJzt4NtupBN+/JcY+PYozZoeR2scY4cna256Z1PVlteI9rq26GyzPvwe0EUku1IpACF/N1iGR16CdOlPrBijLTjuc5pUsT3Xc1Y6S91mWcarAgyhHzGTzFqmK4rLPCXeZGVRXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284693; c=relaxed/simple;
	bh=byxXvCc25/UBn5G3fsI02F/XIYUZoQFNeyxCX/4ywH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XS+pRJoxJi0nPDzqOqIbx0mtUKTsXrafqFEg1V5fQjEprpD6t0IRwX1DzVBrTtEKXiYEp0G3jzx2AlVjt3UHyC+MkpJXtDdHDX56IWS/ze+Fsf8FWSVQXltNorBolYjbDiL14+ZucLU8ujlXcRi4n8MJ+p0/m2IHHa3v4z7iILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=JYydJO3O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LxrtZRcJ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="JYydJO3O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LxrtZRcJ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62EC62540199;
	Mon, 26 May 2025 14:38:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 26 May 2025 14:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748284690;
	 x=1748371090; bh=Wg6ZzUU6RKA+p9AW93gylQZbXdxFA3WZB5RI4lcoWDw=; b=
	JYydJO3OJurbBWlExvM/Y5lA7yqajBzk0n10N8TYUrNR5PgwN7+6V9bwx6MfA3NU
	iPtpXbirH6pDttTl5zm9p/eeIre7YyeoWXUz1W/F220l9+UvXObMXmmdfmS/DQcN
	PNAcXLBIhg7iv/v5Guw65o/L2QXY04ppbYs9DvLNZ77qYnOkr1WMgbjMLPUN2eJM
	tJRqadi2DGQcf2uuKTgbbK4r06v6SuhwpGbJcxCtYMdqjGY0wg1XZ/0qD9W3YF8L
	R85wqdRkxLUHusjtDGa6Zd1+9VdzNAzkTfBQV2qhfHkO422JnP0qZgMbx4ZKlE0q
	nUJqDAmxuMdWUyE3YdSIQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748284690; x=
	1748371090; bh=Wg6ZzUU6RKA+p9AW93gylQZbXdxFA3WZB5RI4lcoWDw=; b=L
	xrtZRcJ9q8mgLmjGPVlezty8isoNCPv0nV56dkKCKAtR7ywYVAfn//wKbqCdQPK3
	H4YAZ8xuq4RA15+EhZV2aTdDzrArUg+YQfrKIXRRnaKBEeu6Jetf09YmFKQ8K/QP
	ijVG8H8tDuXcBt5jxDbFz+hiZq95nteVHAnTLC1OEglcYAmHoHRHpax3i4S0gj1i
	KLORegnzOjv3Ce+Mms5S/Fr95DqqT46VAxT73ZE6WG12eB6awYHhFSwGTD+fAWyH
	SZu89lpUTm1gocBFmGVytjv3TiKiS+q+q11ChpxQwHFbDTWNrn2U4JkDh5X0IKpG
	dNjG4M+9Kd0A7fxbqRhDw==
X-ME-Sender: <xms:EbU0aOvhgsu4PTAiuVTpbis8sr37suKqQPDTGcQWoNcDOOhgJQjzpQ>
    <xme:EbU0aDdvTZTkA3C_uCnhGXMk6FVWgC9lVdvuMdODqeHXKirWCEDnPyRYiSTUtJpD2
    171YwLt5ffcB-IxkKg>
X-ME-Received: <xmr:EbU0aJwc-OZPo4kPPNgLPv6sVgf6E44S2oMfRObWvjRyeHepEFOo9N-DvczuGX2MbF4DgOJhWcPbgmUcNFsVRdoI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddukedvieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfev
    fhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomh
    esmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpedukeevhfegvedvveeihedv
    vdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghr
    tghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguih
    hgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopegusghurhhgvghnvghrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtoh
    hmpdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgv
    fhhfgihusehgohhoghhlvgdrtghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprh
    gtphhtthhopehmrghtthhhihgvuhessghufhhfvghtrdhrvg
X-ME-Proxy: <xmx:EbU0aJPCCy6_BIBp_yc2mRzolCGY2eYTyNN8sk6tWALG6EBSjHD-tQ>
    <xmx:EbU0aO-umUH468zrDGsFOCvKbs_pBEOPmTCHt8iROleqFIhMw2qF6A>
    <xmx:EbU0aBXS1Ai5Z6G5bewiLUgYD_nOqk4W_1z_V3t7dRwXN8nhR9nd_g>
    <xmx:EbU0aHfiVUsymsp_mGFD1PpENpCgehyzYwRDs-KCFQykX1HCT9Ru0g>
    <xmx:ErU0aCDpSPV9Q1ZF642ddKaZy-5nGj769AGwQ6ASUXWyxVm_V_DHPUQk>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 14:38:07 -0400 (EDT)
Message-ID: <ec7198c7-bed9-4a04-9ff0-da90ce729897@maowtm.org>
Date: Mon, 26 May 2025 19:38:07 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/5] landlock: Merge landlock_find_rule() into
 landlock_unmask_layers()
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Daniel Burgener <dburgener@linux.microsoft.com>,
 Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>,
 Kees Cook <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Ryan Sullivan <rysulliv@redhat.com>, Shervin Oloumi
 <enlightened@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250523165741.693976-1-mic@digikod.net>
 <20250523165741.693976-3-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250523165741.693976-3-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/23/25 17:57, Mickaël Salaün wrote:
> To be able to have useful traces, let's consolidate rule finding into
> unmask checking.  landlock_unmask_layers() now gets a landlock_rule_ref
> instead of a rule pointer.
> 
> This enables us to not deal with Landlock rule pointers outside of
> ruleset.c, to avoid two calls, and to get all required information
> available to landlock_unmask_layers().
> 
> We could make struct landlock_rule private because it is now only used
> in the ruleset.c file.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>   security/landlock/fs.c      | 144 ++++++++++++++++++++++--------------
>   security/landlock/net.c     |   6 +-
>   security/landlock/ruleset.c |  12 ++-
>   security/landlock/ruleset.h |   9 +--
>   4 files changed, 100 insertions(+), 71 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index f5087688190a..73a20a501c3c 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -356,30 +356,27 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>   /* Access-control management */
>   
>   /*
> - * The lifetime of the returned rule is tied to @domain.
> - *
> - * Returns NULL if no rule is found or if @dentry is negative.
> + * Returns true if an object is tied to @dentry, and updates @ref accordingly.
>    */
> -static const struct landlock_rule *
> -find_rule(const struct landlock_ruleset *const domain,
> -	  const struct dentry *const dentry)
> +static bool find_rule_ref(const struct dentry *const dentry,
> +			  struct landlock_rule_ref *ref)

I think a better name would be something like "get_rule_ref"? Since it's 
not really _finding_ anything (like doing a search in a rbtree).

(If you take the rename suggestion, then it would be "get_rule_target")

> [...]
