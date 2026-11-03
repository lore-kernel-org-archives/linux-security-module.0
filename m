Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742584;
	b=GslN14wG9725m06em4A3ybTZEQurtwnuPpfvUNnzFYk5CvuWXmyM+DGJitu8chXHT5Kg
	 4+lCPSPd8U3MQSn4OOMbXA0lXMI0Bjq0lFEjfWWIoXzPicLypNVJOEjviS83zrMVhThYN
	 wXhrUAj8Dfb5/GpCkIV7ap8Msg9xx6SvoFKhWJn5/mThEUMjwUYG0ecuX1rHh9GgMKitc
	 T8QzXnCVZ2pE2b9hgXNnBiKUoSb0j4k4AEtkSgejL0iH6uK0GEqWIFMHqvFP5SmlQufak
	 LCisXK5bHF9YcGzfCzO/57K2Ca2EICZ1kGaq1/QvZdPgodgNJKYSZ9x12kVt+KNlEAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742584;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0PzhGlwivk5ut3NM8Y+GDWARHDeV9ILEL9ouE21WHXs=;
	b=rJRurZQic2tYiqBjpYLje9hKSoy78L1aqbhHq3AdAmhGHEg9b/HwNOU9d7uJVf5jzc7t
	 qBpMu0oCRFdze9flKLU927s6uu7ifgNh/v7SkOAIByQs4fZuPBk9Fa32uaHBZW+UCobEj
	 FcNfIEiNgPj1DgOtntEMo1ROey/0RcQZLDuPUrkdRFpVv9EkGidUV3XMGYbkdByVAyOFA
	 msJcujnkJ17TDGEjcSQ/aIUFRSRMRzxa/dOKspNOAhyod9Mv7JFRZof5kR3vNO3/lDksb
	 BPpnek9+5+XdUQQrfS4UBnSgQNbNTFXHPGKoPqJNAlF01tNw7derGV72zg75VhqfAmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awQn3FXj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE3606A328;
	Tue,  3 Nov 2026 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awQn3FXj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B1D1F000C1;
	Tue,  3 Nov 2026 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742583;
	bh=0PzhGlwivk5ut3NM8Y+GDWARHDeV9ILEL9ouE21WHXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=awQn3FXjuOnS27R9NiFgA40a8ycZiyjB7WyB+ZdTaZHz8wDVh/wlO0aoJV3txzJBj
	 qCC4t0405STFRpj0WJMIUexCw5Gx+F8OI273ek+JE/NIaem9xbvpWyBuBUwanuYB5V
	 Rkv6jNofbUC+x2fILvbqVNaOAHprz5I16S3+f/vTzOusjyxFWmx9M0I17PE4+MoVBK
	 qKdF2heyGvIS5VRqgqbwMAMbz+Nj5WRpgpHlVSoVmZeMu645xh9vGML8s8iqh3uz1N
	 YEAzKcaIP/h6hUM/s+BEkQuEZHcKMTT8iDDsY2rxYxr0E2ASMeD+g8w2xKkCCQD885
	 02m6yFD4spVvA==
From: Sasha Levin <sashal@kernel.org>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: fix the regex_escape() error check
Date: Tue,  3 Nov 2026 16:49:41 -0500
Message-ID: <20261103214941.1553946-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103.06edcd6fc9f1@gnoack.org>
References: <20261103163917.641130-1-sashal@kernel.org> <20261103.06edcd6fc9f1@gnoack.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Nov 03, 2026 at 09:31:33PM +0100, Günther Noack wrote:
> Thanks for the contribution!  I also stumbled across this one when I
> did a wider cleanup, and at the time I came to the conclusion that it
> would be wiser to fix the weird way in which regex_escape() reports
> errors.
>
> https://lore.kernel.org/all/20261008142604.39107-20-gnoack3000@gmail.com/
>
> Does that seem reasonable to you?

Yes, that's better. Your 18/27 also fixes the size miscount after the
escaped path, so it covers everything this patch does. Let's drop this
one in favor of your series.

--
Thanks,
Sasha
