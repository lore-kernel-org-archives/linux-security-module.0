Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A0E36D4F0
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763931713; cv=none; b=YdYyB+6cil0jV7cbkxQ56mE4dbwMaOBfeXAATGcZCFVxdXR/VNxta/SF/RjREqhaSjcc4zN2INaq7n6+OH00UzaA4B/Z6403Qie9tTH4jozLiflY+bQbzb3pBfsrtUA/RGlmD1rvbVW4T/8fQ7XPlhPFUhwH66S+V+HDcf158wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763931713; c=relaxed/simple;
	bh=9ArgT/PHLZdxFFXsn6sHGz8mm40/vr11TWyaqakkAqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GanaetFi/j3TCITGF/ysGt3/TOzQVVWwBNmJErXmL6Tk3ylvY9CjgozlAe2pvIJ23yftmO6eKBSywYW3rAtscNB2W/JxDaqpzzddr1davCTt10kkfBofkLLrVdZEc/1eM6w7jTxJe2P845nMkwTFhA+DEjL5F3BNaWRf/BsvvZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=LepP6JEk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=atoEOzf0; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="LepP6JEk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="atoEOzf0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACC5C14000CA;
	Sun, 23 Nov 2025 16:01:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 23 Nov 2025 16:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763931709;
	 x=1764018109; bh=SaY9UDC/KHqWyXifqRkK6sxirhS0C+p5eO8dJlNzto0=; b=
	LepP6JEkU76IW9UqLwWjMHeM54Tn4p8kP7QTjNGHSh0s92839XJPVLOV4aLRZaDj
	OpHZG9DBackTlSyTPb4X5y8rcjN5Qh4sX8miND03ZVGkeYyjQ881klYofaC1nMZT
	PjLgIe04nQOc+S/BZXxr9MGO82laJyeTsdfTMyn3kwndSACWAaqDj4j6duVApdQn
	55vXLIgLXsl1ZRZR+aaFVWVJX+cNiFGP7TIYmZ9+fK9svYFIB/V/BESWkK0JM0h8
	h4gd0Ex3S6wvaEqrsH04BIzoIsANvOEyfubyZz9fBI0f+fo7O058Kgd2J2snjNAX
	ZCZZ/MkFZj55RRh9kQtStw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763931709; x=
	1764018109; bh=SaY9UDC/KHqWyXifqRkK6sxirhS0C+p5eO8dJlNzto0=; b=a
	toEOzf0Luzx8qlyDFTnpVG2/SRqYFu9iD82ZEcGZELe7xbc0RPQbM8KxJMK+D4Dy
	SsAXFK+S4cTN8O6zIkYNVTt56588TEKgZUnkVLZKuZXbInsmRGJKu0uVkSwdLwCK
	F4aMgvTkFPkwUiRAI6TBrkq9VVIf4SjZwCGKfe0vBjKzNQLm60nek3zk7uV+OOo6
	RHqPtxmYdiXsQswNFORJ9DdDrHEZPvqEu4kicjxZOvef5WMe9OaMQTuAWV7fLYtS
	IPKRWbKjmvPLIwFpgsz3zQpnVHsXudVW8kHPF1BANfmV0VEv94Y1qf5EQ5aObqFM
	nksdS2/Wir0cdPIntKedg==
X-ME-Sender: <xms:PXYjaSpiED7Ld4ikIgr2hB5s2pppeHLTvI1ixQU0czRppMqfrwpK9g>
    <xme:PXYjaUXJVAfy5R70rjz5Qqt-Obhizx1tKH4eXP-_0o_YrTwycMk9msw4k40trBqxB
    XdqJFKRBhjWWOXsNBkmc6XF5aZHqpSslqxFcaYPLomb2aEjBZvVOsI>
X-ME-Received: <xmr:PXYjaRALTfYpsc-Y7XzedOUxDGTCFTBcnjIq1-pHHK7F8OUYKBW71Y06N27Q2sZSDTz4k3KHH_fessde8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    fhgeeuvdfhffdvleeuvddvtdfgjedufeevhefhkedvgeevkeejgeettdeutdetnecuffho
    mhgrihhnpegrtggtvghsshgpmhgrshhkshdrnhgvthenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughigh
    hikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtth
    hopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghi
    lhdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PXYjaY2Faw0h_SHiM-zq9OqcfJBLva2RwzJKhnuqLIIFZ2eHeroy9g>
    <xmx:PXYjaT1aNhswaPzPnHYAmTAt9JVZdmVhnAW2gOl5ms5QGsupV_PHew>
    <xmx:PXYjadBYoxCTYnwX-KfZM-hberN0UzdoA26Bq6KJoNXUKWVa-FB64A>
    <xmx:PXYjaS4nICUN-r46-zkbU7rhjyptrJFj2Yf5HE4L52hNzdg2PrctrA>
    <xmx:PXYjabsMqOE5YH8D1UluFoSke-DZIV6TuRn7ElkrpymLP_OMt0WLsuxK>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 16:01:48 -0500 (EST)
