Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415D63B05AB
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507515; cv=none; b=PCZf+5Z+O/4A+51ClcMgvcoWA7lLKxEjUv8OSjATEAahV5eaJ6PAX4Mji1GMVxaNevYBP+jhPBQ4vWH8eq6nHJL/or38Qg939GQT1sJBtHwEfp/OkJ3z3y6UQxlrQaBn0clBY3t533lfxwzzk6eqttx1teHcOU7Z59xPXA5YcK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507515; c=relaxed/simple;
	bh=ORp7IyylWcUfCdmRZ+Tk4ka/FpezX8BYOLVYxIEsTWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbFh/UUHLVZB5Dcuz4bo3HpD96qmWLJqyeJ/KXL4REb6WlQBiqLLoszzlA7m32S6gE5QDvVXPTFp3DmGAKWWs4r3XHcPsAhBx0zR/rkqZJTZqUoCoYPiTK8ItWFsRCEGUdIKBR32EarV8r8ugxsv2x9FtPROhy36iEm76FfHjGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Al2Jpujr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Al2Jpujr"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1600d040e4so142020166b.1
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785507512; x=1786112312; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L5cROrxerlKRiqGxS9AtwvGNvt/Ag7kMbfNKxXEHhBg=;
        b=Al2Jpujr/WFD/H35JjTTJwoatmB9Ph94o3L4Cply8BeGoYA6HFUP1hhnxuYPcvOu2P
         zsetHs9McSV1Jf4aoZRhilxMQnv4mW8turd59fa3cbGUWHhXlm+kdpXm3zID+yYmjCnV
         dxEJzSU4cGwN435UAvLt4L28uik2hJV7ZyOltrntAXoZg3TouQgxky7v5War45gl+qTM
         /93oqDp7Az1tooHDVIeud7O8tFG6vHQC898WCuyXOEobuaFpfzV25smoO/sZuojAne+J
         OoEU1RE0F8gGbAgt+hX6VIsZv27rc9dHSAXv6o40pmpzaFiFCO6xmyhaXvLqLaADYQJV
         HMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507512; x=1786112312;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L5cROrxerlKRiqGxS9AtwvGNvt/Ag7kMbfNKxXEHhBg=;
        b=N+sSftsf5Ti3NLBfsZ7rTp4CmCxA5axY0iKJMXDUTiCemeQZgANstsB0BHcJuMOgh/
         gaJiDphP8q93fluDC4aSHcZckbpjVkTIm8KsBspkT/rcuC4sp2kO1i010qkscXyLbwJe
         svQMmYTaheYEU7UoezINyVf/4B8ia1Qv4tZ6YGGyaGaAyD5L3DKk8YLMO7K5o/C8f8DQ
         mOoPhlerlwiciHWjgfmeTAprpewpT0P0BSARDJySjGx5BjmW2jZogqNyNdY/glhPW2Lk
         RfM3mLh7mFVBtos2oNZhOZqbeRcjGAl1glkivi8kJ39Zp2+GVMWXLJAQUWnFmcbsU4Xa
         swEg==
X-Forwarded-Encrypted: i=1; AHgh+RpSDGrb/bQYJ9luZX0VgO7RIIid+Rc3ia9MpcXl/WzOoOq3qNsiq/JXAS9U5P2MR451RRFPyLl5jxdYV2JVXbsWyXTFDTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaj9IC8FLL9EADyBCAluTQ1K9beFJCfwXdWuBDiREQosRQQwpg
	0gJY87BA5im5tk9jbsG75Jw7eitR6u9HsADd0QDmiRWKGnhQ/yPJNN3M/2OZGRI9pQ==
X-Gm-Gg: AR+sD11KQ5WWo+Pg9ob3oHo+T4jvyeVNFmXRiwwx5NlkfE1n0rMQueooYhnrOhAcKS5
	nCN/nWdbeq3CUQNXqxU2alIQ9rOeigCe+W9HyZOwhoD3drI64KEv0nzB8ga/YWWgiWqCT7XVxSU
	bX1MU96t39Iz+3tBOso7mmb36HpNz69i0G2tz/MGOd6ScxPZbfjCjsrNA13o3y4t7bQTdW0k3cJ
	PWTKyJK8XeE49is31ptcra3TzOfKxqU9N+AVIdjrUGW0MP63n/79LNDQn2/1AflqQNy3FiW07Vj
	QBQIfDCkgKhRiNHKty8iHPg/laMiBujSYqWdHsVxio02d9/Sk9qm7LtvGL8KzdsmEMTut5YWWQG
	+dZA/NfIK3MviiK1iDjIgYgXdU/b/qd3NuNwkKogZEy+cqJfEBF592VMO9o26lkskw7qGupY3aF
	yiqGIf1ltKteMjZiPWVc8PHD9945hi0G6zAh3CcnXZ2HBzDO6QcgY8KdrkLjzb0LBNdlUU6vJce
	3J8i0RvPcgtDHIcDuw=
