Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE325228C
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 01:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226699; cv=none; b=t/HJ8GEsg4pLw143TpeN30DzGGHNCqdt2uUhILkizUy9M9D3qKB2kUBX0gbFXcCA4QE3KjkjAnonutbIAJ6C5La8lrzaqrLm+xolA0t/O73Z5NmdDzSdBkakZQttjoIjuB4K7tfKsX1be1s5xL1sN7b7/NfkM+3svzWUqZITQdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226699; c=relaxed/simple;
	bh=KvbWwydzakxnJX3U9otcQnxNaQMFLfmetPQxNO6tJnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irlrEWdcZ/yuiVZoIrcsc5N0HuG7cqEw00YgW+5K9NE5XjHOtOgQy9aPtChhNLyQfnWNiyifX9Ici1jZeTApy2MI7+xV9BnOTPq5TxudT3YdmctndoyncbbozihJQPHiDR2oUGBaL0tvwAsLAKW2UUm532S3J/gZEEmgU9eo5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=IYhx+BOq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sx4vPnF0; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="IYhx+BOq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sx4vPnF0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DAEBC1D00162;
	Thu, 11 Jun 2026 21:11:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 11 Jun 2026 21:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781226696;
	 x=1781313096; bh=DtQzSwFawxnv1vpuRVvtqeow/jl6goAWGvJ9FcFLBb4=; b=
	IYhx+BOqWkl4hSTxQzlA8/UZ4yXqf1jSR7/4IArNyFJiO2X8WPm8pEt+xvvnIJvP
	6MoBvIuJsjgXjiwoKzePIUDfXKfpJioNrtC/20CAtC1VC6hTx8B6s6gVoCOr0Lpx
	MwobBUnygrdEudhlEcYmt6hzCh9uV86DkZXWHDtzG1VtSfIURyKz5utj4sciBorU
	Z1X5udkCtNMypDKZj6olQ1D1ybv0k03b811tSWRwOMxonA+o14GvfHmdi5U+d9JI
	HSfw4MVz1Y2Kp+gz3ndSPASeLeHWfG8D1H2SNHpMuWXGRdM04A+7s9Blyt294i52
	OlEGN6UKtfsl8bojaAkkhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781226696; x=
	1781313096; bh=DtQzSwFawxnv1vpuRVvtqeow/jl6goAWGvJ9FcFLBb4=; b=S
	x4vPnF0mTtJlQFr80kVgsxBBMOHE7g46DJ/M2qwzTkFaH7T6FXALMy1+k/e10845
	2W1jbxTqvYeNrafkjaFygOZdQblNFtXkTMvf37xW1LvOL7DtnxoRHEpPgR1bMhaM
	gzCEee31IcePznemTvQ+FroZxQhMJj8KtTpSfpG2Jv19HCC78e8O+ltHw94KEjcn
	kmVE0sCDF9Il+3T61MAeQj2v/+o/bdawxmiOgrzCvyfRKbqg3UFdjMskcAR8wFla
	UZ4r+1LedJ1KQlalx4iDvXpGBsAnGX7f4P37LX1k96prpoIPyTSenH9DpVuFVUEr
	iizAGJoPh01Czori4cXsw==
X-ME-Sender: <xms:yFwravQgoFUZYkR0Hhh_7yn52nZfC2ihM0oj2TbyNFT9bymm6UszAQ>
    <xme:yFwrakeBKkMVDJKcx2E_G1dR4xw-m_Px8dx7fCjALEkpSpcamZJw2oRVXwljx1lGH
    csGeA6XH7XnAZHN-0GQrz24jjRUs3aaAG_rCtPS4LTA6bixbcIQag>
X-ME-Received: <xmr:yFwrauovdtFxQtWFbC8LZiMZ4ZbonwYcvzWohGNFZmVdgm9dup4rtsltjAl70aY7lKmRhL0hm-jHVFgXZg>
X-ME-Proxy-Cause: dmFkZTF/ZzgcodfEGQOF/MA31cvgKlhVRzO9QKpJ9lmdpMV6t0KvYkRCHp+UVlhNEGz1oC
    WavJaJ5lCNnpogyn0GW5jV4y+9SYDKjWvslEHaH5HDMwgclbf5gW4mue7/lCbwBdnsAxq9
    79jK3E+FaB7FwZoiygqbEebKcPKGRRBB184g43KpdOtgi37o47cTVGoTjtZBNRjwaKdXei
    Bhik+pcQUXUTvsNXnUNt2dHV9jGfzjM3vZ5i1ijjMzmUyhQuikko8AYwPMmdckfNCpFbS8
    idfDsMMhXtS+K0ii3o/PXKZsNleHUgPYuZQAdB2SXIg71oHY47wcQ1N8J/+0fxFjVj0QTn
    snMGTflVUDXRMNmz3FGN1jCeqjc+hdzuWOcZ3Xwrt5+HEWZfKAl3lg1BOyeFePOn7TZ9Gn
    poMShnMFxqw5JCWbH+reFwGWH53LnI2eXZQ0TkfxsqTz/aSHkMT4Lhgu+InvF7zquNhE4y
    8mVZ/p6tLWA63ifHA/CwBi59eElICKqCjSFuE3Xi1Fk/iCnBq2gbkWtcLqfe1lU3J5ElAf
    UPRzLkMS5KXZNgCBXU/twjb5qLvCqTPdlVBtCen4P8vHplGDg0JtsOo+irdplkWMC+dtLu
    WeipM/k0DHMtUf1OLrWEocm76Tl5vU7g1M2u7ysDxNubc9HCcPx6pFWU30gA
