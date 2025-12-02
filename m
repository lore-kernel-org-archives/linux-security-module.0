Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA682749E4
	for <linux-security-module@vger.kernel.org>; Tue,  2 Dec 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764664655; cv=none; b=swluf1vMUlLD0SFOsyki2CAZPkf/R3s1eGfF+UxF1JMlJJ2OvXDAG3q4aEJEuZ6D19s3dJfnv0ZdnOhxMSvVTlOV1DtyncqzdgzMlhXK2AD1/tDjC6hYmKGELe/tZr/T/n8r6a7Oe56T9TCyzRwKnws6I8EAJcbqHlQJ3doNQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764664655; c=relaxed/simple;
	bh=zaJCg3XWm1SVImp4EQCH8h8sEN9SuEEETVGf8pKib7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aE6yUors1K+wEqmqeT7h+CFuEHNJyfij3Y+XQkxfC5EUTeRmArENP00pdQIWXI3YzLFgTA5lLE2NYUR6y1oTQyE9xGjw8bldCWk8JjLy/GrlYgskgr6xyf9AbfMyi3MgRhRxu2dKs+G/VidR299FgP7NDe9Avez746C1akrJ7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IsjMdwtD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IsjMdwtD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso58130735e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 02 Dec 2025 00:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764664651; x=1765269451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tiOzr1mAqhgqqFJOGWenNhzB/hstykGyBlKIr47rH1g=;
        b=IsjMdwtDY6GVWnmmJ9s0b4w+YatlICnloO1BJoVGs8wUs8cdxNiEz4fXDxN3LEEKDX
         KKGUSXz/rTR09+5FoFdkvMOF2Lnb01baewdde6fu5XcwJbOa+Y90OMiBQLtlt+nH8Li1
         x0csTKDGmbwq1oaWtRRL0jHJ5tTOG3WV0uguAdygVCo/cOepfmgXFnh7kK3t8mUmOIfU
         NtuTdJjtQHZvt6EVMB/jStDMdhq0jkviSP6sHnfothCzsYSvxwampayoIdhiSNxolahm
         o1+5yC4HnrduNQO/HUDqobc6P8NOA97NHuxgQvfM0kB8NlY/dTxSMtbwLHBZXRP0Jg3S
         ki8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764664651; x=1765269451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiOzr1mAqhgqqFJOGWenNhzB/hstykGyBlKIr47rH1g=;
        b=CHa4+D0cE7IvYEPZwIJiArrcO77eeU2UUVlWu/71+D3DYRdgYavcqNa1En3/l8edo8
         KQe2/j51UL3QTdkVijFaILKny7zzDTRe0u4+nJzt/KMga9Gx964KImbuOpBk4XsQ2ny6
         x64Cctv2ihqxTijdKOVDTWc9hV+2IqX1HZ8OQUZPCgOk1ZneI5JuOBmM+Ltij3mMN0ay
         R6dYMcNVhQUvwzJwBAX05XJCnZRSLwH1bSYlnjBmlT0fqDROooV8uK+JtuK5+t12eaaE
         jrLUQoX3rDagl29TeFW/ac3f+2U0+Ke4LqAcMXQC+SbuDLLh2lrJdoc/Ascj3T6ej17b
         YTjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHNxwp1dp7lX67Lt+71IayZnVXzCEgTFFMqMkrM0lrOQeX7/2x3+QlGCXRXjW4GNDmwd/I/G3fhNHrXl1X0tt2ICs8BzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Oo+iYyaNuniqXQ95wSqtJmnAAKswMIN91498D0MXZdXEinRY
	9a7NT9KTIQQCKdrYfqVhXLHZin5ZcC8UH0sPJhoA7AHPhrK5zNsd7kyXYuDo/+eSqCxMIVka47k
	LabTzYA==
