Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8393A9605
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522469; cv=pass; b=iktX7K7Xlz4QKqoct/lFs2eeEP57tPNaCAeMqgRZuqLySiF4Czga3HkRidmoDGfmXAHrthR5dINms2dnzu6sLep3MAkGJiF1sWGZiCTfQAdXaQFQu9bDrsLDZBraxxA9jjRdk43fVGN1uB/Dsy/X1RTVRLr1LdoxVPlq73t+gaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522469; c=relaxed/simple;
	bh=UCPNgs7T7S7vSxo0RpkwEmW84kuw7TMAkPdpCW+Ocws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOv6UrzB/Jmjz8x+rsVb6PS4+DCwR7eLKL3Cz0lkeDyllyfBkxavVGmG9DKT10c1PTPNe20mUQRHuyUgL85G1wgU4qVshKAGPAarecLmWF+md1GY7rKBGBwcMve75Q6uzIpWkO8oGkGq2J8ryBGSbZLQOe+3fgsp+q1X0ENWpDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYgM4cQ7; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYgM4cQ7"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b05bf699easo30240607b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 22:07:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791522468; cv=none;
        d=google.com; s=arc-20260327;
        b=diE7F/53yLs1l01Gi/XE/hRu/BplX3xADnmKAU7hmZQaYUdiACnv97ayfOKJ6L/0kJ
         Eu2AI+/g5GpCvuti4AOO5zsIOLgt5p+qH+bq8kVB0E9+bNiTd5e6GhhX6Nr/mQooJvDW
         fvUaVxv9x5y5N084qM9FTbeEA3GihYagwyeh209/PV3GkVOIAYr6A1ZK7hjrz8w15+Mo
         X1dp5YX8Yhp/iOLpcuy603abOxfNdxJrHARZ4TfasWh4Xa06+MkQZMoJ4kTetl6YwvlN
         N+VDTZkKj6jzNyxQisKYGq8wNgQ0O0+gJ+s+q07GFGGWeVDQswFBEHtNWPCbmVH+FjaT
         MRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7dtIf3z0dvmVlA//c0wg2QPe+8angNo6UaOAKikdDOs=;
        fh=pq5WVlJSK8qtIer/Psrjpy5iLFTaHZElevZnWkLs+ms=;
        b=oO7j8za6Eq5iVAGi2BJM4DLfouS9zBzO+2MFVpjoTv4wUzV8PrF4xspr8bj1yo01bx
         N1w3mZX5gOtzulIyUOTtE0SdK+MOnxqqmoAB+5KP6DsXiPj+Rn5c47scjZR9ASwwNx4I
         0zbdglfocYj/+lESnpQSnGYNjJSTxqI7drHh+B835MlOfq+dVIEn8/ujJXPOw7eGalcl
         2x88xbjbsV5se6YI8HxNcyy3qhG9F9flToNtarBr9CiETwf15B9sUvYbJo+hJVFNRxhN
         aicsDObeGBeWNargLryThrc12CFO2E0S6iH3KiGFWrvSXMqUcQ4eVhJeb6dk4cTdzgEp
         ryUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791522468; x=1792127268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7dtIf3z0dvmVlA//c0wg2QPe+8angNo6UaOAKikdDOs=;
        b=lYgM4cQ7CxEgMrskLr36CaxFfeibwioXt8yCoC0CfS6Zo2NcA8Q4rwqfuofTFI1Vrw
         F4w7RNTfmiax16hPrlL0IF8osvzHM4+KW6KaxJv56YoJO5hralzumaLW0CksjvWK1q0z
         mZh4p51AisS8wem2TYap8nCy4nP/tsjtgDn8110DobsSajHAYWXmJsAsr6hPsGjVJO+y
         58CeuY3GNlrmP4Lo4aAlN5He+Mg9IxzF9YcvpZxieW+/NN5gGYbVLGGWb8GsId6INjhx
         djC6q3kWqixOhZXElqFBSyTxrlI2yESqnrS3B+bhGVYkYJ9g/1cIJV3gQpAvcVne5zK6
         f+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791522468; x=1792127268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7dtIf3z0dvmVlA//c0wg2QPe+8angNo6UaOAKikdDOs=;
        b=Jx69nQC/1TMLwiXu52wKW/RfEkPPMJfWqV+/O5iHpPkBicHJxtiTTthbDBXrwMormN
         WNJxpRA1nBRli72xl90wJa3Iyyrj1wq2xErwMzyZOZs4H1aWm3/nwixroTtMKUlFxAOe
         o4aZ2upmpfglAuZ+VzUFn6e167wZehC6MfzCoUZqfGSojXJsdnz2DUZeG8ehJ19xm0XY
         +0NPRP4tIgQQd3T+J7PVjLgJ7xhDYbl/8rmBN0G+jI48MNq470/Z/dtw9kXc+Jg4O//Q
         NxA+k4bDmhXVbYFzOCbPEImRRWf+DJV0LDG4lrk7DpNyVlsGsdE84XJW8wL9KFXKhPl+
         riSg==
