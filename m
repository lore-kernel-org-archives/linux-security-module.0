Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D6271456;
	Sun, 12 Apr 2026 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776011371; cv=none; b=lDNPF32exfEjEMySiga7q1vrQtCpt+mypgqESLKK0B5HIGD5Pdx3JheHnjZohjZZfcBHw8/8cl2MvZ7kfuDTEXXM8Fp3ha9dVHkGhWhufVH1k5WFloBqEMoOL7jctJhKNxuLF1LHpiR3qlje15NneEfMvVzQZxeG3WzetV+k+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776011371; c=relaxed/simple;
	bh=RByfpH+PZ0mnQDZT7rC2TxNtViuclKa4ObQpONWapzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZ+j4lLuDr7tJQSApZNbWeHBYcFU2sYEsyJdCPBcYHgH8llvanl1U1QxyOVlxtnG6UrDJTLyeOUzG27WXk/bBsOrk4+qBaAsOYJ7GS31hBDzLlvBmzW+x1Mo9aA6748xHw2+zx2FPzathKJAbjmnD0Z1rkcDUFwR66TOKklDegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=ISMQQS1P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LeDOI44y; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="ISMQQS1P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LeDOI44y"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67C087A0275;
	Sun, 12 Apr 2026 12:29:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 12 Apr 2026 12:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776011368;
	 x=1776097768; bh=wU7xx4y42EqftV+K9QOvqUvU2b/Vk9fw+6/QZjqjueM=; b=
	ISMQQS1PBMY9rVEMYQLixDDKvLIGh0PsctpdnhhUyedmY6FO6ERYafFB42DYtnvF
	4VFHf+4cP1Qh3xawJJmVOtEj6YYJVJmeW4SHXqxUeJKroI9EV3l4ZwcRptY1rEm1
	2talhFvCEf2KmdeqUlo839xuUCT2/n1CSecBcTfm7xNn7B8QCrMGtJzC4zrcBDKg
	aqkKalRODYsLhjo7BbfZGxb5or0Bv5rzD2Hc1BlZfhMC3VEufcmnDh19WOqdkt3b
	bxw/skA9aOUF1O4y2t5eHY5mmZcEX+6jfS5rrmE2tIuO3ohlXxyirqUU1Tluhba/
	/syNjzvEwXbPliz6mSCILw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776011368; x=
	1776097768; bh=wU7xx4y42EqftV+K9QOvqUvU2b/Vk9fw+6/QZjqjueM=; b=L
	eDOI44yaG47XsQHgo/zW3ds4SepAV/KrrNUff4uhckShNJmNTUB+5gLGpNYcL+W9
	LirDkiklrVj8QEyYTKN3vltnnnfKuFYEtYRFGR0g9bp7Ceh945nNAeYJVLED8K9S
	Vl1YTMj5r8JOo5mwequxUMErd5BW0ZiWKDWObVNB5Xmokue/exPtlTojGjcMIMk5
	WgmlJAPNoZOLd1GUjFXk8PIY6gZ10n7osZ27qLvA7rOdFIGCbCv/bmKWcRUoIvk6
	0uhFfPf1tErC9SaAEzHGwBT6V4Qix3YHSTjLoy3+qb4fdU5ZipSYIrIzFdgYvRvl
	YdRBSI/Hax1thAkhpA2Bw==
X-ME-Sender: <xms:Z8jbaXesUfiCEi8ku9FVjBoScbVMbdi9PAbW8WqfZ7JhDqZam6Al_Q>
    <xme:Z8jbaSy4IP_Rf6NpkaPDoPGA8__vCK7dZMQCus3HEgIZfG2ZC5qpBcZu5C86lhcGc
    Bjucs_n_ZYSQ8BM3XzXjEonbEoueK_EnnnMY2_Gb71vBMwsA_Aovs8>
X-ME-Received: <xmr:Z8jbaaF6Rwu4QaEm_bjiiksFrpuvMGl084_xAr9uuc5M529l9F1wzcb5oZUA0QPjTcu_ka9OBq4un4LGyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefheejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
    evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepsghrrghunhgvrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepjh
    grnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgvfhhfgihusehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehuthhilhhithihvghmrghljeejsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmhhhi
    rhgrmhgrtheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Z8jbaZ0ajo9BbkliiflQfuCaz4fEPc-ZZ8hUuTy76MXYv7D6H2BezQ>
    <xmx:Z8jbaa9-IvCZGB1TaLQ64lhffDON0SMN_ccwL_8Tf-7F8PKhGksRlA>
    <xmx:Z8jbaUF2O5nJW1ffiII7TfSak7KfqBfndY33f6fOYVjBTDFu4qqHSQ>
    <xmx:Z8jbaYj9etyeGzFDBLCbnPguFqzjH23J-dXOQsnj4Ap92kTCD84oEA>
    <xmx:aMjbackfNn6uWAGtq5xfGIhw9Us7NLf-RSKN4FJfJPZSjAAYwlY0-iZn>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Apr 2026 12:29:25 -0400 (EDT)
Message-ID: <0e6fe895-9c3e-443d-a928-35640ba8c184@maowtm.org>
Date: Sun, 12 Apr 2026 17:29:24 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] landlock: Prepare ruleset and domain type split
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>,
 Justin Suess <utilityemal77@gmail.com>, Kees Cook <kees@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260406143717.1815792-1-mic@digikod.net>
 <20260406143717.1815792-2-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260406143717.1815792-2-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/6/26 15:36, Mickaël Salaün wrote:
> [...]

Hi Mickaël,

I like this approach, as I basically ended up doing similar refactoring
previously for the hashtable / array-based domain changes, and having this
done first should make it easier to adopt the domain data structure
changes in the future.

I assume it's fine for me to add:
Reviewed-by: Tingmao Wang <m@maowtm.org>

> @@ -175,19 +163,24 @@ static void free_rule(struct landlock_rule *const rule,
>  
>  static void build_check_ruleset(void)
>  {
> -	const struct landlock_ruleset ruleset = {
> +	const struct landlock_rules rules = {
>  		.num_rules = ~0,
> +	};
> +	const struct landlock_ruleset ruleset = {
>  		.num_layers = ~0,
>  	};
>  
> -	BUILD_BUG_ON(ruleset.num_rules < LANDLOCK_MAX_NUM_RULES);
> +	BUILD_BUG_ON(rules.num_rules < LANDLOCK_MAX_NUM_RULES);
>  	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
>  }
>  
>  /**
> - * insert_rule - Create and insert a rule in a ruleset
> + * insert_rule - Create and insert a rule in a rule set
                                                  ^^^^^^^^

Should this be rule storage to be consistent with the next 2 lines?

Alternatively maybe we can just say "struct landlock_rules" to avoid
inventing new names?

>   *
> - * @ruleset: The ruleset to be updated.
> + * @rules: The rule storage to be updated.  The caller is responsible for
> + *         any required locking.  For rulesets, this means holding
> + *         landlock_ruleset.lock.  For domains under construction, no lock is
> + *         needed because the domain is not yet visible to other tasks.
>   * @id: The ID to build the new rule with.  The underlying kernel object, if
>   *      any, must be held by the caller.
>   * @layers: One or multiple layers to be copied into the new rule.
