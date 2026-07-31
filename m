Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121DB366052
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504177; cv=none; b=OmMH59xxcrlSAcUsktlJtUbqHsmk/iHnF5UEwl6XuXlmYw+TVtJB7i/O5CKKwCRcsEk9gyR7TQvvLHuSl+9h4xnmwyMEVdO860TOblacqUIIA0geimeUlNCeGaBefv59uwmRdnZoxyJcMdbvYv16QwdfLLnz1nN01BumFtCMLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504177; c=relaxed/simple;
	bh=DovkdF0QdXM0r7OQsFhe2Ix+1RumqioDKo/Pz8gyu/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMsvr1nFqq9zSMx2corTKnwLuijmAa7sGH7iGIAxWO67KBBtzmS1VLGDv4gmpbloWw7ln97c+WJ7sBE8W+I6QMNsHcpgLHQKlLwEdssKurs4idV/ug6W7ZWCRdj++HoxVvLRvIW9KspzlBP4Akt7ap+1fxKA8MbuaL5dlO1UPt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jU+FuKWG; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jU+FuKWG"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBRZZ2CMdzVvC;
	Fri, 31 Jul 2026 15:22:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785504166;
	bh=a5AHDh5aGIoQuHsVHPsUHoeIlJMooMcTcqqzyhtoQd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jU+FuKWGPT+lY9QRcnPbDZFkJNL3CMyjam550q8bctct1oOFXjFx2cz8hoSlKJum+
	 6oVIpLb8rOtXxliFvwYQ9gRUUf9ZkOJVnpwGG1mpMtZMC5vSvxZIiv1iwuhSjyg9+n
	 XP2N4Qm5YFRdceXMyS+e7TmoH/ltH3rcqaUF2qcU=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hBRZY19KCzby4;
	Fri, 31 Jul 2026 15:22:45 +0200 (CEST)
Date: Fri, 31 Jul 2026 15:22:40 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Serge Hallyn <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 3/5] selftests/landlock: Add tests for whiteout object
 creation
Message-ID: <20260731.ichi2taiQuuc@digikod.net>
References: <20260724161004.2360749-1-gnoack@google.com>
 <20260724161004.2360749-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724161004.2360749-4-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Jul 24, 2026 at 06:10:02PM +0200, Günther Noack wrote:
> Add a test to check that whiteout object creation is guarded by
> LANDLOCK_ACCESS_FS_MAKE_REG, in the cases where these are created from
> userspace:
> 
> * Conventional creation with mknod()
> * Linking or renaming an existing whiteout object
> * renameat2() with RENAME_WHITEOUT,
>   which creates a new whiteout object in the source location
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index e82b56a74c5f..fe5faeca83eb 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -2247,6 +2247,19 @@ TEST_F_FORK(layout1, rename_file)
>  			       RENAME_EXCHANGE));
>  }
>  
> +TEST_F_FORK(layout1, rename_whiteout_denied)
> +{
> +	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
> +
> +	/*
> +	 * Try to rename a file with RENAME_WHITEOUT.
> +	 * file1_s3d3 is in dir_s3d2 (tmpfs), so it supports RENAME_WHITEOUT.
> +	 */
> +	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
> +				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
> +	EXPECT_EQ(EACCES, errno);
> +}

rename_whiteout_denied could not fail.  It moves a regular file, whose
own creation already requires MAKE_REG, and a same-directory rename
merges both parent directories' requirements, so its EACCES came from
the moved file and not from the whiteout: it passes unchanged with the
whiteout checks removed from fs.c .  Moving a named pipe with MAKE_FIFO
granted leaves MAKE_REG required for the whiteout alone.

Four cases are then unexercised, each covering something a bug could
have broken silently:

- allowing RENAME_WHITEOUT where MAKE_REG is granted, since a check that
  denied unconditionally would have passed the denial test;

- reparenting, since a same-directory rename merges both parents and so
  cannot show that the whiteout is charged to the source directory;

- the audit record, since the denial now reports fs.make_reg where it
  used to report fs.make_char, and nothing pinned which;

- RENAME_EXCHANGE of an existing whiteout, the only operation needing
  that right in the source directory, and the case that shows the
  reclassification covers moving a whiteout and not only creating one.

> +
>  TEST_F_FORK(layout1, rename_dir)
>  {
>  	const struct rule rules[] = {
> @@ -3270,6 +3283,14 @@ TEST_F_FORK(layout1, make_char)
>  		       makedev(1, 3));
>  }
>  
> +TEST_F_FORK(layout1, make_whiteout)
> +{
> +	/* Creates a whiteout object (creation guarded by MAKE_REG). */
> +	set_cap(_metadata, CAP_MKNOD);

CAP_MKNOD was never needed for whiteout.

> +	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, S_IFCHR,
> +		       makedev(0, 0));
> +}
> +
>  TEST_F_FORK(layout1, make_block)
>  {
>  	/* Creates a /dev/loop0 device. */
> @@ -6951,6 +6972,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
>  	}
>  }
>  
> +
>  FIXTURE(layout3_fs)
>  {
>  	bool has_created_dir;
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
> 
