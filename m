Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DB515E218
	for <linux-security-module@vger.kernel.org>; Thu, 18 Apr 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438610; cv=none; b=NvOSO75+FNLI/HfrM1S4PkT62DRzgwp/Nglvt2z2Wajp8+gwHBIRFX062djzWJ3oSUJAEFcRlYBm49feAVbCvaCFTEjvVEO7vJyq303Qm01L6CuqwQSBsNRSQYcQLneNPqp529VrdgLijBwmvJsX5j9/7WjMYiozucKN4OjZOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438610; c=relaxed/simple;
	bh=npfaqdhJbMZP1tJoKVECZi+mv2A0Gwc10D5of/54RG0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pOOslincNr+J/XafzUmf1VaScoTr1yIclu4wWIqpih0sllZnIt0whs+2k2UiFMJ91qGnCNRSgv3G83XfHrHNF43d89N+T1QbAfa7uedyuocjXdnDwXFc7IOTo+vEB7EzowrKgetjaH6ZIQ8MR8jDq3id30Rb5mfBonn0OopHQEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drA5tBeP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drA5tBeP"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-619151db81cso23729997b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 18 Apr 2024 04:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713438608; x=1714043408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/O/io06BoHx+EQzwCObOzbeI1xhmJNh9rex6GUYRhI=;
        b=drA5tBeP++y8XI3yBcHAHF7WESZADd+l399xuhAw+NDJnnf4lmEPB+G5CyUyVTTjw6
         IIh3rvww3swNjER86tojmbLUMymrNoTmZIuZiAdmux410A7rJU3CztSXLSnVCFp7CckC
         DVMvJFvn5QAloXok1er/aHv9FUpIIhMN/vN1elE6g+gIIDipU8SeDRH00I8poDyIEEub
         dLBxPLCFh5QEIL0BQvA9FQMXPush77VzVyNk30ymYQTwxeAS91V8fRYvzrDc7s2xI/jU
         DJU1WGjeThIEd+AG8yjGQxKadfLWteoEZw1dXsWL+4l9lWXWrf7/VrAsjQvG4O1LTKwM
         wcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713438608; x=1714043408;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G/O/io06BoHx+EQzwCObOzbeI1xhmJNh9rex6GUYRhI=;
        b=HTWRkqc34GHJnxhmnK6tcC+O+z+JMEhBc4LkoMELn1K0eLg9utZQJOVPy/osME4VL+
         SG518R4b/A892seMHAto5QveZ5Z17c5yXpnQPVNm9LfM6u1GDaVUNpKszEOpaVOKXZb0
         xD+luGbfLvNDd/147oQ0/6TbXan704Uy/vDaFS4IghYbWVpHLUprKeg9CvXfCdHKo1WL
         E60ZCuvZ0XHsH2ckDkA9MkuyGYB7c6wVIwLgkOB5TNOGgFv5zSU2rttjoerr3HLy/ar1
         mHi8H9xqQ54Jq1AWVHtt5kJ+QENavFUXzrSMSEwJbrQDcNS7DgoccFCK+l0XHw8u9LZ2
         DmOg==
X-Gm-Message-State: AOJu0Yzb/9+gi/vnAUnVrFYxvs5pO6dMU8BjPcjy8f7vFyr7rrBTukkX
	tK6xSzKmGLGpWvQ/ixN6Uj35RQjh+dcsRPeC1k+/Bq+OEXuwYxnH8rSCe+E+y485VdvyU2R/Ppp
	TZw==
X-Google-Smtp-Source: AGHT+IHi2BsgqxHM/izivqAuFc0apv16UHRdpgcbVvY53tAbRAJvOBK3/gxs01k6yyKroqs0OKxD+qFwAd0=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a25:d612:0:b0:dc7:4ca0:cbf0 with SMTP id
 n18-20020a25d612000000b00dc74ca0cbf0mr441230ybg.3.1713438607959; Thu, 18 Apr
 2024 04:10:07 -0700 (PDT)
Date: Thu, 18 Apr 2024 13:10:05 +0200
In-Reply-To: <20240412.ooteCh1thee0@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com> <20240405214040.101396-4-gnoack@google.com>
 <20240412.ooteCh1thee0@digikod.net>
Message-ID: <ZiD_jZ8AfhPWRLOT@google.com>
Subject: Re: [PATCH v14 03/12] selftests/landlock: Test IOCTL support
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 05:17:44PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Apr 05, 2024 at 09:40:31PM +0000, G=C3=BCnther Noack wrote:
> > Exercises Landlock's IOCTL feature in different combinations of
> > handling and permitting the LANDLOCK_ACCESS_FS_IOCTL_DEV right, and in
> > different combinations of using files and directories.
> >=20
> > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > ---
> >  tools/testing/selftests/landlock/fs_test.c | 227 ++++++++++++++++++++-
> >  1 file changed, 224 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing=
/selftests/landlock/fs_test.c
> > index 418ad745a5dd..8a72e26d4977 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
>=20
> > +TEST_F_FORK(ioctl, handle_dir_access_file)
> > +{
> > +	const int flag =3D 0;
> > +	const struct rule rules[] =3D {
> > +		{
> > +			.path =3D "/dev",
> > +			.access =3D variant->allowed,
> > +		},
> > +		{},
> > +	};
> > +	int file_fd, ruleset_fd;
> > +
> > +	/* Enables Landlock. */
> > +	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
> > +	ASSERT_LE(0, ruleset_fd);
> > +	enforce_ruleset(_metadata, ruleset_fd);
> > +	ASSERT_EQ(0, close(ruleset_fd));
> > +
> > +	file_fd =3D open("/dev/tty", variant->open_mode);
>=20
> Why /dev/tty? Could we use /dev/null or something less tied to the
> current context and less sensitive?

Absolutely, good point -- I'm switching to /dev/zero.

I am dropping the TCGETS test and only keeping FIONREAD,
but these two IOCTL commands work the same way as far as Landlock is concer=
ned.


> > +TEST_F_FORK(ioctl, handle_file_access_file)
> > +{
> > +	const int flag =3D 0;
> > +	const struct rule rules[] =3D {
> > +		{
> > +			.path =3D "/dev/tty0",
>=20
> Same here (and elsewhere), /dev/null or a similar harmless device file
> would be better.

Ditto, /dev/zero it is.


> > +	if (variant->allowed & LANDLOCK_ACCESS_FS_READ_DIR) {
> > +		SKIP(return, "LANDLOCK_ACCESS_FS_READ_DIR "
> > +			     "can not be granted on files");
>=20
> Can we avoid using SKIP() in this case?  Tests should only be skipped
> when not supported, in other words, we should be able to run all tests
> with the right combination of architecture and kernel options.

Good point.  After double checking, I realized that this was left over from=
 an
earlier test where we still had more fixture variants.  I'm removing that c=
heck.


Thanks for the review!
=E2=80=94G=C3=BCnther
