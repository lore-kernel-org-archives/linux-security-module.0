Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FDA41
	for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2024 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728739; cv=none; b=Jg3xHj2l3i1ebJ7U5A8VWBvqn8LVNFStSgoQVNKiETKHoCbByPcIwQ8IpGDQWUzJm+nIQqKLD6Rfkjddd2bLsznQSJf/NLSXxS6W/Wo0a56ZpETweg8Ctz/Q6kWqmjM/wsxq3pr3oCqeuvnyHQxROhpFGcDcoWbk13/nWq/lxdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728739; c=relaxed/simple;
	bh=+mWIcf/agpq6mpheDznJ5ojCr+7NwjqAUIvCquTT8io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQT9mxzHNMJ7f8gM7FJ20vKuFQkjELccOCF5F8r1kTnmoGM+Yc1mvdGJBleV/rgNYrFIa7SgOnKIFKUcwHHPJEXyKHEZECgC22qczF/cjOjKLCQcwyk9EtZGl01VkToSnb9gm4Nt81kb+rbZLuy1f9+Qi5/YtLM57qVb68hU/Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hcWPUIyn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hcWPUIyn"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so64986421fa.3
        for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2024 09:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732728735; x=1733333535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JNQg0IQVTirbSwf8BBJVUJisrcRpHW57JCOkb6UyqHc=;
        b=hcWPUIyn3oh3XVbzQs96/4RI59GpCsSNR4yRvr2CyBoC7G2IsMTAcBMjUX6UrW80xK
         6yRs/mvC+JSYRL/Nrc+UzaL5jeTNI6gmKKe+mKGyJ1sRy2tjM15gKFcfBju8fzU6Tnr0
         yPca+dC/WxaXiD2GJHqNH/lkG84zFEsfniu8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728735; x=1733333535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNQg0IQVTirbSwf8BBJVUJisrcRpHW57JCOkb6UyqHc=;
        b=mw75VT9YG5bVm2dip7v53v5P0frM7H0PBFSoVsVfpE0PcrhawL4+0IpqOfIIiPRO8k
         pxumcW/qSCsQaW/tEClAZaYvIdGeiA9qtiAXbtIUljgiWDu+OZhGdjID67F/p6careIq
         gGJzkfBqovPfXUHTZWO1RAK/cqU6oaDMnX/h/o2bO/n83x9yT7vOSqd2i1+SrYZ3TSP6
         SQYQgLLbJ42m9VRewhKBtnjI0yQ8A8f/7BB3nKSyl9lyvvEm92t9HV5XUYjLw2iPPsL5
         NMbfnzIu4HXVbv91Vk0XEUKMHc5yFYM5HYzywJDp6O/WR536vgzsP+7CHRPzgIHS7Zjt
         KBdg==
X-Forwarded-Encrypted: i=1; AJvYcCVd2Vc0duXDPzusS7ngxwPkacHGb7dyw8op7Dr+fPig5HcwIv86j/VTyqUWp7FFgt4yZX50t/bgdOph3gWnr0dlsoizZHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRv7ONyuRFWEj9SqvPKMdQOep+uKGMLg0dHT5lRpn/bIZ2tUw/
	AibXNbsYUC1FkITJ+CyaWpslfLltPhKXCsDVDC0003hvVrWsqRYXWsfvRIj4ORMsvw2GVkj8qXE
	p6AEO+A==
X-Gm-Gg: ASbGncuvDCn8xUvcdZf1k9GyuPU6T2nVqf86T/i13IUg8Fh/ykt60i9qAUH2VwTr2ia
	jql/5OLP3hYW0L6YakJfyvQIiRbVl152vo/j2JeG2DHWqNuoXaHJxObR7vaLLQ/gq0zsmE5pFQZ
	YfIZ87HE5GzsdG3IHRnrqSSPZH9tyBhKypf/48/mlmcFQLpm7G+tCoZulEFJjh7k8UjCtKQg9SL
	l5CyYemAtDTnyT87WeyN59wh1aGkCJ4uI/bY2Sj6WI6SAIfVsakmKNWYuDkoLEkw8tigiA+VBc5
	TG9T/3LAA+TYZfOzNiDZMXIG
