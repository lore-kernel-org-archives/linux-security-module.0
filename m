Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3771353E4
	for <linux-security-module@vger.kernel.org>; Tue,  2 Apr 2024 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069260; cv=none; b=ZJAhBk9txfLuwJU+FZrmQxz6iA35rVGS833zZsIDYEUuQa4bNfQgf5fTQSesikVlBZHQ0dz57PgfJWtFO3LT2DDhFo9egVh9Veap0i/oyFgEoCp1QGPUrbQO1od29RrxGtTcnCv/N2LJlGob+FqQXfTwYYFsWwdnfmZqqY9KU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069260; c=relaxed/simple;
	bh=MK6T30+Wo49ys6KJbgTIIvM1jdCkjz/jw84lOhXfxfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDvPz3TT4vVj3DNrD1ho0xFfP4kPpU9qYYDCID6T41V+4aztCXaCiIXMIGG2duB2EQYSy+bFeYUjHAXoXkWli2f/1Oaydfo1fEAJpTNbeZE2zQ3Lf86VSfKd2U1emoUmEzxcHXU7NIY2ZEkWpTrN7s5yUC2oFcGP4dmk2Y2wpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=eZVLpNRe; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="eZVLpNRe"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V89hg4PLczJsc;
	Tue,  2 Apr 2024 16:47:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712069251;
	bh=MK6T30+Wo49ys6KJbgTIIvM1jdCkjz/jw84lOhXfxfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZVLpNRedGX1fsnBtd8O4iL3hg2jMgMkmVvwcK1prvfAkNZ2vOlmwe0IvuMzjBJaV
	 SC376maWx78ZDcT2Qv3iBGbbIE5hZGVP/upjcHjetdbSD3V2v/NG9gLXveJsbhZds5
	 G25+DVjyigtsy7P22cihf4lvcSIf3kcwLvL6ZBNw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V89hf5TcYz1b2;
	Tue,  2 Apr 2024 16:47:30 +0200 (CEST)
Date: Tue, 2 Apr 2024 16:47:30 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Dorine Tipo <dorine.a.tipo@gmail.com>
Cc: skhan@linuxfoundation.org, outreachy@lists.linux.dev, 
	Linux-kernel-mentees-request@lists.linuxfoundation.org, fabio.maria.de.francesco@linux.intel.com, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v3] selftests/landlock: Add tests for io_uring openat
 access control with Landlock rules
Message-ID: <20240402.MooNaiJoo2cu@digikod.net>
References: <20240330124817.42591-1-dorine.a.tipo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240330124817.42591-1-dorine.a.tipo@gmail.com>
X-Infomaniak-Routing: alpha

On Sat, Mar 30, 2024 at 12:48:17PM +0000, Dorine Tipo wrote:
> This v3 patch expands Landlock test coverage to include io_uring
> operations. It also introduces a test for IORING_OP_OPENAT with Landlock
> rules, verifying allowed and disallowed access. This makes sure that
> IORING_OP_OPENAT is well covered from security vulnerabilities by
> ensuring Landlock controls access through io_uring.
> 
> It also updates Makefile to include -luring in the LDLIBS variable.
> This ensures the test code has access to the necessary library for
> io_uring operations.
> 
> The patch includes several improvements to the test_ioring_openat(),
> FIXTURE_SETUP() and FIXTURE_TEARDOWN() addressing feedback received on
> the initial version.
> 
> Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
> ---
> Changes since V1:
> V2: - Consolidated two dependent patches in the V1 series into one patch
>       as suggested by Fabio.
>     - Updated The subject line to be more descriptive.
> 
> V3: - Added "selftests/landlock" subject prefix
>     - Revised wording in the commit message to accurately reflect the
>       test functionality as suggested by Mickaël.
>     - Updated the Fixture set_up and tear_down to create and remove the
>       necesssary files and folders for testing access.
>     - renamed allowed_ruleset_fd and disallowed_ruleset_fd to ruleset_fd
>       as suggest by Mickaël.
>     - Moved all variable declarations to the top of the function.
>     - Refactored the code to test only one allowed and one restricted
>       path instead of iterating through all the paths.
>     - Added comments to explain what is happening in different blocks
>       of code
>     - Removed the clang-format markers.
>     - Removed unused arguments in the function definition.
>     - Added a final rule struct with a null path to the allowed_rule
>       and disallowed_rule arrays as suggested by Fabio.
>     - CC'd the missing mailing lists as suggested by Shuah.
>     - All executables have been included in the .gitignore so no updates
>       are necessary.
> 
>  tools/testing/selftests/landlock/Makefile  |   4 +-
>  tools/testing/selftests/landlock/fs_test.c | 140 +++++++++++++++++++++
>  2 files changed, 142 insertions(+), 2 deletions(-)
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
> index 9a6036fbf289..7147c75b6f79 100644
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
> 
>  #include "common.h"
> 
> @@ -4874,4 +4877,141 @@ TEST_F_FORK(layout3_fs, release_inodes)
>  	ASSERT_EQ(EACCES, test_open(TMP_DIR, O_RDONLY));
>  }
> 
> +/* Test io_uring's IORING_OP_OPENAT access control with landlock rules */

