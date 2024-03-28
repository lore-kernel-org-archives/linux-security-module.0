Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1095A4E1D1
	for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637017; cv=none; b=HJQB8W2CXTZs70f3BsfWSqRvSBkxmoOVx8B5XC0ee5cCsXZ4LaXXFxzCGBkcs/EAeKY4ddsa7ULjp02wsTZMP6NxLt71+vqaD+OdoR+AKqjMg5ydMw/KH8HhkmkRRgrYt/d0jnFZM1f2dKcVDIyKITxb44qAPRPNvPLTF3Q15nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637017; c=relaxed/simple;
	bh=nVYaRIvg0D/p0wv6SHeev56226P4gK/S5foCmekjRxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/jjCk0drfPiEPVpTxJV4pSEUuBzoEqtsyu0Phnhf3Tw486ppkVamYGec7BmgoEWMkff4JYIOz8ahvz1m235K+s1r30BStEl5s2fs6gW0xEgihA9+RPZj4ySRrRbFyJZywkGbdsEWN8pOlbwpe6i/9R0alq6nXjOOYSde5ktp6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=084vGO6V; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="084vGO6V"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V55rC1VTxzRbs;
	Thu, 28 Mar 2024 15:43:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711637003;
	bh=nVYaRIvg0D/p0wv6SHeev56226P4gK/S5foCmekjRxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=084vGO6VK1xqN2lN2258GNVWytP7XGz0FZDahWLZRyCahhJVt8CUGsFDLfXwxrNuZ
	 nmeJ1yWuJcpbIws56pI94OoIq4zoCObzhlT1Dn7mq4YORBvrgF/U2XANeVjla1uFQ/
	 DWkx7gjjl5cs3V3SWBFeBr/eGsOiQHJPJxxsC1yU=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4V55rB2NVDzMpnPt;
	Thu, 28 Mar 2024 15:43:22 +0100 (CET)
Date: Thu, 28 Mar 2024 15:43:21 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Dorine Tipo <dorine.a.tipo@gmail.com>
Cc: skhan@linuxfoundation.org, outreachy@lists.linux.dev, 
	"Fabio M . De Francesco" <fabio.maria.de.francesco@linux.intel.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] Add Landlock test for io_uring IORING_OP_OPENAT
 operation
Message-ID: <20240328.Toj5hahve6ga@digikod.net>
References: <20240327132001.30576-1-dorine.a.tipo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240327132001.30576-1-dorine.a.tipo@gmail.com>
X-Infomaniak-Routing: alpha

Please use the "selftests/landlock: " subject prefix.

On Wed, Mar 27, 2024 at 01:20:01PM +0000, Dorine Tipo wrote:
> This patch expands Landlock test coverage to include io_uring operations.
> It introduces a test for IORING_OP_OPENAT with Landlock rules, verifying
> allowed and disallowed access. This mitigates potential security

I wouldn't say "This mitigate..." but "This makes sure that IORING_OP_OPENAT is
well covered...".

> vulnerabilities by ensuring Landlock controls access through io_uring.
> 
> It also updates the Makefile to include -luring in the LDLIBS.
> This ensures the test code has access to the necessary liburing
> library for io_uring operations.

When running tests I get:

#  RUN           openat_test.test_ioring_op_openat_allowed ...
# fs_test.c:683:test_ioring_op_openat_allowed:Expected 0 (0) <= path_beneath.parent_fd (-1)
# fs_test.c:685:test_ioring_op_openat_allowed:Failed to open directory "tmp/s1d1/f1": No such file or directory
# test_ioring_op_openat_allowed: Test failed at step #5
#          FAIL  openat_test.test_ioring_op_openat_allowed
not ok 112 openat_test.test_ioring_op_openat_allowed


> 
> Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
> ---
> Changes since V1:
> V2: - Consolidated two dependent patches in the V1 series into one patch
>       as suggested by <fabio.maria.de.francesco@linux.intel.com>
>     - Updated the subject line to be more descriptive.
> 
>  tools/testing/selftests/landlock/Makefile  |   4 +-
>  tools/testing/selftests/landlock/fs_test.c | 132 +++++++++++++++++++++
>  2 files changed, 134 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
> index 348e2dbdb4e0..ab47d1dadb62 100644
> --- a/tools/testing/selftests/landlock/Makefile
> +++ b/tools/testing/selftests/landlock/Makefile
> @@ -13,11 +13,11 @@ TEST_GEN_PROGS := $(src_test:.c=)
>  TEST_GEN_PROGS_EXTENDED := true
> 
>  # Short targets:
> -$(TEST_GEN_PROGS): LDLIBS += -lcap
> +$(TEST_GEN_PROGS): LDLIBS += -lcap -luring
>  $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
> 
>  include ../lib.mk
> 
>  # Targets with $(OUTPUT)/ prefix:
> -$(TEST_GEN_PROGS): LDLIBS += -lcap
> +$(TEST_GEN_PROGS): LDLIBS += -lcap -luring
>  $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 9a6036fbf289..9c8247995d42 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -21,7 +21,10 @@
>  #include <sys/stat.h>
>  #include <sys/sysmacros.h>
>  #include <sys/vfs.h>
> +#include <sys/types.h>
>  #include <unistd.h>
> +#include <liburing.h>
> +#include <linux/io_uring.h>

You can sort include lines with `sort -u`

