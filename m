Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30DB672
	for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779586187; cv=none; b=bCdr3jNnq72SBGoTU8pgh9zxF+XRlQwlDPtP+3ojciyDQySxVxEXiL37djY9A6X6U+paLRAMcC+nRT9EQ8DZkUcXLhg6gqgmb/ORVel0EC2rSNWvBiY2JDbdgKgIBWzLZVIse3Gv5jkrHfrKKeymNxjWrdRH/rqC+rzKAspKzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779586187; c=relaxed/simple;
	bh=W+2tOPmppuXu2cCCPZgUiMIPoqg2qCbrvpoHRl0MfRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmqOUxotTqzJbjcCFr5lgDJzEzk1JKWjbqOHJtJV1errJSc8G302k8u1d7YucvhWGlVuNp6J1lGfJZPcSAkjPlNI32zkMv5B5IfsrdYQY8vfK8i3FV6JdfB2R9PH++/ZcU0FQB5Nexljw+fXLp6tiL3h3+KwIw96QuGBF/UJcLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=5Dwvc7jF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HXyE8aZQ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="5Dwvc7jF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HXyE8aZQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F5141D00038;
	Sat, 23 May 2026 21:29:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 23 May 2026 21:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779586183;
	 x=1779672583; bh=7vd0Wb0X8p/SgXhFNnjUs8F/vIdYN8jcFWBTbqVU31c=; b=
	5Dwvc7jFLSZR9ZNZ4V1OBTPErVx87pk785jbyGgkb/8DBps+W3t775VWsLJW1geu
	46Amu15kVeKRRTjOurC56bhbij3lcFYp4WhWMIJ8LKshnAIbUqdEuRmUee+HJCPp
	kYygUk+AtE23IUklNz3FSF6hPnXdmi++AWYhQXTEBa/YHGakhY8H0ss+etINX9u1
	y60jUF62bG00xRgeBQxtGZ5r+LFbA8Lb55COWkwmpwW4ar8523uqeOGA63l8HoFl
	6Q4rsHXH3xEkL4UaxQ0SaNEuvcsIk0xXBF6WTGUepkjSb0UbCOtmZI0ijkyL6HkI
	w/L+qm/8rXXCM6luqnWQFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779586183; x=
	1779672583; bh=7vd0Wb0X8p/SgXhFNnjUs8F/vIdYN8jcFWBTbqVU31c=; b=H
	XyE8aZQTERy+eeKpz4QuhXRYyDCTGN3TvwL8v0ErAGf9pKA1YHATKmHlRESMsNqy
	Dzwj5cRztyAxYI/M57x5laSc+1TKMhyImlb4QahWklLFnAz0DNGWwasLeoTv1Kuv
	v2XSYTq9TjgCbewFxlMRkrSZ/cSAkf0ox3igtVfpCc2pxKfvMDtdT3+Cz/ItzulJ
	qYzd4+OcC0eyU8v7kGTku7iM3p4HZrWIZdQ3DgDh5dmVaxINo0rX51aCVRBHiHvZ
	k1NTkDcsXWUqvw3Be/4m7sRrdkuUBhYRn7r2b3OnuLlsm05y8PnUtrDAbGy5Chg9
	1luht0SVBo3GqmMU2iKsw==
X-ME-Sender: <xms:h1QSauEhApiqh96AZwHm7_B8zp0EE8YP5Lr2mRzZlv1q_59C2l8gUg>
    <xme:h1QSajDUNfSUiB-BHVeE6s96CzQouybKGIgdfQZQSHB69IpoFcPs_E442kbkpa8JB
    BrEE9bYzRrtEUYUJllGD-aWojzGp-0wYfvBp5zdJrSTapjUInNhhWbM>
X-ME-Received: <xmr:h1QSah_Tkdwq5Yc3afsvieemrtYskdSzkodgn9eLZkCnnEINiE1zGuuu78d2P6hb2QzIIg-t7Ob3wxr9uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheegiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghkfedttd
    dtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhtihhlihhthigvmhgrlhejjeesghhm
    rghilhdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhope
    igrghnughfuhhrhiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggt
    uhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:h1QSavAtRlRuiCy8yOlH9PFBVozHYMVy4hKfbrhQ278_nMcyTJfHbA>
    <xmx:h1QSamT-3M4hzUKKAje693d0_hAyR0c0San4onVY8tVixzVDZ4M_gw>
    <xmx:h1QSamtHBmyESFLrOqwLh4VrtYZS6C_i-ynCMKFN021Mti1glC5-Aw>
    <xmx:h1QSai0Bg1Ekt_VcW_Ecn-VDqKdyIqVI922mBfub7t4HSRX4JrD5Lw>
    <xmx:h1QSavzuHVG0WWpbsTVZqL0MWp_0K7EtJY-y-l44eYb5cAb19KAUD0iT>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 May 2026 21:29:42 -0400 (EDT)