What is tested exactly?

> +static int test_ioring_op_openat(struct __test_metadata *const _metadata, const __u64 access, const char **paths)
> +{
> +	int ruleset_fd;
> +	int ret;
> +	struct io_uring ring;
> +	struct io_uring_sqe *sqe;
> +
> +	/* Test Allowed Access */
> +	const struct rule allowed_rule[] = {
> +		{
> +			.path = paths[0],
> +			.access = access,
> +		},
> +		{
> +			.path = NULL,
> +		},
> +	};
> +
> +	ruleset_fd = create_ruleset(_metadata, allowed_rule[0].access, allowed_rule);
> +
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	ret = io_uring_queue_init(32, &ring, 0);
> +
> +	ASSERT_EQ(0, ret);
> +
> +	/* Test allowed path */
> +	sqe = io_uring_get_sqe(&ring);
> +
> +	/* Prepare SQE  for the openat operation */
> +	io_uring_prep_openat(sqe, AT_FDCWD, paths[0], O_RDONLY, ruleset_fd);

Can you please explain what this call to io_uring_prep_openat() do?

> +
> +	/* Verify successful SQE preparation */
> +	ASSERT_EQ(0, ret);
> +
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = io_uring_submit(&ring);
> +
> +	/* Verify 1 submission completed */
> +	ASSERT_EQ(1, ret);
> +
> +	/* Test Disallowed Access */
> +	const struct rule disallowed_rule[] = {
> +		{
> +			.path = paths[0],
> +			.access = 0,
> +		},
> +		{
> +			.path = NULL,
> +		},
> +	};
> +
> +	ruleset_fd = create_ruleset(_metadata, disallowed_rule[0].access, disallowed_rule);
> +
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	/* Test disallowed path */
> +	sqe = io_uring_get_sqe(&ring);
> +
> +	/* Prepare SQE  for the openat operation */
> +	io_uring_prep_openat(sqe, AT_FDCWD, paths[0], O_RDONLY, ruleset_fd);
> +
> +	/* Verify successful SQE preparation */
> +	ASSERT_EQ(0, ret);
> +
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = io_uring_submit(&ring);
> +	/* Verify 1 submission completed */
> +	ASSERT_EQ(0, ret);
> +
> +	/*  Cleanup: close ruleset fds, etc. */
> +	close(ruleset_fd);
> +
> +	return 0;
> +}
> +
> +FIXTURE(openat_test) {
> +	struct __test_metadata *metadata;
> +	const char *allowed_paths[11];
> +	const char *disallowed_paths[2];
> +};
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
> +
> +	/* Create necessary directories and files */
> +	for (int i = 0; i < sizeof(self->allowed_paths) / sizeof(char *); i++) {
> +		create_file(self->metadata, self->allowed_paths[i]);
> +	}
> +
> +	/* Create directories for disallowed paths */
> +	for (int i = 0; i < sizeof(self->disallowed_paths) / sizeof(char *); i++) {
> +		create_directory(self->metadata, self->disallowed_paths[i]);
> +	}
> +}
> +
> +FIXTURE_TEARDOWN(openat_test)
> +{
> +	/* Clean up test environment */
> +	for (int i = 0; i < sizeof(self->allowed_paths) / sizeof(char *); i++) {
> +		remove_path(self->allowed_paths[i]);
> +	}
> +
> +	for (int i = 0; i < sizeof(self->disallowed_paths) / sizeof(char *); i++) {
> +		remove_path(self->disallowed_paths[i]);
> +	}
> +}
> +
> +/* Test IORING_OP_OPENAT. */
> +TEST_F_FORK(openat_test, test_ioring_op_openat_allowed)
> +{
> +	test_ioring_op_openat(self->metadata, LANDLOCK_ACCESS_FS_READ_FILE |
> +			      LANDLOCK_ACCESS_FS_WRITE_FILE, self->allowed_paths);
> +}
> +
> +TEST_F_FORK(openat_test, test_ioring_op_openat_disallowed)
> +{
> +	test_ioring_op_openat(self->metadata, 0, self->disallowed_paths);
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.25.1
> 
> 