X-Received: by 2002:a17:907:3ea1:b0:c0d:7c31:26a9 with SMTP id a640c23a62f3a-c1fd3a6ff0bmr137660766b.2.1785507511766;
        Fri, 31 Jul 2026 07:18:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:3ba9:7454:5ca0:a791])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4453823sm178312766b.40.2026.07.31.07.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:18:31 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:18:25 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 3/5] selftests/landlock: Add tests for whiteout object
 creation
Message-ID: <amyusSlNoIHj2cEF@google.com>
References: <20260724161004.2360749-1-gnoack@google.com>
 <20260724161004.2360749-4-gnoack@google.com>
 <20260731.ichi2taiQuuc@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731.ichi2taiQuuc@digikod.net>

On Fri, Jul 31, 2026 at 03:22:40PM +0200, Mickaël Salaün wrote:
> On Fri, Jul 24, 2026 at 06:10:02PM +0200, Günther Noack wrote:
> > Add a test to check that whiteout object creation is guarded by
> > LANDLOCK_ACCESS_FS_MAKE_REG, in the cases where these are created from
> > userspace:
> > 
> > * Conventional creation with mknod()
> > * Linking or renaming an existing whiteout object
> > * renameat2() with RENAME_WHITEOUT,
> >   which creates a new whiteout object in the source location
> > 
> > Signed-off-by: Günther Noack <gnoack@google.com>
> > ---
> >  tools/testing/selftests/landlock/fs_test.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > index e82b56a74c5f..fe5faeca83eb 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -2247,6 +2247,19 @@ TEST_F_FORK(layout1, rename_file)
> >  			       RENAME_EXCHANGE));
> >  }
> >  
> > +TEST_F_FORK(layout1, rename_whiteout_denied)
> > +{
> > +	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
> > +
> > +	/*
> > +	 * Try to rename a file with RENAME_WHITEOUT.
> > +	 * file1_s3d3 is in dir_s3d2 (tmpfs), so it supports RENAME_WHITEOUT.
> > +	 */
> > +	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
> > +				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
> > +	EXPECT_EQ(EACCES, errno);
> > +}
> 
> rename_whiteout_denied could not fail.  It moves a regular file, whose
> own creation already requires MAKE_REG, and a same-directory rename
> merges both parent directories' requirements, so its EACCES came from
> the moved file and not from the whiteout: it passes unchanged with the
> whiteout checks removed from fs.c .  Moving a named pipe with MAKE_FIFO
> granted leaves MAKE_REG required for the whiteout alone.

Good catch -- renaming a FIFO makes this test more useful. Fixed (and double
checked by breaking the implementation, to see that it gets caught).


> Four cases are then unexercised, each covering something a bug could
> have broken silently:
> 
> - allowing RENAME_WHITEOUT where MAKE_REG is granted, since a check that
>   denied unconditionally would have passed the denial test;
> 
> - reparenting, since a same-directory rename merges both parents and so
>   cannot show that the whiteout is charged to the source directory;
> 
> - the audit record, since the denial now reports fs.make_reg where it
>   used to report fs.make_char, and nothing pinned which;
> 
> - RENAME_EXCHANGE of an existing whiteout, the only operation needing
>   that right in the source directory, and the case that shows the
>   reclassification covers moving a whiteout and not only creating one.

(Note to self, I still need to look into these)

 - needs a rename_whiteout_allowed or similar check
 - by testing reparenting, the test can check in which of the two directories
   MAKE_REG is allowed
 - updated audit test for whiteouts
 - rename_exchange case -- maybe double check whether this should be tested
   in test_make_file() in a generic way?

> > +
> >  TEST_F_FORK(layout1, rename_dir)
> >  {
> >  	const struct rule rules[] = {
> > @@ -3270,6 +3283,14 @@ TEST_F_FORK(layout1, make_char)
> >  		       makedev(1, 3));
> >  }
> >  
> > +TEST_F_FORK(layout1, make_whiteout)
> > +{
> > +	/* Creates a whiteout object (creation guarded by MAKE_REG). */
> > +	set_cap(_metadata, CAP_MKNOD);
> 
> CAP_MKNOD was never needed for whiteout.

Done.


—Günther

