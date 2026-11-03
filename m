Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738049;
	b=upnNY700dteZyMIu02SsNb/bgNfoKV7BpzFdO5SMORMOv6OMq0H4/NhnUzMpsz3hLTNu
	 bbPEO7oKPaZMD1CbeuWB1sRJs0qkdRHv4qX6ILez0zpKpZWX6Q9a9Twmj2jajdba1LSqF
	 ElKlTMFRWUlnhZvAkqC76kayr16Cy0demcJ1GhiA5MSKD0zStAK+Qg7UZTlWNHCPHY/9U
	 jza/wGAaP/1OhUdn0O/+OxZMfHegn9R3M2I6aRxfYYIDq8y2dPaMAyMUdRqqQLbdZuGM/
	 sGY0srNK+B12I0CFBXKr7hR5nuqo6q1PV18VaFerJLRUlWqmxgfeenPIS9e9KGOdPrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=dNjq2OxDVtbu8F9xl0nqlhF7Q6giPt5SRyE2tzpRWmQ=;
	b=b5BOo+L5HY2Mhlyd6JSi2mB+nojLYtelY4huK15bhG0j1MNIpbTy22CjJqAcIk1jBJBn
	 u1uz8oVZJGYOuQHK75dGfihMoU+JZYmhs2jgoi3331sTO93yf4uf+i+lGLY75ne8uXxGS
	 8UafJECeCAzKPE5E8L3zEkvZrdL22S2mf0jbkP+zHr0gquD/OkXmSiryA9gDwDclzFtce
	 tkuQly9v241JtIn6ICgYZj+oXL7P7CetOX5YhFHS/7jhT83buhOpAq19QxZY8CnKYaG26
	 FTKGO9jAPBv4vIJm2iPYnpciZKf73SQkB6lUdZXMozhio+cAsITuRP1ZzJp4gBI3Xww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UWXAKpab;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1302A606A32C
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 20:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1302A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UWXAKpab
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so47665215e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 03 Nov 2026 12:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793738047; x=1794342847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dNjq2OxDVtbu8F9xl0nqlhF7Q6giPt5SRyE2tzpRWmQ=;
        b=UWXAKpabW7n4FQOPPPF0svuPcfJ1+lbF/6LldmOQX8FUE3AwCxbl4EQ2MD/7z3T0LG
         kyfXvLfhChBscW4Kg0gq9jXN/BcVcD8RGQ9RNsnZTAVvEns0JPRgzD96cPSBT4mAV60x
         xTYsry0bqdfVVSL4DK5PhIvfcIyJKAQaIkX2zLbgzZ3/vrpFH2Y9hsEaECR0cxCqLmc2
         04XY/1XM97cVRyPPxGlvWFbEcRNi0DEAH5uie568rx5C16IQwYXiPaVQT/AmYXg/oE8C
         6QrhtCYf6CqL6zTK3B7msS7WRpUMJeOoqmI/GbQ3XtqZkQbRQ+NUZI7Jn6FYAkOtzO1X
         TnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738047; x=1794342847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dNjq2OxDVtbu8F9xl0nqlhF7Q6giPt5SRyE2tzpRWmQ=;
        b=pRpkFLRMhQtOMDPCWjRYUciUT4H7ew0txBqad1Neh9OvuhLhlpAFl/CDui0oq8ehlM
         Ha8Z5qf5/xbbW3C5AKGx7cybuuS9caqr+98UkHbX82ri9UMpBkZ2OP1hdnxqv9DVRH81
         L3NdwHf/5G3KQXqJCUCjIjZCb9ZvZAwU2xZEA+qoYeiRXaLxwTS5oUYwlTkjQnr51MQI
         RNojmRRG9/lfXEk4/ayVGPEVQWJRSIEJuQ6SRLhM1TN2l6cBz+pwHqNdo7M94yWAXzow
         SUNXe+SKE5pWfVwlWj/AOcQfa7kgerxEzbbtCjuGUUfLcQsGt/bnD3TBshXmMG5kZzzF
         A7EQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7GVrE6/UM74o1iDNlHuUo02Yy5QAylCLMLhyRuJs3tm50Z7TcfEGB4YeSVZpGg1/h77fzUim509gfNWyp5p0kVdr8GTA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sIcWYBQaFNMoW4EQyRvWQ7+a7XZLo4z+xwHXgZroFBvTfOt4v
	nDDS4xmXqUTlGoxTNM/6iozMt3ofT8TymTPBHZod7QKIQJ/0vvZYw71y
