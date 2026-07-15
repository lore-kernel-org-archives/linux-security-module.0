Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C3833F5A5
	for <linux-security-module@vger.kernel.org>; Wed, 15 Jul 2026 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784157537; cv=none; b=mumEX7oGYp1GczHbt8a5I2sPKaNOW3P4ZsjaTqEnegU5HxEU7PcOLxZOFI23P2kVuinF8g4W6wgw522xxti2u2+X1YKgkkMdxuEXVGhPH/v0cdKM/Fr4o8PCyT8CDb51hiuD6i6XNs/c6UpiRUYvijrtnU8Dw192tqsH93NaA9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784157537; c=relaxed/simple;
	bh=YmiaAOiqSES0n4bPaifm8LmO7QOF90ItLH9z60K/bso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDggET/iHMArzgo3D6W/bSf6hm4d5l+nFMQE90K8k1Kf31mwJ/87722n2xBInonXR593pmYMcF/QhHHzEEw3eIgME5omzYWDEXyVqMeWH/zVPQSKAsbKIS2v29ohSiFoeohB3+xwqyfrEcocZothDuREilSQLGeboV/o66ZL7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Dqs7y6+M; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Dqs7y6+M"
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 46D6C3F5A1
	for <linux-security-module@vger.kernel.org>; Wed, 15 Jul 2026 23:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784157532;
	bh=GRROHls+8Qjidaqe7pncrBWTjg3creWvtDpOFB0ZzUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Dqs7y6+MSZiBFaol//XssL3aF+8+/Qf9OjTJcAYxhtyi8byLiPJ2y8DnZ/uyucPbB
	 ay7LRandUPjO55LLoZHGqEEzOZwhQZx8dHRhuZzyqrCR5UKABXyAOCocUWjSiT4Wbk
	 dyilTKOImjLSP+V8hem9/lzUFkSxC3qcipFl7Bsx4B4kS+5s69iG0A6alWgOJZVXhh
	 WFk8LXQmLOnzSdkltn/+h82CkISylxnagKCsZxI4Xc042irPL/UBVtdJF6wCKL3gbb
	 kJG4OcaLBHTyw08fuanwS6JnifJxcazwf2GUfNFisXvpEFeLrTTDaqMKsbbdCJDA65
	 1HaHtCzZAjbSx9qIDV2X7zz3sAPOt4Ygxxfe1cz2+vpqP9IPZCXcnCoLusQo7FPVTU
	 0lNN7M4C1dZJ+CD2bObFYWwhkxAazrfe7xx4p5EshaRrTHxsjg+TAGf5QQkR060E7M
	 vlqGmrarDSae9OKFUY0mUrGiJoLHTMk3oSH0uzOhIffToQk5XXsBm1rNiCiEzTfhOA
	 k+akDVGyvGGu6zh81E76LVikhbgVl2vVLtWYxL5xr6r+cJbAuovOxRCT23nq+L/JO7
	 6zi19alCo2zwZy79u5BHsAtQXS5bPZgqzYQFtN8FE5Phystsoqkf8irEsKpayMSdjx
	 0BZ1A8PqO3Abi9VLRH2Ly7Ms=
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84870e7f498so6846677b3a.3
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jul 2026 16:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784157531; x=1784762331;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GRROHls+8Qjidaqe7pncrBWTjg3creWvtDpOFB0ZzUQ=;
        b=fpAYw73t4Wkie/lvFB/AEsSCLesbC2BploL0ckQ0tnPLucphhjCuiKAX3Nisdc8A3S
         bzoCFVS9omLGUsP0cU+tYEf/5ZCeB19YTSc99ISPBkiROwYp7wsRqbRV/QOG/FrcH6Ma
         ybF0oXbiKI0IrsvGVr2KaFPkPqliQZedN/uwOH3QueuO1cc4a/gwj9WsdcNBB7b5affB
         acYYkuFk/q5rOwLgklEYH94FbOnLoNwOqrMMxsd58rSuyF3J+pjT7EQuYwCzaduObiQv
         8kyI4acJrGQfzZo3zamHizcb4v6jaEMCnKVBx+egBTgXUhhWs15WxBXV3PbMgx1cg2E2
         b7hQ==
