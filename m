Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5D319848
	for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2026 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565907; cv=none; b=miy6nD3D2SSkL6uzT4j4EpZEggX+RiXquMdtxzAeabyAoiwU7/gkBtldVRJJhZ3eJwKKs5yCWlTKSlLuetNmVUHUdx7geoV6vJcIuwGkNQSZ2tDPkvtY6ZY/ypdX4M8WbX3SM6FtP86VlU4SR7g/mb+/vyJ2sR34dnMxajDodMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565907; c=relaxed/simple;
	bh=WIA71DUq84IXzXsNYvgiELwXp11snf62/XZv1k4i1vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KweEAiDopEPxKDSnc+RaFtObXULuABM+3fpc3HGXUcFmQ4wQek9YbMlPDRvinYyVWf4a0TDjD8lPXsl33rQQ/Qma2KjcHjaDkt7OX0BQTycldXVXDon079Dt9pj8V7j/vci4y7YucRePlei/mfRMU1G4Qc/C2gbqDesEHPs5F2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CC8i6Wdm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC8i6Wdm"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f71156e1aso628719f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2026 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786565904; x=1787170704; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kj9Mv/P3EgX6HYHzc7yiLvdqqjbfWysMFmw7Rf/ehfk=;
        b=CC8i6Wdm5mkVyi/hsPwcqlDPYRvaB5wvEbGWnrFwk1Df3XUMR9q+4r13rNu6oSsHfr
         fPcSJxgVUR3Rv/GxVvhkS5KLITB+IoKkCjvle7B32RrZ6HGNt4YU/odsV68NxuwCgHkQ
         c8Oj04EKGz5+KiUUvgYMLWxoLEFwFOXQBX7Uxcyg7QuouVVAgWCCyRCFeegqTQXkvP/z
         2fvG8IHmt8rMM2KYdsRhERCPaSe7XpqnEh+xiAjtw3LKM4noWYhBAgmVkRNfuoIlLtb1
         sGa1iJkvKWZ1D3EX9H9/XIV3m9UlDy0gUnJ5JP5643emSOmrWnKQjecjPrVcI6MJjmoW
         1j0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786565904; x=1787170704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kj9Mv/P3EgX6HYHzc7yiLvdqqjbfWysMFmw7Rf/ehfk=;
        b=s3PbyYVUK5wRZqR0sFvrWwNCdEVK+Dm9fwJGruFAleIa4XZvAVdCx/V86bAEHzlRJs
         wxugrIp8yFuPCBDt+8H2Pv2X5siNjKbG/U34MYIlbTEuFriksqBfQxeymHj5y56ZKYj3
         Qh/zHwFxXUpF1FpzGNFVUuAFrgxc5kSRGbzeM7PgNwg9KSlzzMsspOpjniX5JPYf2apY
         SNAId1u9s6nRFicmPZ5MHZUU4eAqIQWDnhwOlVVO3axiW7jIbxL9GMrEMjb9ypJsEuYm
         PFxOAo3zHMXjLcAMH4thxm/SNehIPPZhiOTpaE6ENiJESvDKbZ2BeTviesPLjXEwyRkp
         /Urw==
X-Forwarded-Encrypted: i=1; AHgh+Rqid7+W3OksMLGp/kqsSIqJXtFdb+vuORLC8sW71bhc7j1WhoD3551UU65EONxb4D8iZYvc86lFRKTWAU5Wx/5EK6HL4J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhWAeI6ISPnnGmPk8UJZFQ6XdiIHK/BWt+VpYs4gEzUbFzhBjh
	josjmfQde/dq4FIDG5nH3lnMvbLC539ShKyxVQb5Mrb/8lrvwCWhT7YR
X-Gm-Gg: AR+sD13fUL23qJ2oxGKPFchiBme+0lfASq0nc8fiRQVklHWr9K/3LjeaSpWjiZtEyZ+
	WKRA37p6fiYZ8c5AdPpl489rU4Kt1Kb+B/eLcngXImQZp1gCLW0JBYh6w81BLSFIEUVLc3jEoVR
	6Td/B/ZFioA4ZXxjjXiVwLs88wyxoH0teAugTbMQA02rz3di9UpxsrT5yhYVE3D15Zx21pTiD6j
	LNZPGr64bqs5Dzc6DOagxGrVLOfPsY8fUpexbUM03FgKxuL60+eQWTXFitb4rVUX6qHmCIEZ9q9
	aSnDFvJZsOcWL+qhEgl5AjNy/LTcZTt0tlzwHWqloLfFKb2IczKcekJsWhwqaK6TwDkGMMJMPft
	g4ulXj3c3KMOgrxN4yiQKAjYfqCjYcDPB3NACipEsVH4+seirZfTcf6E8jCiDXxhJ+9XY7alR/B
	vSumgnoLJ3cukcDAhD4wqQPy22T5BOvq2aoyBOG8/TxsLcjLI33qPSmwMxd7QU4SoRHiG3wMJWF
	cvtpLL6Papq5A==
X-Received: by 2002:a05:6000:2a0c:b0:481:5167:abda with SMTP id ffacd0b85a97d-48159cbfab9mr845261f8f.9.1786565904386;
        Wed, 12 Aug 2026 13:18:24 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5613eesm266502f8f.5.2026.08.12.13.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:18:24 -0700 (PDT)
