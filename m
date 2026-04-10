Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6751A6815;
	Fri, 10 Apr 2026 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775785522; cv=none; b=hkU5LsRRnsJHQic9g2/8pVO+HOC3Cvl+LmpyZqfn7QUGPzqTrvAPj3muojvyR9bOrq93x8EeIe9BmOHQBOcC+s7dOuHXn5UfgmoPHMxpQsgjAlple3c1SvscCkD1gXEqn0mQH8xYrKDxaqiOyEuzqroI2MRiDCsSNtjsz+hiSu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775785522; c=relaxed/simple;
	bh=8VVUWQGEGifaqJReexCkt2AKzYWDDKFANds7lGlG4RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8LHT9PIPA5dpZgX2+z5QVJsRhGSnOh14D+tsn043rt/anusAdYpq8bGO5bKHK35ILLHmbNdlHnhmAMp3JXMAIVK1GTbBXewqDqhSOL3Bp8ovE+R9PyxQcvf3QkDSt01b8co5dMRnNIIJ6VYBShCqQASZkXhiq5SdtrHDAAMkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=AU0b3bo1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OcducM9K; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="AU0b3bo1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OcducM9K"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0B8E77A013F;
	Thu,  9 Apr 2026 21:45:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 09 Apr 2026 21:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775785519;
	 x=1775871919; bh=La4sgp0twI/Z8VHj4g27zpkjaszDSqH9NsPs0IRew3s=; b=
	AU0b3bo1VNmapRTRCOLG2LtOoxXjCFd2LoCH3mwpN0+AJRsWGO/soiS96ctSQdYi
	HM6XYi451iuyHROdAstETCnsHPKcyWEW/bylGijWuNhBrjwSW3Hi84ueGqP7Tamx
	4swS2SI0sakwH3PUYSuQ64OZJYZ8FOhnAO2JIBc4ZTvLyAF7DS3wD9Jp50w8OzZG
	p01oZANoA9VTWyYtdTYTgnh7CIRHnq6v4WZBuEPtCcl9F715XuqW0whpsQlUlcCS
	7G5FDe/Y5SgSQCk1GHloqpp0lzp3pCA7MZ1C5qjuAbWjr5ocWMC17O4Lgb0DZqfg
	n7+9upiZdUJA7gDm7rUDjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775785519; x=
	1775871919; bh=La4sgp0twI/Z8VHj4g27zpkjaszDSqH9NsPs0IRew3s=; b=O
	cducM9K8neH8+52uA1PEdEqlc0Y/unYOlTQeMDo7nntgom7g8FX5rudEFFvLDjRV
	kIP1cgPIdneTisa4rgGZD8n7n2trSkPBdeOAL74tfo0/OjGVSNdLyeXcP8HyO93Y
	Lfhxgc5UT+ccLQIIV1SB5nEb34mWLyxxcQ5DzQYldYvP3zAZrQNqS3USlceL/6j+
	yuN6yV7cdsgltKTvRxukiG/iCb44aS6LxxoznhUuyyueozSGwEeHmhSgE6HZxV19
	uALNqyB4N3YfFSCXixpHlstzCzvFds2ybrxJZH4yn7ovum0QtxGocDHP16o1yUaZ
	AZV803lMdzdd604biHdNA==
X-ME-Sender: <xms:L1bYaWgiF7YEhEqF77UrC8wF57UtGN0tKIwVaq6LmJz92rJV7GNhQQ>
    <xme:L1bYaRYr2L9SBBlQiTQwtWSx8uhU5LjLDmQ2nkzP4jM8Tvh3UBpwh5HoLZxOJCROV
    vCtDDms6ouklMNurh7FUuPAjceNnjPmubJKqsQoXnJemN6zKZ4XOA>
X-ME-Received: <xmr:L1bYaUO8zl60vRPaRiqtVqxe3EiqWrKPR-sneS16ReumpSECxApqOlRJjFVpPTMU-TmJLb35r5hDUee4cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvkedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenufhusg
    hsthcuvhgrrhhsucdlhedtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredt
    tddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorh
    hgqeenucggtffrrghtthgvrhhnpedukeevhfegvedvveeihedvvdeghfeglefgudegfeet
    vdekiefgledtheeggefhgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepudegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpd
    hrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegsrhgr
    uhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhesphgruhhlqdhmoh
    horhgvrdgtohhmpdhrtghpthhtohepshgvrhhgvgeshhgrlhhlhihnrdgtohhmpdhrtghp
    thhtohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhope
    hlvghnnhgrrhhtsehpohgvthhtvghrihhnghdrnhgvthdprhgtphhtthhopehivhgrnhho
    vhdrmhhikhhhrghilhdusehhuhgrfigvihdqphgrrhhtnhgvrhhsrdgtohhmpdhrtghpth
    htohepnhhitgholhgrshdrsghouhgthhhinhgvthesohhsshdrtgihsggvrhdrghhouhhv
    rdhfrh