X-Gm-Message-State: AOJu0YyYdaeh1JSDN21O55yVrrQ/WvYe77Fpj8fbh2I8R6mq9MVxEM25
	vVLmfOZUT1uWwf4XDlYj02BrQLM8DeASVTi5tdPrqQeG01CpMw1whKURHU7EyO1wYpXi9oXiml+
	5ATVnsFhKRBkApfRulS41oD58LdpIwUItwvjSY+sUkd/gbVr9kobQDtqCYp3qPEy7gzdgTiYJBM
	2tXU2NZE8zberY0sbX4Q==
X-Gm-Gg: AfdE7cm8ZTse+2YdFMzJdcnr90u3fC+/mJF2slErkYbiqgpQotpXJpbfn2wXmrlyEqy
	0W1LSgJ/8VDWVkH1CQvUL9Z5EPtUGq/yCEUEUx1ymkeVMmPhx9qgokamsuOp7L15ctxJLflTZKm
	/LvaTXb8IpNp+jxjehj2g1YHaMAax6x68+PesXZf6Y3Ax18yZ62IUTboOYhf+p83GSPALeDDWef
	PgTL6b33GZ3QlawpZuqcAjX3gKITj5lOQXrwarNIfQ3ZBhbmoKmUuGfFNPbf1zlNbOEwLQhV0ot
	3bhNyfCNgiKImm68kKVPLM8P21HkB1euZXOV0lAwjUTRuZz/E6iB2hLmvuqaM8YmmpwomEVyk0I
	S+C/EYlOPAGg4iNI=
X-Received: by 2002:a05:6a21:a98:b0:3bf:6c04:a813 with SMTP id adf61e73a8af0-3c36c35c811mr5033588637.52.1784157530758;
        Wed, 15 Jul 2026 16:18:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:a98:b0:3bf:6c04:a813 with SMTP id adf61e73a8af0-3c36c35c811mr5033572637.52.1784157530390;
        Wed, 15 Jul 2026 16:18:50 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-cb258ff402asm834465a12.22.2026.07.15.16.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 16:18:49 -0700 (PDT)
Message-ID: <a14f5144-144c-41df-8f13-433b0b7790d1@canonical.com>
Date: Wed, 15 Jul 2026 16:18:48 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: replace decompress_zstd() prototype with its
 entity
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Georgia Garcia <georgia.garcia@canonical.com>,
 =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Mark Brown <broonie@kernel.org>
References: <83eb9325-9688-4a6c-9727-e137df773694@I-love.SAKURA.ne.jp>
 <df2830d0-5ae8-4bb9-b11c-6051fc3784ea@I-love.SAKURA.ne.jp>
 <dd652e1fbc0620d7d45e61f81336428860441f2d.camel@canonical.com>
 <66e44083-d021-4207-9f88-aa9ef737619b@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <66e44083-d021-4207-9f88-aa9ef737619b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/26 16:05, Tetsuo Handa wrote:
> Thank you. Please send to linux-next tree via apparmor tree, for
> syzbot won't be able to test linux-next tree due to this build failure.
> 
done, thanks Tetsuo


