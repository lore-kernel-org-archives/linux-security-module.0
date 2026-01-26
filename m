Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955234D390
	for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450156; cv=none; b=IgC++u+J7auAvcjAFT81bj3+7hvvUhuVAfrgZTr+ftRNlvzU4yRjJRnY90mHbAx8vOn0An8yCo4G83Bmn6qZxtQg046GiCgtVxn7EZPlA5c5n6K5i/N/rUhxLt6PbjBm8OcDq8LUgmTo4qwLERbT20foUbF9mSJmTxK0w0TpcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450156; c=relaxed/simple;
	bh=W9DRjOPAVpHjT2O1j9oUr2MBPeqq6bmnMBBGGuZlkgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyk4Jlf2KlnK8ANLP0wgNZ0BrA2oyWFYdcHeWBNk2P/5DQ0ioLadeWKMLdJ8XlOQMJ86/uzpnCHDSqFSvL7CcgIsWmANIQW72BSIynDC4dzfyUrbb0jNAMoRHm/kTiTTpegB9h8ZbktHEB8eqQi9GblAPs6aI6m4DkUpZPl4x1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VPwhaQYY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VPwhaQYY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=NrtTHT1WuCqdftMCpD7Z34eSW1yX4kdbcp00nY35cbI=; b=VPwhaQYY8QOUhwqoXUCwLNVBzY
	KHIQSFuZIzNBGwCHjlrI1Zos/j7DpDToS+TOOG6R3sZQuRU9E1uPYE3qwrSPQTBuOLrCcqVEq+Ma5
	hPMAbbg/iEKisVUbPVhVgrINLB4Lbrjy5IndxnuBoilRaQu2/tHJtqW6FYRY2U+Rsv2478CS4inty
	iCAKdwyoAhkpChS87icqaw2tDgyGKgkae0tTnBa3Vzl8gRLrwarcLP1wTYyxc6BFMDp+LfF/Y+XBu
	Dwc9u8/cxwrpc0EeyhgLXe0fVk4Aqr7oqUI7YXMAVoTsg4dOndOywnwOkRONRLpnYOciH6Iu9Y5wi
	7RaBQVPw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkQoV-0000000D1QR-2R9n;
	Mon, 26 Jan 2026 17:55:49 +0000
Message-ID: <d75185de-d8e8-475c-be57-9100ddd2d9fc@infradead.org>
Date: Mon, 26 Jan 2026 09:55:46 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] landlock: transpose the layer masks data structure
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
 Justin Suess <utilityemal77@gmail.com>,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-4-gnoack3000@gmail.com>
 <7b7b8fd5-7e1f-4572-a342-11a0fd24b0ac@infradead.org>
 <20260126.fd8c7b7537e1@gnoack.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260126.fd8c7b7537e1@gnoack.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/26/26 8:52 AM, Günther Noack wrote:
> On Sun, Jan 25, 2026 at 02:02:50PM -0800, Randy Dunlap wrote:
>> The first line here is confusing: "in @rule in @masks"
>> Maybe:
>>
>> On 1/25/26 11:58 AM, Günther Noack wrote:
>>> +/**
>>> + * landlock_unmask_layers - Cross off access rights granted in @rule in @masks
>>
>>                              - Update (or Remove) access rights in @masks that are
>>                                granted in @rules
>>
>> ?
> 
> Thanks, that is a better wording indeed.
> 
> Will be included in next patch set version,
> I think this is less grammatically ambiguous:
> 
> - * landlock_unmask_layers - Cross off access rights granted in @rule in @masks
> + * landlock_unmask_layers - Remove the access rights in @masks
> + *                          which are granted in @rule
> 

Ack, that's good. Thanks.

-- 
~Randy

