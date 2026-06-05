Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F178F29
	for <linux-security-module@vger.kernel.org>; Fri,  5 Jun 2026 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686248; cv=none; b=uxrz2ccbgRKHiDzHpMyoMvjK9Q9yh3Xx7vVSVLmT952pBV8TI2ddqArl+yZHwOOXmKXL9nbp5dHQky2fdnYngKIQSE2r4MmPXZIZtDOrnc/tot2wGdkDBSK0v7s7XQXxdlKIqNgBk84oAGmYMiyt1IUKAV1JfqUSWyhrn3Q4oTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686248; c=relaxed/simple;
	bh=pG72mN0bnESu8T+L8EvPtFZYKgzDsUFqbde4mlzY2/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuV5VhsE2fokPkzbSZwcToCaoT20bNWk8uwX96kz7fNU4YQAiZOvUP9R8Rc0zmNkBL07C4RMcM96LhwEtlXeYTqobVXLNQ1j0IQzAjO/dgqAKpioV468Z8xvPzsfTZOTWhK30CYrNM7oigknuWqu3aVy9RHGETs2+8hSH7wB2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dy5IcaNO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy5IcaNO"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7e10f91425fso16948177b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jun 2026 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780686245; x=1781291045; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ho3RLxpOov2zgvCax9gqwt+oCZwDolkXxKN3oADpKMI=;
        b=Dy5IcaNOfk9r+rk8n0JL57UqJSl3hp4XtroqzNho+OK8AtICIeE8qVg9tzuJnM+piv
         7YI1m+a4Jjxpe6YZ+kYKK2Bcrv/M9yjK6347jgrdtECUUGRnsqxgNyhiN+TerAYxea38
         UJlVKPFziDLw+/Hdhv5YpMrgYyYfeEDuLusEIuXsEKU7R2Sak/DPeHzCJCBO2PEgb9Fk
         mMF5WxxU3H5ZR0Ghj2arykR4vrVzmdgaDd5QFy3ow79NMaJHPftTnlpH6wOvSKkgf7bp
         oDB2ZNXO8XijxkgoU4RmWdtOWL1oBrejjtZHHtipoZ6axaa+FW6R/F0+AND4+I7cGv0m
         +RNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686245; x=1781291045;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ho3RLxpOov2zgvCax9gqwt+oCZwDolkXxKN3oADpKMI=;
        b=ohT6jTuWLIggL/ktXgX+AqbKgbp2xIruBe1gdQ2XwGb9u4F2r2Lcb42kHbUsluZWGD
         HsZ18WPuGEvVchrp2GOXc5W1D9GD2l9Gt7NPMbFxMBOBIgG49i7u18/uINLKcVUQFKA7
         3Ra7KEYrVuxQ/Q1/GJeOC4u9gJRutJVbAjlqd29D5FnND1rXuoSOraxPy2SkSIzOxK+B
         x/6tLJ80iIy/QsZ9DVa+8rznAgpzgqTM6U2l3fg8iJSBLKMQjh/JdM+Q85d7v6x/ru40
         N6fA15JAYZW/U4JnnPShdMvK9phwa3VJoBzr1Z1zkM7F1cXPucd/bdxQ5xCXGN96/h9K
         QKUA==
X-Forwarded-Encrypted: i=1; AFNElJ/mgJaULdepQ+u93tfFGNXapuMlNXhMY261ItxLJ8JUyq675EmJb6rHVaa+z7Ik4oM0Yd/IAgVc6LWVhdEU410Ml0q5LP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8nxJjypphYjoZ7dv4NKch5njX/uA7+hnMM6ZT4StMHuIyiPtw
	0o+QJiIdr6fjNfiJVPV7HZAllv/hxDw9YZLkFDBqmjjqqpjYp5JEPAdB
