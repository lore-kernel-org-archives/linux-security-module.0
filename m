Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974DE361DA7
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773813606; cv=none; b=dOnorrYXcoKoNVrQ3XPzLNKiZFj6m3TG6pahmHTnGnB5jXDBWWwpQ08jw/eQnf3HrJSKRmBtNNrSg26d40UPZW3bTvUAj8uO4zC1N2GtErPRofi6V48gUKZLEkvP4yXFheG15idrs83LpPZi6t1InRhDn+w6VRIuTVTwDpHOb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773813606; c=relaxed/simple;
	bh=7WWRN1vIAWhzuNuAj2IZfH8hqINnziFMhTwSlItkpVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gc/SF/NPfZ6slD9ZBVImYJYhmbG/OiQiJcIc7PWHO4Yk17mQ+mVJqmFfBFSbYY+oHtTEvP7Y7lQnwcZBom2kPbIRZoKZIIDg58whjkUKQa9YSMFo+qnMNSBJqqxdU2AKJFcs6CcP+fRiUfWrZvvkrUoBdovINmK8+6W2yPPFR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=OgKDZzps; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="OgKDZzps"
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B2BA93FB75
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 05:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1773813221;
	bh=TaXaxCufMl6szy9eE7qxF5U+KCmrPgzfU+BhVZEw+sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=OgKDZzps2L0Wnex69+6ti8ktZRd5cq8jfADxnwdsKM5ETb2DcvSYj2/UHc5SRMfCr
	 3C/w36tvTZ5zBjj21ZlU70r8SrW1bmX69u7lDbxbgWtsltPpIuXlYoBG8BsSZHD6y5
	 msYXeVHzQom2LBRODozOUT3Bj+DESUDhEoCZVlO6nCQlnvyJYPnjmuUr2+/Ero9e5M
	 OJ2mEMzMaQJVTKI1dcTPuLWm0eLp2EYiouU7tSAu/My+eafua1wLYpfCGym3JVktF8
	 c/vYW7Bl5TIkCcMMz/Lucrky2qt4Jgqpgy9/4GB0Dv7oN7rfMHC2H2A5ZsII1vxOvq
	 w0UqCPQ8K9O6hMzTnPsIlfdTaBbZSbQ/1Yn+FKzr0kIi7gjvCxi4yCYKFhgWBBSljZ
	 Y0xkR/8v3uVgXUy+kJZ3YohlN30D2Xyp9h+UAscfhK/3ZptfZNoJQ9A+WAMcoLFOn2
	 xkrj6BIousqHH5S89g9rpAwhMEFE1IzqZaWp6OPdBQlJ3dtxyMutaPIHX8tYiKuYvy
	 3aa5lPRIc1m7vlYucPavQHJLEA8rmQBncdQeF4KMybGrI6tj/cUSORRJKHaHTEvgLZ
	 pd9bcVuwyvi8O95ipFEPL6/3MS3HbllcvhHIP8f+7+egKRgauZDzJXBWLhOIxH703F
	 +BShHMbhD08Tvfb8SVIZcTNI=
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c73a4983fc0so4128788a12.3
        for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 22:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773813220; x=1774418020;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaXaxCufMl6szy9eE7qxF5U+KCmrPgzfU+BhVZEw+sU=;
        b=PWXSESIeu9ANjXwVJIknCrh/sc6Wx4Yu/X3g3haseTtbLq3T2Vndgchggrhi5r4XYF
         twlBKVaXpwBQpjK+aZKN6xVj1RnSCsbcNq6RKemboBW1w6Na8oeMwaGz3jiiotq6uaG6
         9q3CjQu/BFfEIt0XYojDyS8GjT6EQnvqXgBM5VIAtX5luM0Wh6J4ssPcSMjASASzMT0W
         W5EWswF/JuhKlayZ2iJqIanmelz3s+ArAWSrcyRWEJFstKTbuKipW4WODG2uGG1+eSny
         h2rNIKRX2cg3q15YhL3E0FGsGyYylQYhhsFItjxkAj2rqjX1if8dTXWtK2kCiL+7lzyo
         /+dg==
