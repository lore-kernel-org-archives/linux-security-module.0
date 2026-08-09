Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C5D2874E6;
	Sun,  9 Aug 2026 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786291298; cv=none; b=bVw44AIilqhlz121vzUmRZGDbUXkdyT+pQ9qENtskIjtOAvw28/zXqEAGEW4uXZCaeXJkQYXejXHanO8EkuibqhUF0/0FUwo8WAMp7/XYTXTsLjof8zsZZVK6PPyAlBaUwyjN7nzfxEqItxJbwBzrBBditJ54mmmdDLRajvSYvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786291298; c=relaxed/simple;
	bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iw9JSIuOCf5Uz93j6itaSQFTxoPyTlfgIt0YAnAwmjCmXdjVf7BL5/W5hzOni+wrre1sfHZsCiZkF8VfQt8BKS6qTAckn6RbIYVeD3+/fP4YD5fBCbsHRbZBTvTU2sUjR4v01GisaSOruUgCEk0hh+lvuOO7nfm/4ea0PCF++xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=SMilG5tt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R7y6OwYf; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="SMilG5tt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R7y6OwYf"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 596F71400040;
	Sun,  9 Aug 2026 12:01:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 09 Aug 2026 12:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786291296;
	 x=1786377696; bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=; b=
	SMilG5ttwOncVftq2ddvv7GAigMBRHmeOaXdCNCS+4+AqE1R8tvu2msi06p5WRZh
	ACuyjgE9le3OQVAezZxWsB08WTx3PzV1VeR6BpEhvG0bypzv+9aqdpIZs3+VMz0A
	L6Tv7MujJqV1D8/sqX72cJE4lzpz+qrj9aL1p4iO5vlrwsviEsoOmJwUCtbyKl6H
	c0X66DoXbyesKEUvejCBNe6kUnQbUPW7V3NxOm8+nzETJURC/fLoFkneT1cjVDwE
	omL78Iit4/YCAR6oTTqRqjthEeADAlVfff568NGIP98YtgmwQAqC0f0xSEEEvKri
	hkmdARWk3aG2otRoMx2cQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786291296; x=
	1786377696; bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=; b=R
	7y6OwYfv7TPxJnAsze4p49+5Q8mNMBMApNLcvOXuZEdqq8KhJk27kkGFKOMwKjYW
	jCigEWr5Lio9lEvfdjec0Ticowmr3NIgWzaJ3tRaA9BP3hrbqMw1VCRvxVjR4iGI
	WtIrkbJuzR+QFUx4MeYQVSRnkAARD6bistn+9sfADeSL8NriNW1hjCrjuEQQtEqj
	E93gZ2G0xSIbDr9LDqXwjy/4QjlvbvaUSzF5mwXegc/Sp5quV2dQ6dcS+2kKn8ZL
	jv8LSoP8hK9Pgib0HZo7UfTSCORGMfpoO63rIKUiG8RzBcqrnylEYL3qg1FIjInY
	tAOs9Vzw6ntjnyyYcJWJw==
X-ME-Sender: <xms:YKR4arOczrLHYRUYlzptffghFOMxSRgw0ImzKP7bG0idwaUmMNgeow>
    <xme:YKR4au7jwXVClFzryj1ZYoJQ9noCUFn9q96ndoe0pKAQSVxePATXrNwyd8U2GzKgS
    MDz9z_6Ez-mneTPBno9b_5QIccxsTKpMs78m9dsffR91KSIG_G1jw>
X-ME-Received: <xmr:YKR4al0o9y_g6yqvgXweaSTHqPP8-PcMXaxmdvYr2-bvT0ovN9oksnD1acDbP6WDZwbOOdC0q3TNA-PDRQ>
X-ME-Proxy-Cause: dmFkZTGuhc7NZoMIsx95rMrkefb5T+XYZyxpM+miIfzIcJc2dCuDnw+PEgqtyR+NCrJmY8
    87abJStCrcJHL2joaPTVbU56IKTZXRsMJ8jdqKzU1I3lWdeakgTLfHj9+8Yydd0pu8Qhl4
    bo/utV/5lXb7RUw9O090S9ZPP3gd/OyXXvnxjyHurq++2NLVxkHZCT9+XnfnQPPDviEjso
    iw8zsDm1L8jr5gcQw1CLToJRrYcQNhm6mNIp/xpWXvo6DjXtG5mcjoPTNW1oxW06TCvEhM
    BDy5DSWrOZlK/QdMdiFEEo+G34zqRsgN/lfQ5Mn/Cu2h873QuWu8V4gmbJofCwL7Kj9hL0
    aeoWzlGEihd/n37Y5RZTGJBUGBrGpUl3rMm1/o6/0+CsmFMWD5g1CY25+3RG4mhOOP5sq+
    6mFgoK15R0ZKSIKKXsXgfMxTDSGZkM23iAyALbmAwv3J07tJ63IFjc2HkZRmjMToInTZpB
    wtX0wzJFsf4RniMh2vMbRl7SxWR6h6GQobyltfGNim544/BO4J8HwXgus9RPUfeiLqohF0
    t52+P5WroQNJvmUj7jShcnoVkCE/fuAWjWIq1yc3oElrpQWqbGhMOaexJkw72FrhO/wm2/
    YVoLEJXx0vcOU3Q+vAK9NHobcAp2s7Ppy8lYqar8f2krdDGBKIzoUv/BYlxA
X-ME-Proxy: <xmx:YKR4avz-rE09z7xBWsMCAQOYMQeiU55AwKt6MZ1IHvRv8hVQ6HTJSw>
    <xmx:YKR4avtT0mAB9Y7Nlvy8BrLGV0YaYE0BLacAKhB8tKYSIPoTr5Iqzg>
    <xmx:YKR4apyzUiqnJzYd93Abh_B6-8-Oo85s0XxqrWMQy_WiVZy5LYqF5Q>
    <xmx:YKR4aqBw2pTq4P-Yg-MT-XWP0IrA_Cl2GZ4uYkR5DboNug100ZlrCQ>
    <xmx:YKR4ao-Gzj49isd1U3X__b180eWvOeCnGT7EK-_Hq9VMX0Zm3xkRsoar>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 12:01:34 -0400 (EDT)
Message-ID: <00b581e1-c92d-4784-bbb6-ea94ba8ff5e3@maowtm.org>
Date: Sun, 9 Aug 2026 17:01:34 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] landlock: Enforce capability restrictions
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260726161400.3010511-1-mic@digikod.net>
 <20260726161400.3010511-9-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260726161400.3010511-9-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tingmao Wang <m@maowtm.org>
