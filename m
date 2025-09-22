Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3B1304BDF
	for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544459; cv=none; b=enWD88FkN8+pq56/rtyq0rD459JIEzrm+pttik79t3fUDlwEqUtI9F93QVi0ZNsA4BE4rRynHFhtG/BtrGa3DNwos+cvlW62zr19k9LyMFhi1izoe4tD9i6mOHDY9Y5XaO2YkQsyTavKZADvktFFq90GjDcmhb0YoPlVV05e8Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544459; c=relaxed/simple;
	bh=ys4IEoI+fdLVxLUuxJrPv2vA1+IDivHuaUVkT1Fa8W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDUWDj+/tD6H2NUObAjn8E7dS2XyWW075igNUeyeY3gCxViFX73myvhwmnRXYD2B102KSgU1/fKmXljKeCLydyndA3ug238XB8mDgPNSAuhR1Bpi6Y5RC32PEg0+jc2gMG5DcnDM2ILy3HL+1NqRPlrtAJ1ui6ALbUshF6yTONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnKWf3f9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnKWf3f9"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so1237450a91.0
        for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 05:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758544453; x=1759149253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNq/C59VuTgRCn+nlqpjLe4b5aVpPSyRTgdZcEzYFpA=;
        b=NnKWf3f9JLbhDurAKtmSidZidQLjQDmIWh+dkaIsYa/dr6Ymul0jwcB94JBDpEIan+
         PzuxSyqXjGbc+8N9tvXJh5MN+aYar/g4CZBRuuTlVAKQq5oMsA1ap6zjJT6oWLZLmvr5
         KKkhYDYkBirLrmp0ZTGls6VGKDjesUzZksbbMTfibz5B8xgXgQL0wT9gRZxRUbowi6cT
         MhptO8yyTVzP5sJaSddSAMbAn3lAxL0C4eH7frcttexo3ZAinW9hpHq7tm0kEtokp4Cg
         rx3XZiwqEU8nHyHdmDj9R3tc3M36uyGN9Tpqpsq8qJSR20YxwjoDY5GohLiCQgNWV3yH
         +UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758544453; x=1759149253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNq/C59VuTgRCn+nlqpjLe4b5aVpPSyRTgdZcEzYFpA=;
        b=TtQB/NLW8ZovE01895UERPvzRRDMfj/0d73JglrEFZRqnAE9lru3Fbdc8o7jT5FBmz
         MTuqYrP5CME5U+pujxlSC+MlP4+f5cuSE1BFSZNcB1/QtHfvvjGWJmGJa3L186l6CrjZ
         80F7FRPgNbJGNfBMfWgrlT37wTMRk7YUacbpLrA4Jw481CTEVJdW0bMwb5GWOrxx+Tjp
         S/4SQbIwIC6p2ghq6Qff3s6s4dIFw47gjIQrwXl1CFH/Komgqk3oQKRrRoYGwUGHNUgc
         lffGvMgrynaBC08Lljp77daWHiNBdZ7UwOnPkoXnPDy4s4qWabzP/SqjeLx07QlMTHWO
         ZtwA==
X-Forwarded-Encrypted: i=1; AJvYcCWMMOBCU0tsCtilU185HGZTX8Jdgk+awqTXulJhhB/RGBnZheyjJeG6NdQX9S1r2i7US0c07nIrZlSN4p+XYU3Ms2TteAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygaR9XUHtP7jqS4iVlpT2xGFeRP+B/4+BLpEVgVLmE9HMp/tyz
	qnP4Y9X1t4UZ7QJr4HAIyCWwll5OO7TrAI3ZB5SsyGaBhUAhsN5V6exLXV6JZC+B02u7EBRb0Lz
	wNCPf5hgFH9BmhgpvavwYIe90s2GHmiY=
X-Gm-Gg: ASbGnctHLoWynzR/YOeP5O6TzeZnVu0IlMcgVNBnZa4rlV2T18m/j3rY1uMk5swa08u
	oWB0rw8OHkb8OH1Nabv0+zY1PdHHb7l8RWV/9DvhQ0iksfcXQDEsvvEPuYwWHp3n2QIUFvPxyJX
	CAvDmVH/UJ4MV60xreOOzCbBwVQhjR12btAgrqxFDhjeyHh+BM+ViOcuOwLTMBc8SyTL5AXVqfO
	hoyLEg=
