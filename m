Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148FE32BF21
	for <linux-security-module@vger.kernel.org>; Fri,  9 Jan 2026 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955295; cv=none; b=VmZghHP/0iPbcjwOdw1jxvjT6UblWwL3u3OmteE4hGLglc1WFMGdJbMYHaVqB4L99sItxOMXTvqCMWZods6yr7rsO1wM+DHf7E+imtvNfLaPdrhfY9WFxDEccrAyixMFmMobRJICyqRlZGaWeEy4ANC6zi5+sTNaPthiJBYJH74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955295; c=relaxed/simple;
	bh=/lxkn/BXzXr1UoR9XTIRCfW9AY/i0O30sRXuWV2e9Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCl3cXzLkJcI/KLy9Py+nuxl41SpTclDE/uaeDerjdUu+l+c0yocnWD0gKndAcVQA4w4F8TBxf8gVwD9Pd3rruknj/tL/emGCnu6mywezYP7ZFfVWCux/Q86j4qpUgZXyXG5K+kIYKjXdRwWUlqBipky8p9vuQMWQyuGNjj3i/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ywaEpoyz; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ywaEpoyz"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dndcB2SFnzkXc;
	Fri,  9 Jan 2026 11:41:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1767955290;
	bh=3x5TS7VKsYQyyV6fOVuCSJrpnjCvmHzH0sXjpWkn180=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ywaEpoyzKpyGLX8lf7D7Hd4YczZ3cFU6KYlkKQqpMmaYtrsp0jFuuZkozOYqVdjf5
	 GzsZ3L2JNn1KvUHYjRgUjL7CyjTOlP2GqT+VxGlISXEmV/kYXz4WvgBudHrZzXrlAk
	 gSOtrQ9eg5VtFT90oFU6i05fAzF8oyKulBkHsykY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dndc94WSDzXKw;
	Fri,  9 Jan 2026 11:41:29 +0100 (CET)
Date: Fri, 9 Jan 2026 11:41:26 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [RFC PATCH 1/5] landlock/selftests: add a missing close(srv_fd)
 call
Message-ID: <20260109.Thoot8ooWai7@digikod.net>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
 <20260101134102.25938-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260101134102.25938-2-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

Good, I'll pick that in my -next branch.

Nit: The prefix should be "selftests/landlock"

On Thu, Jan 01, 2026 at 02:40:58PM +0100, Günther Noack wrote:
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 37a5a3df712ec..16503f2e6a481 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -4400,6 +4400,7 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
>  	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
>  
>  	ASSERT_EQ(0, close(cli_fd));
> +	ASSERT_EQ(0, close(srv_fd));
>  }
>  
>  /* clang-format off */
> -- 
> 2.52.0
> 
> 