X-ME-Proxy: <xmx:yFwral8SBFp8yDvtJVtHn09XO__HkPiEYQTTTD4ET-H3lB2Lh1lciQ>
    <xmx:yFwraqf7RrSZ4G_Qcwv2QCGM7__31jSR-TnvikQuFKnui25D0IcCLQ>
    <xmx:yFwravJOdef9pzqqvZHvZGkWYjYNeu0l3LFInH110CKP3RReXr2vqQ>
    <xmx:yFwraqh_AKOm0xATdyz4jvSv9G_HnMlKuwBnE8QIiZKljx3xjcCkmQ>
    <xmx:yFwraud9CTThQOIRmYJhsYpnzd0UizuG1von6aidCOD8ZfkDpew4imAY>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 21:11:35 -0400 (EDT)
Message-ID: <f969cd40-95da-45e0-8fc1-dfdf43bb887b@maowtm.org>
Date: Fri, 12 Jun 2026 02:11:34 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/9] landlock: Suppress logging when quiet flag is
 present
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>,
 Abhinav Saxena <xandfury@gmail.com>, linux-security-module@vger.kernel.org
References: <cover.1780272022.git.m@maowtm.org>
 <d208c793ac5d5f45bd1bbf87f57d9cc3ab47d6a7.1780272022.git.m@maowtm.org>
 <20260608.daeshu7Leequ@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260608.daeshu7Leequ@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/8/26 23:41, Mickaël Salaün wrote:
> On Mon, Jun 01, 2026 at 01:00:37AM +0100, Tingmao Wang wrote:
>> [...]
>> @@ -265,20 +268,33 @@ get_layer_from_deny_masks(access_mask_t *const access_request,
>>  			 BITS_PER_TYPE(access_mask_t)) {
>>  		if (access_req & BIT(access_bit)) {
>>  			const size_t layer =
>> -				(deny_masks >> (access_index * 4)) &
>> +				(deny_masks >>
>> +				 (access_index *
>> +				  HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1))) &
>>  				(LANDLOCK_MAX_NUM_LAYERS - 1);
>> +			const bool layer_has_quiet =
>> +				!!(quiet_optional_accesses & BIT(access_index));
>>  
>>  			if (layer > youngest_layer) {
>>  				youngest_layer = layer;
>>  				missing = BIT(access_bit);
>> +				should_quiet = layer_has_quiet;
>>  			} else if (layer == youngest_layer) {
>>  				missing |= BIT(access_bit);
>> +				/*
>> +				 * Whether the layer has rules with quiet flag covering
>> +				 * the file accessed does not depend on the access, and so
>> +				 * the following WARN_ON_ONCE() should not fail.
>> +				 */
>> +				WARN_ON_ONCE(should_quiet && !layer_has_quiet);
> 
> WARN_ON_ONCE(should_quiet != layer_has_quiet);

That will fail when layer 0 has quiet flag on the object, at which point
since youngest_layer starts from 0, we will reach this branch with
should_quiet initialized earlier to false, but layer_has_quiet == true.

Also, if should_quiet != layer_has_quiet is always false here, then the
next line is not necessary.

> 
>> +				should_quiet = layer_has_quiet;

Would it be clearer to do should_quiet |= layer_has_quiet, mimicking the
"missing |= BIT(access_bit)"? (The result is the same)

>>  			}
>>  		}
>>  		access_index++;
>>  	}
>>  
>>  	*access_request = missing;
>> +	*quiet = should_quiet;
>>  	return youngest_layer;
>>  }
>>  
>> [...]
>> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
>> index cb7e654933ac..d0fca7da2466 100644
>> --- a/security/landlock/fs.h
>> +++ b/security/landlock/fs.h
>> @@ -63,11 +63,20 @@ struct landlock_file_security {
>>  	 * _LANDLOCK_ACCESS_FS_OPTIONAL).
>>  	 */
>>  	deny_masks_t deny_masks;
>> +	/**
>> +	 * @quiet_optional_accesses: Stores which optional accesses are
>> +	 * covered by quiet rules within the layer referred to in deny_masks,
>> +	 * one access per bit.  Does not take into account whether the quiet
>> +	 * access bits are actually set in the layer's corresponding
>> +	 * landlock_hierarchy.
>> +	 */
>> +	optional_access_t quiet_optional_accesses
>> +		: HWEIGHT(_LANDLOCK_ACCESS_FS_OPTIONAL);
>>  	/**
>>  	 * @fown_layer: Layer level of @fown_subject->domain with
>>  	 * LANDLOCK_SCOPE_SIGNAL.
>>  	 */
>> -	u8 fown_layer;
>> +	u8 fown_layer : 4;
> 
> Please don't hardcode such size.
> 
> Anyway, fown_layer can be updated concurrently (holding a lock), so we
> should not convert it to a bitfield.
> 
>>  #endif /* CONFIG_AUDIT */
>>  
>>  	/**
> 
>> @@ -82,12 +91,6 @@ struct landlock_file_security {
>>  
>>  #ifdef CONFIG_AUDIT
>>  
>> -/* Makes sure all layers can be identified. */
>> -/* clang-format off */
>> -static_assert((typeof_member(struct landlock_file_security, fown_layer))~0 >=
>> -	      LANDLOCK_MAX_NUM_LAYERS);
>> -/* clang-format off */
>> -
>>  #endif /* CONFIG_AUDIT */
> 
> Remaining useless ifdef/endif.

Since we are not using bitfield for fown_layer anymore, I've also turned
quiet_optional_accesses (u8) into a non-bitfield.  Then I reverted this
deletion and added

    static_assert((typeof_member(struct landlock_file_security,
    			     quiet_optional_accesses)) ~0 >=
    	      HWEIGHT(_LANDLOCK_ACCESS_FS_OPTIONAL));

> 
>> [...]
