Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6C253B73
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jul 2026 04:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783312922; cv=none; b=hVGVRd3gUyTKl9HaH2NiS2VppGjEurPwaVsfb1CP+6857AmoCcScRjY3Jy2M4IU8iDRczohT/dde6hapc9M/0rgyObWHRoml05ioAsGBP++8FuAIFVJLhcsXQVxSRh0ZhIE0in1l8RKGez1AXmo272M0pz1cPs8GYGOSmfwTDrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783312922; c=relaxed/simple;
	bh=HO7j9d25A2cB1oMUga2zN18ssrjm2JjjQxJR7AEFmL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWfeASoDEPvVwThWovQo1ip57Gf0UsDt4sHTZXi3DtnwHCB7/p35DsXlp9oxieBvSE2nbma3FdXl+r0ZSWaTwZkSI8ktLF49+lG4UuhiMvTEHmU9pmRXVJu3xGYkP3zji9RPZUGZivaFGest+jKAlEY4snQTHEpfUvjBmuw04LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/UgqI8l; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/UgqI8l"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80bb41f7f3cso21387747b3.2
        for <linux-security-module@vger.kernel.org>; Sun, 05 Jul 2026 21:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783312919; x=1783917719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=59VA+2WQhV/xwTEhpGDxGn1crd8YdD2r2kEXteaZhVU=;
        b=V/UgqI8lilwIDMg/DuHPVXsC6A2S0m/b1Au3SJQW3Pp6ZbRtFuv0WxLSdpbFo2sgMb
         FhwTcnxNeSjFEcwPxiPjWCAf1DMUEKdCdyLqrpTgGEVixGSlig5IPMJSbeqq5M7H5zoW
         WScc6NVIb6641rGI04+1bAaWYCox9uqItkfdp72o7e77+Zd6nt8/OdLbyd4otfRxMbmr
         ePaoxi+tc8qM9fjlymxaecn8Bo9+71O9iJ0suXcKlYQPp8xUc4I0I76Riq44hfEAkRD5
         v3tY6qzpX/xd8I9VuSIFptAsFW3gbrOvL33PXTjj4g9OJ8t2nPPLSo/p6J1e7SGu9Rlp
         o4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783312919; x=1783917719;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59VA+2WQhV/xwTEhpGDxGn1crd8YdD2r2kEXteaZhVU=;
        b=g1uBWE9ezZnTqKqNQw+FV72LkHAlMyUFdmhwNfUTWE/dslwypY7No21cYq9di3QgSe
         Lqg03jchNZTFtizeyWZArl3RZd+OsJSFPYl3nDpiaVVXEcU3WkX5teFvFKM0KrF4wIni
         TnjRo03q4b4/42aZRn7nNs1QSVURHydVp/NJ4rOKtLSfya34RhBGV9XKlZUeynMPt/53
         I73RIENc1X6S/8tY5oAjpZEbZUaR4VYdM4xPm3ZFf3eKs0LYk6lgL5/2ijcFspHd84nL
         6XRGiXgBDXu69tITKWsrLIYULO5bh4U9wPIb1KHkymNcZjsPirUjx99cphi62JPp6cWp
         CY6w==
X-Forwarded-Encrypted: i=1; AHgh+Ro8NdbCdBh9NYl0D2UdfH+anPZKZiIYilpy33SD/3Zkgze5jhfskjIjM1wLzMR/vMEmj8uvds2tQEP69LYf9RHOsabnJmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+X71h0uc8uAnvF+ZoPYz6yNaAhF0t7UcAlMgixauINV+3sLX7
	A55gas7thE6lNnpoKnf07anW5BrzJrL0dtLqBK/OS3yxhpBBK6hiU9knbSGQ1bK0cBQ=
X-Gm-Gg: AfdE7clx9vMI2UkEF0PZG+DHO4Vn81KszEhTOANkNSvZOzSYjCU0N5QdKf1UovYbK92
	/G6eC1uQ9yBNBZAgKMPYMr8ciliAX0N9JqUYI1qoT5iPyzib0BogoxfHG4aIEmiDAo2AqxG5qY/
	BW/CnkE0y4eOc6JrTQTHUhxmDwUsgMp0tmWvXkVLkOdxOZzYcN1YDeCNj/f4f6bWz83pl1bFdhE
	C5XSEWUlxOFeeOlmDlDbjRoJS50OHmlRiEua/PnCAgDzVvalNSaJ5Ty75TpUoeQ9L4HiaNJ4FJI
	XW63d8fjOivrVaY+kEBSJ7lwIInEQe1fzrUd346fTALlExN/cxqn20azPptDoB+BjCuF8zxpm0n
	fqmzHat0egsWbxHqEqA8GuD1uQXCgob0kjGk0ZbnF4kLNDxfUb2ucSKlfCYkCw5lwzRJZsQf8Jh
	OrY8wHU7JL0Ku2a/Dhq4q0cX8cPTW59V5FsfW99hM=
X-Received: by 2002:a05:690c:c4d0:b0:80e:b611:7e1c with SMTP id 00721157ae682-817399eb0cfmr86927257b3.51.1783312919159;
        Sun, 05 Jul 2026 21:41:59 -0700 (PDT)
Received: from [192.168.2.226] (104.194.78.75.16clouds.com. [104.194.78.75])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144783cbcesm53037547b3.10.2026.07.05.21.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 21:41:57 -0700 (PDT)
Message-ID: <6f32b61f-b9dc-479b-ab8f-91f096570c4e@gmail.com>
Date: Mon, 6 Jul 2026 12:41:45 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] docs/zh_CN: add LSM/ipe Chinese translation
To: Fan Wu <wufan@kernel.org>, Yan Zhu <zhuyan2015@qq.com>
Cc: alexs@kernel.org, si.yanteng@linux.dev, corbet@lwn.net, mic@digikod.net,
 dzm91@hust.edu.cn, skhan@linuxfoundation.org, gnoack@google.com,
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
References: <cover.1781105672.git.zhuyan2015@qq.com>
 <tencent_DADDE291CA580302EB7BB40B83A552D6F006@qq.com>
 <CAKtyLkE3unhxMsH1LpqvjHQoKVgz1tcTsZWUxNHs+R6v2amf6w@mail.gmail.com>
From: Alex Shi <seakeel@gmail.com>
Content-Language: en-US
In-Reply-To: <CAKtyLkE3unhxMsH1LpqvjHQoKVgz1tcTsZWUxNHs+R6v2amf6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/6/13 10:54, Fan Wu wrote:
> On Fri, Jun 12, 2026 at 8:59 AM Yan Zhu<zhuyan2015@qq.com> wrote:
>> Translate Documentation/admin-guide/LSM/ipe.rst into Chinese.
>>
>> Update the translation through commit d7ba853c0e47
>> ("ipe: Update documentation for script enforcement")
>>
>> Assisted-by:Claude:deepseek-4-pro
>> Signed-off-by: Yan Zhu<zhuyan2015@qq.com>
>> ---
> Have you tried to refine the AI translation? IMO some are really bad translated.
> 
> Also how does the doc translation project work? I do notice there is
> another IPE design doc translation,
> https://docs.kernel.org/next/translations/zh_CN/security/ipe.html
> which has a wrong "original link".
> 
> -Fan

Sorry for response late.
Like other kernel patches, you are welcomed to submit a patch to fix it.

Thanks
Alex
