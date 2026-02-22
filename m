Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5A495E5
	for <linux-security-module@vger.kernel.org>; Sun, 22 Feb 2026 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771783486; cv=none; b=kXHvCt34teRoVxw0LnER3GDDmscIviU1ElLEdJw74lEmz0NVmDvgdBX9pPyIM4mBMlcMWKwjnRfjTPY25SVAVSuzWDkLPM4HsS6yJpna28c4LrfhCTIBfI47+AYbRm/agq4VQB1wub45XzuR3TX2pc9Wzgu8Y3vOYINpkSiHCLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771783486; c=relaxed/simple;
	bh=U5K4NUQh2EQKgYttx9n1/7BI0sdw9wnNTyI3AHRe9OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJAfIs5QETusqoKImnIzxlac0bxJFtuLaJt51woroF0JyASnSPZbH1ZsQXW7YGftX4PDkLNL/D0QY2lJsvasWLNisGlzl2BkP6KJZ/JqtQsWYEpqi5wKbl9cc7yIepYdHPcgE4+n5b8xz3ld43vW4uoyF1ogdR4GudHznKPaHiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=xL31TgjI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TEl+sTL8; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="xL31TgjI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TEl+sTL8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8AB7A1D00056;
	Sun, 22 Feb 2026 13:04:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 22 Feb 2026 13:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771783483;
	 x=1771869883; bh=xnKYmSqqVmv9C4wgrKOk4DgYFPMHt3BaSAo6sZpwu+8=; b=
	xL31TgjIeASSTjbXx1n7nlaZu0Cy+DA7lP4Gpbiy6N5lShSmmIFEot46aC7WkLkS
	+oPb3ggzVyGXTtycelxn5CsqQ5MRPqGSu49/NfArCbKvVwN6FGOMBsT4F4pPtJYT
	hsW1vhiLS3FarrfuM9eybwZ4ibQ47p4fTsdQ+1aFu54jf/dE6MPmSn+64hnfpvnD
	pwiEBSqQLPxl49+CLs3rlSn4oIwWxS5rjh9XUzm+7XyLDrLWJHtyg8qSEA3eowYO
	KR9Jckl1Bghrqwk96ujgJvzrHuQ3VRj06UgGmxyc2MLOLuplnWEn7FNWJN9DIiwz
	7PRhcntpaO8sqOdWpIOKIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771783483; x=
	1771869883; bh=xnKYmSqqVmv9C4wgrKOk4DgYFPMHt3BaSAo6sZpwu+8=; b=T
	El+sTL8vUD7DkLynbVjeIEftbkC6QO6JvigzQedw0ybXjS/EShkYhfPi2a37Pvhz
	viSZOHqjl3ko7PauhrpCCq/KKvW7g2G5MqnGFwcYIDRGMd/fKbTN1/bblxGraFdW
	Fiv7HfhTpR/9UkGfArmZYnHx1RKOETnyDq5zDu4K/JQVQMU3cwSSxuzauTxDK/A7
	h18bpY2VkDjMltT9DR6Ign5fJ+dWFMO3NXWvldsJRgy18/RxIi/AIg5tQDV++Smw
	1ulNzYA7sPFLH0jnYBtg9F1/BSj5xU2Tvf0ujBqeykAMVyffJYPOfhrNcSS4mtb8
	QY4zVciUCfdobYgbcY8WA==
X-ME-Sender: <xms:OkWbafsAUiKx2sC_XL2-3RWpqeDcb44EO7Ci1WHwFPvRQJ8wtwRArw>
    <xme:OkWbaQ6j0ewGdVQeXmKOyOr_85U5qIDM229BAv4bSbuDWz1jbx5UvsanzsqloIeqr
    ivuikBQmOGfVMGTDiim7Oqgh-Q6UNIHs4N2BCTtyP0cGt39NDp5mf4>
X-ME-Received: <xmr:OkWbaTf9r2tjpBmh-BHGzT2enDw-BatJ1TLdQxtyWwnQ9mfzSsk-KQEE7McK_Dwb0gmK7AkHFeldrrFMVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepff
    fhhfegueejkeefhffffeetieejffevtedutefhhfejjeegleeuieejfffggedunecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhtihhlihhthigvmhgrlhejje
    esghhmrghilhdrtghomhdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopegrmhhirh
    ejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidp
    rhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuh
    igqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgvnhhguhhinhdqkhgvrhhnvghlsehiqdhlohhvvgdrshgrkhhurhgrrd
    hnvgdrjhhppdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OkWbaVwh7o-tAkZlLYTQcg8ajSCKBlV7R1wius8Dq3AY4d8w9LqpOQ>
    <xmx:OkWbaQ8V0zZ5h2qsma0nCD8bZUKrLdhlnhHxOXlJcy54xAAPJUXe_A>
    <xmx:OkWbabxyFJkYays0Q5GspBz9QUoB1shPeo7fLxB0i6f9NCDXu4e2BQ>
    <xmx:OkWbaQqaN7ZCRXb6kj_cdQz2K-Lh4Kyta4fUepVby06GJ8JdF2Kc1Q>
    <xmx:O0WbaXfXfDQg8Cv6PoCr39PIH-D5pRgBkYOu3bPWopT_sMw2iQep3fjx>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 13:04:41 -0500 (EST)
