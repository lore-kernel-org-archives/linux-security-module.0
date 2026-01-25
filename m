Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFFC824BD
	for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769378575; cv=none; b=LH5AabMSqD2C2iTBYShX+Rle1Kd/DQVwgIYXo9sv8vLDPV+v6nSEKikSYAVsO692/aBkkin35Cj2GnEnO3ErijcGzpRS1dhj06dpp/ZtveDjHt07yENsW04ByEU44uBVLxPUumu2+6A9PUfUxEovFpBK2dMJiW5UucL6yDR3lfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769378575; c=relaxed/simple;
	bh=/8LNkr/eNmo/3pIUKh8mKCvIO5JAMNSpZtEV7nCbVzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKUH/FTYoly5zn8f+4QoKAxU/Ay4S2uMQRFBTfbnuscbQwxe744AWzho6FjxclD72T4LXIpvpFhH9J2wOvK0HzqAzA5R4mHjqHwk5BLQPNg+jzIbhN46jDc1EOWg9ZpyhKjU3a59ZLxezFWKCctIKG/Wwv2QtJYa/gjei7+pbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZeLHQTtz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZeLHQTtz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=UlMO8/8rc4Mp2JLPDuLZaDPL9bY4FotThhQfn24pBrs=; b=ZeLHQTtz4nXyyuFg0dY3Ue+Lmv
	sF8O1w3kCiPLOC+Q5s0exc9l6I69SScKYQ/XsTxLDSDlp43ta/dK6z4+CA9nxvLXjvtdhH2FHbezJ
	C/bQs9x942qsXA9kgX5JIaxZv8OFtJXDdJTcQzcqw2JLCPt3penXB2S0Z55vR0rem6AxIBMR80VjJ
	FGG1lLoBKcj11Q5nd4BZglxTJbBUR/K2de0VN6IBSN8ZH1XrY+QA8UgouBaJ6DTOwU9PbbtqU/Xjb
	Dqek4VRPSfZtYjp6pYlgME41rvLAV1eYIBAziTI9eupSCEfqlwuKAMekHd+xlytugpstByVj1RUfE
	zI7j+SGA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vk8C3-0000000BYC7-1Bx7;
	Sun, 25 Jan 2026 22:02:51 +0000
Message-ID: <7b7b8fd5-7e1f-4572-a342-11a0fd24b0ac@infradead.org>
Date: Sun, 25 Jan 2026 14:02:50 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] landlock: transpose the layer masks data structure
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
 Justin Suess <utilityemal77@gmail.com>,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-4-gnoack3000@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260125195853.109967-4-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first line here is confusing: "in @rule in @masks"
Maybe:

On 1/25/26 11:58 AM, Günther Noack wrote:
> +/**
> + * landlock_unmask_layers - Cross off access rights granted in @rule in @masks

                             - Update (or Remove) access rights in @masks that are
                               granted in @rules

?

>   *
> - * Returns true if the request is allowed (i.e. relevant layer masks for the
> - * request are empty).
> + * Updates the set of (per-layer) unfulfilled access rights @masks
> + * so that all the access rights granted in @rule are removed from it
> + * (because they are now fulfilled).
> + *
> + * @rule: A rule that grants a set of access rights for each layer
> + * @masks: A matrix of unfulfilled access rights for each layer
> + *
> + * Returns true if the request is allowed (i.e. the access rights granted all
> + * remaining unfulfilled access rights and masks has no leftover set bits).
>   */

-- 
~Randy

