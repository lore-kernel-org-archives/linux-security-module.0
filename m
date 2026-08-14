Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F88443E43
	for <linux-security-module@vger.kernel.org>; Fri, 14 Aug 2026 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704477; cv=none; b=JOBEQmrVDICZQtOuCxUEBzh0fsi9Zm+g9z3xB9KV0h+oj/6lTPC+fkASjwVEiribZerCfc14yLlAfePnbflsY0H4gJSErJw1VYPZ1B/EsyAugMGOgm7mmBpx5usiex26SJS781HofIGX69kSCd9n+kSGszNRi3VkAc0PdFYue50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704477; c=relaxed/simple;
	bh=BnT3JOnRl4/9w1Li2v+5EAmD+eRDI7vkc6DpLLC1HPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcqEEN4nPm/lS2VOm0NKA2PXjnDZG1jUtGzbz6J145ON3J0iqrdFiV3K5I1RWxd7+1WHBaQhikyGnFXcjLiqCmqTGi60oTN6qrrk6B/FnIGyIy9JdxFZxPxLQDS5q/qaEQ6YytEcbLkSyrh0iRKhT30qf5gpEJ+dYhKbA4NuJE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kiVKSiSK; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kiVKSiSK"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hLzT63psSzVrn;
	Fri, 14 Aug 2026 12:47:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786704458;
	bh=mKij9DAkXC021w1tN6phvLYkC6K4CwSAIKtQeHldtL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kiVKSiSK3FO8kof4oTk+TY6xbkkyi0+zBKxVFrNsdbppBGA2F5RqlQBTh6so69NC8
	 O+pKMB4Khf+LdlNTg/s7+UJy1GHJBnibxLCAUjdPZQha2gywmjm+J68/fmyfmdDCn9
	 IGMHzLdsXWSs0Ol33KEFKiUiepRMXyJqnrgzLgbs=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hLzT50qLzzf10;
	Fri, 14 Aug 2026 12:47:37 +0200 (CEST)
Date: Fri, 14 Aug 2026 12:47:36 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Serge Hallyn <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v6 0/6] landlock: Restrict whiteout object creation
Message-ID: <20260814.Zae0Queisee5@digikod.net>
References: <20260813093157.1436894-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813093157.1436894-1-gnoack@google.com>
X-Infomaniak-Routing: alpha

Thanks!  It's merged (with some extra explanation in commit message).

