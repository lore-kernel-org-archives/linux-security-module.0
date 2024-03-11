Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD951400A
	for <linux-security-module@vger.kernel.org>; Mon, 11 Mar 2024 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147699; cv=none; b=hhu6G5QvXrQG0KZjt52baXlYAv0XT660wQdgrOiN9XZyhNlIDgN48Vsq4FXqG38rDbJ0cLz2kBon+hP9hBIRxNQZMb52xEKrLMdklXVhgfgr7EewJ69DaMr/HTZtXeBUYbaKkjkrRrQ0o8ZcAf22qT9L8QXQod1Q/j+ZhecYlOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147699; c=relaxed/simple;
	bh=JfwTTCLOqEfgrt/PX9g87s4Mxsrv38DsubnJRw0ifsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PCqjQrWhC3AGMzCXIg1yMi+xEWGP1Q7anJfW5GILIJLh8ujiAAKHA5a/+6Srzvnm6R0fTj7Jg7tHmZiWNOEXrdWVktDmiiAV4+qUL7y4IEuMrfJLeSkhgfnSx27z6gDRQ2pQllUIwzqrzTOGikqzGcuoYNSSvc0ZKNYwU6ZPBNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HSAxTQld; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HSAxTQld"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a3fb52f121eso227004166b.0
        for <linux-security-module@vger.kernel.org>; Mon, 11 Mar 2024 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710147696; x=1710752496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CC0Q1pEzKDNX7j2YClNoPuJpJrn1UTfdSy4ZZik0DKQ=;
        b=HSAxTQld7EZfY9e0fuiAyFG12+zhPNAA1BC6dsN1CbKl1DM9osmdRMxaeEEY7Z/SoV
         I4Ii13AajhCcIi3uN49yHdlvsJT5GRQAVH/X6nymWJLetudwLTBPbpANmkpGGP4gvsT6
         dn/SJ6lx/b6R+gxDajwTG9CPHVfJyFIaHlVwxWn8PmoKtUCWtFEc1NXMTkcYUv/6OmBQ
         hyNfNYKNzB1CgOtJ9sG5GAnA51zXfE+ALw/8fCNcVyYQZa88LbUXKEgwGtgXyxfFuonG
         eaBgJBQyrMiumxI+S+qo4n6LmWYcrKKmH9UowxFSwwSt6miQucamABBFHJwCPugej7JO
         zNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710147696; x=1710752496;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CC0Q1pEzKDNX7j2YClNoPuJpJrn1UTfdSy4ZZik0DKQ=;
        b=CL4iQOZIg0HxROrQC9+unE4gpufxrz6lepo2sibwPUHnnvbpj+uOmWp0/VxSpO897C
         VpS0x0jTjiuRqSXo5LokWiQlMakFEWjGhj6RHgrNz7RheU44HlkDCfsppiAN0H/WX0ZR
         aBoRLuQkxiG/8CimCRKGpU5GTvZHTXVCoKI0XoVnsnLZggS49rXQkV/MFK80PLMXAfXM
         vnrkvu85WZFoj3PZBjax7EHrruYxTYyqK5PhWF3isG80NUxQ5Y1DEbrEwyj1BksjCth2
         nz9UCuaur060Yh0h3nk2dlpXgahKcJIY6lT7izRe41uxapzc7x6galFT9CiJJwd6mEiJ
         MIuA==
X-Forwarded-Encrypted: i=1; AJvYcCV8h9Q4R24dbSsWIXMGOi/GqXIWYCHomgL5Zda7XolDvRDWWHj625sqerz3epCgwNllJY4PjYJxieYc5WvqE+CDjwSXhdu0TzDXU9fPiyfvgsKwJuW6
X-Gm-Message-State: AOJu0YysIrr3pO6BDEdgxzibg0Gn6kzcM9+SoItNENbrvuqUARzkZScy
	p5B9f4YKBrTFu0Fg2YYP5Ry5JHryVHcvD3k7gJ5HsitFfEVmTMRS0FDD6xJhf60Yc0tOi680Y/h
	DPA==
