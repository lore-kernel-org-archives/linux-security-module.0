Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CFB1FBC92
	for <linux-security-module@vger.kernel.org>; Thu,  5 Jun 2025 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111924; cv=none; b=KR89gW5RcYqHcgyXb/Wpwh9OWwIjtcHfWJqn/w5zP64MKHe4mHG5lyrCATn5ld7fu60rfTmw50y9D0XBBa8vdaYX+ylOfIj7yJ/3fY/oo6S8Ohz7cXmZQ+czRLpj0U2gL+WttZ8sd/qIFNNJqPLyVQ1Y5JY1F5Sx9oDwRWuR1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111924; c=relaxed/simple;
	bh=OkokvZu1HSQ35Dy1eyAorvBCrf+RRvMraaFRyaSKNVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zk9JfPCydobS/nvffFmdOTJLkZR8EGYI5ogZ1qS8Y9YNh3pbFvRG4Vc15fjzUGcv+2+qCJvdOcWT6WWm4P04MttkVyKGLleRgaf3EE1zwBC1UFrNQM32aleS6AvE/Rp/RuP2qWp0vXfrWugYYzHPkT2KKz5zGuzAfSKMcFhDcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dQF44vY/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dQF44vY/"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a375888197so378425f8f.0
        for <linux-security-module@vger.kernel.org>; Thu, 05 Jun 2025 01:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749111920; x=1749716720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OkokvZu1HSQ35Dy1eyAorvBCrf+RRvMraaFRyaSKNVg=;
        b=dQF44vY/+kxi5R5zJ4MWeopum/UEdhXYy/QPOPW+cl9SlYiNyEWLBUU4QM/p726j1E
         UWSb3xIbXvlKBxVdKcrrMYKISWTveDheqqVm9kAI1ypZGZwcplfdzDv/8CcjJSNsWAZY
         BT6G8Q4u1Of4T0Z1uJEt9UMusBVnipxdrr0mITOYUu/6KBwlD7N/2R7G6ETiC0jNhEqV
         1Y/M9Yv4055MBH7DoTygeh1jXJ6jmiaGk1cUBSM1iuk34/AATAAxPf//Qd4pdTclEhVi
         5uemZe8RotoKzgPMhzNTwN0UHCXLsuRT1HNEedN+vSYv/F/IpfqsDqiFrHXy1bqjVzLP
         vkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749111920; x=1749716720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkokvZu1HSQ35Dy1eyAorvBCrf+RRvMraaFRyaSKNVg=;
        b=KTMRuva8zylaPF11POekn+RAHWxP0sn0xivO9oEkJqRYczUhxW4gCBGmo68ju0cLYi
         m5y9g/TcN1dC0cNZ7acBL+oTWs2WI5ThJkA3wCXtAX4EUPgQ2YK4Ss57s/jwUNh0xmuw
         saeeRo0StSIOIAiklvkFX4DvHTw1Hys5ArxwWT+wVYvqPUR2CvxyB7GNobucOE9D6cX6
         /hGsABHH1cN4/UoPWnt1Gsxy7jbbILiNh9kQivh+cWb17EbDijq2E/vZjX0ugHgjDH+3
         ZR5mY4lCZl4/b2QCyO5XzolAZladZ7JUi1j8+GuP0gjBYRQNrw+CMfYOyKjD4bBBZZwB
         sshQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOftntPlO8ekunGuZpjQgzKYsZaX3IBc5SCNQTuzy+oQQsMoAKvUXVI0Nx1CSdOOgpfsM5qw88GVkp+aeUaU1SjR0ZpLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Jp4Gz5U6Q7kt3dItUn8YobtSq4BdiO36leole0VALLS0sLPV
	yEXSQTifCqG+Fn7r0lrCvJ5jCNvoCMtj3Ji28lvmHC06yc3fbrFV0xSvMq+Fwx8ZKC0=
X-Gm-Gg: ASbGncssRVbvQqEChtWExkko0clTeGf5T5pY3njgmDij9rP47FUQpieiVNVm5ZnCOqo
	7lJbYVot/LOOaWMwUR1llu1KezA1UtpmCkb8IrW/J8sZzMSWTtSwnHIBYjWYGaHSXpv7Qe5Vjb8
	pfNaZLxTJhdLvCSxNCP8YDbhaVdWU16oBl96Czn6qXQNMhjSOCHZt+qPRDgvFEgld1qoYrJBq56
	3ngtw2im6W4pG9f3VUZLIMTWlV+NxlSvbExh3pOe8hpsXZG+27CNzbCU6QKQWwpAAXc9O5Sm+vb
	13wcE6KY2MNl30CZ+w21vFNSNBhioaCeCzzWsZlZdJ4x5niPwXvyvOPhMsQN7wJ7uP8H2bFkICv
	fCOsngMaTOdl7c2tvEDWuTUE4p/lSLKluIsOKuZTrerwhqQu+dJOU7heqrNnb7Cc++i1OutmKl8
	KXhelrXizzzXN5eD0ehGvD0i7+
X-Google-Smtp-Source: AGHT+IEpSVoHolvm9692NZ3jDiaMRs9r9Du7svC1ED1HSCfbchMJqSwIkMg/k5Lw6HgnfsY9JY2sFQ==
X-Received: by 2002:a05:6000:402a:b0:3a4:eda1:6c39 with SMTP id ffacd0b85a97d-3a51d9223ebmr4710229f8f.13.1749111920232;
        Thu, 05 Jun 2025 01:25:20 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4? (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de. [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe96474sm12380152b3a.22.2025.06.05.01.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 01:25:19 -0700 (PDT)
Message-ID: <f920262e-0668-4dc4-8e2e-a75b1ef4c449@suse.com>
Date: Thu, 5 Jun 2025 10:25:11 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LTP] [PATCH v4 7/7] Add lsm_set_self_attr01 test
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
Cc: ltp@lists.linux.it, Avinesh Kumar <akumar@suse.de>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org
References: <20250429-lsm-v4-0-602b7097e722@suse.com>
 <20250429-lsm-v4-7-602b7097e722@suse.com> <20250605081309.GD1190804@pevik>
Content-Language: en-US
From: Andrea Cervesato <andrea.cervesato@suse.com>
In-Reply-To: <20250605081309.GD1190804@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> FYI The test fails on this check on current Tumbleweed with new
> 6.15.0-1-default. It worked on 6.14.
>
> Looking at 6.15 landlock related changes (added Landlock audit support and
> Landlock signal scope fixes) test might needs to be updated.
> https://kernelnewbies.org/Linux_6.15#Security
>
> @Andrea could you please have a look?
>
> Kind regards,
> Petr
There's already a patch in queue fixing the way we are checking errors.

About Tumbleweed: I'm already working on it.

- Andrea


