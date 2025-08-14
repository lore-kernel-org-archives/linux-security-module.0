Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC71EF39E
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165762; cv=none; b=M3pe132/WxDBXWiRdU50PXytXTREvC8Smg7U7b65MrxrSfkllucHh9YTii1ARuzuONKyB463R/e7GAf/krlhTTZQ86UvHq/49tGulxJAhjobsymoBzmMuW9XFY5bG2G14rGWaOTkcZD1oxQd4byu9xFsxFRi1keOppopWxNY77I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165762; c=relaxed/simple;
	bh=aBEShMavPb3fLSFiITTeKGk30484O0rW97dYU7J0ko8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ux4ENz1Kd/IcllXblqvSqgu8D74Slv5KJBu7q+sA3A4OPnx8aF3zV3kGueEAsG/a4LaqWcpCIVUokTa8gF0Qzj9JMOFXi/UldNMQJq0qJXSEHJ2yjGjPTw+ImlmrAfA9IOog8EEb7vDapL5YgomBADyRXWCDlkJ6pDufzJxZPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GzRJVavu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GzRJVavu"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b05d252so4452265e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 03:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755165759; x=1755770559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2DqnuyGtmQV8C1HuuzIHsMvMdsiCOpmphQkBfwc5+d4=;
        b=GzRJVavugUOXSNdrC7gYfoZpI70G6G0MDHPUoJYiohpM08Dm9RkcscIz/rNK4FC4Jb
         IHbGjTjRfIQitxIB7II8Fqm/a42kRv/NMKGtskyQ2vkAQ9SUV1TsivyPXuDAwpceTODQ
         3ZK/XDierM/FDuRxmSVHKbqBFVXf5q8ekuraYFWzAany8xMuTuV+fHwVykilMwsxADi4
         RDr74QQ9EUYdio1vDhS8DDs2bYGpU84dbM5eZX465chtaX36gBkrLiy8jQGHuyOvsZFX
         nKXQuJRuYA3YU/Ou6DnbXOVvSi+s+VVJUQ+WW/KeTezWHLYgrjNhU0WCN1MagTUcySBK
         6n9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165759; x=1755770559;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DqnuyGtmQV8C1HuuzIHsMvMdsiCOpmphQkBfwc5+d4=;
        b=ZbN/st2yuhzL2Cgpj6MbiNRdFcxC+BuR+dOteEio9UqzXtxkjjoafZy20VVBlJgp1o
         PprrQSusFjDWzZs3IZB2zVluXoVpYvKS9mCnPmkeakuWRLPsSAEqKi9NwBCTZPKKAKzr
         W7KG4n++YDGURD3tTD5SIhE+h610q7YyfBVqjlajM4kyM5GWy7cIUbqZ+yOiCZ4EW6ZN
         mqFAatqs3WM037atPjn9cmf4OU+x0kvjT8Hv2cXqF/wocMACzYzc+raDOZwzQ+MPKGp7
         5vfE7xkJLNK76TzFljNXyxde0IKSL1cCDEhGYik2pUqh9a95kuPyNsXnYXNaJGwqy7SG
         l0fA==
X-Gm-Message-State: AOJu0YxVjAMzogG+d6ln/tHAEBz/XU8M07HyR0lFW/YPK3PSrHdXsJ6n
	UMmMC7eAc88zR8TFj2eRUv3qxpUF41RqsEhQEAlkczwplHEbiPLKI5K3mmqRKruBLH4=
X-Gm-Gg: ASbGnct4tGUGUA334iBDp8uUfEcgfx0JFkpMgw94gZ3fwyexqnXIgMsBGi3aLTV+2xm
	bkv0T4oKNoAA0GNtZkfEyHtZCVKSE5ZCffbxCQLJbOdjPITIJRrBLF5iVJt2N9VZD6jsPv94zXM
	Q6SwfAx+s0ORghilPNQ81H+S3DkubfWblmxw37DgasWm1SBIFFrg3QEQx8mNZNfHcw/V/Z/ulmw
	6m4nGw5uKB5SC2I4KkDyl1gTNqg2lHYy03d7g0wqrtX1+/r3yf4977A7D6x1/b9hp+UFx4vsqcO
	hzRKzTijIye0g7Tai3V6BdE3oMOH95mV+3if/c+f8vmxPTOODoKjsgKupiJXF4qjSdHBKxnfOeo
	cRun9ZBVBB67lOqhrz0PTT0mSzJkGfQQAF6fg8JDWXv3kloHWow==
X-Google-Smtp-Source: AGHT+IEfycQ5WcPFQlA+URxy7QUA1w3YdWPnzKG/f6GEj3a63RATSLcHBVVI3WHNqtwNKks0h+UiWg==
X-Received: by 2002:a05:600c:138d:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-45a1b6697d0mr16374795e9.19.1755165758640;
        Thu, 14 Aug 2025 03:02:38 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.143.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48105csm50658060f8f.64.2025.08.14.03.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 03:02:38 -0700 (PDT)
Message-ID: <60f17362-af8e-46db-9bcf-be85b84a525d@suse.com>
Date: Thu, 14 Aug 2025 13:02:36 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Allow individual features to be locked down
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 paul@paul-moore.com, serge@hallyn.com, jmorris@namei.org,
 dan.j.williams@intel.com, Xiujianfeng <xiujianfeng@huawei.com>
References: <20250728111517.134116-1-nik.borisov@suse.com>
 <kl4rvgnupxnz4zrwlofrawdfy23tj2ylp5s3wovnsjxkr6tbrt@x5s3avqo2e7t>
 <9b6fd06e-5438-4539-821c-6f3d5fa6b7d1@suse.com>
 <2vldrnqs6fbljqqp6vbwmkushx6dxcpephgb6svmu5i64lijpy@lg37aflddv3b>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <2vldrnqs6fbljqqp6vbwmkushx6dxcpephgb6svmu5i64lijpy@lg37aflddv3b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/25 11:59, Nicolas Bouchinet wrote:
> Hi Nikolay,
> 
> After discussing with Xiu, we have decided not to accept this patchset.
> 
> The goal of Lockdown being to draw a clear line between ring-0 and uid-0,
> having a more granular way to activate Lockdown will break it. Primarily
> because most lockdown-reasons can be bypassed if used independently.
> 
> Even if the goal of Lockdown were to be redefined, we would need to ensure the
> security interdependence between different lockdown-reasons. This is highly
> tied to where people calls the `security_locked_down` hook and thus is out of
> our maintenance scope.
> 
> Having coarse-grained lockdown reasons and integrity/confidentiality levels
> allows us to ensure that all of the reasons are correctly locked down.
> 
> Best regards,
> 
> Nicolas

Thanks for the feedback, to try and not have all this code go to waste, 
what about consdering patch 2 - kunits tests. Apart from 
lockdown_test_individual_level() the other tests are applicable to the 
existing lockdown implementation and can aid in future developments?

