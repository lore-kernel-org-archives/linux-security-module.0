Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DAF1B9B20
	for <linux-security-module@vger.kernel.org>; Wed,  7 Aug 2024 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723029619; cv=none; b=PoIQkf0FSJskMdXRidKdoA/6MveySTuofvPqA7qUDKiCIjK3I88ONhujfIbliw/8+Ow3hRYhKKsRcLr6hzKsGBK2Z2fQ3NCa8JPKKKf7MHWC80nWxLO+H5IXbXF8fH9D57EFIXCLWcKfeT+5MkZnzKgXerYV4M7wMeG8q3IA204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723029619; c=relaxed/simple;
	bh=vyUtZ+IzW/Sxj6Fm41Tuev1tyNO6KoMeXmicKETFr00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7EMhMO6Elx5gNpMPk5CUM155Piz+r6XKaE8YO3eoic+S6FxlJQ0k17+o0hrEYWbc2v4KLS615xQv4ngCQPk+COHFkgIRyApDIDo7LzX8aHpD85R46txW8OwLLYgmGQqOAeOYaHUg53C5A3SO4uGpMQ4fm3LMFIlpG+bN7ZvpeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vNIYzFJV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNIYzFJV"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so2144240e87.2
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2024 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723029616; x=1723634416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AnT8tM5Re9ArEMYyFgg615Zk12421KA9IxT4E7DVwQ=;
        b=vNIYzFJVr6ahEugShgcMbjxmhavFgCe7epQeFLM9Cfnl9G5eyHxgbQuUhbUooJZ1DG
         2vWw+fu97xjm4G1KIr3RhTKoNmxzm7HqOUQ1LzpT/UKtcy2QZoq7UBauALz/Ms/pP4SS
         ILa2cSlfwd3o9C1ZPIWIYqUNsjLk4yfQQ7t2L4YAEHoQEoI6Zu8F05H9QzZKQMZtZ6rk
         2G7H+OqW+cqx1K7kuxIN4gRIyWfcw5zCpEBmNc6LKbiTq2j4YMnMPRMxTzxN4TDSa9SC
         Dqdb3FCQNrXRZOOCPPWqtTE7FRVsxrjRg1AJGYTlJNgr8kUQoFCpiQq3H4u9Vw0jK2wR
         cpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723029616; x=1723634416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AnT8tM5Re9ArEMYyFgg615Zk12421KA9IxT4E7DVwQ=;
        b=mosC+WABqZ8W2oytfxlY6WIlUruXBCm52PHw5cU3M1BlaDj6pDr3McCOXqZHg+miD0
         Zkn3G/JwPqq6nTBksvW3abewUWnvttJ+5xzIW+k/c8JxRQpjAsVlw9UUVunt0qV9yNK+
         aerzUOk8Fo9WHJJIzcR6vvdwyg5+u8xvEHbqmrDNQurnY+PFNUH6Iyg4WxuZ95BdXofb
         /kP5EeuGf6MK/7IqwTE9Smg6S9PO9MFnrekLwXmmipu3aq+czxyChdH37YyJYfyCFuxU
         2GWlU/dt1m4u0M7uXwVreJxSaRy/zP5oomLaea172QKOMoPVr4WjSS+v3/NGP2JeVZut
         hWqw==
X-Forwarded-Encrypted: i=1; AJvYcCVe8ph302BeRgs+oREa+P/79KD6eJANGjqVZN+UcFFwqfofUrQ06SR8IWKDnT5ldBb+IjOFrHjpIpEgxf8Xc4Js6kLPc56tYTejMxx0UDbWZYgqOa/O
X-Gm-Message-State: AOJu0Yxk4nDoBKU//UAbsjQL2G8cewTIQiJX5mu/xIac8CdFJgj5QCgV
	NZl9s+hNlGrZIr7pwm+DTdmvAXDLUZoi1dRtvahp56dzj5QntMxRruWEF/kZZzA=
X-Google-Smtp-Source: AGHT+IFD1x5owvgDUm1iLMvihjtHRJQDhrCOXcBOdvIMHDZ/yDmNOdnKRPkvS3eIDRgmpeUTXRQhzQ==
X-Received: by 2002:ac2:4c48:0:b0:52f:2adf:d445 with SMTP id 2adb3069b0e04-530bb39b88cmr13683647e87.41.1723029615408;
        Wed, 07 Aug 2024 04:20:15 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83960f353sm6894900a12.15.2024.08.07.04.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 04:20:14 -0700 (PDT)
Message-ID: <bfe18512-03fc-4e17-b945-d8e3480a32e3@linaro.org>
Date: Wed, 7 Aug 2024 12:20:13 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/perf: arm_spe: Use perf_allow_kernel() for
 permissions
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, Al Grant <al.grant@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20240807105441.2156738-1-james.clark@linaro.org>
 <20240807111520.GC37996@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240807111520.GC37996@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/08/2024 12:15 pm, Peter Zijlstra wrote:
> On Wed, Aug 07, 2024 at 11:54:41AM +0100, James Clark wrote:
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index aa3450bdc227..4a69583e329a 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -417,6 +417,7 @@ static struct kmem_cache *perf_event_cache;
>>    *   2 - disallow kernel profiling for unpriv
>>    */
>>   int sysctl_perf_event_paranoid __read_mostly = 2;
>> +EXPORT_SYMBOL_GPL(sysctl_perf_event_paranoid);
> 
> I'm never a fan of exporting variables. Perhaps create a helper function
> that returns the value and use that where required?
> 
> That avoids modules getting the idea it would be okay to change this
> valie themselves.

I could also remove the inline from perf_allow_kernel() and export that 
instead. I don't think it really needs to be inlined but I gave it the 
benefit of the doubt because it was added that way.
