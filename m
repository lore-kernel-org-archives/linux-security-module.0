Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981C17A305
	for <linux-security-module@vger.kernel.org>; Sun, 21 Sep 2025 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758498745; cv=none; b=Ytbe0h+s29S7q+uety32Kowq9aicVPMGluoJxEK0hD9rISv+0tdBK5SbidGju6k9368XwRVRclOZO76fAHRaor+5MwYm7V26Nzp4Ek02xMEnl4UuzQ2yd3Y1K/q1IjlAhLFIJD0Eep1SBkBMrMN68rSzfDwaCOnGzvSym0m5vR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758498745; c=relaxed/simple;
	bh=3yAuicTkwd4iWvfIHwra6bjZUfqtVsAtIVgU3fUZf4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5OumyEpFk5BvDtmZI7MWKB0OeJrKtEt/EPMIIwuL8JBGNkB6JO2tp1T60QVZMSO144u7ZgPDLnMqFQ6IHA8seTv4hvdNIW147g+Cc9MJoWkmsnat2wqEfivM45JNfREcnwVtKe1jOW2slOI5Zu3I9t/0NVjeua9r+EMwk4q56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=hiRjJZmA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mLxE8GsU; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="hiRjJZmA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLxE8GsU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C15141400067;
	Sun, 21 Sep 2025 19:52:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 21 Sep 2025 19:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758498741;
	 x=1758585141; bh=oGiBztFPcZ99HVcDaWV34B7aUW5LY11IX0u+BlT0KhU=; b=
	hiRjJZmALNmo2LWsOwz7VR/29T8CvtkGORo75fvkTi9S8A0GvR7gjmEDEYMM8H9R
	1Muv4mIwPqgjieu5A9kYEgk0f0Wtbr66YTVFbu3hw5ygtk2A3TRqoqtzGdiZTchf
	jNYY/hIu/72E2cPUEX47SybfkYwV2qbWeNV6mkLShNLUie2LCENAQhZjpw6K90il
	y1vL07A+YdDW+9F+hiWUNucLJNXkE/Qcdwmv1XzeyGcbDU7S6W7FRDi25I1fCK8Z
	GagEICRXy74MGN88w+ZrClvCCc9Ic7P6zv632bGhZhOGp1ndW/56inRzQXbADqaA
	y2vkwbv/Oe89CEBN1K4JFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758498741; x=
	1758585141; bh=oGiBztFPcZ99HVcDaWV34B7aUW5LY11IX0u+BlT0KhU=; b=m
	LxE8GsUAEvqONl41ajH5W6hgesOt4nzcINpp487pSNj/pAr1tuvhSts2IgFWveZO
	SGrtBk8uD/z62paOx8Ve95vSAdY51dvovesPmxyeM0mlWdQtbgrwPCVcBw+UoXv3
	cbUhVk09XH6YpglLfK2dEMugKS7bqAAV7SSLmFKWVGY4z+kJYMUHoVkHD6cZdMdA
	v/DvWfaHElJowNzTLh2447k3OuXQFIXz/+z7+V5quVe9/yzzh20fd7s+uY1nNjgB
	/U2NNn/eyytukEOMDqkWl/BEBGLX9OvZW2PEk1AzRb0G71HYlwU2NduYvwbvNs0J
	ftBgrT2WISw0JfP8G4nbA==
X-ME-Sender: <xms:tY_QaJxHqXNbswWA0HTfZ-doR2j111VfhlTYm4YV_0f3mihTK6ZaOQ>
    <xme:tY_QaD2zIw_S3wnJ7oA7L3N9ehqfLScswGKrWVgT3MV9OY3F37C9XzJLPbuk26L8f
    8-r6BYUunBFNzaIBVU>
X-ME-Received: <xmr:tY_QaP4smICUUYjfYp0ck7SsGup9AdzT6VOjbrmc7MkIeZQGHC26UK84iYEQv7OhH9cAsURubSEFzPx3gvXmakPC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehieefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
    evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohep
    lhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:tY_QaOWRoOSiqJW6k3qI_f0b76rQJ9NWvPohw2vXKWFGEh5dzVStsA>
    <xmx:tY_QaGAqJP8MXsE4dzPuaNSAX6OWuxwnWcTH_6gHIW8a8LnuwgLdxA>
    <xmx:tY_QaF5e4_ge-kPlKSwt1Xn4UF32bSqgd0x05acoiUgRrBPZebHxFQ>
    <xmx:tY_QaJyIbN2v1AFJ-OkUvmaLEvn7bNz8apJGgf9rvMUYBKVTysTKzw>
    <xmx:tY_QaLIW_7S_A9YxtaGeSpEukEEm-5Hx9LZyy2LdGTESh8lDecmFq1Zh>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Sep 2025 19:52:20 -0400 (EDT)
