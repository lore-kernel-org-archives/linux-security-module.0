Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC9225A29
	for <linux-security-module@vger.kernel.org>; Thu,  4 Sep 2025 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003121; cv=none; b=jJqBdaEDobkrlmjLd07kbJJkLhlkxMf6+7hlWQWIh/IecErdPAtmWHyKJiQ6i8hUAAtkomGA2er13Ak9RAZ6c8GZzr0lI6hFOCb90WNb7YG8wr5Xgvay7uVuHvgYJdBgrgfMgF3Y+WBaEsICf/qL5dK89kV/3d3w2nTX6ECdJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003121; c=relaxed/simple;
	bh=Xr7HXV2EDj1MUXPmxuHpYx/sRLGDUigEszHvOfugdJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGhYHxC+Gz2fbPqONMAfkPOHwrS0HrxXn2fG7oKLxjz+tZJ0ho3mXdF4TPcbjGA2UywyXK4l0p+BUPHegvQL+HiRDwpr2SjjLG4Qst+uuuDbFQaSiLeuIbFxLIUKrOmmHlBCbD2bk2xiTB1e+cqDXnepFKsT5dY2BU35exKG7fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Avj5ZyE1; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Avj5ZyE1"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cHjcS5yPWzfRJ;
	Thu,  4 Sep 2025 17:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1756998696;
	bh=U2mCz3zznSLsWb7GNeP1eHBLdUbSnWIoGL7c11C9feg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Avj5ZyE1T5StHeQ9hVNvK1r+CVM1voY2tYMZDYfh6WHLK689wDoxb87r3+Piou/oE
	 XFN8qdXhQRcGm1ATYXkTX//HIHbm/jEhpPjqTopY8M/J8tLsLcP1JvYnlyQb0dgA3X
	 XAgvq4GMpLViKLATuUEVpW29hYN27jFBVfXN9kcQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cHjcS0Bk0zGB8;
	Thu,  4 Sep 2025 17:11:35 +0200 (CEST)
Date: Thu, 4 Sep 2025 17:11:35 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH] selftests/landlock: Support running the full fs test
 suite on another FS
Message-ID: <20250904.Jai9ahj2eoh2@digikod.net>
References: <20250830034753.186551-1-m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250830034753.186551-1-m@maowtm.org>
X-Infomaniak-Routing: alpha

On Sat, Aug 30, 2025 at 11:47:51AM +0800, Tingmao Wang wrote:
> Adds a TMP_BIND_TO environment variable which the test binary will check,
> and if present, instead of mounting a tmpfs on ./tmp, it will bind mount
> that path to ./tmp instead.
> 
> Currently there is the layout3_fs tests which runs a few tests (but not
> the full set of Landlock tests) in separate filesystems, notably no file
> creation/write/rename etc.  This is necessary for certain special fs such
> as proc or sysfs, as the tests can only read a specific path.  However,
> for a more typical fs like v9fs, this is limitting.
> 
> This test makes it possible to run the full set on any filesystem (even
> though this is still not automated).  Note that there are some expected
> failures, such as v9fs not supporting RENAME_EXCHANGE, as well as the
> known issue of ephemeral inodes, which may be fixed by a later revision of
> [1].
> 
> Suggestions for alternatives welcome.  Maybe we need to also detect the
> fs, and disable known-unsupported tests like RENAME_EXCHANGE?

Extending layout3_fs tests with new ones that make sense (i.e. those you
listed) would make be more consistent whithout scaling issue.  We can
extend the fixture variants to skip some tests.

This patch should help:
https://lore.kernel.org/all/20250704171345.1393451-1-mic@digikod.net/
Feel free to take it with your 9pfs patch series and add a new patch
with extended checks.

> 
> Link: https://lore.kernel.org/v9fs/cover.1743971855.git.m@maowtm.org/ [1]
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index fa0f18ec62c4..847be67fff9e 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -285,6 +285,22 @@ static const struct mnt_opt mnt_tmp = {
>  	.data = MNT_TMP_DATA,
>  };
>  
> +static struct mnt_opt get_tmp_mnt_opt(void)
> +{
> +	const char *const tmp_bind_to = getenv("TMP_BIND_TO");
> +
> +	if (tmp_bind_to) {
> +		struct mnt_opt mnt = {
> +			.flags = MS_BIND,
> +			.source = tmp_bind_to
> +		};
> +
> +		return mnt;
> +	}
> +
> +	return mnt_tmp;
> +}
> +
>  static int mount_opt(const struct mnt_opt *const mnt, const char *const target)
>  {
>  	return mount(mnt->source ?: mnt->type, target, mnt->type, mnt->flags,
> @@ -322,7 +338,9 @@ static void prepare_layout_opt(struct __test_metadata *const _metadata,
>  
>  static void prepare_layout(struct __test_metadata *const _metadata)
>  {
> -	prepare_layout_opt(_metadata, &mnt_tmp);
> +	struct mnt_opt mnt = get_tmp_mnt_opt();
> +
> +	prepare_layout_opt(_metadata, &mnt);
>  }
>  
>  static void cleanup_layout(struct __test_metadata *const _metadata)
> 
> base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> -- 
> 2.51.0
> 
> 
