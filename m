Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8F182496
	for <linux-security-module@vger.kernel.org>; Thu, 23 May 2024 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487323; cv=none; b=FphD/1UobV/sBL+tLFrC5YoS0wvt5iE6tnweAuJPc6B5TVu1B6aZtsUZXzOdg3f+BsmXyZp1HyuzOMm9ae+kDzXFR5NmTFPRVCVTak3PShYUjtrHt7ca0MayeNkmMIRduq4Sx8jJ/N9lMO/eX5EBmxa9qsH52iowVnOluf3+vL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487323; c=relaxed/simple;
	bh=3k6WvpZBot26hna6+k0egsJmF3ju+afeCCSsoYxl4Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtlO4mEk+iak13z45eP+2oqvhy7iN5kpkfg1I1YEqyHDFJlOUCgGCfIgTV0FgRRO8Azu4hzr0j9I8+SWsWypQmXZWdjP68HWDEy5Gmmq8lHhw0vSGOxOAHFEIqZOFgIznqKzpdO5wim1HtBZXEUr3ImFIAxe86aV5vpoc6+cDEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MLES0gKj; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MLES0gKj"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3737b3c6411so10095ab.2
        for <linux-security-module@vger.kernel.org>; Thu, 23 May 2024 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716487321; x=1717092121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CcmoKrno51oIESzU6CRBDsbzTPCeYv0t1iR5nNF3XwI=;
        b=MLES0gKjNB1Q6Gv7e0DHXND23LLPEB++Jh+KAE8VPYFIcSh0+73GBKU00MsCF9pMfB
         OfsQ/nyVm4UDg8yDyjQArOR1PlSgYO84JyE65KnZrh3f7Dh2E36SBomicsALB4BxBbpo
         aJSP5LxrI+0MnwS28KbgVgWHcKecjadnLcXF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716487321; x=1717092121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcmoKrno51oIESzU6CRBDsbzTPCeYv0t1iR5nNF3XwI=;
        b=Ax6gq8XSSyX0sSL98xOEbIycFtgnPBYRKYXN4yZxOnjHZOefut6kdEQlka02gRrvDD
         ZDR4whArOwh09tIqzlPFWn3NNKLbfqWIeCmSw2grGTZETZ13jm8X02TegofXfnXQR/TD
         0ncMV9iFJElLOtB7s0yF3NVadJZvnklNLJvJpaa+89Z/W+NLFWVWdLwjZP3WGjfqmFMk
         nG5iiy7+8PYo+FUZzdEnYr3Shnt+9WhNoW6s9fVzK7KZhAuzbh4QsPNh/gqUtKKHVt7L
         Z6grV50hGuoO3juHEET64ECMVEpAdyCdCR9/cDCaJsoOp7pbOq4F9hPLNj7ZLfRe/UVr
         rKrw==
X-Forwarded-Encrypted: i=1; AJvYcCUOmKWTca5RF1S7KdvJzn35XDtquCPJD1b3j443a1q5/MYWE2lUZYdlakhVsQ+5lpwrsId3WMf7YQ9iAiSpOyVp4Ne2dVUo/YBgsB8WeoPXkVomxgos
X-Gm-Message-State: AOJu0Yw7kIHa80PFQHUkABau5Pv7PGqFbooTs6H2LL5J3xVoUHYpcbIT
	4D+1F0EQhBNj0JgFD97LY3Mt41ESpOntvTRtItvMlRgoB/JDTwh//4nyOdlDD6Y=
X-Google-Smtp-Source: AGHT+IHFL67Z83I3o40zCsNMJ+ZoJnLtFsbE/QtO0U+1g9W23Ofor/d2rDbzaegpkLYOLJ/pxEIroQ==
X-Received: by 2002:a05:6e02:1fc1:b0:36c:3856:4386 with SMTP id e9e14a558f8ab-3737b3cad00mr209585ab.3.1716487320819;
        Thu, 23 May 2024 11:02:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3737a5e826bsm519205ab.73.2024.05.23.11.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 11:02:00 -0700 (PDT)
Message-ID: <d5471e30-227d-4e6d-9bbd-90a74bd9006b@linuxfoundation.org>
Date: Thu, 23 May 2024 12:01:59 -0600
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/68] kselftest: Desecalate reporting of missing
 _GNU_SOURCE
To: John Hubbard <jhubbard@nvidia.com>, Edward Liaw <edliaw@google.com>,
 Mark Brown <broonie@kernel.org>
Cc: shuah@kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Kees Cook
 <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240522005913.3540131-1-edliaw@google.com>
 <20240522005913.3540131-3-edliaw@google.com>
 <94b73291-5b8a-480d-942d-cfc72971c2f5@sirena.org.uk>
 <CAG4es9WAASaSG+Xgp31-kLT3G8wpeT5vAqbCA4r=Z8G_zAF73w@mail.gmail.com>
 <9e2677ec-1d54-4969-907b-112b71ef8dd3@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <9e2677ec-1d54-4969-907b-112b71ef8dd3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/22/24 20:28, John Hubbard wrote:
> On 5/22/24 10:46 AM, Edward Liaw wrote:
>> On Wed, May 22, 2024 at 4:21 AM Mark Brown <broonie@kernel.org> wrote:
>>> On Wed, May 22, 2024 at 12:56:48AM +0000, Edward Liaw wrote:
> ...
>>> You've not provided a Signed-off-by for this so people can't do anything
>>> with it, please see Documentation/process/submitting-patches.rst for
>>> details on what this is and why it's important.
>>
>> Sorry, my mistake, I forgot to add it after cherry-picking.  If added
> 
> Adding this to your .gitconfig would cover you for cases like this, I think
> it's pretty common to do this:
> 
> [format]
>      signoff = true
> 
> 

Mark, Edward,

Is this patch still necessary of the series is dropped?

thanks,
-- Shuah

