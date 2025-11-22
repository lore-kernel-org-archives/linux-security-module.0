Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F96CA5A
	for <linux-security-module@vger.kernel.org>; Sat, 22 Nov 2025 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763806567; cv=none; b=Lumizqw1lRbQVI1ibI4rjP2hodk73fz82Hnq+Oe+y6o18rjfipavQblz9qJtXGjzgh3Q2/Tsatv0sM04heYhD/K/eqY8juVzuO0Fl4r2y9aZbotwVlG1GM/8pEAiJHgsWHTMA3t8bIQO7k236f/SHiSYN8hH3LIZ8MxZnxP3mNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763806567; c=relaxed/simple;
	bh=okpyZGlEFjEuEDFNYuruZwkefkPmV4EIGxCGt77K1j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=An92Wor9Xbx8Zvqlc35J+sRvBGPpVuaI7V9E/zIml9hb6dmJ4m/ZiAF6bldoxEZ4yI3bJgEd0auJe0o/wa4j81H8jbRZb1oIPFm7nPvtfAwEJ/Ekr6zJyVB7VfNNJjQ2BbLOb6YwZxi5I4rDZsp4IPw7V1ghgkBKAFTxXhAmJ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiNkRK7F; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiNkRK7F"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b737c6c13e1so515484666b.3
        for <linux-security-module@vger.kernel.org>; Sat, 22 Nov 2025 02:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763806563; x=1764411363; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mS/vz1rW7oaq1ahBZ3rleu8uUoiOnYHPIRfP3oM2Z9Q=;
        b=eiNkRK7FWVQQ4EFDGPfIPJkC8lovp7vBYF/9D8EplMpXmMyibk0T1MjtegsoC2UPrl
         KpOrI2dRYkx8o7MmTvZiurG2k2MK3qPG3QzU4k71AAgU6yckiRV2R6FXtmiGvRYvHkll
         R9KjbSsjV2f3rx2nC3lHAAT2GGo7oG5ojlbeJ8HVTEK8/2qR/2TozhBL5nB0VA4rrXfF
         tu6Q33YDZN2VhkoevrlSxD/kN21wuSgXXXzNgGELpDggjNmswQDgH20wD+7CJzNy/E61
         NdiCVgCZ6FlE9Sbj9EMfrjbdBcvAqBHbQF20DHZO5tzsaSr9zjwN1hjAezc/7dVaY0P4
         8/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763806563; x=1764411363;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mS/vz1rW7oaq1ahBZ3rleu8uUoiOnYHPIRfP3oM2Z9Q=;
        b=LhJQ8yqYZAxDDKZ+IQgLc/JN/GpVlNlj2E9UPi/4tgK/7jpA6ccbkKyBYrhC38DYSG
         wLtUmRCPRiF9Zao3rxfz25v06NPB4BShxyDANd+mtMg7JX4r8skzwi6q1Zzcx8qFnPt8
         +Doy4MMqOrCRH0arUtGPZiKx2iii1ryj/mGG6nHjzKkjzggoL7LpEgyjt6m1ARvrKKv2
         ji4BsQI//lwfSVZt5QTGj2aqSx9gl6NfQUlWN8RZYWxBJvUV+qWtP4htRjKqezQiVaX8
         Rzj5+arFCIIoqqUM4CZOxt5SzLKGZIrvWFWDNJqQZAIkCarXCP0v0ZDHGAekrj0TPMhk
         TFXg==
X-Forwarded-Encrypted: i=1; AJvYcCWqSJgUcalXXyvylRXr9PnlXn5UO5KPfB+gKkaJOjvp25nmjO9Tv49PGVWzhcti32JA543nmnTvKXlvaWEqijNubtWlRZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwchKR2tH73NrBkTtnmezFN002D6Z0TOSaAoq4VbhrwOsYLGKu7
	boywpaJEAJVZjei1QbJfQvg6qOugUL0m1VAFz/rXrk9GPWOAHcnK3pmn/lyoKX4V
