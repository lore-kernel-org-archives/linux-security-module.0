Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06648A2C2
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808286; cv=none; b=FjSEZk0ZnWwn5AkDshKC2P/2qNd7z/tWCYUgHm+p8HcBSA/4mRry5u6MTQNAqBpNop+v5oH8eO8XvUQ2DzDnpBB6ZgLS1XbfO6g4W2WRPwzP0Q5dipHti/5ZMG+pchnHYDG7teXaUS4vbBzJTOD4KMrqOV4rglU0PKaYHDAdC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808286; c=relaxed/simple;
	bh=5UJPff0wg1VlQcLFGbr1hGIhRar/AfVfr9sTYErW3Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clNxO6HzK9dw+5ZEPz87ZlQbATTrLDqQEhcIwB55YNjabgf0Jd+2RNFqUfrWhMysmwfK8e1pDka8+j/QIO/ZYCWFFWeg+msRxs4L9br4q9QHlJTC2RuHKX1SmN7PH/ZYBlvKOm3BNpEC95ItqZpOxL9EXkwbWrKRuRHXjOd7VTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SDbK6KIS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SDbK6KIS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so4289895e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 05:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784808282; x=1785413082; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+gcaFElBC7f8Nh+YVyKdMXyTbQBEVPsN+a9qINNwuvw=;
        b=SDbK6KISkmsneRHlARlcIPPM3lC5UZk1WzHrfWO9Q9ops+FBm2/98c2I9iJTUDvdUr
         V4MY2HGOjdyUVjUbr3Y0G9jJoli8Fn7TP4AAeUkytQ0ZzZLku4wFtK4SRbP0YrJMgOyM
         nUyqvKQOyFvIbfhGEvvWHBZfTIY1Zds95oL+PbMq1GMyvVqLEIz//lsBCOFYettz27Ib
         GwR1fF1z8fDfkDksyvg/qh6pm/1mVHC39oXGI+hsr328KFdoClomqJplRE2t5mZuZq3d
         8wTqgilpFB/8UiQmdJxjzumjePQudNjvFPcOc0FomBy9+KlilJUXvUhEXlIUhgGGWlnn
         eyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784808282; x=1785413082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+gcaFElBC7f8Nh+YVyKdMXyTbQBEVPsN+a9qINNwuvw=;
        b=EXoaH7UGFLGxmd3/bbLDQV9dcookHpAeF+rsfoxwPYXcCC6mu9As0wy9ZaMLJLlego
         4c90PaPseoZum+JHhcrt2RfWAuepZ9KUyL6oO5OsL5hdyILb8h0NRzaflxx01hx370/o
         Qaw7tboSjVblekt2ipUBTbf4SNNgNfYrYc5Tc48791cC4rAiQxVLJ9naen46jBFvFPRX
         JbmMHRjnhI2bUkm2gwfwOJDkqBZ0lFR4yPVALk287FmWTFGgFFbeoy4AbCbed0ayFBjB
         3j5GxW17fDsqkHjw29+CtSWwhxqvfh1J2sOP27Dx7spDrWg6/VBdV92wqGdU5g1nRZdf
         dlAQ==
X-Gm-Message-State: AOJu0YwroQdiK8Q6BMEO/wnQVGm5cNym325cfqGWQ0IlwMPzIEq9Nill
	wVPqMM/Wt8EehNmq4VBTLi8fRFGIalkHnK+CazSBeRabLkKHiL0bqhVKE3EYvDwrHw==