On Thu, Aug 13, 2026 at 11:31:51AM +0200, Günther Noack wrote:
> Hello!
> 
> As discussed in [1], the renameat2() syscall's RENAME_WHITEOUT flag allows
> the creation of chardev directory entries with major=minor=0 as "whiteout
> objects" in the location of the rename source file [2].
> 
> This functionality is available even without having any OverlayFS mounted
> and can be invoked with the regular renameat2(2) syscall [3].
> 
> In V1 [5], it was discussed that whiteout objects are not the same as character
> devices, and should therefore be treated differently.  After considering a new
> access right in V2 and V3, we eventually settled on guarding it with the
> existing LANDLOCK_ACCESS_FS_MAKE_REG access right and introducing a new erratum
> [6].
> 
> V6 addresses the remaining review feedback: the V4 feedback on the selftests
> in patches 3/5 and 4/5, and the V5 remarks on the get_dentry_access() helper.
> 
> Motivation
> ==========
> 
> The RENAME_WHITEOUT flag side-steps all of the existing Landlock access
> rights, which are designed to restrict the creation of directory entries.
> It is desirable to restrict that.
> 
> This patch set fixes that by adding a check in Landlock's path_rename and
> path_mknod hooks.  Where we previously treated whiteout creation like the
> creation of a character device, we now guard it with
> LANDLOCK_ACCESS_FS_MAKE_REG and add an erratum to probe for that.
> 
> 
> [1] https://lore.kernel.org/all/adUBCQXrt7kmgqJT@google.com/
> [2] https://docs.kernel.org/filesystems/overlayfs.html#whiteouts-and-opaque-directories
> [3] https://man7.org/linux/man-pages/man2/renameat2.2.html#DESCRIPTION
> [4] https://codesearch.debian.net/search?q=rename.*RENAME_WHITEOUT&literal=0
> [5] https://lore.kernel.org/all/20260411090944.3131168-2-gnoack@google.com/
> [6] https://lore.kernel.org/all/20260720.chow9ohYie5b@digikod.net/
> 
> Changelog
> =========
> 
> v6:
>  - Smaller code changes:
>    - get_dentry_access(): Drop the incorrect __attribute_const__ and use a
>      local inode variable
>  - Fix a LANDLOCK_ACCESS_FS_MAKE_REG typo in the commit message of patch 2/5
>  - Tests, addressing the remaining v4 feedback on patch 3/5:
>    - Add rename_whiteout_allowed: RENAME_WHITEOUT works when MAKE_REG is
>      granted, and the whiteout object shows up in the source location
>    - Add rename_whiteout_reparenting: the MAKE_REG right for the created
>      whiteout object is required in the source directory of the rename
>    - Add rename_whiteout_exchange: RENAME_EXCHANGE of an existing whiteout
>      object requires MAKE_REG in the directory which the whiteout moves into
>    - Add audit test make_whiteout: denied whiteout creation is logged with
>      blockers=fs.make_reg instead of fs.make_char
>  - Tests, addressing the v4 feedback on patch 4/5:
>    - Rework the OverlayFS rename test to rename a FIFO which originates
>      from the lower layer, instead of preparing it in the upper layer with
>      unlink() and mknod().  The unlink() had already created the whiteout
>      in the upper layer before Landlock was enforced
>    - Check that the whiteout object in the upper layer did not exist before
>      the rename
>  - Verified that the new tests fail on a kernel which lacks the fix from
>    patch 2/5
> 
> v5:
>  - Erratum: Clarify that this is about mknod(2) only
>  - Add Cc stable@vger.kernel.org and Depends-on lines
>  - Smaller code changes
>    - Use dev_t where appropriate
>    - Introduce get_dentry_access() helper
>    - Use get_mode_access(S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV)
>      to calculate the required access right for the created whiteout object
>  - Tests:
>    - rename_whiteout_denied: move a FIFO
>      - otherwise, the test succeeded without the change
>    - make_whiteout: drop set_cap(CAP_MKNOD) (not needed)
>  - This is an intermediary state: It incorporates feedback to 2/5 and some 3/5
>    feedback from v4, but not the 4/5 feedback yet.
>  - https://lore.kernel.org/all/20260731154353.1790268-1-gnoack@google.com/
> 
> v4:
>  - Guard it with LANDLOCK_ACCESS_FS_MAKE_REG as discussed.
>  - Selftests and documentation.
>  - https://lore.kernel.org/all/20260724161004.2360749-1-gnoack@google.com/
> 
> v3:
>  - Do LANDLOCK_ACCESS_FS_MAKE_WHITEOUT check as part of
>    current_check_refer_path().
>  - https://lore.kernel.org/all/20260610092318.3868884-1-gnoack@google.com/
> 
> v2:
>  - Introduce LANDLOCK_ACCESS_FS_MAKE_WHITEOUT access right
>    and guard it with that.
>  - Bump ABI version
>  - https://lore.kernel.org/all/20260513160552.4022649-1-gnoack@google.com/
> 
> v1:
>  - initial version
>    https://lore.kernel.org/all/20260411090944.3131168-2-gnoack@google.com/
> 
> 
> Günther Noack (6):
>   selftests/landlock: Use an actual chardev for MAKE_CHAR audit test
>   landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creation
>   selftests/landlock: Add tests for whiteout object creation
>   selftests/landlock: Add audit test for whiteout object creation
>   selftests/landlock: Test whiteout object behaviour in OverlayFS
>     renames
>   landlock: Link the erratum documentation for whiteout objects
> 
>  Documentation/userspace-api/landlock.rst   |   3 +
>  include/uapi/linux/landlock.h              |   1 +
>  security/landlock/errata/abi-1.h           |  23 ++
>  security/landlock/fs.c                     |  41 +++-
>  tools/testing/selftests/landlock/fs_test.c | 253 ++++++++++++++++++++-
>  5 files changed, 309 insertions(+), 12 deletions(-)
> 
> Range-diff against v5:

No need for such range-diff.