X-Gm-Gg: ASbGnctwbRcoD9/z6aUyn5ld0nGkLJr02IlZjc0/1s+rA2coN4uTX5aB7ABDr0jIYnY
	P3RQtWuypzE4agUuSR7JGKsuXLOC2J5ZOylwogcQmjqAwQNjfo6Hk7TLYsMocoO6CICSXKRRsIh
	39LfuUxlthXSuIGhR2Eb/i36/6TUKxVQh4Jy2vCsQ7+ylN6VphZzQiVVM5t/uNJrKOh10lQVy7d
	aNu14fH3ayLMauaAUHgHmv57ETO7XR5sjvMmJui4OGFyWYGTJCmOAsE4k0STj3QKzPZIYDuTjTP
	FTeFA5NJTbq64KGH5MRKOzeHNMu7Rrj3W/tCI+Y0SJMuVon7OSDoiw13k5U9NUQPs16/9H6PD8T
	mf/TqYFmPOWvR+Trd7Dwe9S3R7GZmPWxUQLGTPKRiwt8KC4iG7MH1LCeGQX3weXKYoLVF2Hdl3q
	L9yXhs37EBINpnhlMBsTsmKbUE+dB/D96I6YME
X-Google-Smtp-Source: AGHT+IFvc6Tdcl0gKFGge7EMecimqjBsOE5KfFFBnMOWlWkZjJiEqjTrnAEKRSLZBoXUKpD+VYqOVw==
X-Received: by 2002:a17:907:1c26:b0:b70:5aa6:1535 with SMTP id a640c23a62f3a-b767157138dmr624288566b.18.1763806562727;
        Sat, 22 Nov 2025 02:16:02 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654ff3962sm698791966b.50.2025.11.22.02.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:16:02 -0800 (PST)
Date: Sat, 22 Nov 2025 11:16:00 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, gnoack@google.com, willemdebruijn.kernel@gmail.com,
	matthieu@buffet.re, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	yusongping@huawei.com, artem.kuzin@huawei.com,
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH v4 12/19] selftests/landlock: Test socketpair(2)
 restriction
Message-ID: <20251122.4795c4c3bb03@gnoack.org>
References: <20251118134639.3314803-1-ivanov.mikhail1@huawei-partners.com>
 <20251118134639.3314803-13-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251118134639.3314803-13-ivanov.mikhail1@huawei-partners.com>

On Tue, Nov 18, 2025 at 09:46:32PM +0800, Mikhail Ivanov wrote:
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testing/selftests/landlock/socket_test.c
> index e22e10edb103..d1a004c2e0f5 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -866,4 +866,59 @@ TEST_F(tcp_protocol, alias_restriction)
>  	}
>  }
>  
> +static int test_socketpair(int family, int type, int protocol)
> +{
> +	int fds[2];
> +	int err;
> +
> +	err = socketpair(family, type | SOCK_CLOEXEC, protocol, fds);
> +	if (err)
> +		return errno;
> +	/*
> +	 * Mixing error codes from close(2) and socketpair(2) should not lead to
> +	 * any (access type) confusion for this test.
> +	 */
> +	if (close(fds[0]) != 0)
> +		return errno;
> +	if (close(fds[1]) != 0)
> +		return errno;

Very minor nit: the function leaks an FD if it returns early after the
first close() call failed.  (Highly unlikely to happen though.)

> +	return 0;
> +}
> +
> +TEST_F(mini, socketpair)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_socket = LANDLOCK_ACCESS_SOCKET_CREATE,
> +	};
> +	const struct landlock_socket_attr unix_socket_create = {
> +		.allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
> +		.family = AF_UNIX,
> +		.type = SOCK_STREAM,
> +		.protocol = 0,
> +	};
> +	int ruleset_fd;
> +
> +	/* Tries to create socket when ruleset is not established. */
> +	ASSERT_EQ(0, test_socketpair(AF_UNIX, SOCK_STREAM, 0));
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +				       &unix_socket_create, 0));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Tries to create socket when protocol is allowed */
> +	EXPECT_EQ(0, test_socketpair(AF_UNIX, SOCK_STREAM, 0));
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);

You may want to check that landlock_create_ruleset() succeeded here:

ASSERT_LE(0, ruleset_fd)

> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Tries to create socket when protocol is restricted. */
> +	EXPECT_EQ(EACCES, test_socketpair(AF_UNIX, SOCK_STREAM, 0));
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 

Otherwise, looks good.
–Günther
