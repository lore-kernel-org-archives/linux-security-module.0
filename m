Return-Path: <SRS0=YGRx=XF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A17C49ED7
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Sep 2019 23:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F29216F4
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Sep 2019 23:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfIJXnn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Sep 2019 19:43:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53594 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbfIJXnm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Sep 2019 19:43:42 -0400
Received: from 92.40.249.110.threembb.co.uk ([92.40.249.110] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1i7pnL-00040D-BC; Wed, 11 Sep 2019 00:43:35 +0100
Received: from ben by deadeye with local (Exim 4.92.1)
        (envelope-from <ben@decadent.org.uk>)
        id 1i7pnJ-0001mT-5q; Wed, 11 Sep 2019 00:43:33 +0100
Message-ID: <cc538ddebead346bc622adc8f163427458fb5c6d.camel@decadent.org.uk>
Subject: Re: [PATCH 2/2] mtd: phram,slram: Disable when the kernel is locked
 down
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        James Morris <jmorris@namei.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Joern Engel <joern@lazybastard.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-mtd@lists.infradead.org
Date:   Wed, 11 Sep 2019 00:43:28 +0100
In-Reply-To: <CAFLxGvxRVwt0=wtKJnZB6s+VDCoGT3vsW27P2MECO999sJKAHw@mail.gmail.com>
References: <20190830154549.vss6h5tlrl6d5r5y@decadent.org.uk>
         <20190830154720.eekfjt6c4jzvlbfz@decadent.org.uk>
         <CACdnJuutzv+0nPKeizsiaix5YtYHU4RSoH-hPFfG1Z8sW_yy2w@mail.gmail.com>
         <alpine.LRH.2.21.1909100816170.3709@namei.org>
         <CAFLxGvxRVwt0=wtKJnZB6s+VDCoGT3vsW27P2MECO999sJKAHw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-r8SF5OwVuFn1THoEmlQI"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 92.40.249.110
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


--=-r8SF5OwVuFn1THoEmlQI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-09-11 at 00:18 +0200, Richard Weinberger wrote:
> On Tue, Sep 10, 2019 at 5:17 PM James Morris <jmorris@namei.org> wrote:
> > On Tue, 10 Sep 2019, Matthew Garrett wrote:
> >=20
> > > On Fri, Aug 30, 2019 at 11:47 AM Ben Hutchings <ben@decadent.org.uk> =
wrote:
> > > > These drivers allow mapping arbitrary memory ranges as MTD devices.
> > > > This should be disabled to preserve the kernel's integrity when it =
is
> > > > locked down.
> > > >=20
> > > > * Add the HWPARAM flag to the module parameters
> > > > * When slram is built-in, it uses __setup() to read kernel paramete=
rs,
> > > >   so add an explicit check security_locked_down() check
> > > >=20
> > > > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > > > Cc: Matthew Garrett <mjg59@google.com>
> > > > Cc: David Howells <dhowells@redhat.com>
> > > > Cc: Joern Engel <joern@lazybastard.org>
> > > > Cc: linux-mtd@lists.infradead.org
> > >=20
> > > Reviewed-by: Matthew Garrett <mjg59@google.com>
> > >=20
> > > James, should I pick patches like this up and send them to you, or
> > > will you queue them directly after they're acked?
> >=20
> > As long as I'm on the to or cc when they're acked, I can grab them.
>=20
> Acked-by: Richard Weinberger <richard@nod.at>
>=20
> BTW: I don't have 1/2 in my inbox, is it also MTD related?

No, that was for some other drivers (comedi) that allow setting I/O
addresses from user-space.

Ben.

--=20
Ben Hutchings
The obvious mathematical breakthrough [to break modern encryption]
would be development of an easy way to factor large prime numbers.
                                                           - Bill Gates



--=-r8SF5OwVuFn1THoEmlQI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl14NSAACgkQ57/I7JWG
EQniDxAAr+0WIc1dyucvMVNiLMc5RYy2P5rKBbh6m+3hrxbrXA6aw4RWpZsVwVSd
tJ0hd0Errn2gzOlZNSNSWnJsvT+6ZRU5g3b2ZQLUsw1okJU9rbSTQgyTOagpEiao
bsonp3QtoNsN/UECYd9kwte81lINpNXfb9FeJqY7REhg092QDms17pRi8kVrm4cH
d/6U2PR3wPMcYyx4plgKrJU+GZROpL/Owp8AZhtCd9G4ROFhqhVBAMS+R2QNpdX0
ds61ZB42oCWUrRjbUGWkrjU9koWslayCUawEQeIFMNgkohrT4bVGUnxySPSs1SZp
xmpJbuVxA5dG/2wBpO4xzw1PhaPZkwQx42SXRvkdPzzUzpQbteR8u6BucTMk18KO
Y9NTCHSSCsYn8vznU1VGt2amdA/popmBEGznHAdQnbbdv0lmcOutTfHEpSoUCtNw
4VP9gqGKVyYQ24LIOQ2Yyn8KDdBnWOQQbXs/Pwe1rSOVUbzF/pgPkejEvkc2ndit
Kq341FGr+n7hGnxtcSwidg2Bg8BgJy/kuDr1X7TxeEG99qk7R8vfNUW7Rwn9ypa8
jNkUGX7c0DlmFdkjonaA8vzuVcqhjATlc0GZyhu1VpvrZ8dAZD9AgAAbfRjS0ANy
lu1lzTmlXt0uuQGYscMcCW3NzrKWFFcMvx9cZ62GcZZ0uJ0PulY=
=5rjt
-----END PGP SIGNATURE-----

--=-r8SF5OwVuFn1THoEmlQI--
