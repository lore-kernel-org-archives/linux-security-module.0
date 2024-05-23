Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC688287D
	for <linux-security-module@vger.kernel.org>; Thu, 23 May 2024 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491468; cv=none; b=WlIdwaTWDTmM/K8b0Ue7NmoDJIs3CHLlphb5lAz8zWBJIMAghk/kwHGwB7BOYXSA/2LoeIb4hR42PY5JREd53YBqFgzIfIsD/78x+O0pwqWfFXMpRDa0ZQ+OOGtph9uDvvOn6lsCPPYspZh4RJsvuGIjadvVCZ6cW9a/BC7iKUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491468; c=relaxed/simple;
	bh=eoCnpmqq6nw3Fy1R7DEd4SHwvcgaixOSexpmOblrHGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsPwAmChLG4PpPKwnvmraztlpJBLaKMJVoLMd7rfJdoeEzuTRG4gMXZHAJPgaSXA5hCcSOZv8LiUMA9OvvCJIcRckpIZtTu+IHj0h6/HQL5b7d+L4RQdNrEkAqNexV+6npvwMb5ViIrzQDNMOrEHlbeYEzZb7mjSC7F9+HCuSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T/lHMsJE; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T/lHMsJE"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3737b3c6411so85555ab.2
        for <linux-security-module@vger.kernel.org>; Thu, 23 May 2024 12:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716491466; x=1717096266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fC9kDW+kPeeEhu/sk0DK4Ea1cI30Dc81o1at+TwfLXw=;
        b=T/lHMsJEP9X2cam/KtMjqzD0ImnLF5V7ijmSPX8/CDtTWs+NOkFSZY17ATFJIocVrN
         2z3izIUAZyLluT9lmSJKcnB1i0mGAU4I+LzBMZVagRaxGGR/4omkB7dUV0bfKC4bIkEq
         BDsINTVzZ0h2Gm9FAqz/7EiTFMcuiHORBStiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491466; x=1717096266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fC9kDW+kPeeEhu/sk0DK4Ea1cI30Dc81o1at+TwfLXw=;
        b=iUeTkPI6QWsB7EhmeRYCQn+EGCCsH7X55b4b10tCvXMEf0bQs3GONL8di16+gEy6Uy
         by7TLvi81YZOHKzi4yHgkc5ch9lLBtSwh9pFb1yhIoE0BF/OnsUZi8z5uwiajjR9esAo
         GsjR32If55tFqRTELIi9Phe0MEC+d6nI6Wof7canBtYzBKQSEvbSNfTtWow15O1VcLeA
         rUVzLgMzJgWqwC/8xP5UNDuy/HpGxlnB7+bK53NnobUgahsDiOc+oh2ggDU+d+ZCtdnn
         7nENQzufEZm31tKcoMZlS/enbFgGegUkHwwczJh6+UvGLZDWT7/SzRmz3TUi8VghHSjA
         x6RA==
X-Forwarded-Encrypted: i=1; AJvYcCWJBGRDdbh9E1RX+4+8rLDP13ycDsXYXcjVmUNOcDyFP95Vx/aQRBtNwZU2dmIgffl2l/MS3gjmOGcSvIuHRc7DLejpguXm5WcKIReHNZLIo5eD1/0x
X-Gm-Message-State: AOJu0Yy36ji1F5SABwx5MPY5Uc49t57pAbj7yFVwMMKVgcd+aKVxiWhO
	hJaE7tMmQiPraX85bVh5GiTe/qORPEWeUNrVQcoU5H8Sg0oqrn3i0MwqTKmdLto=
X-Google-Smtp-Source: AGHT+IGUJadL8tuWvotBY37jyLWH4W/NEbNhdUB06VeC+bbGevmqUO6z3gpToFd7ayYeeicIf3AIYA==
X-Received: by 2002:a05:6e02:1fc1:b0:36c:3856:4386 with SMTP id e9e14a558f8ab-3737b3cad00mr2165555ab.3.1716491465698;
        Thu, 23 May 2024 12:11:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b03ece4797sm1493173.170.2024.05.23.12.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 12:11:05 -0700 (PDT)
Message-ID: <b208df48-b909-4f2d-8bc2-80531c044470@linuxfoundation.org>
Date: Thu, 23 May 2024 13:11:04 -0600
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/68] kselftest: Desecalate reporting of missing
 _GNU_SOURCE
To: Edward Liaw <edliaw@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Mark Brown <broonie@kernel.org>,
 shuah@kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
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
 <d5471e30-227d-4e6d-9bbd-90a74bd9006b@linuxfoundation.org>
 <CAG4es9XU2fMo7hBv81vpn1JGKFWt9gExOhyAyRtOc-5OR5eiLQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAG4es9XU2fMo7hBv81vpn1JGKFWt9gExOhyAyRtOc-5OR5eiLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/23/24 12:12, Edward Liaw wrote:
> On Thu, May 23, 2024 at 11:02 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 5/22/24 20:28, John Hubbard wrote:
>>> On 5/22/24 10:46 AM, Edward Liaw wrote:
>>>> On Wed, May 22, 2024 at 4:21 AM Mark Brown <broonie@kernel.org> wrote:
>>>>> On Wed, May 22, 2024 at 12:56:48AM +0000, Edward Liaw wrote:
>>> ...
>>>>> You've not provided a Signed-off-by for this so people can't do anything
>>>>> with it, please see Documentation/process/submitting-patches.rst for
>>>>> details on what this is and why it's important.
>>>>
>>>> Sorry, my mistake, I forgot to add it after cherry-picking.  If added
>>>
>>> Adding this to your .gitconfig would cover you for cases like this, I think
>>> it's pretty common to do this:
>>>
>>> [format]
>>>       signoff = true
>>>
>>>
> 
> Thanks Mark, I'll add that.
> 
>>
>> Mark, Edward,
>>
>> Is this patch still necessary of the series is dropped?
>>
>> thanks,
>> -- Shuah
>>
> 
> No, it is not necessary anymore.

Thank you Edward.

thanks,
-- Shuah