X-Gm-Gg: AYBFou2TPzyh137HuX4Hroax28nGKjTSYW9NChfCLiP03yKF14OtC/T0yEKAc2oP0Vx
	V6qqM2EZWq1bnCdrU4R1R+1q6NKxCarj0zWNkYVPkOuSn7I88ZfQM2gM7Jk3SVQfnPk8jwRhNK3
	VebwUxehjZDNvRDxbeb8Ij/v/v67/0RI6mTBUeMhaEoRAVaopi9EiFmLbeb1zmdDncT3U83Om6r
	y+llpJDnQjVB15ooOjyBfmwRrBFxRWH4GaXiK6vS9xX8Ngx7ac+xg30DZqcIhX69UBNS0KtGpAj
	FBWPhukIIk3tIQO1bHTSE9QnXv9tbNc7NvAxDcXW+6b5xBreVIzdfQDWK22vbeoKNOxn5lm/vY4
	ul+KCcvo5yEhGvJ8Buq4uLyG8fMGwuqs9QKBXvryM077+LlHUmSVhtu9tLJdT84rEwioZnQPhV0
	AFWOkakJdYgK+8OGfEPIzZd94GHCQWJXXqLt+JF77F4+okVAD3g3wxIKvRC/Ay5WUTDrx3Lz9ra
	8BhnUn9LtyLaDpKbikAo9N1m0Cwxz+hB3EZYHfFGN5hT52pmkMbd8UNWzyEk7DYrejbeS11Kdxg
	f1hcDszrq0MP9oMpAQ/Ebro1uvLizhk4BfSpgC87RqPEpkzT4qRd/w==
X-Received: by 2002:a05:600c:6099:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4ac180f2ac5mr302267155e9.16.1793738047466;
        Tue, 03 Nov 2026 12:34:07 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fcd03d01dsm479666f8f.44.2026.11.03.12.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:34:07 -0800 (PST)
Date: Tue, 3 Nov 2026 21:34:05 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: print st_ino as unsigned long long
Message-ID: <20261103.96f7e09c16ae@gnoack.org>
References: <20261103155512.535137-1-sashal@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261103155512.535137-1-sashal@kernel.org>

On Tue, Nov 03, 2026 at 10:55:12AM -0500, Sasha Levin wrote:
> On 32-bit architectures with a 64-bit ino_t, st_ino is an unsigned long
> long, and printing it with %lu warns:
> 
>   fs_test.c:10511:57: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type '__ino64_t' {aka 'long long unsigned int'} [-Wformat=]
> 
> Cast it to unsigned long long and print it with %llu.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> Found with a 32-bit build of the selftests with a 64-bit time_t (gcc 16
> and clang 21 with -m32 -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
> KernelCI's 32-bit arm builds show the same warnings. The changed files
> build without format warnings there now, and the x86_64 builds don't
> change. The other selftests get the same kind of fix in separate
> patches.
> 
>  tools/testing/selftests/landlock/fs_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index f725882fa4a78..a2dc9a7f0481a 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -10508,7 +10508,8 @@ TEST_F(trace_layout1, check_rule_fs_fields)
>  	ASSERT_EQ(0, stat(dir_s1d1, &dir_stat));
>  	snprintf(expected_dev, sizeof(expected_dev), "%u:%u",
>  		 major(dir_stat.st_dev), minor(dir_stat.st_dev));
> -	snprintf(expected_ino, sizeof(expected_ino), "%lu", dir_stat.st_ino);
> +	snprintf(expected_ino, sizeof(expected_ino), "%llu",
> +		 (unsigned long long)dir_stat.st_ino);
>  
>  	set_cap(_metadata, CAP_DAC_OVERRIDE);
>  	ASSERT_EQ(0, tracefs_clear());
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Thank you!
–Günther
