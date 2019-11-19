Return-Path: <SRS0=tSh8=ZL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51027C432C0
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Nov 2019 15:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C2921D7F
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Nov 2019 15:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4JnhhiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfKSPkc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:40:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29428 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727849AbfKSPkc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Nov 2019 10:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574178031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNe4ndK8WdSlkwGJufBA82BQjblnirabjNcrpn5neeU=;
        b=D4JnhhiWNoK491Boi2uvil+e1j3ljNHsO0E+nGvyHOfuQ0YCmL9H5t74a10RotV9EhOUgV
        z5DsLTf4zQlPZRySSSh73uq3VOLsArNVprB+le/+GRCU2ZByqok7+jjdAYH6kMV/+DGWnz
        Wf8XRz2/Q5cyXZzsSHR0h//ULVcCv1A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-Hb2KfxfCP2yjjYouhfgj4g-1; Tue, 19 Nov 2019 10:40:29 -0500
Received: by mail-wr1-f70.google.com with SMTP id q6so18506603wrv.11
        for <linux-security-module@vger.kernel.org>; Tue, 19 Nov 2019 07:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dZRjNZXZ61hhKmaHtSnRk7b5EzibrobN0AxAOUBtmvI=;
        b=LYSb/PsKEa5tFuTIZKJssBZJ7JP8abkG4T6yL0J6F7WVHhnmCtPOh6HcjVHi36Soek
         EoiuD54Ux5pV+mHMBPL581HT3JliG5sDIeQpULC66wlxp/V0QuLL38V+BKiPDTlt7aFI
         73s/4RU3SyfWhNWKYKgp+xcfLPBo7MZoS3Uzr2AEt1/4ZYElvDJe6yfourKwEIL1n4Zq
         DJhlrT6Yrp3QyZHZ6da3mx5vKKRl18NglYIImyjpG8DGn3Rtz4yrzsLTCdlbRF0zkNTO
         lkVOJy8Bo9xpSI4UAULC/nRA5sgZ3NxGglOy7QK7aqElULsUc0OPatduC6WFj24VL4rL
         M0NQ==
X-Gm-Message-State: APjAAAW0gsGKRDt0g+33V4QZoLhgMBa2ObmiKmOpLlNZ2LqBUmb6+VME
        KHnEn2LPMbReSKLoQYRDk7pR1vruUoBA5Vx/R+tay3c30JhzVRkutRqpsyPwx2eWfieIFADm0sf
        qSMOkr3zf2bBa843f4c5xDUo1uqGMrePU2r0c
X-Received: by 2002:adf:ed48:: with SMTP id u8mr7988234wro.28.1574178028399;
        Tue, 19 Nov 2019 07:40:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzldw8DoEiwEyUqdk+tBwVApBnkrf0/oTRZ75PevuEveEyel5xjSPzurgJDjHaBmQNEW3Zcbw==
X-Received: by 2002:adf:ed48:: with SMTP id u8mr7988198wro.28.1574178028152;
        Tue, 19 Nov 2019 07:40:28 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id w7sm26878892wru.62.2019.11.19.07.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 07:40:27 -0800 (PST)
Subject: Re: [PATCH v2] efi: Only print errors about failing to get certs if
 EFI vars are found
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
References: <20191119115043.21585-1-javierm@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bb68bacf-4982-0d86-d2cb-7799e47200f5@redhat.com>
Date:   Tue, 19 Nov 2019 16:40:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191119115043.21585-1-javierm@redhat.com>
Content-Language: en-US
X-MC-Unique: Hb2KfxfCP2yjjYouhfgj4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

On 19-11-2019 12:50, Javier Martinez Canillas wrote:
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
>=20
> ---
> Hans,
>=20
> I'll really appreciate if you can test this patch. I just built tested it
> because I don't have access to a machine to reproduce the issue right now=
.

Ok, I've given this a test-run just now, works as advertised for me:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> Changes in v2:
> - Fix flaws in the logic, that caused the signature list was parsed if
>    the return code was EFI_NOT_FOUND that pointed out Hans de Goede.
> - Print debug messages if the variables are not found.
>=20
>   security/integrity/platform_certs/load_uefi.c | 40 ++++++++++++-------
>   1 file changed, 26 insertions(+), 14 deletions(-)
>=20
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/int=
egrity/platform_certs/load_uefi.c
> index 81b19c52832..020fc7a11ef 100644
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
> @@ -153,9 +156,12 @@ static int __init load_uefi_certs(void)
>   =09 * an error if we can't get them.
>   =09 */
>   =09if (!uefi_check_ignore_db()) {
> -=09=09db =3D get_cert_list(L"db", &secure_var, &dbsize);
> +=09=09db =3D get_cert_list(L"db", &secure_var, &dbsize, &status);
>   =09=09if (!db) {
> -=09=09=09pr_err("MODSIGN: Couldn't get UEFI db list\n");
> +=09=09=09if (status =3D=3D EFI_NOT_FOUND)
> +=09=09=09=09pr_debug("MODSIGN: db variable wasn't found\n");
> +=09=09=09else
> +=09=09=09=09pr_err("MODSIGN: Couldn't get UEFI db list\n");
>   =09=09} else {
>   =09=09=09rc =3D parse_efi_signature_list("UEFI:db",
>   =09=09=09=09=09db, dbsize, get_handler_for_db);
> @@ -166,9 +172,12 @@ static int __init load_uefi_certs(void)
>   =09=09}
>   =09}
>  =20
> -=09mok =3D get_cert_list(L"MokListRT", &mok_var, &moksize);
> +=09mok =3D get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
>   =09if (!mok) {
> -=09=09pr_info("Couldn't get UEFI MokListRT\n");
> +=09=09if (status =3D=3D EFI_NOT_FOUND)
> +=09=09=09pr_debug("MokListRT variable wasn't found\n");
> +=09=09else
> +=09=09=09pr_info("Couldn't get UEFI MokListRT\n");
>   =09} else {
>   =09=09rc =3D parse_efi_signature_list("UEFI:MokListRT",
>   =09=09=09=09=09      mok, moksize, get_handler_for_db);
> @@ -177,9 +186,12 @@ static int __init load_uefi_certs(void)
>   =09=09kfree(mok);
>   =09}
>  =20
> -=09dbx =3D get_cert_list(L"dbx", &secure_var, &dbxsize);
> +=09dbx =3D get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
>   =09if (!dbx) {
> -=09=09pr_info("Couldn't get UEFI dbx list\n");
> +=09=09if (status =3D=3D EFI_NOT_FOUND)
> +=09=09=09pr_debug("dbx variable wasn't found\n");
> +=09=09else
> +=09=09=09pr_info("Couldn't get UEFI dbx list\n");
>   =09} else {
>   =09=09rc =3D parse_efi_signature_list("UEFI:dbx",
>   =09=09=09=09=09      dbx, dbxsize,
>=20

