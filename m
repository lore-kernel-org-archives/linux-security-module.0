Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B94CF4F1;
	Sun, 12 Apr 2026 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776011279; cv=none; b=OJ7ik9Sry0136AfAmL08ZUG+N1STRPo0kRMIyeyup7IyK6H0We9ebHUuZsM8sw1jYyxX9SdkwKdO3yWFAQROpl0NzBrUYJc5M8fMajg9h8Prv0Rk78KinnYvkMIUQao3pit/WeL+Z7Abj0Jlcq4EKtKch8fbsGEQ+u/iVySZ7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776011279; c=relaxed/simple;
	bh=OpwoOxLcnMDQCVU/RHu5iwpItaucQdoTlJZBJ0oMpVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzkYKxnnvlvDeJqzBNAYqdjjxCK1nuheOvq41fAyrpEeKNs/Om9S3py1jHgdr9iH1e98i0c7E3y3h1fQANdAtLe/ksJGUNI+lGvKeFEESA5Us9Pse0eEPy0hWDmPGGODMjKUWHkL2J3ah/3ghEAtOR/vIHZnHdAmilYaaZyVr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=f6nuTFWm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RhwSn3qg; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="f6nuTFWm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RhwSn3qg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E8A257A0278;
	Sun, 12 Apr 2026 12:27:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 12 Apr 2026 12:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776011275;
	 x=1776097675; bh=JFcI1aAXqRNOoIOGiNBuFSHH+AnFP5VFrvO+zV0HEFM=; b=
	f6nuTFWmCTkmQVgbIdnO8vQeeZADALKFQLbKYso6b7sLXSvjrJ4ZRTOoDRnReK7g
	sIMtoV/4rwNiLP7eLPoeKscCG8UZj6NbavO2Ogi+f6rEdQg+AQTCuboAtvmdQ+xF
	rJqZGMEBdd9xifSIX6IoJkDrxLLrMFJX7suok2Lfe2QfF2BNZO+2ZpAhFMaEAwfH
	SJRuLAG8FVLsY1lH0kiF6OmJQbKE+tDOYCXIRj6TGtpI4gy2KDvsoeBQPorUBv0X
	br9Exof1TCk9IgwcKNkPvIqkWPPrsu6cd0kPTjqpFiFJO5OfeozizE7LWAibKhFj
	EvmQHbJYdtWmOqnlysoRdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776011275; x=
	1776097675; bh=JFcI1aAXqRNOoIOGiNBuFSHH+AnFP5VFrvO+zV0HEFM=; b=R
	hwSn3qg9ndUGaCvi75f5R+mf0Yfgh8f47XC87+VfHAfkCUTlhJEFhUU6Es/lppqn
	J0BhTo3YFLDkiIk5hT1nEAM4MjH3aGy9M9n2DbmecqNU8VkhwlVRI0/r+6dKb27e
	1uTkGicip9KmjIFQvcYGy/HHbyAEUDG13CIa7WdkinWzT3O8OMYxCxm7xP+D77Wm
	tvtLJi/uKjAGVupmjSnrpln6NIMgi8sQLBthuC/6sE5tP7WVxGIEPMIGHXsqiTqa
	NdVn2X/1QUc3zco8cT10HrfsCbAEnCpRt8S61OcFarbSzs+QspR/+FWeJAEyXRVk
	fmq2yvFmuDpfDEQ7vvtug==
X-ME-Sender: <xms:CsjbaX0J939HAS5zUeVq7B-p6HN6PCszX7oNc4nwjCN42SnuSL4tbQ>
    <xme:Csjbabq3pEdYiu5tfj4SzvJR8-TS9k-MSaacIZFyvJmwNZXwwAbTH_2QU6iUkCEz7
    Gnaa_7zH3boQrTQPiAhYMdCfCCNvGWweFgIjn3IMFLN-XR-mqglpA>
