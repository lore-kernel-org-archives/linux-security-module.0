Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D03AF66C
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jun 2026 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958523; cv=none; b=nP5jhI6FK7ATr+RbOea2dFbpd2PiDp+tjcAX1oi004OErN+hvMAsXN3ZaudNpZGASurByFzZ+MQ0qAt4zhO1Ar3pLlzojsTsnk3SioT9zwxuQNjJl3sGK7X1KCJf+YnFgYBn9g7z2cMyvkyGBZSthNUFHNZR1gJkuEc0M4qXpGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958523; c=relaxed/simple;
	bh=BquwduWoMU5uFR+5UAsG5d+fjCmwWC93X7PJYpyqa78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqCWogd2aXDSRbHRRS0I5MrA5O9l66nZV2Lf96JKv2/zwIJ2H9k1rJ76ubATxljZMfZgsc+hHDr4YwzbtmRANHvoOhJwcMCjh/gPK6nhZEhXX5wTBdJYpUu89m+d+JKnJltqrX28SsGFsPWkMGJviO2f0iuAgCmn73RuWCjSyvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Ici4HA3t; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Ici4HA3t"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gZ6VH0p3dzC1Y;
	Tue,  9 Jun 2026 00:41:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1780958518;
	bh=ncIyXtYZtjgQXxqMJEKjvbKCsvRqfL39zuTf83Ravjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ici4HA3txEZQdK9swFIRLjalp2HiDiXFCe+QNjegfraNnZRRlHm1TBhMZ1l3a6QQg
	 YWbP5T2DV1KZI1sw+0ShLLnnJsUVGLeoXz1SmvqsGUM5+E9XIerhjhCvXYMp81HoF6
	 RHgIt6DWXFtyZd0whI6fGNiUMmsP1SRQoW3hJI0U=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gZ6VG211Xz4m1;
	Tue,  9 Jun 2026 00:41:58 +0200 (CEST)
Date: Tue, 9 Jun 2026 00:41:57 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 9/9] selftests/landlock: Add tests for invalid use of
 quiet flag
Message-ID: <20260609.Quah2aegeiMu@digikod.net>
References: <cover.1780272022.git.m@maowtm.org>
 <99587e6f737a425d18fda31649edf304f74f3567.1780272022.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99587e6f737a425d18fda31649edf304f74f3567.1780272022.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Jun 01, 2026 at 01:00:43AM +0100, Tingmao Wang wrote:
> Make sure that these calls return EINVAL.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> Changes in v4:
> - New patch
> 
>  tools/testing/selftests/landlock/base_test.c | 57 ++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 84e91fcaa1b2..af9ad822a444 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -526,4 +526,61 @@ TEST(cred_transfer)
>  	EXPECT_EQ(EACCES, errno);
>  }
>  
> +TEST(useless_quiet_rule)
> +{
> +	struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
> +		.quiet_access_fs = 0,

The other .quiet_* fields should also be tested.

> +	};
> +	struct landlock_path_beneath_attr path_beneath_attr = {
> +		.allowed_access = LANDLOCK_ACCESS_FS_READ_DIR,
> +	};
> +	int ruleset_fd, root_fd;
> +
> +	drop_caps(_metadata);
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	root_fd = open("/", O_PATH | O_CLOEXEC);
> +	ASSERT_LE(0, root_fd);
> +	path_beneath_attr.parent_fd = root_fd;
> +	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> +					&path_beneath_attr,
> +					LANDLOCK_ADD_RULE_QUIET));
> +	ASSERT_EQ(EINVAL, errno);
> +
> +	/* Check that the rule had not been added. */
> +	ASSERT_EQ(0, close(root_fd));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
> +	ASSERT_EQ(EACCES, errno);
> +}
> +
> +TEST(invalid_quiet_bits_1)
> +{
> +	struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
> +		.quiet_access_fs = LANDLOCK_ACCESS_FS_WRITE_FILE,

ditto

> +	};
> +
> +	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
> +					      sizeof(ruleset_attr), 0));
> +	ASSERT_EQ(EINVAL, errno);
> +}
> +
> +TEST(invalid_quiet_bits_2)
> +{
> +	struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
> +		.quiet_access_fs = 1ULL << 63,

ditto

> +	};
> +
> +	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
> +					      sizeof(ruleset_attr), 0));
> +	ASSERT_EQ(EINVAL, errno);
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.54.0
> 
