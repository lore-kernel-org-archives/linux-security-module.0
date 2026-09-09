Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612D3C3F44
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983368; cv=pass; b=fSl9zC2wPwcOw90uJC8LVN2z4LBEysC44DH0o7EeMqtrTeGvZ3wZv6TfZWRKdhks0cLjqWqjfJlNrBBAy2FDvUrgUt9DCgHRYJxECiAiTY6hW6Kl3AD9K439ozNGl+uPBjW3Wr+e9zdgA8ibDTy/YZrW4G5DVJRhpCkI5sToA9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983368; c=relaxed/simple;
	bh=i63kkYRN+s0Z6WIOGfVRLoULhk9JW5XKXKE6rv83tEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCJ/X2GZ4DjMZ6Zl3y5KPwNT69XqfrPz7G4TVAVrtSJpycm/0Exj6rnA8pJhmFGPG1aJ1DzneK3k+mCsgAZY8ve0QuBbBHLhMqlWhP7wie19VX5cB4uY5LhGIf8pFnCY7jy+cFp2c8SBh8W7ZbNL4VbWsn04Xw97PT4qd6YpZW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Vy+DOp/v; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Vy+DOp/v"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso8560382a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 12:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788983365; cv=none;
        d=google.com; s=arc-20260327;
        b=i+g+ypCxZQ8g741NLQ0FILW5EnZK+6Kx0ey8KY2Jbk2pa6kHYo+ZJDEna4wwOP+v/N
         GMO6x6qnvuzaZOxzm3VGcJFNvdHrKqKQBSEbP5D1ne7RweX1q3a7RDMhW9gtWO86qFbs
         7kVD45/eQPnAMzKVsV0FN0yQb0pmuWxWBa0imNq1eeIkwzd7QG5wtpNPpr8psOmygRWi
         YN023Qpky7AmPhpej0BdLPdex6784dHsiUfNbZ20q1Sv4lssExDHdZ/c9rDSInF7/sLu
         ETRzrJItxmx5Wp9xucP2kvRaEQ4AFPDqOdDzt1NIWwO+XdbmJyTCvChw8Rb5YuvrBDuV
         MiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kxHsThRV7xoUza64gH6LQVWpwNMtliqmldDr2tNl4fI=;
        fh=zt7r2znfwV3d+ZevIdjFifFXFhcbkv1RxC8m78vpeso=;
        b=SOIKGyc0uk1chmRP7f7riXEkjNKuzw/1aFmkeJ24IpOLyY6TL0z9+auFW8+P7T8A+D
         h7kjsK/dzVdfVYO6xXurmE403UrIkbymtQS6/DQgk0sjdNdFS3fudzFoRei4FsV2mHsF
         IUDV4aBO09Hq4wxZkA/onAdjOX0Q9KB9ObPLgCb/hkyBomVEj6/dE7FbUN1YLRy3Jz1C
         MoT0dH3ZbrTRxhuDS76O9DwUMgFlRmvi4BRFessUF3tzCDrAH/mkfaBEY/heFDh4KBhB
         lxGfdTbWJysJEId1ROrVFTbVuLbkmFs031UM0f1FcUpDXWWt/NEGSQbPcmib/aZHa08z
         ktcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788983365; x=1789588165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kxHsThRV7xoUza64gH6LQVWpwNMtliqmldDr2tNl4fI=;
        b=Vy+DOp/vjEHIbXQvjo4ifi2hdshUzJe4H+hOiJozAuGmTIXFFEsLYZRo7d6DypDbcM
         DOSOosKTICVVCMj3zZunPcijPljaagq2pSorME79SLUPNOFpLZqBBqGAZL//YaHBKVcg
         DSa0KY4WeidcW18GK61Ke/LJHlFmoIVDLKqIZq+qF032JAK33h/ORbBnRh86A/+CkxGE
         WjTHooB51REVgbYEGRyE73+hks0wDV52Fgi6rAA08BctzeJIYvptI5N3Ohlkp5KcrBO5
         jLz6x7m952NTwkbTm3rDHWojA6HryvMjNkk6+Fbyl5kpo+54WhsJ8aXJRLkgNlvUGdQ5
         I9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788983365; x=1789588165;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kxHsThRV7xoUza64gH6LQVWpwNMtliqmldDr2tNl4fI=;
        b=lXXxpvNeoCw+KNuWN65WIDEkL0cuAFWyohxr6Iul09OPlenD4+47Dp+IBbtPMSC5OP
         /mj7YFXRrgpsR3fVTJs89NJ8hO9znRXA7ku73jaFT2PqFjQZthyZZZ6oWnTNU/33hMlh
         4uZu/7lhymsWAsiYeYJrpQVPCUvY0G5IDosOma9e6DI+R15XxzStASd1cGtE4fJA0YKP
         U49d9EZ/1ZGc8l1b/4Tw3HACPNtz08rNeYpDOhZuNUWdsQcd7WYmt+qjN/j1aTnWCNlG
         qZ7nLt8X+nQEp1VHVVZgEKD3K9sd/enkJbGafxoWzcBIGsP97H5Kj2D1r6hmwWshStD0
         Xwkw==