Date: Wed, 12 Aug 2026 22:18:22 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 4/5] selftests/landlock: Test whiteout object
 behaviour in OverlayFS renames
Message-ID: <20260812.ed47cbfa7bb0@gnoack.org>
References: <20260724161004.2360749-1-gnoack@google.com>
 <20260724161004.2360749-5-gnoack@google.com>
 <20260731.IeC9Eih4chie@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731.IeC9Eih4chie@digikod.net>

On Fri, Jul 31, 2026 at 03:43:24PM +0200, Mickaël Salaün wrote:
> On Fri, Jul 24, 2026 at 06:10:03PM +0200, Günther Noack wrote:
> > Even though OverlayFS uses vfs_rename() with RENAME_WHITEOUT, and even
> > though RENAME_WHITEOUT requires LANDLOCK_ACCESS_FS_MAKE_REG, a process that
> > renames non-regular files in an OverlayFS can do so without having the
> > LANDLOCK_ACCESS_FS_MAKE_REG right in that location.
> > 
> > This works, and is supposed to work, because OverlayFS uses the credentials
> > determined at mount time for the internal vfs_rename() operation. -- The
> 
> This "--" doesn't seem useful.

Reworded this and removed the "--"

(The paragraph was previously slightly misleading - vfs_rename() is
used by OverlayFS, but does not actually call into the Landlock rename
hook, so the credentials at the time of OverlayFS mount do not matter
for the in-kernel OverlayFS.  So the old paragraph was a bit
misleading, but the larger point still applies - the operations done
by OverlayFS on the underlying upper and lower file systems are not
subject to the Landlock policy of the userspace process that triggered
the operation through an operation on the unified OverlayFS file
system.)

> 
> > rename happens with the credentials of the user who mounted the OverlayFS.
> > 
> > Signed-off-by: Günther Noack <gnoack@google.com>
> > ---
> >  tools/testing/selftests/landlock/fs_test.c | 39 ++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > index fe5faeca83eb..73770dbb0592 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -6972,6 +6972,45 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
> >  	}
> >  }
> >  
> > +TEST_F_FORK(layout2_overlay, rename_in_overlay_without_make_reg)
> > +{
> > +	struct stat st;
> > +	const char *merge_fl1_renamed = MERGE_DATA "/fl1_renamed";
> > +
> > +	if (self->skip_test)
> > +		SKIP(return, "overlayfs is not supported (test)");
> > +
> > +	/*
> > +	 * In this test, merge_fl1 is a FIFO file.  MAKE_REG is restricted, but
> > +	 * MAKE_FIFO is allowed.  Despite MAKE_REG being restricted, the rename
> > +	 * on the OverlayFS works and creates a whiteout file in the underlying
> > +	 * upper file system.
> > +	 */
> > +	ASSERT_EQ(0, unlink(merge_fl1));
> 
> merge_fl1 just became a whiteout with this unlink, so I think the test
> is wrong because it doesn't check RENAME_WHITEOUT against the lower file.

OK, changed to this approach:

* Creating a FIFO at lower/data/pl1 as part of the fixture
  (For well-defined behaviour, this needs to happen before mounting
  the OverlayFS, according to Documentation/filesystems/overlayfs.rst,
  section "Changes to underlying filesystems")

Now, as usual:

* Do a rename from merge_pl1 to merge_pl1_renamed.  Because the
  original FIFO came from the lower layer, and modifications through
  OverlayFS take effect on the upper layer, this creates the whiteout
  in the upper layer to hide the FIFO in the lower layer.

I also started using is_whiteout() and is_missing() helpers to avoid
the repeated stat() dance - it reads a bit closer to the test's intent
that way.

> > +	ASSERT_EQ(0, mknod(merge_fl1, S_IFIFO, 0));
> 
> The mode should be 0600.

Done.


> > +	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
> > +
> > +	/*
> > +	 * Execute a regular file rename within OverlayFS.
> 
> merge_fl1 is a fifo.

Done.


> > +	 * merge_fl1 originates from lower layer, so this triggers a copy-up
> > +	 * and creation of a whiteout in the upper layer.
> > +	 */
> > +	EXPECT_EQ(0, rename(merge_fl1, merge_fl1_renamed));
> > +
> > +	/* Check that the rename worked. */
> > +	EXPECT_EQ(0, stat(merge_fl1_renamed, &st));
> > +	EXPECT_EQ(-1, stat(merge_fl1, &st));
> > +	EXPECT_EQ(ENOENT, errno);
> > +
> > +	/*
> > +	 * Check that the whiteout object on the underlying "upper" filesystem
> > +	 * exists after the rename.  This is OK because it was done with the
> > +	 * credentials of the OverlayFS.
> > +	 */
> > +	EXPECT_EQ(0, stat(UPPER_DATA "/fl1", &st));
> > +	EXPECT_TRUE(S_ISCHR(st.st_mode));
> > +	EXPECT_EQ(0, st.st_rdev);
> > +}
> >  
> >  FIXTURE(layout3_fs)
> >  {
> > -- 
> > 2.55.0.229.g6434b31f56-goog
> > 
> > 
