Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994131E2838
	for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154297; cv=none; b=fR67gVhc03ZyalxWSTeflo8PRlHpejpfYwh6ANo3S8s+J06pj15FKa1n9S4bHQAcuqy5ZEtuQ9/M7JkC7EnagtJSrF1SKQT+wEDeO3E1PDJetAX3a8p8QncKpSdRcWoWh6OBD9cjIpoK92a6Kpf2TBSi2ZYF+DLmdM+5VcDQOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154297; c=relaxed/simple;
	bh=T6dHZGQk0pjWXFu/aSpqEr6oeLaxTvUf4yKCsJYPulw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfSNJ17TkEs2qnORob9SmLw5EHAf3euHiSl01mnyNfb8Uau82LkSyT8qgfG4bi/mDOj5Di1nbq0a4dw0k+h3l76vPWgay7y1bnsGJS2Ov2NhsCv6QNbhNv7SAyrY24OdjwwgfDmzk6XoGpmu5dL0FIMr5vLnQRCZiWc7lbcgJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=azSe1hIu; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="azSe1hIu"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yzw9b4wLVzqHw;
	Fri, 21 Feb 2025 17:11:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1740154291;
	bh=yQcOqV1VkaALUen0yjiE4okMbU08ONwrQynXhHTnX2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azSe1hIuIY7sAaid+jbJN+ejJw4gKzqOzf7ryu/CXumCodUdC7tku/ZAVGQ5ojFGQ
	 Ve7nC+MHkAwS+LTYjHezaUBEUlO4Yrl0bPkzPbIvN8yfnTHijt4Cvt5v+okYoC589P
	 GZ6Q8MDD0EXk4MVplgqasHYGEDrJPHi0EsAPXvRU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yzw9b14lkzj1j;
	Fri, 21 Feb 2025 17:11:31 +0100 (CET)
Date: Fri, 21 Feb 2025 17:11:30 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: gnoack@google.com, shuah@kernel.org, skhan@linuxfoundation.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/landlock: add binaries to gitignore
Message-ID: <20250221.iehieChaoki1@digikod.net>
References: <20250210161101.6024-1-bharadwaj.raju777@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210161101.6024-1-bharadwaj.raju777@gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Feb 10, 2025 at 09:40:57PM +0530, Bharadwaj Raju wrote:
> Building the test creates binaries 'wait-pipe' and
> 'sandbox-and-launch' which need to be gitignore'd.
> 
> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>

Thanks!

> ---
>  tools/testing/selftests/landlock/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/.gitignore b/tools/testing/selftests/landlock/.gitignore
> index 470203a7cd73..0566c50dfcad 100644
> --- a/tools/testing/selftests/landlock/.gitignore
> +++ b/tools/testing/selftests/landlock/.gitignore
> @@ -1,2 +1,4 @@
>  /*_test
>  /true
> +/wait-pipe
> +/sandbox-and-launch
> -- 
> 2.43.0
> 
> 