X-Forwarded-Encrypted: i=1; AKwUvBxHlZ8pFceFuykrglCuKjtXTL+5BHoC9AheC6+4iHxTnBnp80XLIiZSWj5yCEaH4mEAmEG829EH0TbPBrmgkvLr8as+cKA=@vger.kernel.org
X-Gm-Message-State: AFuF++nAXdbsf5xyJcoPlUz48FG/8cHP4397AnfXR98XZgjiXC5jF3ZJ
	vY32R/qm9V8jJLUJdgL16ORedBlRdYK5Epqj74PSTN6gpRGlWpQejN5yejuwq8uJGi8vwwJ7M/w
	uw8pJ0Bdd+E55h3c+YIEP3u8XZPwD1niFiBLFxzEo
X-Gm-Gg: AYBFou1EUgFlh32jy2BL2Qc/bjIYAn//KzYC5gNvQA9XPcNwxBLy5kxzWPM2DsfGd82
	jOS2BDkicw5jbB3U1KAWr65SF2f5MR8L3SMAv9+ipcMxpGXf82KcprHV10unETJ3v9eyIu8BCJB
	KgUZd3uMVsb4igb+bd4Z5ORJ5ujap+bpoSJ80xg7QDdmyWwYX8SvTll4eUhPT225Ve8qjbf3Bde
	crqJKY4Za9m7uFHA4lIYimeaj3jAGNQdH1hl7wMrre/vAMztBp1E1dv3mk4guykq8lg06mRpin9
	bpgCSya/nGQL9S9Jx0Ypev4Qux+9hRDyyzMojeLYRqavWakBVttDPuXBTwrB/6j8ZEpJsI8E3Gm
	Bh+trO7eLirg=
X-Received: by 2002:a05:6402:2350:b0:6a6:37a3:2b0f with SMTP id
 4fb4d7f45d1cf-6a7e8d6e0cfmr12759887a12.8.1788983364537; Wed, 09 Sep 2026
 12:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726161400.3010511-4-mic@digikod.net> <5cabf9b33a20f130cedcc423b8b2d151@paul-moore.com>
 <CAHC9VhS_WP-bLgMGiFAfE1MT76iKvVJ-OV5r7xju-KMdrfjssQ@mail.gmail.com> <20260909.quahcia8aiF4@digikod.net>
In-Reply-To: <20260909.quahcia8aiF4@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Sep 2026 15:49:11 -0400
X-Gm-Features: AcwNN1UQqkyFo5vvQsxzjUKUnny07mGrmWOQtO0xD7Tk7ZJkJIAuTKutOi4gn-Y
Message-ID: <CAHC9VhSRV_axaGM0hTZngQY36Jw1ULy_sHHsik0_HCSdVv4P+A@mail.gmail.com>
Subject: Re: [PATCH v3 3/12] security: Add LSM_AUDIT_DATA_NS for namespace
 audit records
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Daniel Durning <danieldurning.work@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 2:35=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Mon, Aug 31, 2026 at 05:26:20PM -0400, Paul Moore wrote:
> > On Tue, Aug 11, 2026 at 4:16=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Jul 26, 2026 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D =
<mic@digikod.net> wrote:

...

> > Micka=C3=ABl, if you would like me to merge the remaining patches in th=
is
> > patchset into the lsm/dev branch just let me know.
>
> I'll send a new patch series soon because this v3 would not apply
> anymore.

Okay.

> I'll include your lsm/dev patches to keep a consistent patch
> series.

Please don't as those are already merged.  If you want to stick with
the same patch series, which is fine, just note that the first three
patches have already been merged into the LSM tree.  It's not uncommon
for patchsets to add or drop patches over time as both the patchset
and the surrounding environment progress.

--=20
paul-moore.com