X-Gm-Gg: ASbGncvhp4iYsW6z9SSHAM5907rXr5tMKyF+z1LjROXQLTXee07xUItpVtalXdMIgHe
	5CLpKPgqzoni6Cf50gA249SiGkKhc21rISbRZ2HPN6o8s8zhlw08w22azb7u/cB2/qqWUFQ5lM6
	oI+mZQyQQohwmF60xQyaYNI3pK3ohraJ3urMC3hVA3sT5aikNlMKK5yO2vbes3FeJn7v0Odi0mN
	5HQzaG4m87am2pzy+86LgCZJlOoroyjDjDg/Rses6tjjtX7bv9HDM6kReHsl5/Z3aGbbQF5tB4/
	fwk5jHyeIv2gTqUSpsohrqqcp3ztQbPnpj5y4n/ZDAkh5tTvkp7eQeMgmenLOBqSTPGWCtGRIFc
	IhQcHTMV7Ah+RREQP/fX4hGyO/jR5WYr8djVX3Cr3J0m5cQM4G+mYkmurDAoosSh10o7gIUB37r
	f9J7s5dcFS7fEFUNgNYeJ2It1wBBQ2HEx5bmgu0XGlmQ==
X-Google-Smtp-Source: AGHT+IE1yDUQZE+ox9F03r1q9Z2lPPQoMTnnFh0xcNqfuw6zmy2Y4NQhNMtqu3t3mAbGrXIEjqiGcA==
X-Received: by 2002:a05:600c:46cd:b0:475:dc5c:3a89 with SMTP id 5b1f17b1804b1-477c1136b7fmr403421225e9.34.1764664651340;
        Tue, 02 Dec 2025 00:37:31 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:fce2:2a7e:3f0f:dfcb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47926ed22ffsm12747825e9.0.2025.12.02.00.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 00:37:30 -0800 (PST)
Date: Tue, 2 Dec 2025 09:37:24 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: Remove invalid unix socket bind()
Message-ID: <aS6lMPTlUo9bWYEG@google.com>
References: <20251201003631.190817-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251201003631.190817-1-matthieu@buffet.re>

Hello!

On Mon, Dec 01, 2025 at 01:36:31AM +0100, Matthieu Buffet wrote:
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index eee814e09dd7..7d378bdf3bce 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -4391,9 +4391,6 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
>  	cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
>  	ASSERT_LE(0, cli_fd);
>  
> -	size = offsetof(struct sockaddr_un, sun_path) + strlen(cli_un.sun_path);
> -	ASSERT_EQ(0, bind(cli_fd, (struct sockaddr *)&cli_un, size));
> -
>  	bzero(&cli_un, sizeof(cli_un));
>  	cli_un.sun_family = AF_UNIX;
>  	strncpy(cli_un.sun_path, path, sizeof(cli_un.sun_path));
> 
> base-commit: 54f9baf537b0a091adad860ec92e3e18e0a0754c
> -- 
> 2.47.3
> 

Reviewed-by: Günther Noack <gnoack@google.com>

It looks like I must have fumbled with the copy&paste in that test,
this bind() call does not make sense in the place where it is and is
not necessary for the test.  Apologies for that and thank you for
spotting this!


Optional: In hindsight, I think it would be nice to simplify the way
that we calculate the address length here.  I probably mis-read
unix(7) at the time, where a similar formula is used (but with a
"+1").  Re-reading it, it seems that just passing sizeof(cli_un) as
the address length would have been the simpler and less error prone
solution:

From unix(7) (emphasis mine):

    The addrlen argument that describes the enclosing sockaddr_un
    structure should have a value of at least:

        offsetof(struct sockaddr_un, sun_path)+strlen(addr.sun_path)+1

    or, more simply, addrlen **can be specified as sizeof(struct
    sockaddr_un).**

So, I believe that all the places where we calculate the size in this
function can just disappear and we can directly use sizeof(cli_un) and
sizeof(srv_un) in the bind() and connect() calls instead.

(Let me know whether you want to do it in this change, otherwise I am
also happy to send a follow-up fix.)

Thanks,
—Günther
