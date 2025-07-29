Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4038D2A1CF
	for <linux-security-module@vger.kernel.org>; Tue, 29 Jul 2025 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791964; cv=none; b=lV8DoDPYQRgOTQp9bfGPD6caAks4lOEu6Dq0pO/x4qAuroZKLkDnViawDS+eYDET7IN/FazAeN1kocwsSr4CPiWlOXsDs6xIj/vpSzI7i/MtMdHdhOuM69SM315pPOTtZ98MgCk/E0C+yCS/oHOl4HSpJSXU6Otgy911EVTnVlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791964; c=relaxed/simple;
	bh=Sa0+7pkvbvKnzUBV/+DKIeFT3oZOcJAjMjz/TTYldSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxG2HmwvVWeTSN8euHMBpbDKQ2CzuIPsbGmKPavFqZfbir+OQVTCipXRRYRO0bZ1DfN+AOScnki1nlEo4I2x5Xbzo/tLF15W3grC2+3Aux/o3slK9hS2uhM1FLP9umhfp1NDAs+u89peDoHRDVDwuhKDEbs8OZMSoovH3IQIAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fGw06QsE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fGw06QsE"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6b7so2014562a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 29 Jul 2025 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753791960; x=1754396760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ePWiaVAU8uB+7gZPcArmwtlemoHV5AVhlPG7UbOq0OQ=;
        b=fGw06QsEJiNENHplR5B6J726zioFOh7DVSlDbazeDm4jYyG9UAa0hPUJrjyFiXjH2y
         YDv7AvVlXyBZcvs8OPnJLffWD6W9bpbphZ6bkjx1GofzSdFPhbHlV9sINTlPeePYz8ua
         4300ElGFOdpAodUkbRZ+n8MYvTpivUKPOGC888JED8ynx/CkQ1ti4CDRAHkhYa8Jm2/M
         lGkWIFWrGVc9fCzyqqKvu0RcQNf7xkgmXWPu4YoK8FXYp0nM3yCgHDA8tLtggUxNh8nb
         3BAp/gFZcECkRMG46F0mq4fhN8nI+sTEI8nm8gs7yPUA/ygnvhofZqIHNmXpufpTpRmg
         lsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753791960; x=1754396760;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePWiaVAU8uB+7gZPcArmwtlemoHV5AVhlPG7UbOq0OQ=;
        b=JvPOFRm9T66U/MJZFBBnhZEYz0+dHxpo8mfTYS4OfcSpU2xCcJjuV4I3CMR9WrVmyC
         fAOXyJwAFIfJW5lxHVLcZMYgZyG3sw6k+RT9f4UF7MNPI3izEs9Up9daNK+Ci+7FI1Gt
         nWVho3uqfA1XFMlXmBqlNw/5PFmGRpck5IOvGPJ2hV8cE2MfaqNxympFcx90V5g2X0m3
         drMkfe70Y1/pP8lL7ubW6hDFgS4OHxepAe11Kfeo88Lf4e5ezQ/5r1PQbfV3t4v1SIig
         LO1ODeoDDRsz705PS3BFNubTuiy8JfKcEywiYZjFijsS33onn4EYSSI4JL2Q327EVZsk
         ZrtA==
X-Gm-Message-State: AOJu0YyxjkTS3YhUbdbGER/rd81Kph6XkEIxT9LNgpLW+AekGENR8VWy
	pEMxVD9njv0r1yw6pa7AZg8mZx3Nd1r24q0m+aRHs4rxLAHgZroEo7k8XF/YdoIsSDkHRvtXhE8
	GWNlg
X-Gm-Gg: ASbGncuf8SVIhF4k0dTx7jjqXBUyi6mbSP+uLFiWNriXzyQgBpvvFk2zE+BLpCdF7Sk
	LPG/zAI78SYyhgBKgQLEv8XKXvLgAzn1HnhJ6M0GuF1GA0u1H35c7lfPz9nwI/5RsEnEFEkHmow
	7E9swcJNXBT3c2Le8YGFIy1ebOAWquZhZguWzYiogX6E7Mt84Nh16y8Cx8GDczIWlh44ZZxyGqo
	gZYwCvPeLnT1a+MlIqCu8mS6ymM40OVlgBPmoRvKCOe8VOFSGgo22aICuZiiNgo3cNMPjnsW2ZI
	vZA6/lV9h2EIs3S1Ax/VqcNYcUlm/5xW16CGzDo1UJN2PUbGFveiHRHRsIydUCQ/q2kRG6lBDTO
	vWVPUMLB0Rt9I18BlyaQtN0Xahbl8Gp796Ncv
X-Google-Smtp-Source: AGHT+IEbL9Glao9a0iC/Zrseyqg2ADGMfqJYmHiqZmrd0fzTrffzSC1ITDlHHAq/xFq0xAY7VlV21w==
X-Received: by 2002:a05:6402:210e:b0:615:546a:932f with SMTP id 4fb4d7f45d1cf-615546a93e7mr5485770a12.18.1753791960574;
        Tue, 29 Jul 2025 05:26:00 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.209.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6153a7a3a10sm2724359a12.56.2025.07.29.05.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 05:26:00 -0700 (PDT)
Message-ID: <9b6fd06e-5438-4539-821c-6f3d5fa6b7d1@suse.com>
Date: Tue, 29 Jul 2025 15:25:58 +0300
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
 dan.j.williams@intel.com
References: <20250728111517.134116-1-nik.borisov@suse.com>
 <kl4rvgnupxnz4zrwlofrawdfy23tj2ylp5s3wovnsjxkr6tbrt@x5s3avqo2e7t>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <kl4rvgnupxnz4zrwlofrawdfy23tj2ylp5s3wovnsjxkr6tbrt@x5s3avqo2e7t>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29.07.25 г. 15:16 ч., Nicolas Bouchinet wrote:
> Hi Nikolay,
> 
> Thanks for you patch.
> 
> Quoting Kees [1], Lockdown is "about creating a bright line between
> uid-0 and ring-0".
> 
> Having a bitmap enabled Lockdown would mean that Lockdown reasons could
> be activated independently. I fear this would lead to a false sense of
> security, locking one reason alone often permits Lockdown restrictions
> bypass. i.e enforcing kernel module signature verification but not
> blocking accesses to `/dev/{k,}mem` or authorizing gkdb which can be
> used to disable the module signature enforcement.
> 
> If one wants to restrict accesses to `/dev/mem`,
> `security_locked_down(LOCKDOWN_DEV_MEM)` should be sufficient.
> 
> My understanding of your problem is that this locks too much for your
> usecase and you want to restrict reasons of Lockdown independently in
> case it has not been enabled in "integrity" mode by default ?
> 
> Can you elaborate more on the usecases for COCO ?

Initially this patchset was supposed to allow us selectively disable 
/dev/iomem access in a CoCo context [0]. As evident from Dan's initial 
response that point pretty much became moot as the issue was fixed in a 
different way. However, later [1] he came back and said that actually 
this patch could be useful in a similar context. So This v2 is 
essentially following up on that.


[0] 
https://lore.kernel.org/all/67f69600ed221_71fe2946f@dwillia2-xfh.jf.intel.com.notmuch/

[1] 
https://lore.kernel.org/all/68226ad551afd_29032945b@dwillia2-xfh.jf.intel.com.notmuch/

<snip>
