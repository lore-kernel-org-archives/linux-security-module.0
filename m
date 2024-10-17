Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E941DD863
	for <linux-security-module@vger.kernel.org>; Thu, 17 Oct 2024 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169340; cv=none; b=jWapBEisKa7Ja06ud4PvE+vAvX0Q43hmp3b9iRd/x0tStLtrWGiRy2gL8PWwbjRUHA/40cMAunknbCcQEVQPxXVgXliLq6X+X5UVG14dEIsg/LbmKFpr0lg9uZE23PU1Q1hiZ7/en6vxoCO5O4kA9ouTgyOB3v/pr7S2OMqoPb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169340; c=relaxed/simple;
	bh=75juBRQBjqsSs5fOsfv8qEeQjqsiZYb288kv+pdKA/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6fs9hWzq3nLCUpjI8uMMDzGaky+cRTiw8TWgHJiBbTIxtaYg+xDPl4eRTgzn1z1javpo2EPkXf0I46Cf0bm8fB1CZkqIIirSLS083eECT68GfgBVRNGVLuM37EMlWU0+xMNHjlsWJr5eT5UA76COU/gPAKArCAEmWrvTxd4pQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 49HCm5GP011859;
	Thu, 17 Oct 2024 21:48:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 49HCm5YY011852
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 17 Oct 2024 21:48:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6be6d6dc-ab48-4399-8460-2b82dfb59742@I-love.SAKURA.ne.jp>
Date: Thu, 17 Oct 2024 21:48:03 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/8] landlock: Fix inconsistency of errors for TCP
 actions
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, mic@digikod.net,
        gnoack@google.com
Cc: linux-security-module@vger.kernel.org
References: <20241017110454.265818-1-ivanov.mikhail1@huawei-partners.com>
 <20241017110454.265818-4-ivanov.mikhail1@huawei-partners.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20241017110454.265818-4-ivanov.mikhail1@huawei-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/17 20:04, Mikhail Ivanov wrote:
> +#endif /* IS_ENABLED(CONFIG_IPV6) */
> +	default:
> +		WARN_ON_ONCE(0);

WARN_ON_ONCE(0) is pointless.

> +		return -EACCES;
> +	}