X-Gm-Gg: Acq92OHMVwMU333hLPhSIiajMXD63lj7aVZkKWeO2h/dXTexYPM2+pv4JWvznoqfyXt
	HchcJxgxM8pQ7e8SurTHKRafFd41OZOQy0hW9nKfviWkX776M7FPEU9KPkUoyz611yiC0NBpcC+
	4JDOYF49n0P/4zIbZocfCW1uirIF332RucHuUtQZ5twDhVoZyo0h9mU6alLySo4ke3uFTiQWga+
	585z/FHK8LJYi33hijuNVtBNCqrJi7GOS7KyAscL++iTt/9/t7vabkRHb4I+e0ONjbDcMeNmfqy
	epIJi74Bqz0ZP9vz1IwAMMnUAonx8jdgXdrbWEaOuzNsrA9RIFiTfz3xxg81cqMsIvAeJREOZNy
	lqN4YMQR3TlJYJSAc0h89zVZyZNhCZQk12yvY5CncUTG22ZyjbIAUB7WAo83IpQ3qFJVM+rdDiV
	cpuuBGTOaFy3nAfaoVUn4iw1ozfSyTxtY4v5QDwyOEr56cshIuzsJZGRSADLWhgOOBEpP3
X-Received: by 2002:a05:690c:d83:b0:7ba:f3a2:552e with SMTP id 00721157ae682-7ed50d632a2mr31034117b3.10.1780686245186;
        Fri, 05 Jun 2026 12:04:05 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:c0d0:c20d:131c:8e23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23592beasm55359377b3.32.2026.06.05.12.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 12:04:04 -0700 (PDT)
Date: Fri, 5 Jun 2026 15:04:04 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 6/9] selftests/landlock: add tests for quiet flag
 with fs rules
Message-ID: <aiMciEe6zVnisbQJ@zenbox>
References: <cover.1780272022.git.m@maowtm.org>
 <9208d19c3aeba778f317defcfee9c62c44600e3b.1780272022.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9208d19c3aeba778f317defcfee9c62c44600e3b.1780272022.git.m@maowtm.org>