X-ME-Received: <xmr:CsjbaRfe_D35lJOPDgVi_Jmb6OAGJYrMi2ShqgCd2GalCUmDfTyNt349Cmx_fqHDCT2yRFJPkxJL1pAP2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefheejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
    evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepjh
    grnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgvfhhfgihusehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehuthhilhhithihvghmrghljeejsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmhhhi
    rhgrmhgrtheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Csjbadt37SJQTWwLIeSFuT_ZFngEvdUvdPJyokSztCbLvR_utJlO0w>
    <xmx:CsjbaRXmqhac2sZJOHovh5IiMWJZDyIh4N1jGHZvZt8oIqQenG9bkg>
    <xmx:Csjbaa8gPVR2p5CYxmBmkOtPA8_AsvxOHV2R6dRSiYJ3k0zu327k1g>
    <xmx:CsjbaV5it3wJoPCgm-qz3P1petXUQStRCRkkcS4eX4w-8qThKgwm1w>
    <xmx:C8jbaT-owS9aTivucahXq9gG_GoRTfFCpO_N_aUncfcEaU6DFpL6YXbD>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Apr 2026 12:27:52 -0400 (EDT)
Message-ID: <4e2adbc9-22df-45a1-b270-674bb9224bb7@maowtm.org>
Date: Sun, 12 Apr 2026 17:27:51 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/17] landlock: Split struct landlock_domain from
 struct landlock_ruleset
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@google.com>, Justin Suess <utilityemal77@gmail.com>,
 Kees Cook <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260406143717.1815792-1-mic@digikod.net>
 <20260406143717.1815792-4-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260406143717.1815792-4-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/6/26 15:37, Mickaël Salaün wrote:
> [...]
> @@ -197,10 +179,10 @@ static void build_check_ruleset(void)
>   *
>   * Return: 0 on success, -errno on failure.
>   */
> -static int insert_rule(struct landlock_rules *const rules,
> -		       const struct landlock_id id,
> -		       const struct landlock_layer (*layers)[],
> -		       const size_t num_layers)
> +int landlock_rule_insert(struct landlock_rules *const rules,
> +			 const struct landlock_id id,
> +			 const struct landlock_layer (*layers)[],
> +			 const size_t num_layers)

Maybe this is slightly off topic, but previously I've found this function,
along with create_rule and merge_tree, to be quite confusing, because the
logic for three different use cases (creating a copy of an old domain,
merging a new layer into this domain, and inserting a new rule into an
unmerged ruleset) are mixed in the code, and personally now that I'm
reading it again I still find these functions to be hard to reason about.
Therefore, given that we're refactoring these areas, I think this might be
a good opportunity to rewrite them (while getting the necessary testing
for this rewrite "for free" as part of this whole domain refactor).

For example, for this snippet:

		/* Only a single-level layer should match an existing rule. */
		if (WARN_ON_ONCE(num_layers != 1))
			return -EINVAL;

Someone unfamiliar with how this function is being used by its caller may
not realize that the reason the comment is true is because the only use
case where we have multiple layers in @layers being passed into this
function is when we're copying an existing domain into a new domain, and
so we should never match something that already exists.

Also, further along in this function, there is this snippet:

		/*
		 * Intersects access rights when it is a merge between a
		 * ruleset and a domain.
		 */
		new_rule = create_rule(id, &this->layers, this->num_layers,
				       &(*layers)[0]);

I also found the comment to be confusing because it's not "intersect"ing
anything (it's adding a new layer to an existing rule in the domain when
the object pointed to by "id" exists already in the domain, and the
intersection is only a consequence of how Landlock works when there are
multiple layers).  This realization is made harder by the fact that a few
lines above we just OR'd the access rights (for modification of an
unmerged ruleset), and so it makes it sound like it's doing a similar
thing except with AND instead of OR.

I think it might make sense to have separate functions, even if they result in some slight code duplication, for use by:

1. Copying a domain: inherit_ruleset() -> inherit_tree() -> _____()
    RB tree search to find the insertion point + create_rule().  Maybe
    this logic could just be in inherit_tree() without creating a separate
    function?
2. Merging a rule into a domain: merge_ruleset() -> merge_tree() -> _____()
    insert_or_append_rule()?  RB tree search, call create_rule() to create
    a new rule with the new layer added, then either
    rb_link_node()+rb_insert_color() or rb_replace_node().

Neither functions above will contain any actual logical AND/OR.

3. Inserting a new rule into an unmerged ruleset: landlock_add_rule() -> ... -> _____()
    insert_or_update_rule()?  RB tree search, and either update the access
    rights of an existing rule in-place (as we currently do), or create a
    new rule if the search fails.

We could create a utility static function or macro for the shared RB tree
search code.

How does this sound?
