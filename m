Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426E4CB5B
	for <linux-security-module@vger.kernel.org>; Sun, 26 Oct 2025 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511838; cv=none; b=nC0BPeamoVUtsIfxZb/zim6wBOCleW0d6u8MSLprf4HZrOC+kWesKYZAroPtSXQfTwKEoQ6t7Zj6VS/AIcRZ6+xbKfoihyYesAe43tbt2+yzCarTDWuv/rRN/DkzRcrXR+1au4+8JRzXrcoaSf4FBec/ypvFHH4+C0LrH3C4n1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511838; c=relaxed/simple;
	bh=hckytp80XjHZbj/04DI2sxAipBtYXCn7EeoxhBsXgRI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=o8LuP096JsyGF+cR2QDdVvhzrBTrZt1aYWpTdpDRRWppkWmPyON4/JgwP8Ei7VhJcEX5qXsnADaCbmhT3J5MZz0KCTB6cCLqfFkdyA3pK/U5+Pal2hUpL9pzXuGtwHs/JwRtgk5CNZ1nit9GO8nctNVfqWNMv0SZ9Ig+N5rlOfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=OJjYASfV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rgRZAyjy; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="OJjYASfV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rgRZAyjy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 58963EC0280;
	Sun, 26 Oct 2025 16:50:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 26 Oct 2025 16:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761511836;
	 x=1761598236; bh=f72vVFnw+IEj3r2Ad7lweAUEWJkk5F8DmSVDsBgIIoI=; b=
	OJjYASfVu3alEiMK/Hoja/+vOEW0zOk1YZ5HVbbS8b7Z10szylmxnWgYQvhl4kvx
	ryyMxis/j+nturnocv00taA9Zxt2AGtoa8qQrKm2rDwq3gi7bVze8sR6HvDnDAKV
	n2EbuIReNIILb/ArLQK/KbupJG1EYzv+26Qo0mGCuDr/9pwmVGKtT1CBN+8ln6jn
	yIvsvJEkPqrNEPtynKrpsf4nCxmjDO1D+S+CabR7L+Z6cMNc+anuwEBXUX9UHZBi
	E6LlC4yTrwzM0eQtGU0cY0s7UGyMclPCx4QzUdQEFC0AifO4sXwpjCEPAcj9yEQB
	zlbZNxuViALjgWPVKaieaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761511836; x=
	1761598236; bh=f72vVFnw+IEj3r2Ad7lweAUEWJkk5F8DmSVDsBgIIoI=; b=r
	gRZAyjyidzhzPL/RhBKeklDVMn8IRTi0LW40pKpovpMLXbRCxaVHWkKyPxXjk+P1
	drICCeq+A+vQqNdB8nKZPOKRnJGX5XNI6bTVBFyLdGDxpLMJjParlGMmQHPHKS//
	zGGhED8ZwArf3GuNiysLFl+rnID5fiAbTXuVUuhekCyU/h0YpYYF+55eZrtmYPcc
	O5BgqNG11aqMIQtakd7viFtHl8oaV5JT8OE19e4XGEPRs7UHbjUweDjpakdbO+kK
	yseCrFpeCirYhYoaFWcg9j9UcmcdpPW/0z6Wzop+Y7l4HdJvCD+ro6VMqVNVCyGO
	bewJfpNYFfTDyuNCi9Bow==
X-ME-Sender: <xms:nIn-aPNYCJq2koYFiyVB_L2RHSstlAORmBiX75xsqChYMHNQYXxt2A>
    <xme:nIn-aA_yqjLpbbgWos3cqW_GV8TbU4mu5GFPqe1LDlhYCDUy8g2EeVctA1b3XxWCs
    EqYn3XQlvSUfb6otSmuV0ls-QSuzIWlNlU5qcZMM8_pVyKSnDzZ3LTZ>
X-ME-Received: <xmr:nIn-aDSYAL55W3Ut3aTeQanX9Zk3CpKQRbpxCkkFh0lKc7SmSNgok3xBNBL22s0zUO45wgt59zXe2fLOGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeiuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepvd
    egudeugfdujefgtdetffdujeejleeliedukeeujeduheetgffhgedvteevffeunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthho
    pehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:nIn-aCmUD7CsrgrFBxAo_REMwWXcc6s9g_D0mmsGL4rN5IWHmh6mnQ>
    <xmx:nIn-aDQhzMa0oK9RnZCAjOyRwUbVLCrEcpCMwasBm6oEh3v-H984uw>
    <xmx:nIn-aAMpRQ24eUB-AeA1GofYgbCQ54oyNjdTJB0Ue9Z77U2Ih5kFPw>
    <xmx:nIn-aMU7-rnTcVA6QIuT7-JanJxtjsdCGDrZztdaBc3JwB_3eGCJPQ>
    <xmx:nIn-aEOWv-_ypaCRZi8yC5yOhUHdBNTsgcMDTpPdWPyTQHzdjRSzeJNF>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 16:50:35 -0400 (EDT)
Message-ID: <788946db-1ad4-4d6b-8bb2-e7145a0999d1@maowtm.org>
Date: Sun, 26 Oct 2025 20:50:33 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v2 6/6] Implement quiet for optional accesses
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
References: <cover.1759686613.git.m@maowtm.org>
 <d9a05ea8fe3b825087351f22c550854dcad02555.1759686613.git.m@maowtm.org>
 <20251015.sohxe1NohFei@digikod.net>
Content-Language: en-US
In-Reply-To: <20251015.sohxe1NohFei@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/15/25 20:09, Mickaël Salaün wrote:
> This extra patch makes the review easier, but it should be squashed into
> the others if possible.

Done in v3.

> 
> On Sun, Oct 05, 2025 at 06:55:29PM +0100, Tingmao Wang wrote:
>> [...]
>> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
>> index 4ba44fb1dccb..f183124755a4 100644
>> --- a/security/landlock/audit.c
>> +++ b/security/landlock/audit.c
>> @@ -273,7 +273,7 @@ static void test_get_denied_layer(struct kunit *const test)
>>  static size_t
>>  get_layer_from_deny_masks(access_mask_t *const access_request,
>>  			  const access_mask_t all_existing_optional_access,
>> -			  const deny_masks_t deny_masks)
>> +			  const deny_masks_t deny_masks, u8 quiet_optional_accesses, bool *quiet)
>>  {
>>  	const unsigned long access_opt = all_existing_optional_access;
>>  	const unsigned long access_req = *access_request;
>> @@ -285,6 +285,7 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
>>  	/* This will require change with new object types. */
>>  	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
>>  
>> +	*quiet = false;
>>  	for_each_set_bit(access_bit, &access_opt,
>>  			 BITS_PER_TYPE(access_mask_t)) {
>>  		if (access_req & BIT(access_bit)) {
>> @@ -298,6 +299,11 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
>>  			} else if (layer == youngest_layer) {
>>  				missing |= BIT(access_bit);
>>  			}
>> +
>> +			/* Make sure we set *quiet even if this is the first layer */
> 
> Missing final dot.
> 
>> +			if (layer >= youngest_layer)
>> +				*quiet = !!(quiet_optional_accesses &
>> +					    BIT(access_index));
> 
> This code is good but a bit confusing at first, especially without more
> context than this patch provides, where we don't see the relation
> between layer and youngest_layer.  Anyway, please extend the comment to
> say that quiet is always overridden for the youngest layer.

TBH I didn't really like it either.  I've moved this around a bit in the
latest version - can you check if that is clearer?