Message-ID: <eb86863b-53b0-460b-b223-84dd31d765b9@maowtm.org>
Date: Sun, 23 Nov 2025 21:01:47 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] landlock: Suppress logging when quiet flag is
 present
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>,
 Abhinav Saxena <xandfury@gmail.com>, linux-security-module@vger.kernel.org
References: <cover.1763330228.git.m@maowtm.org>
 <5c0de8ee7e00aff1aceb3a80f5af162eeaaa06db.1763330228.git.m@maowtm.org>
 <20251120.eoghapeeGh7i@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251120.eoghapeeGh7i@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/21/25 15:27, Mickaël Salaün wrote:
> On Sun, Nov 16, 2025 at 09:59:33PM +0000, Tingmao Wang wrote:
>> [...]
>>  	for_each_set_bit(access_bit, &access_opt,
>>  			 BITS_PER_TYPE(access_mask_t)) {
>>  		if (access_req & BIT(access_bit)) {
>>  			const size_t layer =
>>  				(deny_masks >> (access_index * 4)) &
>>  				(LANDLOCK_MAX_NUM_LAYERS - 1);
>> +			const bool layer_has_quiet =
>> +				!!(quiet_optional_accesses & BIT(access_index));
>>
>>  			if (layer > youngest_layer) {
>>  				youngest_layer = layer;
>> +				*quiet = layer_has_quiet;
>>  				missing = BIT(access_bit);
>>  			} else if (layer == youngest_layer) {
>>  				missing |= BIT(access_bit);
>> +				/*
>> +				 * Whether the layer has rules with quiet flag covering
>> +				 * the file accessed does not depend on the access, and so
>> +				 * if this fails, quiet_optional_accesses is corrupted.
>> +				 */
>> +				WARN_ON_ONCE(*quiet && !layer_has_quiet);
>> +				*quiet = layer_has_quiet;
>
> In this case, why update *quiet?

A legitimate case where we end up here is if layer = youngest_layer = 0,
and layer_has_quiet = true, in which case *quiet starts out as false and
we have to set it to true here.

The comment is saying the WARN_ON_ONCE should not fail because the quiet
flag does not depend on access (and hence we should not be trying to set
*quiet from true back to false if the youngest layer hasn't changed), but
*the line after that WARN is still necessary.

I've updated the comment to clarify.

>
>>  			}
>>  		}
>>  		access_index++;
>> @@ -312,42 +323,188 @@ static void test_get_layer_from_deny_masks(struct kunit *const test)
>>  {
>>  	deny_masks_t deny_mask;
>>  	access_mask_t access;
>> +	u8 quiet_optional_accesses;
>> +	bool quiet;
>>
>>  	/* truncate:0 ioctl_dev:2 */
>>  	deny_mask = 0x20;
>> +	quiet_optional_accesses = 0;
>>
>>  	access = LANDLOCK_ACCESS_FS_TRUNCATE;
>>  	KUNIT_EXPECT_EQ(test, 0,
>> -			get_layer_from_deny_masks(&access,
>> -						  _LANDLOCK_ACCESS_FS_OPTIONAL,
>> -						  deny_mask));
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>>  	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
>> +	KUNIT_EXPECT_EQ(test, quiet, false);
>> +
>> +	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
>> +	KUNIT_EXPECT_EQ(test, 2,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
>> +	KUNIT_EXPECT_EQ(test, quiet, false);
>> +
>> +	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
>> +	KUNIT_EXPECT_EQ(test, 2,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
>> +	KUNIT_EXPECT_EQ(test, quiet, false);
>> +
>> +	/* layer denying truncate: quiet, ioctl: not quiet */
>> +	quiet_optional_accesses = 0b01;
>> +
>> +	access = LANDLOCK_ACCESS_FS_TRUNCATE;
>> +	KUNIT_EXPECT_EQ(test, 0,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
>> +	KUNIT_EXPECT_EQ(test, quiet, true);
>> +
>> +	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
>> +	KUNIT_EXPECT_EQ(test, 2,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
>> +	KUNIT_EXPECT_EQ(test, quiet, false);
>> +
>> +	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
>> +	KUNIT_EXPECT_EQ(test, 2,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
>> +	KUNIT_EXPECT_EQ(test, quiet, false);
>> +
>> +	/* Reverse order - truncate:2 ioctl_dev:0 */
>> +	deny_mask = 0x02;
>> +	quiet_optional_accesses = 0;
>> +
>> +	access = LANDLOCK_ACCESS_FS_TRUNCATE;
>> +	KUNIT_EXPECT_EQ(test, 2,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
>> +	KUNIT_EXPECT_EQ(test, quiet, false);
>> +
>> +	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
>> +	KUNIT_EXPECT_EQ(test, 0,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
>> +	KUNIT_EXPECT_EQ(test, quiet, false);
>> +
>> +	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
>> +	KUNIT_EXPECT_EQ(test, 2,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
>> +	KUNIT_EXPECT_EQ(test, quiet, false);
>> +
>> +	/* layer denying truncate: quiet, ioctl: not quiet */
>> +	quiet_optional_accesses = 0b01;
>> +
>> +	access = LANDLOCK_ACCESS_FS_TRUNCATE;
>> +	KUNIT_EXPECT_EQ(test, 2,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
>> +	KUNIT_EXPECT_EQ(test, quiet, true);
>> +
>> +	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
>> +	KUNIT_EXPECT_EQ(test, 0,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
>> +	KUNIT_EXPECT_EQ(test, quiet, false);
>>
>>  	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
>>  	KUNIT_EXPECT_EQ(test, 2,
>> -			get_layer_from_deny_masks(&access,
>> -						  _LANDLOCK_ACCESS_FS_OPTIONAL,
>> -						  deny_mask));
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
>> +	KUNIT_EXPECT_EQ(test, quiet, true);
>> +
>> +	/* layer denying truncate: not quiet, ioctl: quiet */
>> +	quiet_optional_accesses = 0b10;
>> +
>> +	access = LANDLOCK_ACCESS_FS_TRUNCATE;
>> +	KUNIT_EXPECT_EQ(test, 2,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
>> +	KUNIT_EXPECT_EQ(test, quiet, false);
>> +
>> +	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
>> +	KUNIT_EXPECT_EQ(test, 0,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>>  	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
>> +	KUNIT_EXPECT_EQ(test, quiet, true);
>> +
>> +	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
>> +	KUNIT_EXPECT_EQ(test, 2,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
>> +	KUNIT_EXPECT_EQ(test, quiet, false);
>>
>>  	/* truncate:15 ioctl_dev:15 */
>>  	deny_mask = 0xff;
>> +	quiet_optional_accesses = 0;
>> +
>> +	access = LANDLOCK_ACCESS_FS_TRUNCATE;
>> +	KUNIT_EXPECT_EQ(test, 15,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
>> +	KUNIT_EXPECT_EQ(test, quiet, false);
>> +
>> +	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
>> +	KUNIT_EXPECT_EQ(test, 15,
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>> +	KUNIT_EXPECT_EQ(test, access,
>> +			LANDLOCK_ACCESS_FS_TRUNCATE |
>> +				LANDLOCK_ACCESS_FS_IOCTL_DEV);
>> +	KUNIT_EXPECT_EQ(test, quiet, false);
>> +
>> +	/* Both quiet (same layer so quietness must be the same) */
>> +	quiet_optional_accesses = 0b11;
>>
>>  	access = LANDLOCK_ACCESS_FS_TRUNCATE;
>>  	KUNIT_EXPECT_EQ(test, 15,
>> -			get_layer_from_deny_masks(&access,
>> -						  _LANDLOCK_ACCESS_FS_OPTIONAL,
>> -						  deny_mask));
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>>  	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
>> +	KUNIT_EXPECT_EQ(test, quiet, true);
>>
>>  	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
>>  	KUNIT_EXPECT_EQ(test, 15,
>> -			get_layer_from_deny_masks(&access,
>> -						  _LANDLOCK_ACCESS_FS_OPTIONAL,
>> -						  deny_mask));
>> +			get_layer_from_deny_masks(
>> +				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
>> +				deny_mask, quiet_optional_accesses, &quiet));
>>  	KUNIT_EXPECT_EQ(test, access,
>>  			LANDLOCK_ACCESS_FS_TRUNCATE |
>>  				LANDLOCK_ACCESS_FS_IOCTL_DEV);
>> +	KUNIT_EXPECT_EQ(test, quiet, true);
>>  }
>>
>>  #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
>> @@ -381,19 +538,39 @@ static bool is_valid_request(const struct landlock_request *const request)
>>  	return true;
>>  }
>>
>> +static access_mask_t
>> +pick_access_mask_for_request_type(const enum landlock_request_type type,
>> +				  const struct access_masks access_masks)
>> +{
>> +	switch (type) {
>> +	case LANDLOCK_REQUEST_FS_ACCESS:
>> +		return access_masks.fs;
>> +	case LANDLOCK_REQUEST_NET_ACCESS:
>> +		return access_masks.net;
>> +	default:
>> +		WARN_ONCE(1, "Invalid request type %d passed to %s", type,
>> +			  __func__);
>> +		return 0;
>> +	}
>> +}
>> +
>>  /**
>>   * landlock_log_denial - Create audit records related to a denial
>>   *
>>   * @subject: The Landlock subject's credential denying an action.
>>   * @request: Detail of the user space request.
>> + * @rule_flags: The flags for the matched rule, or no_rule_flags (zero) if
>> + * this is a scope request (no particular object involved).
>>   */
>>  void landlock_log_denial(const struct landlock_cred_security *const subject,
>> -			 const struct landlock_request *const request)
>> +			 const struct landlock_request *const request,
>> +			 const struct collected_rule_flags rule_flags)
>
> It would be simpler and limit code change to move rule_flags/quiet_flags
> into struct landlock_request, which means we can also remove
> no_rule_flags.

That's true, I can do that.  In fact this way we also don't have to have 2
extra parameters for is_access_to_paths_allowed - it can just operate on
log_request_parent{1,2}->rule_flags.  However I do see that
landlock_request is intended to only be used by audit/logging code (and
there is a comment in audit.h about not using it outside CONFIG_AUDIT to
enable it to be optimized away, although testing a fresh build on next it
doesn't look like it is taken out of vmlinux if compiled without
CONFIG_AUDIT).  While this is fine for the purpose of this series as the
quiet flag only affects audit logging, I wonder if this might cause a
problem when we want to add more flags that might not be related to audit
(e.g. Justin's LANDLOCK_ADD_RULE_NO_INHERIT).

Alternatively maybe is_access_to_paths_allowed can still take extra
parameters for rule flags, and we can make it so that the new rule_flags
field in landlock_request is only assigned to right before
landlock_log_denial, not from is_access_to_paths_allowed?  (I won't do
this for v5 which I will send in a minute)

>
>>  {
>>  	struct audit_buffer *ab;
>>  	struct landlock_hierarchy *youngest_denied;
>>  	size_t youngest_layer;
>> -	access_mask_t missing;
>> +	access_mask_t missing, quiet_mask;
>> +	bool object_quiet_flag = false, quiet_applicable_to_access = false;
>>
>>  	if (WARN_ON_ONCE(!subject || !subject->domain ||
>>  			 !subject->domain->hierarchy || !request))
>> @@ -409,10 +586,13 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>>  			youngest_layer = get_denied_layer(
>>  				subject->domain, &missing, request->layer_masks,
>>  				request->layer_masks_size);
>> +			object_quiet_flag = !!(rule_flags.quiet_masks & BIT(youngest_layer));
>>  		} else {
>>  			youngest_layer = get_layer_from_deny_masks(
>>  				&missing, request->all_existing_optional_access,
>> -				request->deny_masks);
>> +				request->deny_masks,
>> +				request->quiet_optional_accesses,
>> +				&object_quiet_flag);
>>  		}
>>  		youngest_denied =
>>  			get_hierarchy(subject->domain, youngest_layer);
>> @@ -447,6 +627,49 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>>  			return;
>>  	}
>>
>> +	/*
>> +	 * Checks if the object is marked quiet by the layer that denied the
>> +	 * request.  If it's a different layer that marked it as quiet, but
>> +	 * that layer is not the one that denied the request, we should still
>> +	 * audit log the denial.
>> +	 */
>> +	if (object_quiet_flag) {
>> +		/*
>> +		 * We now check if the denied requests are all covered by the
>> +		 * layer's quiet access bits.
>> +		 */
>> +		quiet_mask = pick_access_mask_for_request_type(
>
> This quiet_mask is only used in this branch, so we can declare it here
> and make it const:
>
> const access_mask_t quiet_mask = pick_access_mask_for_request_type(
>
>
>> +			request->type, youngest_denied->quiet_masks);
>> +		quiet_applicable_to_access = (quiet_mask & missing) == missing;
>
> I think it should be:
>
>   quiet_applicable_to_access = (quiet_mask & missing) == (handled_mask & missing);

There is no handled_mask in this context, so I assume you meant
handled_mask of the youngest_layer?  But still - not sure I understand why -
missing contains requested access bits that are denied by the youngest
denying layer, and so missing would never be != youngest->handled_mask & missing,
right?  Since a layer that doesn't handle an access can't deny it.

>
> We should have a test for this case: an access request (e.g. read-write)
> is denied, half by one layer (e.g. read) and half by another (e.g.
> write).  Tests should cover this matrix.

Added as quiet_two_layers_different_handled_{1,2,3}