Message-ID: <617fdd53-6612-4f6f-b0e0-16d85985487b@maowtm.org>
Date: Sun, 24 May 2026 02:29:40 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/9] landlock: Add a place for flags to layer rules
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>,
 Abhinav Saxena <xandfury@gmail.com>, linux-security-module@vger.kernel.org
References: <cover.1775490344.git.m@maowtm.org>
 <6f418b431ccf88636ea3a1b930d14bfdcd420233.1775490344.git.m@maowtm.org>
 <20260523.Uephughee8as@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260523.Uephughee8as@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/23/26 21:48, Mickaël Salaün wrote:
> This patch doesn't build.

Missed a hunk in this patch (ended up in the next one), will add.

>> @@ -797,20 +803,28 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
>>  	}
>>  
>>  	if (unlikely(dentry_child1)) {
>> +		/*
>> +		 * Get the layer masks for the child dentries for use by domain
>> +		 * check later.  The rule_flags for child1 should have been
>> +		 * included in rule_flags_parent1 already (cf.
>> +		 * collect_domain_accesses), and is not relevant for domain check,
>> +		 * so we don't have to pass it to landlock_unmask_layers.
>> +		 */
>>  		if (landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
>>  					      &_layer_masks_child1,
>>  					      LANDLOCK_KEY_INODE))
>>  			landlock_unmask_layers(find_rule(domain, dentry_child1),
>> -					       &_layer_masks_child1);
>> +					       &_layer_masks_child1, NULL);
>>  		layer_masks_child1 = &_layer_masks_child1;
>>  		child1_is_directory = d_is_dir(dentry_child1);
>>  	}
>>  	if (unlikely(dentry_child2)) {
>> +		/* See above comment for why NULL is passed as rule_flags_masks. */
> 
> rule_flags_masks doesn't exist.

I guess I was probably referring to the rule_flags argument - will fix.

>> [...]
>> @@ -647,9 +648,14 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
>>  	 */
>>  	for (size_t i = 0; i < rule->num_layers; i++) {
>>  		const struct landlock_layer *const layer = &rule->layers[i];
>> +		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
>>  
> 
>>  		/* Clear the bits where the layer in the rule grants access. */
>>  		masks->access[layer->level - 1] &= ~layer->access;
>> +
>> +		/* Collect rule flags for each layer. */
>> +		if (rule_flags && layer->flags.quiet)
>> +			rule_flags->quiet_masks |= layer_bit;
> 
> Why not store the quiet bit in masks?  That would not only be "access"
> bits anymore but it makes sense to store all this bits it the same
> place.
> 
> We should then probably rename struct layer_access_masks to just struct
> layer_masks.
> 
> We need to be careful to not increase too much the size of this struct
> though while keeping the [LANDLOCK_MAX_NUM_LAYERS] approach if possible
> (see Günther's commit that added it).

Most uses of struct layer_access_masks do not actually care about the rule
flags tho, e.g. in unmask_scoped_access, scope_to_request, or may_refer.
Such a rename would touch 31 places (and only a few of them would actually
touch the quiet flag).

If we want to refactor to make this be in the layer_access_masks (then
rename it), I guess there are 3 options, which do you prefer?

1. Add a u16 bitfield for which layers are quieted.  Future rule flags
   will be additional bitfields.  struct layer_masks becomes 68 bytes (+4).

struct layer_masks {
	access_mask_t access[LANDLOCK_MAX_NUM_LAYERS];
	layer_mask_t quiet_layers;
};

2. Make the [LANDLOCK_MAX_NUM_LAYERS] array store both the access mask and
   the quiet bit (or more bits for future rule flags).  Size of struct stays
   the same.

static_assert(LANDLOCK_NUM_ACCESS_NET <= LANDLOCK_NUM_ACCESS_FS);
static_assert(LANDLOCK_NUM_SCOPE <= LANDLOCK_NUM_ACCESS_FS);
struct layer_mask {
	access_mask_t access:LANDLOCK_NUM_ACCESS_FS;
	bool quiet:1;
};
struct layer_masks {
	struct layer_mask layer[LANDLOCK_MAX_NUM_LAYERS];
};

   (Maybe we can just make struct layer_masks a typedef to
   layer_mask[LANDLOCK_MAX_NUM_LAYERS] instead?  But currently not sure if
   there are any gotchas with a typedef like that)

3. Mirror layer_access_masks::access[] - add a
   rule_flags[LANDLOCK_MAX_NUM_LAYERS] too.  struct layer_masks becomes 80
   bytes (+16).

struct rule_flags {
	bool quiet:1;
};
struct layer_masks {
	/**
	 * @access: The unfulfilled access rights for each layer.
	 */
	access_mask_t access[LANDLOCK_MAX_NUM_LAYERS];
	struct rule_flags rule_flags[LANDLOCK_MAX_NUM_LAYERS];
};

(3 seems very wasteful to me)
