Return-Path: <SRS0=tSh8=ZL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838DAC432C0
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Nov 2019 10:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FF120692
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Nov 2019 10:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbcjTl6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKSK7N (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:59:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27994 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726170AbfKSK7M (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Nov 2019 05:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574161150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcSCJldT6maD3sRjZ6u34JTh/bpqrmp3s9QOjR8YF3g=;
        b=VbcjTl6BBwEYTAtl0VlARGyKt3pQmh4fxtQe970uXBzb/zNYgjlrus6IozbDMXcl//pYeq
        tqOvM3GI141kTBXzbYX2kLrwXtkXd+7SAAv3plp7/kBDy8yR29ye3kFrfVJb42E6ac0qlK
        QDwZXA8uI28uPoFXbVb33xoksDgTKRg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-uMndt1sIOUyVRiKPwWJuOw-1; Tue, 19 Nov 2019 05:59:09 -0500
Received: by mail-wm1-f72.google.com with SMTP id b10so2055913wmh.6
        for <linux-security-module@vger.kernel.org>; Tue, 19 Nov 2019 02:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+O6R/soBFYD12X1MgAjfaQ7P5JGyL71HVn0kuh7PmlU=;
        b=CCkxwEfrY4MDz0+6Ag+aQRQpJpiKn9tDvMQyeMoLPxj3dw/8uleHCmh4gjZeCJ4ojG
         mwrRXUc7MC4eUYfem759vSc4Q9XH5pqRlE1/rbSUKx7xBklDg2fPqvmDfBcFAq+h98Cx
         QSn2jqWNeqlAzZ2x4ZKDEQGb6h1qAHE2WB2CFXByqSU7F4S2SPxXRG3sW95zbryuRnNH
         KxsN0QchzXmmE4at2S4b2T4LCjxIhUmzqwvn1oVAd4/pB5K0jCRA4UkUo4SfQGGsKxr8
         X+uueZpAz4+sElNhExKZChWQUTl6ndkpSlgEgfEkBp8ylVyaCBo1y8nbsUsUFVd6/Srl
         Y0Ew==
X-Gm-Message-State: APjAAAWlE7ujtdxt9nceXpzJdmAlUUoQqGt/J4kr16/ToE4VkZj81WSj
        vVwdZy9QvyHlWdvpZYZt8ct0ZBeOSgMgkqtRhzNQuWZrm6oWd9U6cGy1f8Ea1jdoPznIE/xRCOs
        9eJT9/hB78Ttwh1vhbqMDx/Ye8kC0Dho97Rgz
X-Received: by 2002:adf:f147:: with SMTP id y7mr28916125wro.236.1574161147064;
        Tue, 19 Nov 2019 02:59:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqy9UFRbKj3sx7hWovwNUvGiJyD1UjDmbrBrlm8ghZfaoRoLDjAUL7iEvPbK9uT2jP2EeII5/Q==
X-Received: by 2002:adf:f147:: with SMTP id y7mr28916103wro.236.1574161146841;
        Tue, 19 Nov 2019 02:59:06 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id w17sm27975647wrt.45.2019.11.19.02.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 02:59:06 -0800 (PST)
Subject: Re: [PATCH] efi: Only print errors about failing to get certs if EFI
 vars are found
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
References: <20191119091822.276265-1-javierm@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <71e319d0-5fa9-f464-8546-b51629ae4ab3@redhat.com>
Date:   Tue, 19 Nov 2019 11:59:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191119091822.276265-1-javierm@redhat.com>
Content-Language: en-US
X-MC-Unique: uMndt1sIOUyVRiKPwWJuOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

On 19-11-2019 10:18, Javier Martinez Canillas wrote:
> If CONFIG_LOAD_UEFI_KEYS is enabled, the kernel attempts to load the cert=
s
> from the db, dbx and MokListRT EFI variables into the appropriate keyring=
s.
>=20
> But it just assumes that the variables will be present and prints an erro=
r
> if the certs can't be loaded, even when is possible that the variables ma=
y
> not exist. For example the MokListRT variable will only be present if shi=
m
> is used.
>=20
> So only print an error message about failing to get the certs list from a=
n
> EFI variable if this is found. Otherwise these printed errors just pollut=
e
> the kernel ring buffer with confusing messages like the following:
>=20
> [    5.427251] Couldn't get size: 0x800000000000000e
> [    5.427261] MODSIGN: Couldn't get UEFI db list
> [    5.428012] Couldn't get size: 0x800000000000000e
> [    5.428023] Couldn't get UEFI MokListRT
>=20
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for this, I just noticed a potential issue which I missed
when you send this to me for testing:

>=20
> ---
>=20
>   security/integrity/platform_certs/load_uefi.c | 31 ++++++++++---------
>   1 file changed, 17 insertions(+), 14 deletions(-)
>=20
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/int=
egrity/platform_certs/load_uefi.c
> index 81b19c52832..336fa528359 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -39,16 +39,18 @@ static __init bool uefi_check_ignore_db(void)
>    * Get a certificate list blob from the named EFI variable.
>    */
>   static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
> -=09=09=09=09  unsigned long *size)
> +=09=09=09=09  unsigned long *size, efi_status_t *status)
>   {
> -=09efi_status_t status;
>   =09unsigned long lsize =3D 4;
>   =09unsigned long tmpdb[4];
>   =09void *db;
>  =20
> -=09status =3D efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
> -=09if (status !=3D EFI_BUFFER_TOO_SMALL) {
> -=09=09pr_err("Couldn't get size: 0x%lx\n", status);
> +=09*status =3D efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
> +=09if (*status =3D=3D EFI_NOT_FOUND)
> +=09=09return NULL;
> +
> +=09if (*status !=3D EFI_BUFFER_TOO_SMALL) {
> +=09=09pr_err("Couldn't get size: 0x%lx\n", *status);
>   =09=09return NULL;
>   =09}
>  =20
> @@ -56,10 +58,10 @@ static __init void *get_cert_list(efi_char16_t *name,=
 efi_guid_t *guid,
>   =09if (!db)
>   =09=09return NULL;
>  =20
> -=09status =3D efi.get_variable(name, guid, NULL, &lsize, db);
> -=09if (status !=3D EFI_SUCCESS) {
> +=09*status =3D efi.get_variable(name, guid, NULL, &lsize, db);
> +=09if (*status !=3D EFI_SUCCESS) {
>   =09=09kfree(db);
> -=09=09pr_err("Error reading db var: 0x%lx\n", status);
> +=09=09pr_err("Error reading db var: 0x%lx\n", *status);
>   =09=09return NULL;
>   =09}
>  =20
> @@ -144,6 +146,7 @@ static int __init load_uefi_certs(void)
>   =09efi_guid_t mok_var =3D EFI_SHIM_LOCK_GUID;
>   =09void *db =3D NULL, *dbx =3D NULL, *mok =3D NULL;
>   =09unsigned long dbsize =3D 0, dbxsize =3D 0, moksize =3D 0;
> +=09efi_status_t status;
>   =09int rc =3D 0;
>  =20
>   =09if (!efi.get_variable)
> @@ -153,8 +156,8 @@ static int __init load_uefi_certs(void)
>   =09 * an error if we can't get them.
>   =09 */
>   =09if (!uefi_check_ignore_db()) {
> -=09=09db =3D get_cert_list(L"db", &secure_var, &dbsize);
> -=09=09if (!db) {
> +=09=09db =3D get_cert_list(L"db", &secure_var, &dbsize, &status);
> +=09=09if (!db && status !=3D EFI_NOT_FOUND) {
>   =09=09=09pr_err("MODSIGN: Couldn't get UEFI db list\n");
>   =09=09} else {
>   =09=09=09rc =3D parse_efi_signature_list("UEFI:db",
> @@ -166,8 +169,8 @@ static int __init load_uefi_certs(void)
>   =09=09}
>   =09}
>  =20
> -=09mok =3D get_cert_list(L"MokListRT", &mok_var, &moksize);
> -=09if (!mok) {
> +=09mok =3D get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
> +=09if (!mok && status !=3D EFI_NOT_FOUND) {
>   =09=09pr_info("Couldn't get UEFI MokListRT\n");
>   =09} else {
>   =09=09rc =3D parse_efi_signature_list("UEFI:MokListRT",

This means that if status =3D=3D EFI_NOT_FOUND we end up still
trying to parse the signature list, I guess that moksize =3D=3D 0
or some such is saving us here, but I believe that
this should really be:

=09if (!mok) {
=09=09if (status !=3D EFI_NOT_FOUND)
=09=09=09pr_info("Couldn't get UEFI MokListRT\n");
=09} else {
=09=09rc =3D parse_efi_signature_list("UEFI:MokListRT",

> @@ -177,8 +180,8 @@ static int __init load_uefi_certs(void)
>   =09=09kfree(mok);
>   =09}
>  =20
> -=09dbx =3D get_cert_list(L"dbx", &secure_var, &dbxsize);
> -=09if (!dbx) {
> +=09dbx =3D get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
> +=09if (!dbx && status !=3D EFI_NOT_FOUND) {
>   =09=09pr_info("Couldn't get UEFI dbx list\n");
>   =09} else {
>   =09=09rc =3D parse_efi_signature_list("UEFI:dbx",

Idem.

Regards,

Hans

