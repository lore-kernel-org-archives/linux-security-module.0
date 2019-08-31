Return-Path: <SRS0=v43H=W3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BD7C3A59F
	for <linux-security-module@archiver.kernel.org>; Sat, 31 Aug 2019 09:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338E622CE9
	for <linux-security-module@archiver.kernel.org>; Sat, 31 Aug 2019 09:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfHaJui (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 31 Aug 2019 05:50:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37128 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbfHaJui (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 31 Aug 2019 05:50:38 -0400
Received: from [2a01:e35:2fdd:a4e2:a32f:3987:acd6:ed7c] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1i401h-0002Xs-7y; Sat, 31 Aug 2019 10:50:33 +0100
Received: from ben by deadeye with local (Exim 4.92.1)
        (envelope-from <ben@decadent.org.uk>)
        id 1i401g-0004Ct-It; Sat, 31 Aug 2019 11:50:32 +0200
Message-ID: <f2a2ba9da5b55cae57f1aa62983a7e6598aca128.camel@decadent.org.uk>
Subject: Re: [PATCH 1/2] staging: comedi: Restrict COMEDI_DEVCONFIG when the
 kernel is locked down
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ian Abbott <abbotti@mev.co.uk>, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Date:   Sat, 31 Aug 2019 11:50:27 +0200
In-Reply-To: <ea330943-9d3e-d01d-a6cf-8de08e042ec6@mev.co.uk>
References: <20190830154549.vss6h5tlrl6d5r5y@decadent.org.uk>
         <ea330943-9d3e-d01d-a6cf-8de08e042ec6@mev.co.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-LMS0wOuOP7mRsrP2XxBq"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a01:e35:2fdd:a4e2:a32f:3987:acd6:ed7c
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


--=-LMS0wOuOP7mRsrP2XxBq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-30 at 18:35 +0100, Ian Abbott wrote:
> On 30/08/2019 16:45, Ben Hutchings wrote:
> > The COMEDI_DEVCONFIG ioctl can be used to configure I/O addresses and
> > other hardware settings for non plug-and-play devices such as ISA
> > cards.  This should be disabled to preserve the kernel's integrity
> > when it is locked down.
>=20
> I haven't boned up on the lockdown mechanism yet, but just FYI, this is=
=20
> only possible if the "comedi_num_legacy_minors" module parameter is=20
> non-zero (which it isn't by default).

So do you think would it make more sense to set the HWPARAM flag on
that module parameter?  That should have the same effect although it
doesn't seem to quite fit the intent of that flag.

> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > Cc: Matthew Garrett <mjg59@google.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Ian Abbott <abbotti@mev.co.uk>
> > Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> > ---
> >   drivers/staging/comedi/comedi_fops.c | 6 ++++++
> >   include/linux/security.h             | 1 +
> >   security/lockdown/lockdown.c         | 1 +
> >   3 files changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/com=
edi/comedi_fops.c
> > index f6d1287c7b83..fdf030e53035 100644
> > --- a/drivers/staging/comedi/comedi_fops.c
> > +++ b/drivers/staging/comedi/comedi_fops.c
> > @@ -27,6 +27,7 @@
> >  =20
> >   #include <linux/io.h>
> >   #include <linux/uaccess.h>
> > +#include <linux/security.h>
> >  =20
> >   #include "comedi_internal.h"
> >  =20
> > @@ -813,11 +814,16 @@ static int do_devconfig_ioctl(struct comedi_devic=
e *dev,
> >   			      struct comedi_devconfig __user *arg)
> >   {
> >   	struct comedi_devconfig it;
> > +	int ret;
> >  =20
> >   	lockdep_assert_held(&dev->mutex);
> >   	if (!capable(CAP_SYS_ADMIN))
> >   		return -EPERM;
> >  =20
> > +	ret =3D security_locked_down(LOCKDOWN_COMEDI_DEVCONFIG);
> > +	if (ret)
> > +		return ret;
> > +
>=20
> You might consider moving that check to be done after the following 'if=
=20
> (!arg)' block, since that should be safe.  (It detaches an already=20
> configured device from the comedi core.)
[...]

How would it have been configured, though?

Ben.

--=20
Ben Hutchings
You can't have everything.  Where would you put it?



--=-LMS0wOuOP7mRsrP2XxBq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl1qQuMACgkQ57/I7JWG
EQneEBAAqSvxv5dpkVhqd5ebs1//SeV9wAt43pVc4QRHsORTQaIHPifIeC6ehWlL
v3rFF0IRjfD+gYvQnd80Qc04ACuds+sD6+ytAXq9swsZQxVfQPPbiV9FITuEE9KB
fZ4nedLRqMwlv2hhqEUz9xhN4sVwRrvc9H3/0RIzwsHv0//UGZvefgK0UVuqy7P/
7OhpBdzDshRFKaL/iUTh6Exq9Dqp9uILHidioxUFthpftOTmDjq44phqc8Z56iog
T4d+XszPdRUlQE2NR7eOUkz4YX/bpWtXaEj0SA0OQBRImaYD9QtCmpurVKJExInQ
XsodPRyF3ZHr+Ww+nicpMQVVGwWtesFeX5bu7sT/0FscT1wtS0How4kSG+0ZJfNm
SowVRCgQtVWKHN67onrvubG3EWNX8YbyA5voTuypv0e687QkEzCWCAhPFPJ8TmzY
TfIevx0YG5OaxUAovj/1z4t/UJ+v43MW+rxtxgFAkRLIsW2gPVX8YIdQPEZ0q60j
WGkFcty1R1YlWAlNnBJ5WzM4QsAlvP5L+CnnpEOqYDwG7pSEzU+Z3bsU7Q12ANwW
mPqTSgtotIcMzKZ2EOZQBWqZdZLPaEXGU1RFwH26q76ElQh1X0ORkivCdty/+UbU
6mD/IDZMIfHYOYD/Px2VesrOtJ0PXU4OjkxSAqYw7clbVwneO7Y=
=IDDw
-----END PGP SIGNATURE-----

--=-LMS0wOuOP7mRsrP2XxBq--