X-Forwarded-Encrypted: i=1; AJvYcCVawqn9s4XOxTFk13mcSxeIEmfrz47sKcVO/TNuWvtcKmFvgmoCcUSY1/pNgBEbG9I/XkycGzKRN27xQJ7j4Y06t76grMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuKGfhdJGNiJeIJ7CHvYbF8Mexc4hfqVH6LDIPZIQGFg6TekO3
	53fTaYUbBfTfC+wbtMs8GCegYy/CgE9XUvgOk5hhKA5BUKVp2L2xEVSmJJ9f2nqrr9T3CeoriGz
	CGn8SkVi1eMqHB0Ik6VYJQ+6S1+g72Ke8rqzmAsIn4Pu5/pVFuNeHyQnvtiA7GCZ1tgbwxAjGvo
	fcLCj62KTOZYIkgMhOpw==
X-Gm-Gg: ATEYQzyzkkPofhXkLrWMhpIMes6LnTfu9VZSXTssZKofQ6j/dFhC70ufInVBJkXupYb
	YVBs/JmJd74LCk99i8l73KDoNZsZvhGcc/JETHRlla2tC2X4cQOcszGOJYGk6bvme6RZMaFU56q
	EiTLobRFjevaeRCIuFZ9vOf3RNuC4X2i1rWllvNvHpVlIqVhPO0YvOuspD3H2x+UQ5p96aosjDu
	bvtJ+guTpj/vh37pelpBb3bJhMEmIpkRKYt74Ax8IXcBkTJOkLjfrJWtmWTbYr54hlO/2t28yIP
	dEMvr0XWVGOc/iEW76cp66xFUriMfXsqNMzxsD5SYZrTgaNsUyFbWo0Ymf3w2vov0RPxANWndAK
	E2F/vp/V6VSGwCTC/kJD1BzT9BEHRcw5LFNZGsA==
X-Received: by 2002:a05:6a00:28c3:b0:81f:4884:4fed with SMTP id d2e1a72fcca58-82a6adc8dacmr1917295b3a.7.1773813220139;
        Tue, 17 Mar 2026 22:53:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:28c3:b0:81f:4884:4fed with SMTP id d2e1a72fcca58-82a6adc8dacmr1917283b3a.7.1773813219816;
        Tue, 17 Mar 2026 22:53:39 -0700 (PDT)
Received: from [192.168.192.71] ([50.39.102.197])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-82a6bbe200bsm1436681b3a.44.2026.03.17.22.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 22:53:39 -0700 (PDT)
Message-ID: <779f2d5b-a5af-4137-a1ee-78dc9fed58e1@canonical.com>
Date: Tue, 17 Mar 2026 22:53:38 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [apparmor][PATCH] apparmor: fix incorrect success return value in
 unpack_tag_headers()
To: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260210172159.535137-1-mpellizzer.dev@gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260210172159.535137-1-mpellizzer.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/10/26 09:21, Massimiliano Pellizzer wrote:
> unpack_tag_headers() returns `true` (1) on success instead of 0.
> Since it's caller unpack_tags() checks the return value with
> `if (error)`, a non-zero success value is incorrectly treated as
> a failure, causing tag header unpacking to always even if the data
> is well-formed.
> 
> Change the success return in unpack_tag_headers() from `true` to 0.
> 
> Fixes: 3d28e2397af7 ("apparmor: add support loading per permission tagging")
> Signed-off-by: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>

sorry, my reply to this seems to have failed. This was pulled in for the
7.0 PR

Acked-by: John Johansen <john.johansen@canonical.com>


> ---
>   security/apparmor/policy_unpack.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index dc908e1f5a88..221208788025 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -825,7 +825,7 @@ static int unpack_tag_headers(struct aa_ext *e, struct aa_tags_struct *tags)
>   	tags->hdrs.size = size;
>   	tags->hdrs.table = hdrs;
>   	AA_DEBUG(DEBUG_UNPACK, "headers %ld size %d", (long) hdrs, size);
> -	return true;
> +	return 0;
>   
>   fail:
>   	kfree_sensitive(hdrs);