X-Google-Smtp-Source: AGHT+IEPnzETHfIgVe8rbYGpffEitkgUY5tbApm7qiaC9l5Nc8ofRpUyTQPO48qxBeA4pIWC06Mh2wcCe4/H5YFHFPg=
X-Received: by 2002:a17:90b:3d0f:b0:32b:dfdb:b27f with SMTP id
 98e67ed59e1d1-33098246affmr18469898a91.17.1758544453556; Mon, 22 Sep 2025
 05:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920074156.GK39973@ZenIV> <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
 <20250920074759.3564072-31-viro@zeniv.linux.org.uk> <CAHC9VhTRsQtncKx4bkbkSqVXpZyQLHbvKkcaVO-ss21Fq36r+Q@mail.gmail.com>
 <20250921214110.GN39973@ZenIV> <CAHC9VhSJJ5YLXZbB-SvQket-PJCv81quM6XLrBDc7+erus-vhA@mail.gmail.com>
In-Reply-To: <CAHC9VhSJJ5YLXZbB-SvQket-PJCv81quM6XLrBDc7+erus-vhA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Sep 2025 08:34:02 -0400
X-Gm-Features: AS18NWDPYNiBNGWS7nxHqJa1sonTvXEysr_U_r4l4cLpOAIMmTBrwipP0XT2NVE
Message-ID: <CAEjxPJ4Ez1oYXa4hEcSLSrO+ikLN0kgrWQc+2n2K7wWoy7a7pQ@mail.gmail.com>
Subject: Re: [PATCH 31/39] convert selinuxfs
To: Paul Moore <paul@paul-moore.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, kees@kernel.org, casey@schaufler-ca.com, 
	linux-security-module@vger.kernel.org, john.johansen@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 10:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Sun, Sep 21, 2025 at 5:41=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
> > On Sun, Sep 21, 2025 at 04:44:28PM -0400, Paul Moore wrote:
> > > > +       dput(dentry);
> > > > +       return dentry;  // borrowed
> > > >  }
> > >
> > > Prefer C style comments on their own line:
> > >
> > >   dput(dentry);
> > >   /* borrowed dentry */
> > >   return dentry;
> >
> > Umm...  IMO that's more of an annotation along the lines of "fallthru".=
..
>
> Maybe, I still prefer the example provided above.  The heart wants
> what the heart wants I guess.
>
> > > > @@ -2079,15 +2088,14 @@ static int sel_fill_super(struct super_bloc=
k *sb, struct fs_context *fc)
> > > >                 goto err;
> > > >         }
> > > >
> > > > -       fsi->policycap_dir =3D sel_make_dir(sb->s_root, POLICYCAP_D=
IR_NAME,
> > > > +       dentry =3D sel_make_dir(sb->s_root, POLICYCAP_DIR_NAME,
> > > >                                           &fsi->last_ino);
> > >
> > > I'd probably keep fsi->policycap_dir in this patch simply to limit th=
e
> > > scope of this patch to just the DCACHE_PERSISTENT related changes, bu=
t
> > > I'm not going to make a big fuss about that.
> >
> > Not hard to split that way.  Will do...
>
> Thanks.
>
> > BTW, an unrelated question: does userland care about selinuxfs /null be=
ing
> > called that (and being on selinuxfs, for that matter)?  Same for the
> > apparmor's securityfs /apparmor/.null...
>
> That's an interesting question.  The kernel really only references it
> in one place after creation, and as you've already seen, that's easily
> changed.  It's more important that it can be uniquely labeled such
> that most any process can open it, otherwise we run into problems when
> trying to replace fds when another file that the process can't open.
>
> I'm adding the SELinux list to tap into the folks that play with
> userland more than I do, but off the top of my head I can't think of
> why userspace would need to do anything directly with
> /sys/fs/selinux/null.  There are some comments in the userland code
> about not being able to mount selinuxfs with MS_NODEV due to the null
> device, but that's the only obvious thing I see while quickly
> searching through the code tonight.

Is there a reason why these patches weren't sent to selinux list in
the first place?
In any event, yes, Android userspace (in particular the Android init
program) relies on /sys/fs/selinux/null at a point where /dev/null
does not yet exist [1]. Hence, I don't believe we can drop it since it
would break userspace.

[1] https://cs.android.com/search?q=3D%2Fsys%2Ffs%2Fselinux%2Fnull&sq=3D&ss=
=3Dandroid%2Fplatform%2Fsuperproject%2Fmain


>
> > If nobody cares, I would rather add an internal-only filesystem with
> > root being a character device (1,3) and whatever markings selinux et.al=
.
> > need for it.  With open_devnull(creds) provided for selinux,
> > apparmor and whoever else wants to play with neutering descriptors
> > on exec...
>
> With the ongoing efforts to push towards better support for multiple
> simultaneous LSMs, we would likely need to make sure there each LSM
> that currently has their own null device would continue to have their
> own, otherwise we potentially run into permission conflicts between
> LSMs where one could end up blocking another and then we're back to
> not having a file to use as a replacement.  Not sure if that is what
> you had in mind with your proposal, but just wanted to make sure that
> was factored into the idea.
>
> --
> paul-moore.com
>