Message-ID: <33a898dc-20ae-4984-a03b-b3b4e5039cde@maowtm.org>
Date: Sun, 22 Feb 2026 18:04:39 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Landlock: mutable domains (and supervisor notification uAPI
 options)
To: Justin Suess <utilityemal77@gmail.com>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: amir73il@gmail.com, jack@suse.cz, jannh@google.com,
 linux-security-module@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
 song@kernel.org
References: <6981cdab-dcff-47fc-a236-1890f9bc9c55@maowtm.org>
 <20260215212353.3549464-1-utilityemal77@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260215212353.3549464-1-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/15/26 21:23, Justin Suess wrote:
> On Sun, Feb 15, 2026 at 02:54:08AM +0000, Tingmao Wang wrote:
> [...]
>> Discussion on LANDLOCK_ADD_RULE_INTERSECT
>> -----------------------------------------
>>
>> This was initially proposed by Mickaël, although now after writing some
>> example code against it [7], I'm not 100% sure that it is the most useful
>> uAPI.  For a supervisor based on some sort of config file, it already has
>> to track which rules are added to know what to remove, and thus I feel
>> that it would be easier (both to use and to implement) to have an API that
>> simply "replaces" a rule, rather than do a bitwise AND on the access.
>>
> Instead of intersection being done at the rule level via
> landlock_add_rule, would it be better for intersection to be done at the
> ruleset_fd/ruleset level?
>
> So instead of intersecting individual rules, you can intersect entire
> rulesets, with the added benefit of being able to intersect handled
> accesses as well. (so you could handle an access initially, and not
> handle it later).

Personally I don't think making the list of handled accesses mutable would
add a lot of value (after all, a sandbox would usually handle all accesses
that it knows of), and I would like to avoid the complexity of making the
list of handled accesses mutable.  The semantic of "intersection" and
"union" of handled accesses is also not trivial: if ruleset A handles
read, and ruleset B handles read+write, their "intersection", if
interpreted as "only allow accesses allowed by both rulesets", would in
fact handle read+write (and their "union" would handle read only).

In the second (union) case, there is also the problem of what to do if
ruleset B has write access rules - these rules would technically become
invalid (although to no negative effect) in a ruleset that doesn't handle
write.

I do see the benefit of modifying scope bits (and maybe also
quiet_access_* bits), but I'm still worried about the extra complexity
(and thus also testing / docs needed etc)

>
> Intersecting at the ruleset level allows for grouping the intersection rules
> together, so you could create an unenforced ruleset for the sole purpose
> of intersecting with rulesets, and intersect all the rule(s) at once.
>
> That way, the ruleset fd can be reused for this purpose later with other
> supervisees, instead of creating ruleset, intersecting individual rules,
> repeat.
>
> I think also the semantics of having a function called
> "landlock_add_rule" actually removing accesses (when the intersect flag
> is added) is also confusing, because we're not really *add*-ing
> anything, we're removing.
>
> ALTERNATIVE #1
>
> Maybe the best way to do it is instead continue treating rulesets as
> immutable, but allow composition of them at ruleset creation time.
>
> This would look something like:
>
> Ruleset C = Ruleset A & Ruleset B
>
> Ruleset A and B are never modified, but instead a new Ruleset C is
> created that is the intersection of A and B. This could be done in a
> variety of ways (LANDLOCK_CREATE_RULESET_INTERSECT? new IOCTL?)
>
> An example API for what this might look like:
>
>   struct landlock_ruleset_attr ruleset_attr = {
>           // other fields for handled accesses must be blank.
>           .left_fd = existing_fd,
>           .right_fd = other_existing_fd,
>   };
>   int new_ruleset_fd = syscall(SYS_landlock_create_ruleset, &ruleset_attr,
>     sizeof(ruleset_attr), LANDLOCK_CREATE_RULESET_INTERSECT);
>
> And then the resulting ruleset which is the intersection of existing_fd
> and other_existing_fd could be returned.
>
> Similarly, we could:
>
>   int new_ruleset_fd = syscall(SYS_landlock_create_ruleset, &ruleset_attr,
>       sizeof(ruleset_attr), LANDLOCK_CREATE_RULESET_UNION);

If we do keep with the "intersect" way of removing rules (instead of
replace / clear all), this does seem like an interesting idea.  However,
it is more complex to implement (it will probably require traversing two
rbtrees at once to be implemented efficiently), and I'm not sure how much
utility this would add compared to just LANDLOCK_ADD_RULE_INTERSECT.  See
below for more reasoning.

