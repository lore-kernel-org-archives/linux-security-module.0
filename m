Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA65145341
	for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2024 19:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096853; cv=none; b=gdmprjTPkycvyilO8B7XThuGihG01ptoF5apPpI3qp+11JnCbZ32pAGuWmuKTsY1rvI8st+eLHnTTpwQs0ZSkm4tHXeA2WAidHdWorCuRfjsi6sAEowBkP65ETn5xX16V/pj9u+g7SbVJvkmJmDKLjjrhH+zIBGeB/OEsNgCf3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096853; c=relaxed/simple;
	bh=aFO8S6ptrA9vRatPbkASy+wPxZ+69fy3yw2vN8gDmyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chnOeP0thL15oo256cfKo4gmVS+o35cEHeAeo2WAFjqJ8rfUM3dAQ6XvR1nsUmv6LGXG4ukmkbYlwOFaXsZqGG/gUbuo3P1MM1f9+w64LZTqOzOlzodKK3X5XDyY2ybkmn0egAE9YlU6V29L9qqLtKjV8mrFAPVJsywaMurbt6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=r/zgoQk4; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="r/zgoQk4"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wnjmb1n0vzl56;
	Mon, 19 Aug 2024 21:47:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724096847;
	bh=47ZixQsG6Q3QUb7QdsnWS5gr698drar7jhvYV9oZYqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/zgoQk4IAhjbwAJg5XLXENBvlZ/P26MVDkiXM/bF3Gf1X2mLHq1aDGmtwX0Pvx1e
	 79Mb28wAS+xfG1/FeBqVWUEXKucJp1a10gO4JWtbEsferxfgoEZ5aMhNkKNsk6ctBf
	 p4e6hkfHM6RusnwKzCgDvyVkRugQyKI5GTLe//fo=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WnjmZ55z7z27s;
	Mon, 19 Aug 2024 21:47:26 +0200 (CEST)
Date: Mon, 19 Aug 2024 21:47:23 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v9 3/5] selftests/Landlock: Adding pathname Unix socket
 tests
Message-ID: <20240819.Ohph6ahphohH@digikod.net>
References: <cover.1723615689.git.fahimitahera@gmail.com>
 <df1c54690beeab024534f6671ee9a3266270d9e1.1723615689.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df1c54690beeab024534f6671ee9a3266270d9e1.1723615689.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Aug 14, 2024 at 12:22:21AM -0600, Tahera Fahimi wrote:
> This patch expands abstract Unix socket restriction tests by
> testing pathname sockets connection with scoped domain.
> 
> pathname_address_sockets ensures that Unix sockets bound to
> a null-terminated filesystem can still connect to a socket

"bound to a filesystem path name"

> outside of their scoped domain. This means that even if the
> domain is scoped with LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
> the socket can connect to a socket outside the scoped domain.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
> changes in versions:
> v9:
> - Moving remove_path() back to fs_test.c, and using unlink(2)
>   and rmdir(2) instead.
> - Removing hard-coded numbers and using "backlog" instead.
> V8:
> - Adding pathname_address_sockets to cover all types of address
>   formats for unix sockets, and moving remove_path() to
>   common.h to reuse in this test.
> ---
>  .../landlock/scoped_abstract_unix_test.c      | 204 ++++++++++++++++++
>  1 file changed, 204 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> index 232c3b767b8a..21285a7158b6 100644
> --- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> +++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> @@ -939,4 +939,208 @@ TEST_F(unix_sock_special_cases, socket_with_different_domain)
>  	    WEXITSTATUS(status) != EXIT_SUCCESS)
>  		_metadata->exit_code = KSFT_FAIL;
>  }
> +
> +static const char path1[] = TMP_DIR "/s1_variant1";
> +static const char path2[] = TMP_DIR "/s2_variant1";
> +
> +/* clang-format off */
> +FIXTURE(pathname_address_sockets) {
> +	struct service_fixture stream_address, dgram_address;
> +};
> +
> +/* clang-format on */

Please minimize the use of these tags (e.g. don't include new lines) and
remove them when they don't change the formatting.

> +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> +		_metadata->exit_code = KSFT_FAIL;
> +}

Please always add a newline before TEST_HARNESS_MAIN.
`check-linux.sh all` prints an error.

>  TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 
> 