> 1:  d1a8a84d92e0 = 1:  49a6fa0831e8 selftests/landlock: Use an actual chardev for MAKE_CHAR audit test
> 2:  9fe2edf17413 ! 2:  a29c7919a412 landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creation
>     @@ Commit message
>          For the mknod(2) case, introduce a Landlock erratum.  The creation of
>          whiteout objects through mknod(2) was previously guarded using
>          LANDLOCK_ACCESS_FS_MAKE_CHAR, and it is now guarded using
>     -    LANDLOCK_ACCESS_MAKE_REG.
>     +    LANDLOCK_ACCESS_FS_MAKE_REG.
>      
>          For the renameat2(2) case, fix a bug: Before this commit, renameat2(2)
>          with RENAME_WHITEOUT would create a directory entry even when all
>     @@ security/landlock/fs.c: static __attribute_const__ access_mask_t get_mode_access
>       	}
>       }
>       
>     -+static __attribute_const__ access_mask_t
>     -+get_dentry_access(const struct dentry *const dentry)
>     ++static access_mask_t get_dentry_access(const struct dentry *const dentry)
>      +{
>     -+	return get_mode_access(d_backing_inode(dentry)->i_mode,
>     -+			       d_backing_inode(dentry)->i_rdev);
>     ++	const struct inode *const inode = d_backing_inode(dentry);
>     ++
>     ++	return get_mode_access(inode->i_mode, inode->i_rdev);
>      +}
>      +
>       static access_mask_t maybe_remove(const struct dentry *const dentry)
> 3:  d23ea62b3325 ! 3:  0711d9e709fb selftests/landlock: Add tests for whiteout object creation
>     @@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout1, rename_file)
>      +				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
>      +	EXPECT_EQ(EACCES, errno);
>      +}
>     ++
>     ++static bool is_whiteout(const char *const path)
>     ++{
>     ++	struct stat st;
>     ++
>     ++	if (stat(path, &st) == -1)
>     ++		return false;
>     ++
>     ++	return S_ISCHR(st.st_mode) && st.st_rdev == makedev(0, 0);
>     ++}
>     ++
>     ++static bool is_fifo(const char *const path)
>     ++{
>     ++	struct stat st;
>     ++
>     ++	return stat(path, &st) == 0 && S_ISFIFO(st.st_mode);
>     ++}
>     ++
>     ++TEST_F_FORK(layout1, rename_whiteout_allowed)
>     ++{
>     ++	const struct rule rules[] = {
>     ++		{
>     ++			.path = dir_s3d3,
>     ++			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
>     ++		},
>     ++		{},
>     ++	};
>     ++
>     ++	/* The affected file is a FIFO. */
>     ++	ASSERT_EQ(0, unlink(file1_s3d3));
>     ++	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
>     ++
>     ++	/* Allow MAKE_REG below dir_s3d3. */
>     ++	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, rules);
>     ++
>     ++	/*
>     ++	 * Rename a file with RENAME_WHITEOUT within the same directory.
>     ++	 * Allowed, because MAKE_REG is granted for the whiteout object which
>     ++	 * gets created in the source location.
>     ++	 */
>     ++	EXPECT_EQ(0, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
>     ++			       TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
>     ++
>     ++	/* A whiteout object took the place of the moved FIFO. */
>     ++	EXPECT_TRUE(is_whiteout(file1_s3d3));
>     ++	EXPECT_TRUE(is_fifo(TMP_DIR "/s3d1/s3d2/s3d3/f2"));
>     ++}
>     ++
>     ++TEST_F_FORK(layout1, rename_whiteout_reparenting)
>     ++{
>     ++	const struct rule rules[] = {
>     ++		{
>     ++			.path = dir_s3d2,
>     ++			.access = LANDLOCK_ACCESS_FS_REFER,
>     ++		},
>     ++		{
>     ++			.path = dir_s3d3,
>     ++			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
>     ++		},
>     ++		{},
>     ++	};
>     ++
>     ++	/* The moved files are FIFOs. */
>     ++	ASSERT_EQ(0, unlink(file1_s3d3));
>     ++	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
>     ++	ASSERT_EQ(0, unlink(file1_s3d4));
>     ++	ASSERT_EQ(0, mknod(file1_s3d4, S_IFIFO | 0600, 0));
>     ++
>     ++	/* Allow REFER below dir_s3d2, but MAKE_REG only below dir_s3d3. */
>     ++	enforce_fs(_metadata,
>     ++		   LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER,
>     ++		   rules);
>     ++
>     ++	/*
>     ++	 * The whiteout object is created in the source directory: Moving the
>     ++	 * FIFO out of dir_s3d4 is denied because MAKE_REG is not granted
>     ++	 * there, even though it is granted in the destination directory
>     ++	 * dir_s3d3.
>     ++	 */
>     ++	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d4, AT_FDCWD,
>     ++				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
>     ++	EXPECT_EQ(EACCES, errno);
>     ++
>     ++	/*
>     ++	 * Moving the FIFO out of dir_s3d3 is allowed, because MAKE_REG is
>     ++	 * granted there for the created whiteout object.
>     ++	 */
>     ++	EXPECT_EQ(0, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
>     ++			       TMP_DIR "/s3d1/s3d2/s3d4/f2", RENAME_WHITEOUT));
>     ++
>     ++	/* A whiteout object took the place of the moved FIFO. */
>     ++	EXPECT_TRUE(is_whiteout(file1_s3d3));
>     ++	EXPECT_TRUE(is_fifo(TMP_DIR "/s3d1/s3d2/s3d4/f2"));
>     ++}
>     ++
>     ++TEST_F_FORK(layout1, rename_whiteout_exchange)
>     ++{
>     ++	const char *const whiteout_s3d3 = TMP_DIR "/s3d1/s3d2/s3d3/f2";
>     ++	const struct rule rules[] = {
>     ++		{
>     ++			.path = dir_s3d2,
>     ++			.access = LANDLOCK_ACCESS_FS_REFER,
>     ++		},
>     ++		{
>     ++			.path = dir_s3d3,
>     ++			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
>     ++		},
>     ++		{},
>     ++	};
>     ++
>     ++	/* The exchanged files are FIFOs and an existing whiteout object. */
>     ++	ASSERT_EQ(0, unlink(file1_s3d3));
>     ++	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
>     ++	ASSERT_EQ(0, mknod(whiteout_s3d3, S_IFCHR | 0600, makedev(0, 0)));
>     ++	ASSERT_EQ(0, unlink(file1_s3d4));
>     ++	ASSERT_EQ(0, mknod(file1_s3d4, S_IFIFO | 0600, 0));
>     ++
>     ++	/* Allow REFER below dir_s3d2, but MAKE_REG only below dir_s3d3. */
>     ++	enforce_fs(_metadata,
>     ++		   LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER,
>     ++		   rules);
>     ++
>     ++	/*
>     ++	 * With RENAME_EXCHANGE, the whiteout object moves into the source
>     ++	 * directory of the rename: Exchanging the FIFO in dir_s3d4 with the
>     ++	 * whiteout object is denied because MAKE_REG is not granted in
>     ++	 * dir_s3d4, even though it is granted in the whiteout object's own
>     ++	 * directory dir_s3d3.
>     ++	 */
>     ++	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d4, AT_FDCWD, whiteout_s3d3,
>     ++				RENAME_EXCHANGE));
>     ++	EXPECT_EQ(EACCES, errno);
>     ++
>     ++	/*
>     ++	 * Exchanging the FIFO in dir_s3d3 with the whiteout object is
>     ++	 * allowed, because MAKE_REG is granted in the directory into which
>     ++	 * the whiteout object moves.
>     ++	 */
>     ++	EXPECT_EQ(0, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD, whiteout_s3d3,
>     ++			       RENAME_EXCHANGE));
>     ++
>     ++	/* The FIFO and the whiteout object swapped places. */
>     ++	EXPECT_TRUE(is_whiteout(file1_s3d3));
>     ++	EXPECT_TRUE(is_fifo(whiteout_s3d3));
>     ++}
>      +
>       TEST_F_FORK(layout1, rename_dir)
>       {
>     @@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout1, make_char)
>       
>      +TEST_F_FORK(layout1, make_whiteout)
>      +{
>     -+	/* Creates a whiteout object (creation guarded by MAKE_REG). */
>     ++	/*
>     ++	 * Creates a whiteout object (creation guarded by MAKE_REG).
>     ++	 *
>     ++	 * Contrary to the other character devices, this does not require
>     ++	 * CAP_MKNOD, cf. vfs_mknod().
>     ++	 */
>      +	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, S_IFCHR,
>      +		       makedev(0, 0));
>      +}
> -:  ------------ > 4:  f61b6ddb635e selftests/landlock: Add audit test for whiteout object creation
> 4:  10ed1d74636d ! 5:  4862aead03f2 selftests/landlock: Test whiteout object behaviour in OverlayFS renames
>     @@ Metadata
>       ## Commit message ##
>          selftests/landlock: Test whiteout object behaviour in OverlayFS renames
>      
>     -    Even though OverlayFS uses vfs_rename() with RENAME_WHITEOUT, and even
>     -    though RENAME_WHITEOUT requires LANDLOCK_ACCESS_FS_MAKE_REG, a process
>     -    that renames non-regular files in an OverlayFS can do so without
>     -    having the LANDLOCK_ACCESS_FS_MAKE_REG right in that location.
>     +    Even though OverlayFS uses vfs_rename() with RENAME_WHITEOUT on its backing
>     +    directories, and even though RENAME_WHITEOUT requires
>     +    LANDLOCK_ACCESS_FS_MAKE_REG, a process that renames non-regular files in an
>     +    OverlayFS can do so without having the LANDLOCK_ACCESS_FS_MAKE_REG right in
>     +    that location.
>      
>     -    This works, and is supposed to work, because OverlayFS uses the
>     -    credentials determined at mount time for the internal vfs_rename()
>     -    operation.  The rename happens with the credentials of the user who
>     -    mounted the OverlayFS.
>     +    This works, and is supposed to work, because the changes to the backing
>     +    directories are done by OverlayFS, not by the originator task that did the
>     +    original rename() on the OverlayFS mount.  Therefore, the changes done to
>     +    backing directories are not subject to the originator task's credentials.
>      
>          Signed-off-by: Günther Noack <gnoack@google.com>
>      
>       ## tools/testing/selftests/landlock/fs_test.c ##
>     +@@ tools/testing/selftests/landlock/fs_test.c: static bool is_fifo(const char *const path)
>     + 	return stat(path, &st) == 0 && S_ISFIFO(st.st_mode);
>     + }
>     + 
>     ++static bool is_missing(const char *const path)
>     ++{
>     ++	struct stat st;
>     ++
>     ++	return stat(path, &st) == -1 && errno == ENOENT;
>     ++}
>     ++
>     + TEST_F_FORK(layout1, rename_whiteout_allowed)
>     + {
>     + 	const struct rule rules[] = {
>     +@@ tools/testing/selftests/landlock/fs_test.c: static const char lower_fo1[] = LOWER_DATA "/fo1";
>     + static const char lower_do1[] = LOWER_DATA "/do1";
>     + static const char lower_do1_fo2[] = LOWER_DATA "/do1/fo2";
>     + static const char lower_do1_fl3[] = LOWER_DATA "/do1/fl3";
>     ++/* lower_pl1 is a FIFO and is deliberately not in the lists below. */
>     ++static const char lower_pl1[] = LOWER_DATA "/pl1";
>     + 
>     + static const char (*lower_base_files[])[] = {
>     + 	&lower_fl1,
>     +@@ tools/testing/selftests/landlock/fs_test.c: static const char (*upper_sub_files[])[] = {
>     + #define MERGE_BASE TMP_DIR "/merge"
>     + #define MERGE_DATA MERGE_BASE "/data"
>     + static const char merge_fl1[] = MERGE_DATA "/fl1";
>     ++/* merge_pl1 is a FIFO and is deliberately not in the lists below. */
>     ++static const char merge_pl1[] = MERGE_DATA "/pl1";
>     + static const char merge_dl1[] = MERGE_DATA "/dl1";
>     + static const char merge_dl1_fl2[] = MERGE_DATA "/dl1/fl2";
>     + static const char merge_fu1[] = MERGE_DATA "/fu1";
>     +@@ tools/testing/selftests/landlock/fs_test.c: static const char (*merge_sub_files[])[] = {
>     +  * │       │   ├── fl3
>     +  * │       │   └── fo2
>     +  * │       ├── fl1
>     +- * │       └── fo1
>     ++ * │       ├── fo1
>     ++ * │       └── pl1 [FIFO]
>     +  * ├── merge
>     +  * │   └── data
>     +  * │       ├── dl1
>     +@@ tools/testing/selftests/landlock/fs_test.c: static const char (*merge_sub_files[])[] = {
>     +  * │       │   └── fu2
>     +  * │       ├── fl1
>     +  * │       ├── fo1
>     +- * │       └── fu1
>     ++ * │       ├── fu1
>     ++ * │       └── pl1 [FIFO]
>     +  * └── upper
>     +  *     ├── data
>     +  *     │   ├── do1
>     +@@ tools/testing/selftests/landlock/fs_test.c: FIXTURE_SETUP(layout2_overlay)
>     + 	create_file(_metadata, lower_fo1);
>     + 	create_file(_metadata, lower_do1_fo2);
>     + 	create_file(_metadata, lower_do1_fl3);
>     ++	ASSERT_EQ(0, mknod(lower_pl1, S_IFIFO | 0600, 0));
>     + 
>     + 	create_directory(_metadata, UPPER_BASE);
>     + 	set_cap(_metadata, CAP_SYS_ADMIN);
>     +@@ tools/testing/selftests/landlock/fs_test.c: FIXTURE_TEARDOWN_PARENT(layout2_overlay)
>     + 	EXPECT_EQ(0, remove_path(lower_fl1));
>     + 	EXPECT_EQ(0, remove_path(lower_do1_fo2));
>     + 	EXPECT_EQ(0, remove_path(lower_fo1));
>     ++	EXPECT_EQ(0, remove_path(lower_pl1));
>     + 
>     + 	/* umount(LOWER_BASE)) is handled by namespace lifetime. */
>     + 	EXPECT_EQ(0, remove_path(LOWER_BASE));
>      @@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout2_overlay, same_content_different_file)
>       	}
>       }
>       
>      +TEST_F_FORK(layout2_overlay, rename_in_overlay_without_make_reg)
>      +{
>     -+	struct stat st;
>     -+	const char *merge_fl1_renamed = MERGE_DATA "/fl1_renamed";
>     ++	const char *const merge_pl1_renamed = MERGE_DATA "/pl1_renamed";
>      +
>      +	if (self->skip_test)
>      +		SKIP(return, "overlayfs is not supported (test)");
>      +
>      +	/*
>     -+	 * In this test, merge_fl1 is a FIFO file.  MAKE_REG is restricted, but
>     -+	 * MAKE_FIFO is allowed.  Despite MAKE_REG being restricted, the rename
>     -+	 * on the OverlayFS works and creates a whiteout file in the underlying
>     -+	 * upper file system.
>     ++	 * merge_pl1 is a FIFO which only exists in the lower layer.  Before
>     ++	 * the rename, the upper layer has no entry under this name.
>      +	 */
>     -+	ASSERT_EQ(0, unlink(merge_fl1));
>     -+	ASSERT_EQ(0, mknod(merge_fl1, S_IFIFO, 0));
>     ++	ASSERT_TRUE(is_fifo(merge_pl1));
>     ++	ASSERT_TRUE(is_missing(UPPER_DATA "/pl1"));
>     ++
>     ++	/* MAKE_REG is restricted, but MAKE_FIFO is not. */
>      +	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
>      +
>      +	/*
>     -+	 * Execute a regular file rename within OverlayFS.
>     -+	 * merge_fl1 originates from lower layer, so this triggers a copy-up
>     -+	 * and creation of a whiteout in the upper layer.
>     ++	 * Rename the FIFO through OverlayFS.  merge_pl1 originates from the
>     ++	 * lower layer, so this triggers a copy-up and creates the whiteout in
>     ++	 * the upper layer to hide the lower layer FIFO file.  Even though
>     ++	 * MAKE_REG is restricted, the rename on the OverlayFS works.
>      +	 */
>     -+	EXPECT_EQ(0, rename(merge_fl1, merge_fl1_renamed));
>     ++	EXPECT_EQ(0, rename(merge_pl1, merge_pl1_renamed));
>      +
>      +	/* Check that the rename worked. */
>     -+	EXPECT_EQ(0, stat(merge_fl1_renamed, &st));
>     -+	EXPECT_EQ(-1, stat(merge_fl1, &st));
>     -+	EXPECT_EQ(ENOENT, errno);
>     ++	EXPECT_TRUE(is_fifo(merge_pl1_renamed));
>     ++	EXPECT_TRUE(is_missing(merge_pl1));
>      +
>      +	/*
>     -+	 * Check that the whiteout object on the underlying "upper" filesystem
>     -+	 * exists after the rename.  This is OK because it was done with the
>     -+	 * credentials of the OverlayFS.
>     ++	 * Check that the whiteout object was created on the underlying "upper"
>     ++	 * filesystem during the rename.  This is OK because the whiteout object
>     ++	 * was created by OverlayFS, not by the calling task.
>      +	 */
>     -+	EXPECT_EQ(0, stat(UPPER_DATA "/fl1", &st));
>     -+	EXPECT_TRUE(S_ISCHR(st.st_mode));
>     -+	EXPECT_EQ(0, st.st_rdev);
>     ++	EXPECT_TRUE(is_whiteout(UPPER_DATA "/pl1"));
>      +}
>      +
>       FIXTURE(layout3_fs)
> 5:  35651219395c = 6:  4a53acb99752 landlock: Link the erratum documentation for whiteout objects
> -- 
> 2.55.0.699.gb54405d56f-goog
> 
> 