X-Forwarded-Encrypted: i=1; AKwUvBwQQTj6dHBNB+3n527IpMBFLcYbuH0eE7yTWJWYJlfj4Cb2AfVYgetS/QT2NAnAZLDl/uC+KeMjerDQAPX8efGlXqbGs5g=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9U/tMbEQ6zG4HKI7k8prF+7eD9rgMAzWKBfoM/O8qe9xc016O
	NTDnR1LEx94oRMVTYeEVVQ5AmevHXXhyazlMfcQXqqvocuvct3ZOsjbvNRKEli+vFGmUXFQsdKz
	FRAdWUU/f66/kcPAMzdlE486aLd3bAN8=
X-Gm-Gg: AYBFou01JpEQYcGPZLN9Es+h5oFSscds/Fn17WOxQqE+SEBQ8K9b163KsOQd5R76NQR
	E3IzOyYDuJqayw3g6/ymOCOrZQCLxpMTF7Kskk6n0/M0KHpDvylPBK3g4oFO6S9pWDJH+40HCyh
	AJc/fsPcBjXQnReqCbAtXEE9UUONkur7l4LCcpAz8auv2A2cKU6gmCm8h1TWjyomw5z/cFmhRfk
	JM0NmIImn8vnO/3sf1kFtQt5zguWy4OQG1hr2gvq1hVz5L+MMhqlq2lUe1bRHjuqU45fmslKBU/
	MuuH4ialU5vae9O/cRCOQI/r8zM6W9tgjUer8hFmKjJaabkoSZGujqsfVg==
X-Received: by 2002:a05:690c:a588:b0:8b0:7900:144b with SMTP id
 00721157ae682-8b07eea68fcmr1801207b3.68.1791522467787; Thu, 08 Oct 2026
 22:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0009-v3-43bbf21d1c452f23d829@gmail.com>
 <asfZMToWNmQDTk4W@kernel.org>
In-Reply-To: <asfZMToWNmQDTk4W@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 9 Oct 2026 13:07:35 +0800
X-Gm-Features: AclHuK-clEa45iiMBZBHhd7Il41JvNCy-ntPtuIu1Vj_0gM0qBhgbfp7uMK-3Ds
Message-ID: <CAFRLqsWs0BK+dLJ2D+cFptF6TtgqhPSp5BYOz3K60AyN=oWOPw@mail.gmail.com>
Subject: Re: [PATCH] keys: Protect the type name while describing a key
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=94 01:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Just a small nit. Cut just the snippet of the report that is necessary.
> >
> >     BUG: unable to handle page fault for address: fffffbfff8054794
> >     #PF: supervisor read access in kernel mode
> >     #PF: error_code(0x0000) - not-present page
> >     PGD 1a7ff6067 P4D 1a7ff6067 PUD 1a7ff2067 PMD 100b0b067 PTE 0
> >     Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> >     CPU: 0 UID: 0 PID: 500 Comm: key-fixture Tainted: G           O    =
    7.2.0-rc5-pmb-bt-functional-v1+ #1 PREEMPT(lazy)
> >     Tainted: [O]=3DOOT_MODULE
> >     Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fi=
x, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> >     RIP: 0010:string+0x23f/0x470
> >     Code: 48 8b 04 24 48 83 c3 01 41 83 c6 01 48 39 c5 74 34 e8 f5 2e 5=
e fb 48 89 ef 48 83 c5 01 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <42> 0f b6=
 04 38 38 d0 7f 08 84 c0 0f 85 d6 01 00 00 44 0f b6 65 ff
> >     RSP: 0018:ffff888116307b80 EFLAGS: 00010246
> >     RAX: 1ffffffff8054794 RBX: ffff88810a4a52c0 RCX: ffffffff8626be7b
> >     RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffc02a3ca0
> >     RBP: ffffffffc02a3ca1 R08: 0000000000000001 R09: 0000000000000001
> >     R10: ffffffff893cfe57 R11: ffff88811404d700 R12: 00000000ffffffff
> >     R13: ffff88810a4a52d4 R14: 0000000000000000 R15: dffffc0000000000
> >     FS:  00007fad30f2a780(0000) GS:ffff8881fd7d6000(0000) knlGS:0000000=
000000000
> >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     CR2: fffffbfff8054794 CR3: 0000000104fb7004 CR4: 0000000000770ef0
> >     PKRU: 55555554
> >     Call Trace:
> >      <TASK>
> >      ? __pfx_string+0x10/0x10
> >      vsnprintf+0x330/0x1110
>
> I would cut away the rest (what follows).

Thanks for the review. I've trimmed the KASAN report for v2.

Best regards,
Cen Zhang
