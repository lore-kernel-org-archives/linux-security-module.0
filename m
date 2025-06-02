Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242921C9EF
	for <linux-security-module@vger.kernel.org>; Mon,  2 Jun 2025 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870456; cv=none; b=mMMz3AvhSZHyfdcDSxpB9JcxhUOjJ6bq2MxSBmShi56UsgCM0B6AR2WJXzhiueEFN8Z47HqBO9tykeHzlD+RQemvbta8QBUgUeyjY3GfROC/tRaW+l2FsmhLxffsDvWX6cBzocl3BrxjQMyqemWIpXxpMbQ3N7iWAzy5u4lZ/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870456; c=relaxed/simple;
	bh=c3v/amorMK9IR9egja7l0QCz/Q6RS7uVgaK5imY4kDM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f1lWehoaLXarDc6/B5bZDtsB9Wi6tOg42eXmK1VbEVuEKf0+q77XI9yrek3yLopFLjCi2A1S0Z7F2bU6AnyAxVxcI7W4ygmDHN7mk8DXffq8XwD/rNXM294fg+3jJ/+B9Qv73dfhVAjIle7OrHv6HDWWkEheYTwf9KRdidVRphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=cvMGUKfn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a7rpy7Gk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="cvMGUKfn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a7rpy7Gk"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 052D31380361;
	Mon,  2 Jun 2025 09:20:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 02 Jun 2025 09:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748870454;
	 x=1748956854; bh=7iTjot4IwFTvF1NuIm2qYHp03kO2jedFsdBZwaGZkJ0=; b=
	cvMGUKfntgGH6V9C+l94wexZi7sndFFWeLBGLwRuYLBGf15Q+o9cWnsfN+P4bFvt
	WhvtP+Ii476gwq0rm+hLbFFD8eAd0cY6oYiFHFnEsbP1lt4D3w+kwbPzBxqLjRO/
	rbl30UclFQHA8ydcWu7v1VLpRe2Sf+vQyPfhcV/zTIhWbVQ0udze1tEvHEnnrSfM
	75nH7NW5I4+n3zlL46vbjA/HfJ5VwCBTpRJlhyR/nRBNNJWyr169lrwQD7PVWFhH
	FHDKFV5hrADu1b87ygT/H8XN4db3GdzpGT/cVsuzxmj5YfFr+09kHV2kopBIG1ae
	/u4sDYNSD+0Fyop/gCoOyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748870454; x=
	1748956854; bh=7iTjot4IwFTvF1NuIm2qYHp03kO2jedFsdBZwaGZkJ0=; b=a
	7rpy7GkBHX+JFA5JDMBE0lvmF9g4Xd926FS9gNJew8ioBQDo2jXpVjXQBueSLNhn
	gcHMU3X33735WeeC6c22g8FmKVdGK3+thecci1v/l2GSS5VjVO/HStSx75y10mX2
	68ErkOiRq5pUQapt9KCJt/G21sTxYeQEqB//9NgWaF1Z0HuCyUric/JKd7Y6cY8a
	zOzqF2zkI9+L0BusIRglmg4fO5XXg0UOGnRlRgDIhY42Z2YkzKlL3pXaPjHM7Vrj
	BcEqGy0JUcjAvg1QYTEUQFMa2TYmMQaLtNg+nVxBIYp2fmLBvOhzpLLnwyADO61y
	f3KqltssgM60xpNxG+pUw==
X-ME-Sender: <xms:NaU9aB7eLKNWgxv5Zka1e6W2Hm5-s8c1iuCfWMSdG-eNdS_mpitdiw>
    <xme:NaU9aO6iR9nBg06RIWiZrqaXquU0Etkn-2NRwvyI8bCObIe6pRQWvocu2qTb0abav
    VcKW5WL3Ky6wSgTCN0>
X-ME-Received: <xmr:NaU9aIeLqm6QtapFBuYB0dLo40nnr_Nwx97sK7FwhBL7Vsiq-8a6Z24rNZ6rBLa-8DyDQ-PtffhVxK0sY8j3oQHl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeejkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfhuffv
    vehfjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomh
    esmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpedvgeduuefgudejgfdtteff
    udejjeelleeiudekueejudehtefghfegvdetveffueenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughigh
    hikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NaU9aKIeUE-PF31kC01HUwsGdUGharf7Fqfj7QeqSNER7l9C6qV3nA>
    <xmx:NaU9aFJbPrZIQqsU_OSDpbev2Sc_dwH4EUuq4SphzQqmzYk_FgMbyA>
    <xmx:NaU9aDwqF2tpGXdyuau60fPpuDMJlhYOcBCffdNPwlXm0t4PQdNZZw>
    <xmx:NaU9aBJ1vNIm6osizIlX5-bX1sOIsY0tygpQtkE5vf1y5ho5J5-55Q>
    <xmx:NaU9aOah7rwkAmtjxF8aqYClBgsFg_L_Agz33RA_STRnSzaX0GBWoK04>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 09:20:51 -0400 (EDT)
Message-ID: <9738035b-e990-4e3c-a490-987f20f80e17@maowtm.org>
Date: Mon, 2 Jun 2025 14:20:50 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [RFC PATCH 08/10] landlock: Construct the inode hashtable in the
 new landlock_domain
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org
References: <cover.1747836146.git.m@maowtm.org>
 <e0fcfb45accc387fb0c6a4deca2724fc531b7bd0.1747836146.git.m@maowtm.org>
 <20250527.paeShie1ofoo@digikod.net>
Content-Language: en-US
In-Reply-To: <20250527.paeShie1ofoo@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/25 12:00, Mickaël Salaün wrote:
> On Wed, May 21, 2025 at 08:32:04PM +0100, Tingmao Wang wrote:
>> Since we can't get rid of the old landlock_merge_ruleset yet, we call our
>> new thing landlock_merge_ruleset2.
>>
>> Signed-off-by: Tingmao Wang <m@maowtm.org>
>> ---
>>  security/landlock/domain.c   |  87 +++++++++++++++++++++++++++++
>>  security/landlock/domain.h   |   4 ++
>>  security/landlock/hash.h     | 105 +++++++++++++++++++++++++++++++++++
>>  security/landlock/ruleset.h  |   2 +-
>>  security/landlock/syscalls.c |   9 +++
>>  5 files changed, 206 insertions(+), 1 deletion(-)
> 
> 
>> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
>> index 07823771b402..ac91d4a865b9 100644
>> --- a/security/landlock/ruleset.h
>> +++ b/security/landlock/ruleset.h
>> @@ -27,7 +27,7 @@ struct landlock_hierarchy;
>>   */
>>  struct landlock_layer {
>>  	/**
>> -	 * @level: Position of this layer in the layer stack.
>> +	 * @level: Position of this layer in the layer stack. Starts from 1.
> 
> Feel free to send a standalone patch with improved doc, I'll merge it
> directly.

(I've done this and will remove this change from this series.)

> 
>>  	 */
>>  	u16 level;
>>  	/**