>
> Which would be convienent for creating unions of rulesets.
>
> Then instead mutating rulesets, we commit/replace an entirely new ruleset.
>
> ioctl(supervisee_fd, LANDLOCK_IOCTL_COMMIT_RULESET, &new_ruleset_fd);

Using a dedicated ioctl to commit is also a potentially better idea - I
find that having the commit be a side effect of landlock_add_rule() via a
flag a bit unwieldy, as it would either require the supervisor to track
when it adds the last rule, or to add an "empty" rule just to commit.

Mickaël, you initially suggested the LANDLOCK_ADD_RULE_COMMIT_SUPERVISOR
flag, but do you think this is better?

>
> This has the following benefits:
>
> 1. Clearer semantics: "landlock_add_rule" is just for adding rules, not
> removing.
>
> 2. Intersection of all ruleset attributes, not just individual rule
> attributes.
>
> 3. Better logical grouping of rules for the purpose of intersection, and
> better composition.
>
> It does have drawbacks:
>
> 1. Intersecting individual rules requires making an entire ruleset for
> that one rule.
>
> 2. Users must be responsible for closing the unused/old rulesets that
> they might not longer need.
>
> ALTERNATIVE #2
>
> A middle ground is to keep the ruleset mutation via landlock_add_rule,
> but have it be done at the ruleset_fd level.
>
> Something like this:
>
>   struct landlock_ruleset_operand intersection = {
>     .operand = other_ruleset_fd
>   };
>   landlock_add_rule(ruleset_fd, LANDLOCK_RULE_INTERSECT_RULESET, &intersection, 0))
>
> I think this is also a valid way to do things, and increases the
> reusibility of rulesets.
>
> 1. Again, having landlock_add_rule being used to actually remove rules
> is confusing.

In this case, wouldn't we also be removing rules via landlock_add_rule()?
Personally I feel like this inconsistency is tolerable (it's easy enough
to explain), but I guess we could also change this to an ioctl if this is
a problem.

>
> 2. I'm unsure if we can change handled accesses after ruleset creation,
> so we might not be able to intersect the handled accesses like we can in
> the ALTERNATIVE #1.
>
>> Another alternative is to simply have a "clear all rules in this ruleset"
>> flag.  This allows the supervisor to not have to track what is already
>> allowed - if it reloads the config file, it can simply clear the ruleset,
>> re-add all rules based on the config, then commit it.  Although I worry
>> that this might make implementing some other use cases more difficult.
>
> At a minimum, it is cumbersome, and I worry about file descriptors
> becoming inaccessible (due to bind mounts / namespace changes in the
> supervisor's environment).
>
> Of course they can just hold those file descriptors open for the purposes
> of future intersections, but this is annoying and error prone.

If a supervisor doesn't care about potential renames / mount / namespace
changes making the sandboxed application lose access to previously
accessible files, the "clear all rules" approach would not force it to
keep any fds open in order to remove rules (i.e. it can clear everything,
then re-open the fds to add the rules back).  On the other hand, with the
"intersect" approach, it would have to keep the fds open in all cases to
correctly remove previously added rules, so I think this "clear all" is
not more cumbersome.

There is a general consideration here about how much we want to design the
API to advantage / disadvantage particular ways of using it.  For example,
having ruleset-ruleset intersection / union operations would (in theory,
setting aside the fact that to remain compatible to older kernels it
cannot do this for constructions of existing static rulesets) work very
well for something like island [1] / landlock-config, where we compose
rulesets by intersecting / unioning different landlock configuration files
together.  However, it will introduce more complexity to someone who just
wants to allow access as they come up (e.g. something like a "permissive /
learning mode"), as they now have to, every time when an access is denied,
create a new ruleset, add one single rule, and do a union.

IMO, there is also the general preference of having complicated logic
being in user-space rather than implemented by the kernel.  In this case,
one can argue that for someone that wants to compose rulesets via logical
operations, this should really be handled by a Landlock library, which
could, for static rulesets, do it completely internally in-memory, and do
one landlock_create_ruleset() + n landlock_add_rule()s in the end.  For
live modifications, it could then use the more low-level "intersect" /
"add rule" / "clear all" uAPI.  Compared to intersecting single rules,
having the kernel do the logical operations on entire rulesets also
doesn't reduce the number of syscalls needed (you still need one
landlock_add_rule() for each rule to be modified), so there is not a
performance argument either

(although for the use case where the supervisor wants to incrementally add
and remove rules, there is a performance benefit to intersect vs "clear
all".  But I do wonder how often in practice this would be implemented for
a supervisor that can remove rules - because it needs to keep an in-memory
table for the fds it has open anyway, in order to correctly remove rules,
a simpler approach would be to simply clear all, then re-add whatever it
wants based on what it still has in that table).

[1]: https://github.com/landlock-lsm/island