X-ME-Proxy: <xmx:L1bYaaZ-Vd6bMCY1PgfNSqZ_vllFw4VVj63VpiKhYWC8d-0FfL4zJw>
    <xmx:L1bYacUVY8OxXhe7FluLDDdzOVODPkMRvb5vmisdfHXdQD1lIs7hTg>
    <xmx:L1bYaRC2BVKY2RMDFYbJUwm3mb_W0eQQ2_ASYPdeqU4zZ9xAv91rxg>
    <xmx:L1bYaQJVpCUPz6QU0uH6z7ztOgA9uQAQbayiQssDM6xvq0fLi0wEKA>
    <xmx:L1bYaWCuihG6MxWD1txi9WRfmQ4MBhcOA3ROuL2-MomnOQ4tCFl8TDpW>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 21:45:17 -0400 (EDT)
Message-ID: <1d197217-ab74-4caf-abca-7ae35a42fdc0@maowtm.org>
Date: Fri, 10 Apr 2026 02:45:16 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 05/11] landlock: Enforce namespace entry
 restrictions
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>,
 "Serge E . Hallyn" <serge@hallyn.com>, Justin Suess
 <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Shervin Oloumi <enlightened@google.com>, kernel-team@cloudflare.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-6-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260312100444.2609563-6-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/12/26 10:04, Mickaël Salaün wrote:
> [...]
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f88fa1f68b77..b76e656241df 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -51,6 +51,14 @@ struct landlock_ruleset_attr {
>  	 * resources (e.g. IPCs).
>  	 */
>  	__u64 scoped;
> +	/**
> +	 * @handled_perm: Bitmask of permissions (cf. `Permission flags`_)
> +	 * that this ruleset handles.  Each permission controls a broad
> +	 * operation enforced at a kernel chokepoint: all instances of
> +	 * that operation are denied unless explicitly allowed by a rule.
> +	 * See Documentation/security/landlock.rst for the rationale.
> +	 */
> +	__u64 handled_perm;
>  };
>  
>  /**
> @@ -153,6 +161,11 @@ enum landlock_rule_type {
>  	 * landlock_net_port_attr .
>  	 */
>  	LANDLOCK_RULE_NET_PORT,
> +	/**
> +	 * @LANDLOCK_RULE_NAMESPACE: Type of a &struct
> +	 * landlock_namespace_attr .
> +	 */
> +	LANDLOCK_RULE_NAMESPACE,
>  };
>  
>  /**
> @@ -206,6 +219,24 @@ struct landlock_net_port_attr {
>  	__u64 port;
>  };
>  
> +/**
> + * struct landlock_namespace_attr - Namespace type definition
> + *
> + * Argument of sys_landlock_add_rule() with %LANDLOCK_RULE_NAMESPACE.
> + */
> +struct landlock_namespace_attr {
> +	/**
> +	 * @allowed_perm: Must be set to %LANDLOCK_PERM_NAMESPACE_ENTER.
> +	 */
> +	__u64 allowed_perm;
> +	/**
> +	 * @namespace_types: Bitmask of namespace types (``CLONE_NEW*`` flags)
> +	 * that should be allowed to be entered under this rule.  Unknown bits
> +	 * are silently ignored for forward compatibility.
> +	 */
> +	__u64 namespace_types;
> +};
> +
>  /**
>   * DOC: fs_access
>   *

This UAPI looks good, follows existing patterns and is extensible.

btw, I guess for consistency, later on this new handled_perm should also
have a quiet_perm, which would allow suppressing audit logs for namespace
/ capability rules (for those (possibly a subset) added with
LANDLOCK_ADD_RULE_QUIET)?

> [...]
> @@ -153,6 +153,48 @@ landlock_get_applicable_subject(const struct cred *const cred,
>  	return NULL;
>  }
>  
> +/**
> + * landlock_perm_is_denied - Check if a permission bitmask request is denied
> + *
> + * @domain: The enforced domain.
> + * @perm_bit: The LANDLOCK_PERM_* flag to check.
> + * @request_value: Compact bitmask to look for (e.g. result of
> + *                 ``landlock_ns_type_to_bit(CLONE_NEWNET)``).
> + *
> + * Iterate from the youngest layer to the oldest.  For each layer that

How about this:

/**
 * landlock_perm_is_denied - Check if a permission request is denied
 *
 * @domain: The enforced domain.
 * @perm_bit: The LANDLOCK_PERM_* flag to check.
 * @request_value: Compact bitmask to look for (e.g. result of
 *                 ``landlock_ns_type_to_bit(CLONE_NEWNET)``).
 *                 Must have only bit set.
 *
 * Iterate from the youngest layer to the oldest.  For each layer that

Basically, to make it more obvious that this functions only checks one
bit.  Currently if a combination of permission bits are passed, this
allows access if any of them are allowed, which if accidentally used this
way in the future will probably be a bug.  I was considering a
WARN_ON_ONCE but maybe it's a bit unnecessary for now given the caller
always passes a landlock_*_to_bit result (and those already WARN_ON_ONCE
if given invalid parameter).

Reviewed-by: Tingmao Wang <m@maowtm.org>