X-Google-Smtp-Source: AGHT+IGGcdFW/ZUKsU7Eqq2e+deGlpp78HmTn8ThbeXCnnjpfdN6SevQxLABg0gWqETXEjDlkxrqxwSyI7A=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:907:9711:b0:a46:130a:44c with SMTP id
 jg17-20020a170907971100b00a46130a044cmr19194ejc.9.1710147696259; Mon, 11 Mar
 2024 02:01:36 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:01:33 +0100
In-Reply-To: <Ze5YUUUQqaZsPjql@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306.zoochahX8xai@digikod.net> <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
 <20240307-hinspiel-leselust-c505bc441fe5@brauner> <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
 <Zem5tnB7lL-xLjFP@google.com> <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area> <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
 <ZervrVoHfZzAYZy4@google.com> <Ze5YUUUQqaZsPjql@dread.disaster.area>
Message-ID: <Ze7IbSKzvCYRl2Ox@google.com>
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 12:03:13PM +1100, Dave Chinner wrote:
> On Fri, Mar 08, 2024 at 12:03:01PM +0100, G=C3=BCnther Noack wrote:
> > On Fri, Mar 08, 2024 at 08:02:13AM +0100, Arnd Bergmann wrote:
> > > On Fri, Mar 8, 2024, at 00:09, Dave Chinner wrote:
> > > > I have no idea what a "safe" ioctl means here. Subsystems already
> > > > restrict ioctls that can do damage if misused to CAP_SYS_ADMIN, so
> > > > "safe" clearly means something different here.
> > >=20
> > > That was my problem with the first version as well, but I think
> > > drawing the line between "implemented in fs/ioctl.c" and
> > > "implemented in a random device driver fops->unlock_ioctl()"
> > > seems like a more helpful definition.
> >=20
> > Yes, sorry for the confusion - that is exactly what I meant to say with=
 "safe".:
> >=20
> > Those are the IOCTL commands implemented in fs/ioctl.c which do not go =
through
> > f_ops->unlocked_ioctl (or the compat equivalent).
>=20
> Which means all the ioctls we wrequire for to manage filesystems are
> going to be considered "unsafe" and barred, yes?
>=20
> That means you'll break basic commands like 'xfs_info' that tell you
> the configuration of the filesystem. It will prevent things like
> online growing and shrinking, online defrag, fstrim, online
> scrubbing and repair, etc will not worki anymore. It will break
> backup utilities like xfsdump, and break -all- the device management
> of btrfs and bcachefs filesystems.
>=20
> Further, all the setup and management of -VFS functionality- like
> fsverity and fscrypt is actually done at the filesystem level (i.e
> through ->unlocked_ioctl, no do_vfs_ioctl()) so those are all going
> to get broken as well despite them being "vfs features".
>=20
> Hence from a filesystem perspective, this is a fundamentally
> unworkable definition of "safe".

As discussed further up in this thread[1], we want to only apply the IOCTL
command filtering to block and character devices.  I think this should reso=
lve
your concerns about file system specific IOCTLs?  This is implemented in pa=
tch
V10 going forward[2].

[1] https://lore.kernel.org/all/20240219.chu4Yeegh3oo@digikod.net/
[2] https://lore.kernel.org/all/20240309075320.160128-1-gnoack@google.com/


> > We want to give people a way with Landlock so that they can restrict th=
e use of
> > device-driver implemented IOCTLs, but where they can keep using the bul=
k of
> > more harmless IOCTLs in fs/ioctl.c.
>=20
> Hah! There's plenty of "harm" that can be done through those ioctls.
> It's the entry point for things like filesystem freeze/thaw, FIEMAP
> (returns physical data location information), file cloning,
> deduplication and per-inode feature manipulation. Lots of this stuff
> is under CAP_SYS_ADMIN because they aren't safe for to be exposed to
> general users...

The operations themselves are not all harmless, but they are harmless to pe=
rmit
from the Landlock perspective, because (as you point out as well) their use=
 is
already adequately controlled in their existing implementations.

The proposed patch v10 only influences IOCTL operations on device files,
so the "reflink" deduplication IOCTLs, FIEMAP, etc. should not matter.

=E2=80=94G=C3=BCnther