X-Google-Smtp-Source: AGHT+IG5J5ztuB5RiqX0pPCaj4CHNX21aL52ciSFRNH+p/UiqjxMchW25ASRUiPIZskZXgekt6DUag==
X-Received: by 2002:a05:651c:220d:b0:2fa:de52:f03c with SMTP id 38308e7fff4ca-2ffd6040d95mr24376781fa.5.1732728734526;
        Wed, 27 Nov 2024 09:32:14 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d41af02sm6315884a12.87.2024.11.27.09.32.13
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 09:32:13 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5302a0901so593741866b.0
        for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2024 09:32:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdTdT7zuK6Jc4PueFRIbAP162HAYG/JKT/vQfgYiu9BlynKY20bLyQaW42mjrFInJDEi0aDB0lxW9INRZ1hJf4CCJ0R1A=@vger.kernel.org
X-Received: by 2002:a17:906:1bb1:b0:aa5:2e85:3b04 with SMTP id
 a640c23a62f3a-aa5810739e7mr264453166b.50.1732728733459; Wed, 27 Nov 2024
 09:32:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zztcp-fm9Ln57c-t@lei> <CAHk-=wiotQ0isGLKp3EUOdq6sSEb=G=WbnxCfcsDnbszHGXNtw@mail.gmail.com>
In-Reply-To: <CAHk-=wiotQ0isGLKp3EUOdq6sSEb=G=WbnxCfcsDnbszHGXNtw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 09:31:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whArvb=wUqw7eYko_MkBuvFBiiV_0xzqHDJa-J_Qacf2Q@mail.gmail.com>
Message-ID: <CAHk-=whArvb=wUqw7eYko_MkBuvFBiiV_0xzqHDJa-J_Qacf2Q@mail.gmail.com>
Subject: Re: [GIT PULL] capabilities
To: Serge Hallyn <sergeh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Jordan Rome <linux@jordanrome.com>, 
	linux-security-module@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a6ab4f0627e8588a"

--000000000000a6ab4f0627e8588a
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 09:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Something *UNTESTED* like the attached diff.

Well, that "attached diff" wass again something I forgot to actually attach.

Here.

Again: very much untested. But at least the code makes a bit of sense,
and code generation is actually improved by this.

                Linus

--000000000000a6ab4f0627e8588a
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m405xte70>
X-Attachment-Id: f_m405xte70