Message-ID: <a43a9985-cf62-482b-9a2d-fce463ca69b0@maowtm.org>
Date: Mon, 22 Sep 2025 00:52:19 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] landlock: Add a place for flags to layer rules
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
References: <cover.1757376311.git.m@maowtm.org>
 <841550c5d7bbc7ffcd74f85ee659caf1e29cff67.1757376311.git.m@maowtm.org>
 <20250919.oanahnoon2Za@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250919.oanahnoon2Za@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/19/25 17:02, Mickaël Salaün wrote:
> On Tue, Sep 09, 2025 at 01:06:35AM +0100, Tingmao Wang wrote:
>> To avoid unnecessarily increasing the size of struct landlock_layer, we
>> make the layer level a u8 and use the space to store the flags struct.
>>
>> Signed-off-by: Tingmao Wang <m@maowtm.org>
>> ---
>>  security/landlock/fs.c      | 75 ++++++++++++++++++++++++-------------
>>  security/landlock/net.c     |  3 +-
>>  security/landlock/ruleset.c |  9 ++++-
>>  security/landlock/ruleset.h | 27 ++++++++++++-
>>  4 files changed, 83 insertions(+), 31 deletions(-)
>>
>> [...]
>> @@ -643,6 +644,12 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
>>  		unsigned long access_bit;
>>  		bool is_empty;
>>  
>> +		if (rule_flags) {
>> +			/* Collect rule flags for each layer */
>> +			if (layer->flags.quiet)
>> +				rule_flags->quiet_masks |= layer_bit;
> 
> This patch makes quiet flags related to on object, but not tied to the
> rule access rights (as explained in the next patch's doc). To tie it to
> rule access rights would require to duplicate the access bits for each
> rule (because multiple rules can be tied to the same object for the same
> layer/ruleset).

(imo the use of "rule" here as a terminology is a bit confusing, I would
have thought that a "rule" is a collection of access rights associated
with an object, and therefore you can of course only have one rule per
object in a ruleset.  Otherwise landlock_add_rule should really have been
called landlock_add_rules...?)

> 
> So, the question is, what do we really need to mute?
> 
> I think the current approach is enough. We could still add a new flag in
> the future, or maybe even a new field to each rule type.  However, we
> should rename the flag to make it clear that the it's related to the
> rule's object which is muted instead of the whole rule.  Maybe something
> like LANDLOCK_ADD_RULE_QUIET_OBJECT?

I don't see what benefit a new field to each rule type would bring, since
different rule types targets different objects and live in different
rbtrees, and so they are already separable.

> 
> If we want to have a more fine-grained control, a complementary patch
> could add a bitfield for each access right type to quiet a denied access
> right iff the object is also quiet (where rules are possible).  That
> could be a follow up to complete this quiet feature, but this patch
> series is good on its own.

Worth noting that if one really wants to suppress logging for only some
access bits and we do not add support for it (due to the extra overhead
etc), that is still doable with just this patch by using two layers - the
outer one would contain the intended rules but not have any quiet flags,
whereas the inner one would contain the same set of rules but with quiet
flags set, except that for access bits which the sandbox does not want to
be quiet, it would also "allow" them in the second layer (access would
still be denied by the first layer, but would get audit logged due to
quiet flag not applying when the younger layer allows the access).

But this gets very tricky in the context of mutable domains, and does not
work at all for the purpose of controlling whether supervisor mode would
delegate to the supervisor or deny outright, since supervisors are
"accumulative".  Therefore if this (different "quietness" for different
access bits) becomes a strong need, we should probably consider some way
of implementing it, rather than expecting a sandboxer to do this two-layer
hack.  (But implementing this does have the potential to result in needing
to have a (number of access bits) x (number of layers) matrix...)

> [...]

Will add suggested changes in v2.  Thanks for the review :)

Kind regards,
Tingmao