> 
>  #include "common.h"
> 
> @@ -4874,4 +4877,133 @@ TEST_F_FORK(layout3_fs, release_inodes)
>  	ASSERT_EQ(EACCES, test_open(TMP_DIR, O_RDONLY));
>  }
> 
> +/* Test io_uring openat access control with landlock rules */
> +static int test_ioring_op_openat(struct __test_metadata *const _metadata, const __u64 access, const char **paths, const int paths_size)
> +{
> +	struct io_uring ring;
> +	struct io_uring_sqe *sqe;
> +
> +	const char *allowed_paths[] = {
> +		file1_s1d1, file2_s1d1,
> +		file1_s1d2, file2_s1d2,
> +		file1_s1d3, file2_s1d3,
> +		file1_s2d1, file1_s2d2,
> +		file1_s2d3, file2_s2d3,
> +		file1_s3d1,
> +	};
> +	const char *disallowed_paths[] = {
> +		/* dir_s3d2 is a mount point. */
> +		dir_s3d2,
> +		dir_s3d3,
> +	};
> +
> +	/* Test Allowed Access */
> +	const struct rule allowed_rule[] = {
> +		{
> +			.path = allowed_paths[0],
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +	};
> +	int allowed_ruleset_fd = create_ruleset(_metadata, allowed_rule[0].access, allowed_rule);

Just use ruleset_fd.

> +
> +	ASSERT_LE(0, allowed_ruleset_fd);
> +
> +	int ret = io_uring_queue_init(32, &ring, 0);

All variable declarations need to be at the top of the function.

> +
> +	ASSERT_EQ(0, ret);
> +
> +	/* Test each allowed path */

We don't need to test all paths, only one that is allowed and another
that is denied.

> +	for (int i = 0; i < ARRAY_SIZE(allowed_paths); ++i) {
> +		sqe = io_uring_get_sqe(&ring);

Please add a comment explaining that we test IORING_OP_OPENAT.

> +		io_uring_prep_openat(sqe, AT_FDCWD, allowed_paths[i], O_RDONLY,
> +				     allowed_ruleset_fd);

Please explain what is happening here...

> +		/* Verify successful SQE preparation */
> +		ASSERT_EQ(0, ret);
> +
> +		if (ret != 0)
> +			return ret;
> +
> +		ret = io_uring_submit(&ring);
> +		/* Verify 1 submission completed */
> +		ASSERT_EQ(1, ret);
> +	}
> +
> +	/* Test Disallowed Access */
> +	const struct rule disallowed_rule[] = {
> +		{
> +			.path = disallowed_paths[0],
> +			.access = 0,
> +		}
> +
> +	};
> +	int disallowed_ruleset_fd = create_ruleset(_metadata, disallowed_rule[0].access, disallowed_rule);
> +
> +	ASSERT_LE(0, disallowed_ruleset_fd);
> +
> +	/* Test each disallowed path */
> +	for (int i = 0; i < ARRAY_SIZE(disallowed_paths); ++i) {
> +		sqe = io_uring_get_sqe(&ring);
> +		io_uring_prep_openat(sqe, AT_FDCWD, disallowed_paths[i], O_RDONLY, disallowed_ruleset_fd);
> +		/* Verify successful SQE preparation */
> +		ASSERT_EQ(1, ret);
> +
> +		if (ret != 0)
> +			return ret;
> +
> +		ret = io_uring_submit(&ring);
> +		/* Verify 1 submission completed */
> +		ASSERT_EQ(0, ret);
> +	}
> +
> +	/*  Cleanup: close ruleset fds, etc. */
> +	close(allowed_ruleset_fd);
> +	close(disallowed_ruleset_fd);
> +
> +	return 0;
> +}
> +
> +/* clang-format off */

We don't need these clang-format markers here, but you need to format
this patch with clang-format.

> +FIXTURE(openat_test) {
> +	struct __test_metadata *metadata;
> +	const char *allowed_paths[11];
> +	const char *disallowed_paths[2];
> +};
> +
> +/* clang-format on */
> +
> +FIXTURE_SETUP(openat_test)
> +{
> +	/* initialize metadata, allowed_paths, and disallowed_paths */
> +	self->metadata = _metadata;
> +	const char *temp_allowed_paths[] = {
> +		file1_s1d1, file2_s1d1, file1_s1d2, file2_s1d2,
> +		file1_s1d3, file2_s1d3, file1_s2d1, file1_s2d2,
> +		file1_s2d3, file2_s2d3, file1_s3d1};
> +
> +	memcpy(self->allowed_paths, temp_allowed_paths, sizeof(temp_allowed_paths));
> +
> +	const char *temp_disallowed_paths[] = {dir_s3d2, dir_s3d3};
> +
> +	memcpy(self->disallowed_paths, temp_disallowed_paths, sizeof(temp_disallowed_paths));
> +}
> +
> +FIXTURE_TEARDOWN(openat_test)
> +{
> +	/* Clean up test environment */
> +}
> +
> +TEST_F_FORK(openat_test, test_ioring_op_openat_allowed)
> +{
> +	test_ioring_op_openat(self->metadata, LANDLOCK_ACCESS_FS_READ_FILE |
> +			      LANDLOCK_ACCESS_FS_WRITE_FILE, self->allowed_paths,
> +			      ARRAY_SIZE(self->allowed_paths));
> +}
> +
> +TEST_F_FORK(openat_test, test_ioring_op_openat_disallowed)
> +{
> +	test_ioring_op_openat(self->metadata, 0, self->disallowed_paths,
> +			      ARRAY_SIZE(self->disallowed_paths));
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.25.1
> 
> 