IHNlY3VyaXR5L2NvbW1vbmNhcC5jIHwgMjEgKysrKysrKysrKysrKysrLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9z
ZWN1cml0eS9jb21tb25jYXAuYyBiL3NlY3VyaXR5L2NvbW1vbmNhcC5jCmluZGV4IGNlZmFkMzIz
YTBiMS4uMmZhZGJkYTc1MTMxIDEwMDY0NAotLS0gYS9zZWN1cml0eS9jb21tb25jYXAuYworKysg
Yi9zZWN1cml0eS9jb21tb25jYXAuYwpAQCAtNjQsMTggKzY0LDE4IEBAIHN0YXRpYyB2b2lkIHdh
cm5fc2V0dWlkX2FuZF9mY2Fwc19taXhlZChjb25zdCBjaGFyICpmbmFtZSkKICAqIGNhcF9oYXNf
Y2FwYWJpbGl0eSgpIHJldHVybnMgMCB3aGVuIGEgdGFzayBoYXMgYSBjYXBhYmlsaXR5LCBidXQg
dGhlCiAgKiBrZXJuZWwncyBjYXBhYmxlKCkgYW5kIGhhc19jYXBhYmlsaXR5KCkgcmV0dXJucyAx
IGZvciB0aGlzIGNhc2UuCiAgKi8KLWludCBjYXBfY2FwYWJsZShjb25zdCBzdHJ1Y3QgY3JlZCAq
Y3JlZCwgc3RydWN0IHVzZXJfbmFtZXNwYWNlICp0YXJnX25zLAotCQlpbnQgY2FwLCB1bnNpZ25l
ZCBpbnQgb3B0cykKK3N0YXRpYyBpbnQgY2FwX2NhcGFibGVfaGVscGVyKGNvbnN0IHN0cnVjdCBj
cmVkICpjcmVkLAorCQkJCWNvbnN0IHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbnMsCisJCQkJY29u
c3Qgc3RydWN0IHVzZXJfbmFtZXNwYWNlICpjcmVkX25zLAorCQkJCWludCBjYXApCiB7Ci0Jc3Ry
dWN0IHVzZXJfbmFtZXNwYWNlICpucyA9IHRhcmdfbnM7Ci0KIAkvKiBTZWUgaWYgY3JlZCBoYXMg
dGhlIGNhcGFiaWxpdHkgaW4gdGhlIHRhcmdldCB1c2VyIG5hbWVzcGFjZQogCSAqIGJ5IGV4YW1p
bmluZyB0aGUgdGFyZ2V0IHVzZXIgbmFtZXNwYWNlIGFuZCBhbGwgb2YgdGhlIHRhcmdldAogCSAq
IHVzZXIgbmFtZXNwYWNlJ3MgcGFyZW50cy4KIAkgKi8KIAlmb3IgKDs7KSB7CiAJCS8qIERvIHdl
IGhhdmUgdGhlIG5lY2Vzc2FyeSBjYXBhYmlsaXRpZXM/ICovCi0JCWlmIChucyA9PSBjcmVkLT51
c2VyX25zKQorCQlpZiAobGlrZWx5KG5zID09IGNyZWRfbnMpKQogCQkJcmV0dXJuIGNhcF9yYWlz
ZWQoY3JlZC0+Y2FwX2VmZmVjdGl2ZSwgY2FwKSA/IDAgOiAtRVBFUk07CiAKIAkJLyoKQEAgLTg5
LDcgKzg5LDcgQEAgaW50IGNhcF9jYXBhYmxlKGNvbnN0IHN0cnVjdCBjcmVkICpjcmVkLCBzdHJ1
Y3QgdXNlcl9uYW1lc3BhY2UgKnRhcmdfbnMsCiAJCSAqIFRoZSBvd25lciBvZiB0aGUgdXNlciBu
YW1lc3BhY2UgaW4gdGhlIHBhcmVudCBvZiB0aGUKIAkJICogdXNlciBuYW1lc3BhY2UgaGFzIGFs
bCBjYXBzLgogCQkgKi8KLQkJaWYgKChucy0+cGFyZW50ID09IGNyZWQtPnVzZXJfbnMpICYmIHVp
ZF9lcShucy0+b3duZXIsIGNyZWQtPmV1aWQpKQorCQlpZiAoKG5zLT5wYXJlbnQgPT0gY3JlZF9u
cykgJiYgdWlkX2VxKG5zLT5vd25lciwgY3JlZC0+ZXVpZCkpCiAJCQlyZXR1cm4gMDsKIAogCQkv
KgpAQCAtMTAyLDYgKzEwMiwxNSBAQCBpbnQgY2FwX2NhcGFibGUoY29uc3Qgc3RydWN0IGNyZWQg
KmNyZWQsIHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqdGFyZ19ucywKIAkvKiBXZSBuZXZlciBnZXQg
aGVyZSAqLwogfQogCitpbnQgY2FwX2NhcGFibGUoY29uc3Qgc3RydWN0IGNyZWQgKmNyZWQsIHN0
cnVjdCB1c2VyX25hbWVzcGFjZSAqdGFyZ2V0X25zLAorCWludCBjYXAsIHVuc2lnbmVkIGludCBv
cHRzKQoreworCWNvbnN0IHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqY3JlZF9ucyA9IGNyZWQtPnVz
ZXJfbnM7CisJaW50IHJldCA9IGNhcF9jYXBhYmxlX2hlbHBlcihjcmVkLCB0YXJnZXRfbnMsIGNy
ZWRfbnMsIGNhcCk7CisJLyogdHJhY2Vwb2ludCBoZXJlICovCisJcmV0dXJuIHJldDsKK30KKwog
LyoqCiAgKiBjYXBfc2V0dGltZSAtIERldGVybWluZSB3aGV0aGVyIHRoZSBjdXJyZW50IHByb2Nl
c3MgbWF5IHNldCB0aGUgc3lzdGVtIGNsb2NrCiAgKiBAdHM6IFRoZSB0aW1lIHRvIHNldAo=
--000000000000a6ab4f0627e8588a--