X-Gm-Gg: AR+sD12XBkEiiBHn+cX1ujBU3DtFwfhTir+id4xFTo9UIIxAKAwjV6jSfPWCFTcAOjK
	t410nXupwvwfP+ugiWwEWmNKmNwMEu5w0nL/ZjmUYWKxBz4nIeo0iayNUqoge6Ql/V7tWyfcjGP
	W41LOfvchp4RDac2SSFYhGLUWTGthzqz5Mj9ufxbKLq7zuBxR0F3hY3XFpeJ6iJ/dQzAdAmEc0W
	g5FdWqOcgdonWyAyYjRpGUrzDVYlj1Bs1QHMFDjImQ8wmvBT6xEQ12l9VLnEAGNfVdsUvUWYU9p
	ZYZAXy7hgbyto6gNvjopdTP7to4ZBnjZgb/Ea6bYxgi7FHLefH5knBgBHVsUSTNv+M7A20UN0G6
	oPTBPqDF6Doi07hcCtIKlSnkmF8drrx/9AfLs7lTXekmKElUaziunPKE1mMIRIFA9ng4dfrjK6R
	2IEy01Nk/MfLn39Mxf3QiRN3kM4tzMtxa8
X-Received: by 2002:a05:600c:4b1a:b0:495:518a:5cbf with SMTP id 5b1f17b1804b1-49573d08bafmr18881125e9.32.1784808280978;
        Thu, 23 Jul 2026 05:04:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:a914:97a6:4219:66dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bc62basm15034562f8f.13.2026.07.23.05.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 05:04:40 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:04:35 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	Takao Sato <takaosato1997@gmail.com>, Willy Tarreau <w@1wt.eu>,
	brauner@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v1] selftests/landlock: Add tests for O_TMPFILE
Message-ID: <amIDU0Z8Meq8fHTX@google.com>
References: <20260722151354.2736457-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722151354.2736457-1-mic@digikod.net>

On Wed, Jul 22, 2026 at 05:13:52PM +0200, Mickaël Salaün wrote:
> open(2) with O_TMPFILE creates its unnamed inode through vfs_tmpfile(),
> which, unlike normal file creation, calls neither security_path_mknod()
> nor security_inode_create().  It is nonetheless mediated: vfs_tmpfile()
> opens the inode through the filesystem's ->tmpfile() operation, which
> reaches security_file_open() via finish_open().  The open is therefore
> checked like any other, and materializing the file with linkat(2) is
> checked like any other link.
> 
> Add tests for both paths so O_TMPFILE cannot bypass Landlock.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 251 +++++++++++++++++++++
>  1 file changed, 251 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index cdb47fc1fc0a..b826b2c6a8f0 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -450,6 +450,25 @@ static int test_open(const char *const path, const int flags)
>  	return test_open_rel(AT_FDCWD, path, flags);
>  }
>  
> +/*
> + * Opens an anonymous O_TMPFILE inode in the directory dir.  O_TMPFILE is always
> + * combined with O_WRONLY or O_RDWR, so the caller must pass one of them in
> + * flags.
> + */
> +static int test_tmpfile(const char *const dir, const int flags)
> +{
> +	int fd;
> +
> +	fd = open(dir, O_TMPFILE | flags | O_CLOEXEC, 0700);
                                                      ^^^^
The file mode doesn't seem to be used in the test.  According to the man page,
it's only relevant when you later do a linkat(), but even then this
functionality seems unrelated to Landlock and is not tested here, I think.

> +	if (fd < 0)
> +		return errno;
> +
> +	if (close(fd) != 0)
> +		return errno;
> +
> +	return 0;
> +}
> +

The test_open() function does the exact same thing, except that it doesn't
enforce O_TMPFILE.  But because the test_open() function mirrors the syscall
parameters, you can pass O_TMPFILE as a flag from the outside, by calling it
with:

    EXPECT_EQ(0, test_open(dir_s1d2, O_TMPFILE|O_WRONLY));

I find that preferrable over using a special test_tmpfile() helper, because it
is not much longer than what you have now, and it is very implicit here what
parameters we are passing to open(2) -- and the interface of open(2) is already
well-known.  For a test_tmpfile() helper, you'd always have to look up what that
function does.