On Mon, Jun 01, 2026 at 01:00:40AM +0100, Tingmao Wang wrote:
> Test various interactions of the quiet flag with filesystem rules:
> - Non-optional access (tested with open and rename).
> - Optional access (tested with truncate and ioctl).
> - Behaviour around mounts matches with normal Landlock rules.
> - Behaviour around disconnected directories matches with normal Landlock
>   rules (test expected behaviour of 9a868cdbe66a ("landlock: Fix handling of
>   disconnected directories") applied to the collected quiet flag).
> - Multiple layers works as expected.
> 
> Assisted-by: GitHub Copilot:claude-opus-4.6 copilot-review
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> Changes in v10:
> - Fix grammar in some comments
> - if brackets
> 
> Changes in v8:
> - Rebase, resolve conflict, then clang-format
> - Remove previously added comment about domain allocation record leakage -
>   this is now documented properly by 239fd9a6f948 ("selftests/landlock:
>   Drain stale audit records on init")
> - Fix missing EXPECT_EQ on audit_count_records() return value
> 
> Changes in v6:
> - Change quiet bool argument of add_path_beneath into a __u32 flags
>   (suggested by Justin Suess)
> - Rename quiet_behind_mountpoint_ignored_disconnected to
>   quiet_behind_mountpoint_disconnected and fix test due to disconnected
>   directory handling changes
> 
> Changes in v5:
> - Add quiet_two_layers_different_handled_{1,2,3} variants.
> 
> Changes in v3:
> - New patch
> 
>  tools/testing/selftests/landlock/fs_test.c | 2447 +++++++++++++++++++-
>  1 file changed, 2438 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 10d9355ade5f..5f5d75fabe07 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -720,7 +720,7 @@ TEST_F_FORK(layout1, rule_with_unhandled_access)
>  
>  static void add_path_beneath(struct __test_metadata *const _metadata,
>  			     const int ruleset_fd, const __u64 allowed_access,
> -			     const char *const path)
> +			     const char *const path, __u32 flags)
>  {
>  	struct landlock_path_beneath_attr path_beneath = {
>  		.allowed_access = allowed_access,
> @@ -733,7 +733,7 @@ static void add_path_beneath(struct __test_metadata *const _metadata,
>  		       strerror(errno));
>  	}
>  	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> -				       &path_beneath, 0))
> +				       &path_beneath, flags))
>  	{
>  		TH_LOG("Failed to update the ruleset with \"%s\": %s", path,
>  		       strerror(errno));
> @@ -780,7 +780,7 @@ static int create_ruleset(struct __test_metadata *const _metadata,
>  				continue;
>  
>  			add_path_beneath(_metadata, ruleset_fd, rules[i].access,
> -					 rules[i].path);
> +					 rules[i].path, 0);
>  		}
>  	return ruleset_fd;
>  }
> @@ -1310,7 +1310,7 @@ TEST_F_FORK(layout1, inherit_subset)
>  	 * ANDed with the previous ones.
>  	 */
>  	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
> -			 dir_s1d2);
> +			 dir_s1d2, 0);
>  	/*
>  	 * According to ruleset_fd, dir_s1d2 should now have the
>  	 * LANDLOCK_ACCESS_FS_READ_FILE and LANDLOCK_ACCESS_FS_WRITE_FILE
> @@ -1342,7 +1342,7 @@ TEST_F_FORK(layout1, inherit_subset)
>  	 * Try to get more privileges by adding new access rights to the parent
>  	 * directory: dir_s1d1.
>  	 */
> -	add_path_beneath(_metadata, ruleset_fd, ACCESS_RW, dir_s1d1);
> +	add_path_beneath(_metadata, ruleset_fd, ACCESS_RW, dir_s1d1, 0);
>  	enforce_ruleset(_metadata, ruleset_fd);
>  
>  	/* Same tests and results as above. */
> @@ -1365,7 +1365,7 @@ TEST_F_FORK(layout1, inherit_subset)
>  	 * that there was no rule tied to it before.
>  	 */
>  	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
> -			 dir_s1d3);
> +			 dir_s1d3, 0);
>  	enforce_ruleset(_metadata, ruleset_fd);
>  	ASSERT_EQ(0, close(ruleset_fd));
>  
> @@ -1417,7 +1417,7 @@ TEST_F_FORK(layout1, inherit_superset)
>  	add_path_beneath(_metadata, ruleset_fd,
>  			 LANDLOCK_ACCESS_FS_READ_FILE |
>  				 LANDLOCK_ACCESS_FS_READ_DIR,
> -			 dir_s1d2);
> +			 dir_s1d2, 0);
>  	enforce_ruleset(_metadata, ruleset_fd);
>  	EXPECT_EQ(0, close(ruleset_fd));
>  
> @@ -3970,7 +3970,7 @@ static int ioctl_error(struct __test_metadata *const _metadata, int fd,
>  		       unsigned int cmd)
>  {
>  	char buf[128]; /* sufficiently large */
> -	int res, stdinbak_fd;
> +	int res, stdinbak_fd, err;
>  
>  	/*
>  	 * Depending on the IOCTL command, parts of the zeroed-out buffer might
> @@ -3985,13 +3985,14 @@ static int ioctl_error(struct __test_metadata *const _metadata, int fd,
>  	/* Invokes the IOCTL with a zeroed-out buffer. */
>  	bzero(&buf, sizeof(buf));
>  	res = ioctl(fd, cmd, &buf);
> +	err = errno;
>  
>  	/* Restores the old FD 0 and closes the backup FD. */
>  	ASSERT_EQ(0, dup2(stdinbak_fd, 0));
>  	ASSERT_EQ(0, close(stdinbak_fd));
>  
>  	if (res < 0)
> -		return errno;
> +		return err;
>  
>  	return 0;
>  }
> @@ -4789,6 +4790,7 @@ FIXTURE(layout1_bind) {};
>  
>  static const char bind_dir_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3";
>  static const char bind_file1_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3/f1";
> +static const char bind_file2_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3/f2";
>  
>  /* Move targets for disconnected path tests. */
>  static const char dir_s4d1[] = TMP_DIR "/s4d1";
> @@ -7764,4 +7766,2431 @@ TEST_F(audit_layout1, mount)
>  	EXPECT_EQ(1, records.domain);
>  }
>  
> +static bool debug_quiet_tests;
> +
> +FIXTURE(audit_quiet_layout1)
> +{
> +	struct audit_filter audit_filter;
> +	int audit_fd;
> +};
> +
> +FIXTURE_SETUP(audit_quiet_layout1)
> +{
> +	prepare_layout(_metadata);
> +	create_layout1(_metadata);
> +
> +	set_cap(_metadata, CAP_AUDIT_CONTROL);
> +	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
> +	EXPECT_LE(0, self->audit_fd);
> +	clear_cap(_metadata, CAP_AUDIT_CONTROL);
> +
> +	if (getenv("DEBUG_QUIET_TESTS"))
> +		debug_quiet_tests = true;
> +}
> +
> +FIXTURE_TEARDOWN_PARENT(audit_quiet_layout1)
> +{
> +	remove_layout1(_metadata);
> +	cleanup_layout(_metadata);
> +
> +	set_cap(_metadata, CAP_AUDIT_CONTROL);
> +	EXPECT_EQ(0, audit_cleanup(-1, NULL));
> +	clear_cap(_metadata, CAP_AUDIT_CONTROL);
> +}
> +
> +struct a_rule {
> +	const char *path;
> +	__u64 access;
> +	bool quiet;
> +};
> +
> +struct a_layer {
> +	__u64 handled_access_fs;
> +	__u64 quiet_access_fs;
> +	struct a_rule rules[6];
> +	__u64 restrict_flags;
> +};
> +
> +struct a_target {
> +	/* File/dir to try open. */
> +	const char *target;
> +	/* Open mode (one of O_RDONLY, O_WRONLY, or O_RDWR). */
> +	int open_mode;
> +	/* Should open succeed? */
> +	bool expect_open_success;
> +	/* If open fails, whether to expect an audit log for read. */
> +	bool audit_read_blocked;
> +	/* If open fails, whether to expect an audit log for write. */
> +	bool audit_write_blocked;
> +	/* If ftruncate() is expected to be allowed. */
> +	bool expect_truncate_success;
> +	/* If ftruncate fails, whether to expect an audit log. */
> +	bool audit_truncate;
> +	/*
> +	 * If ioctl() is expected to be allowed (ioctl not attempted if
> +	 * neither this nor expect_ioctl_denied is set).
> +	 */
> +	bool expect_ioctl_allowed;
> +	/* If ioctl() is expected to be denied. */
> +	bool expect_ioctl_denied;
> +	/* If ioctl fails, whether to expect an audit log. */
> +	bool audit_ioctl;
> +};
> +
> +#define AUDIT_QUIET_MAX_TARGETS 10
> +
> +FIXTURE_VARIANT(audit_quiet_layout1)
> +{
> +	struct a_layer layers[3];
> +	struct a_target targets[AUDIT_QUIET_MAX_TARGETS];
> +};
> +
> +#define FS_R LANDLOCK_ACCESS_FS_READ_FILE
> +#define FS_W LANDLOCK_ACCESS_FS_WRITE_FILE
> +#define FS_TRUNC LANDLOCK_ACCESS_FS_TRUNCATE
> +#define FS_IOCTL LANDLOCK_ACCESS_FS_IOCTL_DEV
> +
> +static int sprint_access_bits(char *buf, size_t buflen, __u64 access)
> +{
> +	size_t offset = 0;
> +
> +	if (buflen < strlen("rwti make_reg remove_file refer") + 1)
> +		abort();
> +
> +	buf[0] = '\0';
> +	if (access & FS_R)
> +		offset += snprintf(buf + offset, buflen - offset, "r");
> +	if (access & FS_W)
> +		offset += snprintf(buf + offset, buflen - offset, "w");
> +	if (access & FS_TRUNC)
> +		offset += snprintf(buf + offset, buflen - offset, "t");
> +	if (access & FS_IOCTL)
> +		offset += snprintf(buf + offset, buflen - offset, "i");
> +	if (access & LANDLOCK_ACCESS_FS_MAKE_REG)
> +		offset += snprintf(buf + offset, buflen - offset, ",make_reg");
> +	if (access & LANDLOCK_ACCESS_FS_REMOVE_FILE)
> +		offset +=
> +			snprintf(buf + offset, buflen - offset, ",remove_file");
> +	if (access & LANDLOCK_ACCESS_FS_REFER)
> +		offset += snprintf(buf + offset, buflen - offset, ",refer");
> +
> +	if (buf[0] == ',') {
> +		offset--;
> +		memmove(buf, buf + 1, offset);
> +		buf[offset] = '\0';
> +	}
> +
> +	return offset;
> +}
> +
> +static int apply_a_layer(struct __test_metadata *const _metadata,
> +			 const struct a_layer *l)
> +{
> +	struct landlock_ruleset_attr rs_attr = {
> +		.handled_access_fs = l->handled_access_fs,
> +		.quiet_access_fs = l->quiet_access_fs,
> +	};
> +	int rs_fd;
> +	int i;
> +	const struct a_rule *r;
> +	char handled_access_s[33], quiet_access_s[33], rule_access_s[33];
> +
> +	if (!l->handled_access_fs)
> +		return 0;
> +
> +	rs_fd = landlock_create_ruleset(&rs_attr, sizeof(rs_attr), 0);
> +	ASSERT_LE(0, rs_fd);
> +
> +	for (i = 0; i < ARRAY_SIZE(l->rules); i++) {
> +		r = &l->rules[i];
> +		if (!r->path)
> +			continue;
> +
> +		add_path_beneath(_metadata, rs_fd, r->access, r->path,
> +				 r->quiet ? LANDLOCK_ADD_RULE_QUIET : 0);
> +	}
> +
> +	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +	ASSERT_EQ(0, landlock_restrict_self(rs_fd, l->restrict_flags))
> +	{
> +		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
> +	}
> +	ASSERT_EQ(0, close(rs_fd));
> +
> +	if (debug_quiet_tests) {
> +		sprint_access_bits(handled_access_s, sizeof(handled_access_s),
> +				   l->handled_access_fs);
> +		sprint_access_bits(quiet_access_s, sizeof(quiet_access_s),
> +				   l->quiet_access_fs);
> +		TH_LOG("applied layer: handled=%s quiet=%s restrict_flags=0x%llx",
> +		       handled_access_s, quiet_access_s,
> +		       (unsigned long long)l->restrict_flags);
> +		for (i = 0; i < ARRAY_SIZE(l->rules); i++) {
> +			r = &l->rules[i];
> +			if (!r->path)
> +				continue;
> +
> +			sprint_access_bits(rule_access_s, sizeof(rule_access_s),
> +					   r->access);
> +			TH_LOG("  rule[%d]: path=%s access=%s quiet=%d", i,
> +			       r->path, rule_access_s, r->quiet);
> +		}
> +	}
> +	return 0;
> +}
> +
> +void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
> +				   FIXTURE_DATA(audit_quiet_layout1) * self,
> +				   const struct a_target *targets)
> +{
> +	struct audit_records records = {};
> +	int i;
> +	const struct a_target *target;
> +	int fd = -1;
> +	int open_mode;
> +	int ret;
> +	bool expect_audit;
> +	const char *blocker;
> +
> +	for (i = 0; i < AUDIT_QUIET_MAX_TARGETS; i++) {
> +		target = &targets[i];
> +		if (!target->target)
> +			continue;
> +
> +		open_mode = target->open_mode & (O_RDONLY | O_WRONLY | O_RDWR);
> +
> +		EXPECT_TRUE(open_mode == O_RDONLY || open_mode == O_WRONLY ||
> +			    open_mode == O_RDWR);
> +
> +		if (target->expect_open_success) {
> +			EXPECT_FALSE(target->audit_read_blocked);
> +			EXPECT_FALSE(target->audit_write_blocked);
> +		}
> +		if (target->expect_truncate_success)
> +			EXPECT_TRUE(target->expect_open_success &&
> +				    !target->audit_truncate);
> +
> +		if (debug_quiet_tests)
> +			TH_LOG("Try open \"%s\" with %s%s", target->target,
> +			       open_mode != O_WRONLY ? "r" : "",
> +			       open_mode != O_RDONLY ? "w" : "");
> +
> +		fd = openat(AT_FDCWD, target->target, open_mode | O_CLOEXEC);
> +		if (target->expect_open_success) {
> +			ASSERT_LE(0, fd)
> +			{
> +				TH_LOG("Failed to open \"%s\": %s",
> +				       target->target, strerror(errno));
> +			};
> +		} else {
> +			ASSERT_EQ(-1, fd);
> +			ASSERT_EQ(EACCES, errno);
> +		}
> +
> +		expect_audit = true;
> +
> +		if (target->audit_read_blocked && target->audit_write_blocked)
> +			blocker = "fs\\.write_file,fs\\.read_file";
> +		else if (target->audit_read_blocked)
> +			blocker = "fs\\.read_file";
> +		else if (target->audit_write_blocked)
> +			blocker = "fs\\.write_file";
> +		else
> +			expect_audit = false;
> +
> +		if (expect_audit)
> +			ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
> +						    blocker, target->target));
> +
> +		/* Check that we see no (other) logs. */
> +		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +		ASSERT_EQ(0, records.access);
> +
> +		if (target->expect_open_success && fd >= 0) {
> +			if (debug_quiet_tests)
> +				TH_LOG("Try ftruncate \"%s\"", target->target);
> +
> +			ret = ftruncate(fd, 0);
> +			if (target->expect_truncate_success) {
> +				ASSERT_EQ(0, ret);
> +			} else {
> +				ASSERT_EQ(-1, ret);
> +				if (open_mode != O_RDONLY)
> +					ASSERT_EQ(EACCES, errno);
> +			}
> +
> +			if (target->audit_truncate)
> +				ASSERT_EQ(0, matches_log_fs(_metadata,
> +							    self->audit_fd,
> +							    "fs\\.truncate",
> +							    target->target));
> +
> +			if (target->expect_ioctl_allowed ||
> +			    target->expect_ioctl_denied) {
> +				if (debug_quiet_tests)
> +					TH_LOG("Try ioctl FIONREAD on \"%s\"",
> +					       target->target);
> +
> +				ret = ioctl_error(_metadata, fd, FIONREAD);
> +				if (target->expect_ioctl_allowed)
> +					ASSERT_NE(EACCES, ret);
> +				else
> +					ASSERT_EQ(EACCES, ret);
This doesn't compile.

  make: Entering directory '/home/justin/Code/linux-next/tools/testing/selftests'
    CC       fs_test
  fs_test.c: In function ‘audit_quiet_layout1_test_body’:
  fs_test.c:8456:33: error: expected ‘}’ before ‘else’
   8456 |                                 else
        |                                 ^~~~
  fs_test.c: At top level:
  fs_test.c:8474:1: error: expected identifier or ‘(’ before ‘}’ token
   8474 | }
        | ^
  make[1]: *** [../lib.mk:225: /home/justin/Code/linux-next/.out-landlock_archlinux-base-devel/kselftest/landlock/fs_test] Error 1
  
The ASSERT_* macros doen't properly handle braceless if statements...

(easy to miss if you forget to recompile after clang format and/or
checkpatch --fix...)

Adding braces to this as with previous versions of this series should
fix it.

Justin
