Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD4C2AD0C
	for <linux-security-module@vger.kernel.org>; Sat,  6 Jun 2026 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780765891; cv=none; b=U7cnNrt0dtCdWe6E4vjqfy1HfHlCAaYesgsRZ9eJsovlcCL3wPzN7kSY81m8f+JJq7eisyycWkJegHFC5Oh92YMHd8XYqXDftCx+JHLJK33sxaJRnkMv2b3KnKLhlVLzhM6smCx+P9/SVT8rKa9A8WdDmvWiY8Se9ZJpItIjX8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780765891; c=relaxed/simple;
	bh=3Z2UAsY1LZlww6K2mN0japDUEvT0Ef8G9Gu18DtW9S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIFZR3kdV9sg3tEDjdkBGH0xhj4paYwXPOW/VxZmSR5IPXZSuMf1S3dVV2umgDVNNmiDgVJyPOEnmHb3eprVSjMIhCj8fvCbcLuZC2grO3l3nuQq0jlVwNJ8mihqS3FqrksdRqILeG9JLv/gU5gwP+fnGDIQY1InHPS1VLd80mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=IJu4uxmS; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="IJu4uxmS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1780765887; bh=3Z2UAsY1LZlww6K2mN0japDUEvT0Ef8G9Gu18DtW9S4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IJu4uxmSn/EBZV9Ipk5D2ieC7zl+SgOuQjETxBHePErm6VMnvOanMKl1MTQdaR3OH
	 B9Fr9Da57tKYsCAcPn9kLmHf2wSpC45bcNgw8hNYlvnOJGJcwRGZvjEgarCbwkgM9M
	 BIn5oh3Ak07SvU4VO0zN5i97mJPZALAKrAXQefUlfGdHaTrF5jBj+Mz63afVbfPc1i
	 lbOFJkHpDtsfFVVyMvNqvIa3R04bgHwf+YdCaOZf4Ad3gZarHKfgQKSwZlQSFN1Wo2
	 TIZcbnRwpONKcl7qSWj85o3B4/UsNj324TIdWzKLCOPxXU540BQkT06uLbILv3UPDM
	 40LjqZVUn9kwQ==
Received: from [192.168.100.2] (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 2E775125930;
	Sat,  6 Jun 2026 19:11:27 +0200 (CEST)
Message-ID: <e561a8c3-de10-45ba-a931-27b9a5751dc9@buffet.re>
Date: Sat, 6 Jun 2026 19:11:27 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] landlock: Add UDP connect() access control
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>
References: <20260502124306.3975990-1-matthieu@buffet.re>
 <20260502124306.3975990-3-matthieu@buffet.re>
 <20260522.reif5feiX0Ce@digikod.net>
Content-Language: en-US
From: Matthieu Buffet <matthieu@buffet.re>
In-Reply-To: <20260522.reif5feiX0Ce@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/22/2026 11:10 PM, Mickaël Salaün wrote:
>> +	 * Note: socket is not locked, so another thread could do an
>> +	 * explicit bind(!=0) on this socket, changing inet_num to non-zero
>> +	 * after we read it, but this would only have us enforce an
>> +	 * additional bind(0) access check and would not bypass policy.
>> +	 */
>> +	if (inet_sk(sock->sk)->inet_num != 0)
> 
> There is still a race condition, this should fix it:
> 
>   *
>   * Hold the socket lock around the inet_num read to exclude
>   * udp_lib_get_port()'s transient inet_num = snum write that is reverted
>   * to 0 on a failing reuseport bind.
>   */
> if (inet_sk(sock->sk)->inet_num != 0)
> slow = lock_sock_fast(sock->sk);
> num = inet_sk(sock->sk)->inet_num;
> unlock_sock_fast(sock->sk, slow);
> if (num != 0)
> 	return 0;

Oh wow, nice catch. The transient write in udp_lib_get_port() indeed 
requires locking, a READ_ONCE would not even be enough.

>> +	port0.ss_family = sock->sk->__sk_common.skc_family;
> 
> Looking at net/, __sk_common.skc_family (and other __sk_common.* fields)
> should be replaced by sk_family (see #define in include/net/sock.h).
> Same for all other __sk_common.
> 
> In fact, it should be READ_ONCE(sock->sk->sk_family) for consistency
> with the net/ code and because the socket are not locked when the LSM
> hooks are called.  I realized that the existing Landlock code have the
> same issue...  Could you please add a new patch (to be backported) to
> always use this pattern?
Indeed, setsockopt(IPV6_ADDRFORM) could mess with these too, I can send 
a separate fix patch for that.

Thanks!

-- 
Matthieu
