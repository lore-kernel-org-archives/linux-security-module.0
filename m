Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E34279FC
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505419; cv=none; b=KXmqfoiqXg95Mu5LjfBpy2c5sx8pQT7Yv+xGE14/kQ4Nat5n6xr+XiU2N+twd6QvFCsSBiH2UnVaUuI6q5ScdR+0qYp+NrZLdtyjswuPtqUTSRm65IqsuVauXgGcxIiW0pHzcC5fBxMRqk735mRLNdu+1dPWxswjkl3FA0CxB0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505419; c=relaxed/simple;
	bh=YU2on5ajzrqr0d+yTHuseIgqbJODgbTj5PQfvt0yTOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVx+D5Jii7k34n51zJSefmoTvH6VhHH2+6rNTQ9vmu4ywi7VAfLui0C2mM3vickMHV1tavU9QRe2ucQCIQoGrx7A1Xxpj/1wZd6YDlsm6ZxscAfQrc39Tm85Nv2nOk4ZB89HO3/p2pjM0h7NX+VDtU0Ui4oTIwe5ydTeEZmCrXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0dBpOSFT; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0dBpOSFT"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBS2T0BS3zjh7;
	Fri, 31 Jul 2026 15:43:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785505408;
	bh=3YDo6C5nWVcREbRdzD7qvW8VOz7KGIlWYO91Nk243r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0dBpOSFTXEeO/wl8PPl+czVLYroJo9x0rZ2d9ZDQRGzAysdobJbzej6EZM6DWq+4a
	 yl7uxyzk7ZqGFjuEt8qrDOp68MV+IdthX2vyoUWoUeC/evzHu0jnZnzv+zo3vRasjH
	 J//jjo3uF6Ep1PAUifPyTHW6s9vAV3o9uNAOntuI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hBS2S1H7Qzl4N;
	Fri, 31 Jul 2026 15:43:28 +0200 (CEST)
Date: Fri, 31 Jul 2026 15:43:24 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Serge Hallyn <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 4/5] selftests/landlock: Test whiteout object
 behaviour in OverlayFS renames
Message-ID: <20260731.IeC9Eih4chie@digikod.net>
References: <20260724161004.2360749-1-gnoack@google.com>
 <20260724161004.2360749-5-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724161004.2360749-5-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Jul 24, 2026 at 06:10:03PM +0200, Günther Noack wrote:
> Even though OverlayFS uses vfs_rename() with RENAME_WHITEOUT, and even
> though RENAME_WHITEOUT requires LANDLOCK_ACCESS_FS_MAKE_REG, a process that
> renames non-regular files in an OverlayFS can do so without having the
> LANDLOCK_ACCESS_FS_MAKE_REG right in that location.
> 
> This works, and is supposed to work, because OverlayFS uses the credentials
> determined at mount time for the internal vfs_rename() operation. -- The

This "--" doesn't seem useful.

> rename happens with the credentials of the user who mounted the OverlayFS.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index fe5faeca83eb..73770dbb0592 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -6972,6 +6972,45 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
>  	}
>  }
>  
> +TEST_F_FORK(layout2_overlay, rename_in_overlay_without_make_reg)
> +{
> +	struct stat st;
> +	const char *merge_fl1_renamed = MERGE_DATA "/fl1_renamed";
> +
> +	if (self->skip_test)
> +		SKIP(return, "overlayfs is not supported (test)");
> +
> +	/*
> +	 * In this test, merge_fl1 is a FIFO file.  MAKE_REG is restricted, but
> +	 * MAKE_FIFO is allowed.  Despite MAKE_REG being restricted, the rename
> +	 * on the OverlayFS works and creates a whiteout file in the underlying
> +	 * upper file system.
> +	 */
> +	ASSERT_EQ(0, unlink(merge_fl1));

merge_fl1 just became a whiteout with this unlink, so I think the test
is wrong because it doesn't check RENAME_WHITEOUT against the lower file.

> +	ASSERT_EQ(0, mknod(merge_fl1, S_IFIFO, 0));

The mode should be 0600.

> +	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
> +
> +	/*
> +	 * Execute a regular file rename within OverlayFS.

merge_fl1 is a fifo.

> +	 * merge_fl1 originates from lower layer, so this triggers a copy-up
> +	 * and creation of a whiteout in the upper layer.
> +	 */
> +	EXPECT_EQ(0, rename(merge_fl1, merge_fl1_renamed));
> +
> +	/* Check that the rename worked. */
> +	EXPECT_EQ(0, stat(merge_fl1_renamed, &st));
> +	EXPECT_EQ(-1, stat(merge_fl1, &st));
> +	EXPECT_EQ(ENOENT, errno);
> +
> +	/*
> +	 * Check that the whiteout object on the underlying "upper" filesystem
> +	 * exists after the rename.  This is OK because it was done with the
> +	 * credentials of the OverlayFS.
> +	 */
> +	EXPECT_EQ(0, stat(UPPER_DATA "/fl1", &st));
> +	EXPECT_TRUE(S_ISCHR(st.st_mode));
> +	EXPECT_EQ(0, st.st_rdev);
> +}
>  
>  FIXTURE(layout3_fs)
>  {
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
> 
