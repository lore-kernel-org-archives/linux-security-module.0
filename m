Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45FB1E1E16
	for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779646826; cv=none; b=C0BV6c/OX41sOxU9RoD+DHKaOlkMwzBtvaa4OuWx9QCOY6rk0F3JdBLbspDmvrd+NtCDrd9yotMUsqG+2r9uR+1Vk5gR7EUTMlIDMV+KyWgnQZ9OTCRtmDzOqXuA8kmC57f+/gvxP16/AlNkFSKlRuPepfvfpSl14ogAXQXCxcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779646826; c=relaxed/simple;
	bh=+G657Dlx7QNBGXnxAQitWtIPJEPSVPQMZOZP6n2+UE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H33+pZh7TqisQyvdHahJoXe16kXm7iGjtSPcjplAy7KN9gYoxubJWAk9WVoH2KsnpBDFEnXsS1gOxa15KXYZbzWBTl687837OTbfAGOP0o+2cyybqjcwNNtiGiOH9HqyYY14mtBjnDuobaCKG6S69Inqy3EouRWEkFk2SOAsVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=5O6TIKh4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fVdAB1gT; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="5O6TIKh4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fVdAB1gT"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E157A7A0063;
	Sun, 24 May 2026 14:20:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 24 May 2026 14:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779646822;
	 x=1779733222; bh=7rrHTS8e8QGtxlP4ithxrUu/muAcxzBBhkt6y4CLvtk=; b=
	5O6TIKh47qgGkd26r79yQEJwbaqeYzXGbtN1ZwbWsFz9QmjEJPZP20VQQfvNsmZ9
	MGPGF1Vtns6wpKiWZ2vmGyIG8TX4SytBUeOpSeyZy5teLmIYB7cgMxdKTjy7nWE8
	GOwOKNGAO7iM6LzgWM5AuJHrTr0FQs1YZpqr9fwWpAD4fFM1+x2BoBZGo8UKu+WJ
	l84cA11tnWLnWioccf+Y8tIAzXdOfCyJQ1NnmyV4yue6GiNvi8rrgHZkTCnDw9Dr
	AF9VEWej30CAWim5GMVQVSWeXomUPkrfgi2qdhk3G/HFHBpAcMohuOboV/Zw8Sjv
	Z90DJ7pq6m2D3GKNfIY93Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779646822; x=
	1779733222; bh=7rrHTS8e8QGtxlP4ithxrUu/muAcxzBBhkt6y4CLvtk=; b=f
	VdAB1gToE5Ji+W8m1PJCjZJM8yi80c+ZVZbL8xdmwxa37jk6DYPI827pk2R1yJ4h
	N5iqCA/t11PHzD4WUCvGfII8hcGJhyFfyj8B60ftZ+2UZXts/LK4SAz+AIPDqy6Z
	ptSAIvuvoos5lanBtk8KeUme+2Glcy7CYAKX6gJoI0MzmxLwOTu/eNPGMjgb/SZv
	13phgrCrPbGAOJkCAO05tJFx+XStbcQKMCTbT9cGIfM0AjvAEtta5DteN+6N2zFi
	X8Kbg7Y9NT98dvrXwW5tJqMjTzOJltNmNyPioEKuNEBJB0L1y6+GT0hZYqnFDsUf
	lBs4Pk6gdaBH3GjG32x8Q==
X-ME-Sender: <xms:ZkETaoT6R0Kt4-gaFF94NXhhn4FCOZHaV-8HUPZdQaXde-oLifqIlg>
    <xme:ZkETapeD2UQfk7n1CInPC0WTZNVfEWPw55G1IQKKX9VX_5ybg9JtVEQ2KCsKSR-hs
    jq0saigc7PS8-g9IJUWOpmTGs-bb7P1-4atfsLI6ekpEgARlgX4So4>
X-ME-Received: <xmr:ZkETavoLzka8d1FzNdEAJIeisR5c13tQYNFxIHZGERguVB1xJlXEZxsWRx94T9Qs74FU0IDbuteohMP2Gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheeiieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnheptd
    ffgfdujeeludffkeeiveefvedvjeelvddvjeevjefghedvjedvvdeltdffveehnecuffho
    mhgrihhnpehgohgusgholhhtrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthho
    peeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehuthhilhhithihvghmrghlje
    ejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdp
    rhgtphhtthhopehgnhhorggtkheftddttdesghhmrghilhdrtghomhdprhgtphhtthhope
    hjrggtkhesshhushgvrdgtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZkETai8l4_6k2yKJs9FGYB1aUjDGAGszU0mB_7cTP2_dBW06MUgHGA>
    <xmx:ZkETajfe6AlqY7CUX1xRJYdmQKpvxYAKpB88vzuD82HhZ4kXJaEKBA>
    <xmx:ZkETakImsIucONmpOOWJQ0RX-8ibCKFdChwJrb0OsuMGhg82KKy8yA>
    <xmx:ZkETargMQEtDn1Mc2fnLmNsYfMV7zlRcQN-g1mVOJG4zOD2h67vKwA>
    <xmx:ZkETavf_soFp_CW0CXn4NKHSsnWTjvjomf4t8gPHQ8oQ4iCLNJajYFDf>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 14:20:21 -0400 (EDT)
