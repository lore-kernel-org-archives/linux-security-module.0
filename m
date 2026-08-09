Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B33B21256C;
	Sun,  9 Aug 2026 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786291283; cv=none; b=TtKTMJNNzCZXj01vrL9CAQ64n2Nd5fymB8bctNhMdgx/nCQymaNodZmtyEY7qP0IOukB07DFHut58qMdQqI9CMuiCCiua2vlsKg5q2KyOUp0GRxGciAebqXV2NX3rJfDfbOvN3GggYjh6/ldF7AJxWiuR+9rzqMUhCZQEliWuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786291283; c=relaxed/simple;
	bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzQsuDKFjqPpH5Fradim9ZAynhbz9dx3cW+qND5CJ5YoYUgWC/2A1SssM2gM3aKGJgI4/m8pMJ7qBHQ6vrKmkXvq6U7/QEA04qqjvxg5xb0CkqyMK9gKkv9jfJnQKSIU/CKksG4uNDQg/E5ZlYoQI29Stbf7LG163bfvomKoWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=C98RkyLq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dAdmSYUu; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="C98RkyLq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dAdmSYUu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 855A0EC00A7;
	Sun,  9 Aug 2026 12:01:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 09 Aug 2026 12:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786291280;
	 x=1786377680; bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=; b=
	C98RkyLqAeKPffcm3kpuFaGkK2As0WCeiC/o83M7H5cmRV1ZIpOOxkqS0jY43b+7
	aWBx7yjLDwnX1HmEYrS0FVwsMYXl93JsPzmJ6p88CTiT6t8mfDpzl2uK/v6bEX/e
	IAqOrfm2QoRGQAIv2T7hoWMnN3okYb/O2UWqvmnhGDSlpc6ojF1qOdbr8PvdXIdN
	wORLAz/qls2IB54md9ldhC28t8XydQKDlY+Uzx7LoEw0gfcUkHAY1oJ3K1BqONM6
	eUFNiPZSaVLe5/UyKKiilUaFAO/PVZRCS4f5O8IW/r6dxJCpBgX1upvo0syucobz
	E2TzKEMkKYsbPxQXSdxEIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786291280; x=
	1786377680; bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=; b=d
	AdmSYUuCfDuJBs6e4QGlHWtR07IidkiL+sK7RKv08crXZI4y9NEvIrcscZq+fPtM
	eM2bH0uns5RvycZeWjwl8QXPEYZez3bhAeECiJr43jpYLeu0Y9ldM1x/geaYCGo5
	jT1GbLk9I/CC2UUKRiGy4IDsO34m5nx/Xy90cLkRrx6lmBGMEo3h3npgqmCRUa2j
	ZbmxHdYCr7sHmbXqiJ5PQFIf6lw3u7gYyVp5/tvJ/ZdgiNkwAj7Uo8F+7ko8pjTT
	ozuvHTXEShg2YHiV0at6odJaqk0s52gcB6C7oELfTWs1IkfausOCyOLgoyxaswhF
	xc8J5786nwsZw5dLLOqpw==
X-ME-Sender: <xms:UKR4arQqiSSyijb8ldwiQouMcSGWYN3ZxUtHr84QMnThzsoDK7CVIQ>
    <xme:UKR4altAsUTHuIW4c-FG0hKGIY5BOvVwnNi6ai97khwcrbLxzf_as6iOa3QWMpnd2
    nmcGaO2wxaBJS19eDGrAbnPblQSPSbA5qrVgActH5LuizxkRRXEyuP8>
X-ME-Received: <xmr:UKR4asZwZxOq9kxanDODPN0IaW9w5dLBHPabqKMFS-298lVQ5sXzOIotuqRBHhQXjZeUjqQknL40MdlwFA>
X-ME-Proxy-Cause: dmFkZTEjx6qIP7eMhzMZphCIXDAnOfYjQaD0F3caSctHdgFSZOEkZD/vXKVMYffUgbhyul
    QfdhmJHq572x5X/XzXor6K93EqZ8wB5g+VSSl9M2B/USDS32cYmv5HtVlIBB1UeVr5/oWL
    2ybPhX3wMnA/l87AGx0GJKI0ejSSc8pWgOxwtDSAaH+tEC5L7bFrUSvCfRvonZLbWVrYpi
    V2KxpCFEsieYDL0zXH7yavTuzUJQgzM3R+A+3rQ0Y44hLZCHVmXr6fCzQtuUWRRqktWtsj
    dEJdIPQsOYmTuTrTdvVrRVCYAEyPEds4xBjLw7ddKU5iv0C+C/Iv6tehNTnQJCYLFYnpr+
    gA4sIYyVcc34GoKzjhbbcWSnqIlicaZ4wn+/JiZGgBPngvUWpz4c2zGqzqcn0XuNxqJRK7
    BkjjJ2m/9+jawGQI69iaGIyyOyHbyx6ezOM6c+HIRmMPzzNYs+gpstM9Uqm3sY5rVK/Zd+
    hUkgvqF6I24Y+HVUF4Qf2r/yHpINVI1Yi4JAVdCxUioLVs8NXVI8uaARxNL0/dCFilPDrw
    pBpH7JoF52mqf7G+OjszYT6D7QKr1ppacxqyxxK1+q4tRDlaPFIQ1Sg1f0nfWhD0w6k32V
    +e41ctHSpWaKyhSuWYuN5/sTQnENPmERc1Fam8rprok9yFuecE0UMefHMiVA
X-ME-Proxy: <xmx:UKR4arEpVtS35TZLMUJSy6LVTcIxgqFfoEj5etPJ4ZNcisPaUNQYpA>
    <xmx:UKR4agwhFAg9hq2Lwp4siF4tm7IC8m0TYx7vvdC3qeRHYTiHYjVE2Q>
    <xmx:UKR4atlJQEn7d8idLWqtzu7OPmsKwZZCO9prG0Y0LodSOhxJjE_IeA>
    <xmx:UKR4apk2OpvEuP_8yPUUpIAldQ3-5QEvL0cPtWkS4g9h_J3j0AYWGg>
    <xmx:UKR4aswhYR7eSvUwaTQxP-ocPC0vXSu6HYKz7FcWIGqgVXkAbecElZlH>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 12:01:19 -0400 (EDT)
Message-ID: <5e6cb8c8-2d83-4190-b83c-148c490adcc8@maowtm.org>
Date: Sun, 9 Aug 2026 17:01:18 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] landlock: Rename quiet_masks to quiet_access
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260726161400.3010511-1-mic@digikod.net>
 <20260726161400.3010511-5-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260726161400.3010511-5-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tingmao Wang <m@maowtm.org>
