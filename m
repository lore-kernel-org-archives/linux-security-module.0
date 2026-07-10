Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2E3413D60
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681817; cv=none; b=UEEoI6b73xaP5sXKcCJCOojbtDqD1yEmYs2FuFdYsQY1qkp6CA/ftmRhNa9Kip1vzWItKzPjY8QdVkDI2l0NBGdMcM0D48hMWFnfawIf4w55kjofou8WrapCK8RCN7BjHZx/AqwbdiYPVTTV5U17OsLcQRqBFTFEPlVAU0L+2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681817; c=relaxed/simple;
	bh=jr/OAoxeUGCn9/9dfkc9tVbO3E1fWJ9EVvCmPe8y7ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILbse69LYm9H83DnF/igbgUoZOhhTtM5Gjx/6m3O1eMHF8kot3sYeQXBdJg5d8x6EDxahEHSxx2c1lJ7lCt0eKqepLbRGtMTStm6gBAkJk9B7MLyp5cw2buFMP096920Pimfm94cFKPUiTyPYDj8NHm80fp0FxK2brDww2MW6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=MlJDq6EI; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="MlJDq6EI"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gxTdK2GplzHMN;
	Fri, 10 Jul 2026 13:10:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1783681813;
	bh=uEwzor5CTtpO07iuBsZoVmpm7MR+nLcLGMZpFeyws4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlJDq6EIadVGOvPD71QGwzgPAObawSPElOSH6BzFvNdxNRyW/xf/S8sGOOGs/+7V9
	 d+F+bmgb3MnwpfXN7Jn6yblDrduX0NZ2luPyPOHDdK4Jnuo8W6c16tzwf6bf/mpOjX
	 xBNiCF/e5t7BymEROE3TJJn/NR3mu3OksnQX7NrU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gxTdJ4Ff3zTsX;
	Fri, 10 Jul 2026 13:10:12 +0200 (CEST)
Date: Fri, 10 Jul 2026 13:10:11 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Thomas Huth <thuth@redhat.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: Skip scoped_signal subtest with
 MSG_OOB if not available
Message-ID: <20260710.laisaiR2ooci@digikod.net>
References: <20260710081642.405916-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710081642.405916-1-thuth@redhat.com>
X-Infomaniak-Routing: alpha

Applied (with a Fixes tag), thanks!

On Fri, Jul 10, 2026 at 10:16:42AM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> MSG_OOB might be disabled in the kernel for unix sockets (by not
> selecting CONFIG_AF_UNIX_OOB), and in this case the related tests
> of the scoped_signal_test are currently failing.  Add a runtime
> probe using socketpair() to detect MSG_OOB support and skip the
> test gracefully if it is unavailable.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .../selftests/landlock/scoped_signal_test.c   | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
> index 58d25157fe781..3cf20d769f2bc 100644
> --- a/tools/testing/selftests/landlock/scoped_signal_test.c
> +++ b/tools/testing/selftests/landlock/scoped_signal_test.c
> @@ -398,6 +398,24 @@ static int setup_signal_handler(int signal)
>  	return sigaction(SIGURG, &sa, NULL);
>  }
>  
> +/*
> + * MSG_OOB might be disabled in the kernel via the CONFIG_AF_UNIX_OOB
> + * switch, so this function can be used for probing for its availability.
> + */
> +static bool has_af_unix_oob(void)
> +{
> +	bool available = false;
> +	int sp[2];
> +
> +	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sp) == 0) {
> +		available = (send(sp[0], ".", 1, MSG_OOB) == 1);
> +		close(sp[0]);
> +		close(sp[1]);
> +	}
> +
> +	return available;
> +}
> +
>  /* clang-format off */
>  FIXTURE(fown) {};
>  /* clang-format on */
> @@ -460,6 +478,9 @@ TEST_F(fown, sigurg_socket)
>  	int pipe_parent[2], pipe_child[2];
>  	pid_t child;
>  
> +	if (!has_af_unix_oob())
> +		SKIP(return, "CONFIG_AF_UNIX_OOB / MSG_OOB not available");
> +
>  	memset(&server_address, 0, sizeof(server_address));
>  	set_unix_address(&server_address, 0);
>  
> -- 
> 2.55.0
> 
> 
