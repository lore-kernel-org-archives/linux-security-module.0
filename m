Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9886A20B80D
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508275; cv=none; b=FUeZUojlYB7xJE3Wp+OC0LkdcJXkcXczDT4VgX89dOlahHwaPPni0QOYQPKm8jiSKc6LSDXpQbMC/XjDpy8XUMPeqw+WEth1dETGmPGdhGke7BIi5hIfjbvfgi1q0qLQacIGGb6sNxUpWmHHjnxQbadTOPOxu/O7eYVoi89Vh9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508275; c=relaxed/simple;
	bh=yfPYPQCg67pYoiZZSR5nHbe+tADifIYJcqg8W8cPOU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtYKgskm3LnAv9YOPilsRB9Z++5XW7L6nSsyEHGtT6+mastioPObT2zP0pbHDG3+HIgYEorPCxkEmshAzx64LKy9y+0Hhfiwrs1PJ2z1kd6VX7ry5+6BOrYE0ILeroqp/YHLY0AFdgQBM8Sm/O0qeiGs4eDl2K25xjGiExyKBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=v3ZMmu6y; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="v3ZMmu6y"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YTznr0nxnz2pq;
	Fri, 10 Jan 2025 12:24:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736508272;
	bh=ftgkcFvp8UxyWLCL+yYOQlkIDZYSA36scDqu8HyCN3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v3ZMmu6y36XC7zry04lEIHVBD9Uh33G1XPg89qxbliHHyzKqZ8HiF6kyFbUcuTYwt
	 5aH6TsVF6CSKyFYdjOHJQsQPG7biEklLvGTl0SoHGA7K0RJXYevnhrkE0IFNO/X04u
	 if+s8qNO4PshJpu4jSrVXMFXvaelu4u85BoFhWAQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YTznq2fwfzbbK;
	Fri, 10 Jan 2025 12:24:31 +0100 (CET)
Date: Fri, 10 Jan 2025 12:24:30 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 12/30] selftests/landlock: Add test to check partial
 access in a mount tree
Message-ID: <20250110.Ohthee1ohbah@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
 <20250108154338.1129069-13-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108154338.1129069-13-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Jan 08, 2025 at 04:43:20PM +0100, Mickaël Salaün wrote:
> Add layout1.refer_part_mount_tree_is_allowed to test the masked logical
> issue regarding collect_domain_accesses() calls followed by the
> is_access_to_paths_allowed() check in current_check_refer_path().  See
> previous commit.
> 
> This test should work without the previous fix as well, but it enables
> us to make sure future changes will not have impact regarding this
> behavior.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250108154338.1129069-13-mic@digikod.net

Pushed in my next tree to simplify next patch series.

> ---
> 
> Changes since v2:
> - New patch.
> ---
>  tools/testing/selftests/landlock/fs_test.c | 54 ++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 6788762188fe..42ce1e79ba82 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -85,6 +85,9 @@ static const char file1_s3d1[] = TMP_DIR "/s3d1/f1";
>  /* dir_s3d2 is a mount point. */
>  static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
>  static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
> +static const char file1_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3/f1";
> +static const char dir_s3d4[] = TMP_DIR "/s3d1/s3d2/s3d4";
> +static const char file1_s3d4[] = TMP_DIR "/s3d1/s3d2/s3d4/f1";
>  
>  /*
>   * layout1 hierarchy:
> @@ -108,8 +111,11 @@ static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
>   * │           └── f2
>   * └── s3d1
>   *     ├── f1
> - *     └── s3d2
> - *         └── s3d3
> + *     └── s3d2 [mount point]
> + *         ├── s3d3
> + *         │   └── f1
> + *         └── s3d4
> + *             └── f1
>   */
>  
>  static bool fgrep(FILE *const inf, const char *const str)
> @@ -358,7 +364,8 @@ static void create_layout1(struct __test_metadata *const _metadata)
>  	ASSERT_EQ(0, mount_opt(&mnt_tmp, dir_s3d2));
>  	clear_cap(_metadata, CAP_SYS_ADMIN);
>  
> -	ASSERT_EQ(0, mkdir(dir_s3d3, 0700));
> +	create_file(_metadata, file1_s3d3);
> +	create_file(_metadata, file1_s3d4);
>  }
>  
>  static void remove_layout1(struct __test_metadata *const _metadata)
> @@ -378,7 +385,8 @@ static void remove_layout1(struct __test_metadata *const _metadata)
>  	EXPECT_EQ(0, remove_path(dir_s2d2));
>  
>  	EXPECT_EQ(0, remove_path(file1_s3d1));
> -	EXPECT_EQ(0, remove_path(dir_s3d3));
> +	EXPECT_EQ(0, remove_path(file1_s3d3));
> +	EXPECT_EQ(0, remove_path(file1_s3d4));
>  	set_cap(_metadata, CAP_SYS_ADMIN);
>  	umount(dir_s3d2);
>  	clear_cap(_metadata, CAP_SYS_ADMIN);
> @@ -2444,6 +2452,44 @@ TEST_F_FORK(layout1, refer_mount_root_deny)
>  	EXPECT_EQ(0, close(root_fd));
>  }
>  
> +TEST_F_FORK(layout1, refer_part_mount_tree_is_allowed)
> +{
> +	const struct rule layer1[] = {
> +		{
> +			/* Parent mount point. */
> +			.path = dir_s3d1,
> +			.access = LANDLOCK_ACCESS_FS_REFER |
> +				  LANDLOCK_ACCESS_FS_MAKE_REG,
> +		},
> +		{
> +			/*
> +			 * Removing the source file is allowed because its
> +			 * access rights are already a superset of the
> +			 * destination.
> +			 */
> +			.path = dir_s3d4,
> +			.access = LANDLOCK_ACCESS_FS_REFER |
> +				  LANDLOCK_ACCESS_FS_MAKE_REG |
> +				  LANDLOCK_ACCESS_FS_REMOVE_FILE,
> +		},
> +		{},
> +	};
> +	int ruleset_fd;
> +
> +	ASSERT_EQ(0, unlink(file1_s3d3));
> +	ruleset_fd = create_ruleset(_metadata,
> +				    LANDLOCK_ACCESS_FS_REFER |
> +					    LANDLOCK_ACCESS_FS_MAKE_REG |
> +					    LANDLOCK_ACCESS_FS_REMOVE_FILE,
> +				    layer1);
> +
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	ASSERT_EQ(0, rename(file1_s3d4, file1_s3d3));
> +}
> +
>  TEST_F_FORK(layout1, reparent_link)
>  {
>  	const struct rule layer1[] = {
> -- 
> 2.47.1
> 
> 