Message-ID: <42a06f7c-abb5-4f2d-8428-8d122047e8d4@maowtm.org>
Date: Sun, 24 May 2026 19:20:19 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/9] landlock: Add a place for flags to layer rules
To: Justin Suess <utilityemal77@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>,
 linux-security-module@vger.kernel.org
References: <cover.1775490344.git.m@maowtm.org>
 <6f418b431ccf88636ea3a1b930d14bfdcd420233.1775490344.git.m@maowtm.org>
 <20260523.Uephughee8as@digikod.net>
 <617fdd53-6612-4f6f-b0e0-16d85985487b@maowtm.org> <ahMLLwnDO7g64h63@zenbox>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <ahMLLwnDO7g64h63@zenbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/24/26 15:46, Justin Suess wrote:
> On Sun, May 24, 2026 at 02:29:40AM +0100, Tingmao Wang wrote:
>> On 5/23/26 21:48, Mickaël Salaün wrote:
>>> [...]
>>>> @@ -647,9 +648,14 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
>>>>  	 */
>>>>  	for (size_t i = 0; i < rule->num_layers; i++) {
>>>>  		const struct landlock_layer *const layer = &rule->layers[i];
>>>> +		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
>>>>  
>>>
>>>>  		/* Clear the bits where the layer in the rule grants access. */
>>>>  		masks->access[layer->level - 1] &= ~layer->access;
>>>> +
>>>> +		/* Collect rule flags for each layer. */
>>>> +		if (rule_flags && layer->flags.quiet)
>>>> +			rule_flags->quiet_masks |= layer_bit;
>>>
>>> Why not store the quiet bit in masks?  That would not only be "access"
>>> bits anymore but it makes sense to store all this bits it the same
>>> place.
>>>
>>> We should then probably rename struct layer_access_masks to just struct
>>> layer_masks.
>>>
>>> We need to be careful to not increase too much the size of this struct
>>> though while keeping the [LANDLOCK_MAX_NUM_LAYERS] approach if possible
>>> (see Günther's commit that added it).
>>
>> Most uses of struct layer_access_masks do not actually care about the rule
>> flags tho, e.g. in unmask_scoped_access, scope_to_request, or may_refer.
>> Such a rename would touch 31 places (and only a few of them would actually
>> touch the quiet flag).
>>
>> If we want to refactor to make this be in the layer_access_masks (then
>> rename it), I guess there are 3 options, which do you prefer?
>>
>> 1. Add a u16 bitfield for which layers are quieted.  Future rule flags
>>    will be additional bitfields.  struct layer_masks becomes 68 bytes (+4).
>>
>> struct layer_masks {
>> 	access_mask_t access[LANDLOCK_MAX_NUM_LAYERS];
>> 	layer_mask_t quiet_layers;
>> };
>>
>> 2. Make the [LANDLOCK_MAX_NUM_LAYERS] array store both the access mask and
>>    the quiet bit (or more bits for future rule flags).  Size of struct stays
>>    the same.
>>
> This approach seems best.
>> static_assert(LANDLOCK_NUM_ACCESS_NET <= LANDLOCK_NUM_ACCESS_FS);
>> static_assert(LANDLOCK_NUM_SCOPE <= LANDLOCK_NUM_ACCESS_FS);
>> struct layer_mask {
>> 	access_mask_t access:LANDLOCK_NUM_ACCESS_FS;
>> 	bool quiet:1;
>> };
> 
> Other way to do it could be an (anonymous?) union.
> 
> union {
>   access_mask_t fs_access:LANDLOCK_NUM_ACCESS_FS;
>   access_mask_t net_access:LANDLOCK_NUM_ACCESS_NET;
>   access_mask_t scope_access:LANDLOCK_NUM_SCOPE;
> }
> 
> The union should be sized to fit the largest field automatically.
> 
> That way you don't have to change this when adding new access rights
> and avoid the brittle static_asserts.
> 
> Not sure about the alignment implications here though.

Unfortunately this forces struct layer_mask to be 2x as large:
https://godbolt.org/z/5P9b4rrMW

But it turns out I could have just used MAX, seems to compile for me:

struct layer_mask {
	access_mask_t access
		: MAX(LANDLOCK_NUM_ACCESS_FS,
		      MAX(LANDLOCK_NUM_ACCESS_NET, LANDLOCK_NUM_SCOPE));
	bool quiet : 1;
};
struct layer_masks {
	struct layer_mask layer[LANDLOCK_MAX_NUM_LAYERS];
};

Maybe we could #define LANDLOCK_NUM_ACCESS_MAX to be MAX(...) then use it
here.

I'm still not sure if putting the collected rule flags in struct
layer_(access_)masks is a good idea tho.  Passing a separate struct
collected_rule_flags to the functions that needs to deal with rule flags
(quiet, and later, no inherit / has no inherit descendant) seems quite
practical to me.
