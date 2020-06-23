Return-Path: <SRS0=CLHo=AE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6A9C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 18:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA0C207FB
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 18:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQc9p5oS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbgFWSOM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:14:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32636 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732981AbgFWSOM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Jun 2020 14:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592936050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9OSK+h7qYgAzWHaZZAbxLByby9nYNdBw4r3UMn9ujiY=;
        b=QQc9p5oSihfwNwBPwUG28JzrHP7pjTIzaYjGEMMZwWLjpn1EaKCilG7hJCn4LEXpOWi2xb
        O0en4p214HSfUXI+T5FUqJ9OAvG2nBsd1wJ2UMrn3vhDLqJ2468Cj+jxSIEhf34GwCrqW2
        y6bJR7oOgttUMYJ8P0CxR6RLsoOM6Mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-tzzgtOxxN4ePEPQjCDtjvw-1; Tue, 23 Jun 2020 14:14:02 -0400
X-MC-Unique: tzzgtOxxN4ePEPQjCDtjvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77D1C804001;
        Tue, 23 Jun 2020 18:14:00 +0000 (UTC)
Received: from localhost (ovpn-116-11.gru2.redhat.com [10.97.116.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72BAD60CD3;
        Tue, 23 Jun 2020 18:13:58 +0000 (UTC)
Date:   Tue, 23 Jun 2020 15:13:57 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Maurizio Drocco <maurizio.drocco@ibm.com>
Cc:     zohar@linux.ibm.com, Silviu.Vlasceanu@huawei.com,
        dmitry.kasatkin@gmail.com, jejb@linux.ibm.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mdrocco@linux.vnet.ibm.com,
        roberto.sassu@huawei.com, serge@hallyn.com
Subject: Re: [PATCH v2] ima_evm_utils: extended calc_bootaggr to PCRs 8 - 9
Message-ID: <20200623181357.GC4983@glitch>
References: <1592856871.4987.21.camel@linux.ibm.com>
 <20200623180122.209-1-maurizio.drocco@ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200623180122.209-1-maurizio.drocco@ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2020 at 02:01:22PM -0400, Maurizio Drocco wrote:
> From: Maurizio <maurizio.drocco@ibm.com>
>=20
> If PCRs 8 - 9 are set (i.e. not all-zeros), cal_bootaggr should include
> them into the digest.
>=20
> Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
> ---
> Changelog:
> v2:
> - Always include PCRs 8 & 9 to non-sha1 hashes
> v1:
> - Include non-zero PCRs 8 & 9 to boot aggregates=20
>=20
>  src/evmctl.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 1d065ce..46b7092 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1930,6 +1930,16 @@ static void calc_bootaggr(struct tpm_bank_info *ba=
nk)
>  =09=09}
>  =09}
> =20
> +=09if (strcmp(bank->algo_name, "sha1") !=3D 0) {
> +=09=09for (i =3D 8; i < 10; i++) {
> +=09=09=09err =3D EVP_DigestUpdate(pctx, bank->pcr[i], bank->digest_size)=
;
> +=09=09=09if (!err) {
> +=09=09=09=09log_err("EVP_DigestUpdate() failed\n");
> +=09=09=09=09return;
> +=09=09=09}
> +=09=09}
> +=09}
> +
>  =09err =3D EVP_DigestFinal(pctx, bank->digest, &mdlen);
>  =09if (!err) {
>  =09=09log_err("EVP_DigestFinal() failed\n");
> @@ -1972,8 +1982,9 @@ static int append_bootaggr(char *bootaggr, struct t=
pm_bank_info *tpm_banks)
>  /*
>   * The IMA measurement list boot_aggregate is the link between the prebo=
ot
>   * event log and the IMA measurement list.  Read and calculate all the
> - * possible per TPM bank boot_aggregate digests based on the existing
> - * PCRs 0 - 7 to validate against the IMA boot_aggregate record.
> + * possible per TPM bank boot_aggregate digests based on the existing PC=
Rs
> + * 0 - 9 to validate against the IMA boot_aggregate record. If the diges=
t
> + * algorithm is SHA1, only PCRs 0 - 7 are considered to avoid ambiguity.
>   */
>  static int cmd_ima_bootaggr(struct command *cmd)
>  {
> --=20
> 2.17.1
>=20

Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl7yRmUACgkQYdRkFR+R
okOyDwf/csNoUdXIxPrHGfJ/7A6nZ6PNHG8xsHJ4EJnjxXDY1FGIBRSqtVwMc6wY
09e1b2Q2c1j0qMtAx2PTJC7MXmQS9UFSIL+TEl+rZ6Z9LTK9x9xmop5Qt7EUqRA/
nxqU0nI2srqfwMtF0e7wxrfMQC8NzS3gTT5zWbrbLyq2ejgtunBSdrTJ8yWoMTKQ
EEMImoCdiNDoS3savbXfbie28gZcYYHZBmM4mbyvDVoGRrF4MztcvnJHtnbGgvST
+Do6Ti8LbLXdDUYJ0thiFO+NF+7pHMrZd6MWebse7s0cZw+nRk1Es2bQVNkpifK+
IXHJW7lwIgQCDIAPK5W1270X8m+zkw==
=jGnU
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--