>  TEST_F_FORK(layout1, no_restriction)
>  {
>  	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
> @@ -2140,6 +2159,238 @@ TEST_F_FORK(layout1, link)
>  	ASSERT_EQ(0, link(file1_s1d3, file2_s1d3));
>  }
>  
> +/*
> + * O_TMPFILE does not go through the path_mknod hook: vfs_tmpfile() creates the
> + * inode without calling security_path_mknod().  These tests verify that the
> + * resulting file is still mediated, via the file_open hook, so O_TMPFILE cannot
> + * be used to bypass Landlock.
> + */
> +
> +/*
> + * An O_TMPFILE open requires WRITE_FILE (and READ_FILE for O_RDWR) on the
> + * directory hierarchy, exactly like any other writable open.  It does not
> + * require (nor is it granted by) MAKE_REG: the anonymous inode is not yet a
> + * named file.  O_TMPFILE always implies write access, so a read-only request is
> + * rejected by the VFS with EINVAL before Landlock is consulted; Landlock must
> + * not change that into EACCES.
> + */
> +TEST_F_FORK(layout1, open_tmpfile)
> +{
> +	const struct rule rules[] = {
> +		/* Write allowed, but neither MAKE_REG nor READ_FILE. */
> +		{
> +			.path = dir_s1d1,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		/* Both read and write allowed. */
> +		{
> +			.path = dir_s1d2,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		/* File-creation right without write. */
> +		{
> +			.path = dir_s2d1,
> +			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
> +		},
> +		{},
> +	};
> +
> +	/* Baseline: an unsandboxed O_TMPFILE open works. */
> +	EXPECT_EQ(0, test_tmpfile(dir_s1d1, O_WRONLY));
> +	EXPECT_EQ(0, test_tmpfile(dir_s2d1, O_RDWR));
> +	EXPECT_EQ(0, test_tmpfile(dir_s3d1, O_RDWR));

Nit: Should they all threee use O_RDWR?


> +
> +	/* O_TMPFILE requires write access: read-only is EINVAL at the VFS. */
> +	EXPECT_EQ(EINVAL, test_tmpfile(dir_s1d1, O_RDONLY));
> +
> +	enforce_fs(_metadata,
> +		   LANDLOCK_ACCESS_FS_READ_FILE |
> +			   LANDLOCK_ACCESS_FS_WRITE_FILE |
> +			   LANDLOCK_ACCESS_FS_MAKE_REG,
> +		   rules);
> +
> +	/* Write is enough for an O_WRONLY tmpfile; MAKE_REG is not needed. */
> +	EXPECT_EQ(0, test_tmpfile(dir_s1d1, O_WRONLY));
> +	/* O_RDWR additionally needs READ_FILE, which is absent here. */
> +	EXPECT_EQ(EACCES, test_tmpfile(dir_s1d1, O_RDWR));
> +
> +	/* Read and write allowed: both open modes succeed. */
> +	EXPECT_EQ(0, test_tmpfile(dir_s1d2, O_WRONLY));
> +	EXPECT_EQ(0, test_tmpfile(dir_s1d2, O_RDWR));
> +
> +	/* MAKE_REG without WRITE_FILE does not allow the open. */
> +	EXPECT_EQ(EACCES, test_tmpfile(dir_s2d1, O_WRONLY));
> +	EXPECT_EQ(EACCES, test_tmpfile(dir_s2d1, O_RDWR));
> +
> +	/* No rule at all: the open is denied. */
> +	EXPECT_EQ(EACCES, test_tmpfile(dir_s3d1, O_WRONLY));
> +	EXPECT_EQ(EACCES, test_tmpfile(dir_s3d1, O_RDWR));
> +
> +	/*
> +	 * A read-only O_TMPFILE stays EINVAL under Landlock, whether the
> +	 * directory is fully allowed or has no rule: the VFS rejects the flag
> +	 * combination before the file_open hook, so Landlock never turns it
> +	 * into EACCES.
> +	 */
> +	EXPECT_EQ(EINVAL, test_tmpfile(dir_s1d2, O_RDONLY));
> +	EXPECT_EQ(EINVAL, test_tmpfile(dir_s3d1, O_RDONLY));
> +}
> +
> +/*
> + * When the ruleset handles neither file read nor write access, Landlock has no
> + * opinion on an O_TMPFILE open and must not interfere with it.

If the intent is to demonstrate that only READ_FILE and WRITE_FILE interfere
with O_TMPFILE, I would suggest that (a) the ruleset should "handle" everything
but these two, and (b) we do not need to pass any rules as exceptions to that?
        
enforce_fs(_metadata, ACCESS_ALL & ~(READ_FILE | WRITE_FILE), NULL);


> + */
> +TEST_F_FORK(layout1, open_tmpfile_unhandled)
> +{
> +	const struct rule rules[] = {
> +		{
> +			.path = dir_s1d2,
> +			.access = LANDLOCK_ACCESS_FS_READ_DIR,
> +		},
> +		{},
> +	};
> +
> +	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_DIR, rules);
> +
> +	EXPECT_EQ(0, test_tmpfile(dir_s1d1, O_WRONLY));
> +	EXPECT_EQ(0, test_tmpfile(dir_s1d3, O_RDWR));
> +	EXPECT_EQ(0, test_tmpfile(dir_s3d1, O_RDWR));
> +}
> +
> +/*
> + * Materializing an anonymous O_TMPFILE into its creation directory with
> + * linkat(AT_EMPTY_PATH) is gated by MAKE_REG on that directory, even though
> + * obtaining the writable tmpfile only required WRITE_FILE.  This is the check
> + * that stops O_TMPFILE from creating a named file where the sandbox forbids
> + * file creation.  Linking into the same directory does not involve reparenting,
> + * so REFER is not required.
> + */
> +TEST_F_FORK(layout1, link_tmpfile)
> +{
> +	int fd;
> +	const struct rule rules[] = {
> +		/* Write only: the tmpfile opens but cannot be linked. */
> +		{
> +			.path = dir_s1d1,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		/* Write and MAKE_REG: the tmpfile opens and can be linked. */
> +		{
> +			.path = dir_s2d1,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE |
> +				  LANDLOCK_ACCESS_FS_MAKE_REG,
> +		},
> +		{},
> +	};
> +
> +	/* Frees names in the two directories for the new links. */
> +	ASSERT_EQ(0, unlink(file1_s1d1));
> +	ASSERT_EQ(0, unlink(file1_s2d1));
> +
> +	enforce_fs(_metadata,
> +		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_MAKE_REG,
> +		   rules);
> +
> +	/*
> +	 * WRITE_FILE is enough to obtain the anonymous tmpfile.  linkat(2) with
> +	 * AT_EMPTY_PATH needs no capability because the fd's open-time
> +	 * credentials match the caller's.  Linking into the same directory does
> +	 * not require REFER (no reparenting), only MAKE_REG, which is absent
> +	 * here.
> +	 */
> +	fd = open(dir_s1d1, O_TMPFILE | O_WRONLY | O_CLOEXEC, 0700);
> +	ASSERT_LE(0, fd);
> +	ASSERT_EQ(-1, linkat(fd, "", AT_FDCWD, file1_s1d1, AT_EMPTY_PATH));
> +	EXPECT_EQ(EACCES, errno);
> +	EXPECT_EQ(0, close(fd));
> +
> +	/* With MAKE_REG on the directory, the same link is allowed. */
> +	fd = open(dir_s2d1, O_TMPFILE | O_WRONLY | O_CLOEXEC, 0700);
> +	ASSERT_LE(0, fd);
> +	EXPECT_EQ(0, linkat(fd, "", AT_FDCWD, file1_s2d1, AT_EMPTY_PATH));
> +	EXPECT_EQ(0, close(fd));
> +}
> +
> +/*
> + * Linking a tmpfile into a different directory is a reparenting operation: like
> + * any cross-directory link it requires LANDLOCK_ACCESS_FS_REFER.  Without it,
> + * materializing the tmpfile outside its creation directory is denied with
> + * EXDEV, so a tmpfile cannot escape its origin hierarchy.

Because a O_TMPFILE is always a regular file, I think for most Landlock access
rights, it does not make a difference.  If I understand this correctly, the only
two access rights where it does make a difference would be EXECUTE and TRUNCATE,
because they are the ones which apply to regular files where the refer rule
matters.  Is that correct?  Maybe they would be worth mentioning as a
motivational example here, to show that this makes an actual difference for
O_TMPFILE?

> + */
> +TEST_F_FORK(layout1, link_tmpfile_reparent_without_refer)
> +{
> +	int fd;
> +	const struct rule rules[] = {
> +		/* Source directory: only the tmpfile open is allowed. */
> +		{
> +			.path = dir_s1d1,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		/* Destination directory: file creation is allowed. */
> +		{
> +			.path = dir_s2d1,
> +			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
> +		},
> +		{},
> +	};
> +
> +	/* Frees a name in the destination directory for the new link. */
> +	ASSERT_EQ(0, unlink(file1_s2d1));
> +
> +	enforce_fs(_metadata,
> +		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_MAKE_REG,
> +		   rules);
> +
> +	fd = open(dir_s1d1, O_TMPFILE | O_WRONLY | O_CLOEXEC, 0700);
> +	ASSERT_LE(0, fd);
> +	/* Cross-directory link without REFER is denied with EXDEV. */
> +	ASSERT_EQ(-1, linkat(fd, "", AT_FDCWD, file1_s2d1, AT_EMPTY_PATH));
> +	EXPECT_EQ(EXDEV, errno);
> +	EXPECT_EQ(0, close(fd));
> +}
> +
> +/*
> + * With LANDLOCK_ACCESS_FS_REFER on both directories, a tmpfile created in one
> + * directory can be linked into another.  The destination needs only MAKE_REG
> + * (plus REFER), not WRITE_FILE: the reparenting check compares file access
> + * rights, and the tmpfile gains none by moving to a directory that grants only
> + * the directory-level creation right.

In other words, linking the tmpfile into a directory that grants fewer rights on
it is fine.  The only required rights in the destination directory are REFER and
MAKE_REG, because those are required for the linking itself.  This checks out,
but it's already a basic property that REFER has in the normal case as well.  We
can test it for completeness, but it doesn't seem particularly special to the
tmpfile case.  (Would be OK to drop imho, but I'm not feeling strongly about
it.)

> + */
> +TEST_F_FORK(layout1, link_tmpfile_reparent_with_refer)
> +{
> +	int fd;
> +	const struct rule rules[] = {
> +		/* Source: tmpfile open (write) and reparenting. */
> +		{
> +			.path = dir_s1d1,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE |
> +				  LANDLOCK_ACCESS_FS_REFER,
> +		},
> +		/* Destination: file creation and reparenting, but no write. */
> +		{
> +			.path = dir_s2d1,
> +			.access = LANDLOCK_ACCESS_FS_MAKE_REG |
> +				  LANDLOCK_ACCESS_FS_REFER,
> +		},
> +		{},
> +	};
> +
> +	/* Frees a name in the destination directory for the new link. */
> +	ASSERT_EQ(0, unlink(file1_s2d1));
> +
> +	enforce_fs(_metadata,
> +		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_MAKE_REG |
> +			   LANDLOCK_ACCESS_FS_REFER,
> +		   rules);
> +
> +	fd = open(dir_s1d1, O_TMPFILE | O_WRONLY | O_CLOEXEC, 0700);
> +	ASSERT_LE(0, fd);
> +	/* REFER on both sides plus MAKE_REG on the destination allows it. */
> +	EXPECT_EQ(0, linkat(fd, "", AT_FDCWD, file1_s2d1, AT_EMPTY_PATH));
> +	EXPECT_EQ(0, close(fd));
> +}
> +
>  static int test_rename(const char *const oldpath, const char *const newpath)
>  {
>  	if (rename(oldpath, newpath))
> -- 
> 2.54.0
> 

P.S.: I checked the Sashiko review as well and it did not spot any issues in these tests.

https://sashiko.dev/#/patchset/20260722151354.2736457-1-mic%40digikod.net

(It believes that it spotted a bug in the kernel code, but that is better
investigated separately of this patch.)

—Günther