> On 2026/07/15 21:14, Georgia Garcia wrote:
>> Hello,
>>
>> On Sun, 2026-07-12 at 19:17 +0900, Tetsuo Handa wrote:
>>> Fix "undefined symbol: decompress_zstd" error caused by decompress_zstd()
>>> being guarded by CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y.
>>>
>>
>> Acked-by: Georgia Garcia <georgia.garcia@canonical.com>
>>
>>> Reported-by: syzbot+1f14a35d0c73d31555e4@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=1f14a35d0c73d31555e4
>>> Fixes: 17b5758bf35c ("apparmor: Initial support for compressed policies")
>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>> ---
>>>   security/apparmor/apparmorfs.c | 72 +++++++++++++++++-----------------
>>>   1 file changed, 36 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
>>> index 2ae9ab94a5a91..152c7967ff1ba 100644
>>> --- a/security/apparmor/apparmorfs.c
>>> +++ b/security/apparmor/apparmorfs.c
>>> @@ -483,7 +483,42 @@ static struct aa_loaddata *aa_simple_write_to_buffer(const char __user *userbuf,
>>>   
>>>   	return data;
>>>   }
>>> -static int decompress_zstd(char *src, size_t slen, char *dst, size_t dlen);
>>> +
>>> +static int decompress_zstd(char *src, size_t slen, char *dst, size_t dlen)
>>> +{
>>> +	if (slen < dlen) {
>>> +		const size_t wksp_len = zstd_dctx_workspace_bound();
>>> +		zstd_dctx *ctx;
>>> +		void *wksp;
>>> +		size_t out_len;
>>> +		int ret = 0;
>>> +
>>> +		wksp = kvzalloc(wksp_len, GFP_KERNEL);
>>> +		if (!wksp) {
>>> +			ret = -ENOMEM;
>>> +			goto cleanup;
>>> +		}
>>> +		ctx = zstd_init_dctx(wksp, wksp_len);
>>> +		if (ctx == NULL) {
>>> +			ret = -ENOMEM;
>>> +			goto cleanup;
>>> +		}
>>> +		out_len = zstd_decompress_dctx(ctx, dst, dlen, src, slen);
>>> +		if (zstd_is_error(out_len)) {
>>> +			ret = -EINVAL;
>>> +			goto cleanup;
>>> +		}
>>> +cleanup:
>>> +		kvfree(wksp);
>>> +		return ret;
>>> +	}
>>> +
>>> +	if (dlen < slen)
>>> +		return -EINVAL;
>>> +	memcpy(dst, src, slen);
>>> +	return 0;
>>> +}
>>> +
>>>   /**
>>>    * aa_get_data_from_compressed - common routine for getting compressed policy
>>>    * from user and get both compressed and uncompressed version.
>>> @@ -1517,41 +1552,6 @@ SEQ_RAWDATA_FOPS(revision);
>>>   SEQ_RAWDATA_FOPS(hash);
>>>   SEQ_RAWDATA_FOPS(compressed_size);
>>>   
>>> -static int decompress_zstd(char *src, size_t slen, char *dst, size_t dlen)
>>> -{
>>> -	if (slen < dlen) {
>>> -		const size_t wksp_len = zstd_dctx_workspace_bound();
>>> -		zstd_dctx *ctx;
>>> -		void *wksp;
>>> -		size_t out_len;
>>> -		int ret = 0;
>>> -
>>> -		wksp = kvzalloc(wksp_len, GFP_KERNEL);
>>> -		if (!wksp) {
>>> -			ret = -ENOMEM;
>>> -			goto cleanup;
>>> -		}
>>> -		ctx = zstd_init_dctx(wksp, wksp_len);
>>> -		if (ctx == NULL) {
>>> -			ret = -ENOMEM;
>>> -			goto cleanup;
>>> -		}
>>> -		out_len = zstd_decompress_dctx(ctx, dst, dlen, src, slen);
>>> -		if (zstd_is_error(out_len)) {
>>> -			ret = -EINVAL;
>>> -			goto cleanup;
>>> -		}
>>> -cleanup:
>>> -		kvfree(wksp);
>>> -		return ret;
>>> -	}
>>> -
>>> -	if (dlen < slen)
>>> -		return -EINVAL;
>>> -	memcpy(dst, src, slen);
>>> -	return 0;
>>> -}
>>> -
>>>   static ssize_t rawdata_read(struct file *file, char __user *buf, size_t size,
>>>   			    loff_t *ppos)
>>>   {
>>
> 

