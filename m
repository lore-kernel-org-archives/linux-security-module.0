Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E672819F49D
	for <linux-security-module@vger.kernel.org>; Thu, 19 Sep 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726761943; cv=none; b=jXUVzIxySE0InB2cmsltGq/n7r6qNyqqo6JQ9ofe5k83xFb94W9J/YeEjHs+EZpe1pw1rC8fpdDTBDU77+hkuOfMGBCrxZwxay09OUm0griqKXBDeTfYM/h4V+F2tPBS7pv7Xbkh6BYHoV+wfao7HQdumQ9YQA8OX0MDkBIv9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726761943; c=relaxed/simple;
	bh=YuGyoFlR3zsbYKdnvpdwmpjvDsWB5PPm0aXY6r9+KtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRg1djr/95trQ1mOSefT3LU9D9oZbDABmwoiogOvSuiosXaQVv5PnHXu/gEyP/H2rUp4sTprmSPp/V4GnIVh0PGkCbs0QQHvyCVGP+X90LabcozzHCRuQo92gYK3JYlMjJNw9lJBGJ6JZzYdMKGCgIvZEz0JFxhPi0p1i2fidiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bNZs5mgy; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bNZs5mgy"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e03caab48a2so902004276.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Sep 2024 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726761941; x=1727366741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HdUdhIPwwI6AU/7Ra680ydg6oDI8v4ajBh4UcdHCeXo=;
        b=bNZs5mgy9dFzZ/mWanHF1KqJB70V5B0LAtEP1sAdTMW3aXptpIJZJSB+Qpw/bQSG4N
         7Aq7uFC74smuR4bEfrV1O0ith88CgbcXn4Y+jg6qpDIHN7XC2t/Q+dCSO/PdLSYqdC9+
         IVE7UWq2isHST5wsJvQAH2siA/ENdaeQg8vdAk9LijqVXwpWIZoZMXm05QNd32G/vuND
         33LoiOn3WGFCx+ybozZ4Vc7caFMaOpc8lR8dFdy80kDKrFQyRo3voEx0Ajwoh8MFMrRN
         JxwSWve+EJNHZl5+FEfewffqCgVudhO2zpY1BUvS5b5l40KfVhMnZbhkR5N3qFiKLXVm
         Triw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726761941; x=1727366741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdUdhIPwwI6AU/7Ra680ydg6oDI8v4ajBh4UcdHCeXo=;
        b=dM+K2iuD3LP6+Xgj7V/HHozNDB8XDI+v2wHqJn38TdY6tGeToP594VA63DlyDcY9ko
         IXAJ3XK6A6XiJn/Lvr6AhdkVeqRIb1UuMfcZGBpppPd1WklYladdOM0hvlqdxR0hD3M/
         OWfykw+wPzbfA8i1LxhEDfoyvHKNzjOGr83n2VU08Zd2HBYhUIFCossx4w8/sAMxHrS+
         FE6Upj9BlgCOoBaF/sCyIpfXHPtFOeTTMXTnR0sGLMuISL5HbX3nWD6rX3uziuFuRpS1
         mAdRnyLxaaREfkAyrF6aHbl13i+3yGWupITzop6oxWu08lQIe1Y3uRry02e98JcM1oSl
         C/vw==
X-Forwarded-Encrypted: i=1; AJvYcCWDDna51myIptSHAQMUdStt1KUGSTtfk7rREQwSxGjnukEw/0DxhCEizV87R3cl2g5FcRKjZq+foOAW69AoNchcH7HfQWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPYHNKFh9AywZzwcREZxciS9t3YlI1ePcnPASqtgbdOxtmGn0Y
	dkz9SUB4R2TC8WqiBcJdz6tPZqbmIlU+gevh8HaGdPqCAnj7Gi+pm8rmFQhZhaSYVULXWp6F6Nu
	BMke/FC/CefML2eN25IeFtw3OvjozVvh0+Exg
X-Google-Smtp-Source: AGHT+IGFfsCLFlXzIE4WL4lQnY+XmKm9FIKr65q8ol/AeEEWv1q+PbbdIPzm2vHXkvsahYdpARV3nr7pGfpfrshTuL0=
X-Received: by 2002:a25:a282:0:b0:e20:1e5f:bc9a with SMTP id
 3f1490d57ef6-e202769c379mr3068158276.11.1726761940768; Thu, 19 Sep 2024
 09:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66ec25cb.050a0220.92ef1.001e.GAE@google.com>
In-Reply-To: <66ec25cb.050a0220.92ef1.001e.GAE@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Sep 2024 12:05:29 -0400
Message-ID: <CAHC9VhRpDPTopxgOEbDt1d_XyDVNzaA7++6UojWXidbpBHjeVA@mail.gmail.com>
Subject: Re: [syzbot] [audit?] general protection fault in smack_log_callback
To: syzbot <syzbot+044fdf24e96093584232@syzkaller.appspotmail.com>
Cc: audit@vger.kernel.org, casey@schaufler-ca.com, eparis@redhat.com, 
	jmorris@namei.org, john.johansen@canonical.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="00000000000017a5ae06227b1880"

--00000000000017a5ae06227b1880
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 9:23=E2=80=AFAM syzbot
<syzbot+044fdf24e96093584232@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    bdf56c7580d2 Merge tag 'slab-for-6.12' of git://git.kerne=
l..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12584b0058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4540f5bcdd31e=
3de
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D044fdf24e960935=
84232
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D155cffc7980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16ad24a998000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cec9f3c675f1/dis=
k-bdf56c75.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/21e06ae5b159/vmlinu=
x-bdf56c75.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1e936c954b8b/b=
zImage-bdf56c75.xz
>
> The issue was bisected to:
>
> commit 5f8d28f6d7d568dbbc8c5bce94894474c07afd4f
> Author: Casey Schaufler <casey@schaufler-ca.com>
> Date:   Wed Jul 10 21:32:26 2024 +0000
>
>     lsm: infrastructure management of the key security blob
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1124d69f98=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1324d69f98=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1524d69f98000=
0

I just posted a patch which I believe should fix the problem, but I'd
like to get Casey's ACK on it before submitting upstream as it does
touch Smack code; lore link below:

https://lore.kernel.org/linux-security-module/20240919155740.29539-2-paul@p=
aul-moore.com

... in the meantime, I'm attaching the patch here so syzbot can verify
that it solves the problem.

#syz test

--=20
paul-moore.com

--00000000000017a5ae06227b1880
Content-Type: text/x-patch; charset="US-ASCII"; name="01-lsm-key_blob_fix.patch"
Content-Disposition: attachment; filename="01-lsm-key_blob_fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m19hg97b0>
X-Attachment-Id: f_m19hg97b0

c2VsaW51eCxzbWFjazogcHJvcGVybHkgcmVmZXJlbmNlIHRoZSBMU00gYmxvYiBpbiBzZWN1cml0
eV93YXRjaF9rZXkoKQoKRnJvbTogUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4KClVu
Zm9ydHVuYXRlbHkgd2hlbiB3ZSBtaWdyYXRlZCB0aGUgbGlmZWN5Y2xlIG1hbmFnZW1lbnQgb2Yg
dGhlIGtleSBMU00KYmxvYiB0byB0aGUgTFNNIGZyYW1ld29yayB3ZSBmb3Jnb3QgdG8gY29udmVy
dCB0aGUgc2VjdXJpdHlfd2F0Y2hfa2V5KCkKY2FsbGJhY2tzIGZvciBTRUxpbnV4IGFuZCBTbWFj
ay4gIFRoaXMgcGF0Y2ggY29ycmVjdHMgdGhpcyBieSBtYWtpbmcgdXNlCm9mIHRoZSBzZWxpbnV4
X2tleSgpIGFuZCBzbWFja19rZXkoKSBoZWxwZXIgZnVuY3Rpb25zIHJlc3BlY3RpdmVseS4KClRo
aXMgcGF0Y2ggYWxzbyByZW1vdmVzIHNvbWUgaW5wdXQgY2hlY2tpbmcgaW4gdGhlIFNtYWNrIGNh
bGxiYWNrIGFzIGl0CmlzIG5vIGxvbmdlciBuZWVkZWQuCgpSZXBvcnRlZC1ieTogc3l6Ym90KzA0
NGZkZjI0ZTk2MDkzNTg0MjMyQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KRml4ZXM6IDVmOGQy
OGY2ZDdkNSAoImxzbTogaW5mcmFzdHJ1Y3R1cmUgbWFuYWdlbWVudCBvZiB0aGUga2V5IHNlY3Vy
aXR5IGJsb2IiKQpTaWduZWQtb2ZmLWJ5OiBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29t
PgotLS0KIHNlY3VyaXR5L3NlbGludXgvaG9va3MuYyAgIHwgICAgMiArLQogc2VjdXJpdHkvc21h
Y2svc21hY2tfbHNtLmMgfCAgIDEzICsrKy0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zZWN1cml0eS9zZWxp
bnV4L2hvb2tzLmMgYi9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMKaW5kZXggODFmYmZhNWI4MGQ0
Li42N2JhYTQ4N2NmN2EgMTAwNjQ0Ci0tLSBhL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYworKysg
Yi9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMKQEAgLTY3MjAsNyArNjcyMCw3IEBAIHN0YXRpYyBp
bnQgc2VsaW51eF9rZXlfZ2V0c2VjdXJpdHkoc3RydWN0IGtleSAqa2V5LCBjaGFyICoqX2J1ZmZl
cikKICNpZmRlZiBDT05GSUdfS0VZX05PVElGSUNBVElPTlMKIHN0YXRpYyBpbnQgc2VsaW51eF93
YXRjaF9rZXkoc3RydWN0IGtleSAqa2V5KQogewotCXN0cnVjdCBrZXlfc2VjdXJpdHlfc3RydWN0
ICprc2VjID0ga2V5LT5zZWN1cml0eTsKKwlzdHJ1Y3Qga2V5X3NlY3VyaXR5X3N0cnVjdCAqa3Nl
YyA9IHNlbGludXhfa2V5KGtleSk7CiAJdTMyIHNpZCA9IGN1cnJlbnRfc2lkKCk7CiAKIAlyZXR1
cm4gYXZjX2hhc19wZXJtKHNpZCwga3NlYy0+c2lkLCBTRUNDTEFTU19LRVksIEtFWV9fVklFVywg
TlVMTCk7CmRpZmYgLS1naXQgYS9zZWN1cml0eS9zbWFjay9zbWFja19sc20uYyBiL3NlY3VyaXR5
L3NtYWNrL3NtYWNrX2xzbS5jCmluZGV4IGRhMGMyYmZmYmQwOC4uNTYzZmI0MDRmNjU5IDEwMDY0
NAotLS0gYS9zZWN1cml0eS9zbWFjay9zbWFja19sc20uYworKysgYi9zZWN1cml0eS9zbWFjay9z
bWFja19sc20uYwpAQCAtNDYyOSwxNiArNDYyOSw5IEBAIHN0YXRpYyBpbnQgc21hY2tfd2F0Y2hf
a2V5KHN0cnVjdCBrZXkgKmtleSkKIHsKIAlzdHJ1Y3Qgc21rX2F1ZGl0X2luZm8gYWQ7CiAJc3Ry
dWN0IHNtYWNrX2tub3duICp0a3AgPSBzbWtfb2ZfY3VycmVudCgpOworCXN0cnVjdCBzbWFja19r
bm93biAqKmJsb2IgPSBzbWFja19rZXkoa2V5KTsKIAlpbnQgcmM7CiAKLQlpZiAoa2V5ID09IE5V
TEwpCi0JCXJldHVybiAtRUlOVkFMOwotCS8qCi0JICogSWYgdGhlIGtleSBoYXNuJ3QgYmVlbiBp
bml0aWFsaXplZCBnaXZlIGl0IGFjY2VzcyBzbyB0aGF0Ci0JICogaXQgbWF5IGRvIHNvLgotCSAq
LwotCWlmIChrZXktPnNlY3VyaXR5ID09IE5VTEwpCi0JCXJldHVybiAwOwogCS8qCiAJICogVGhp
cyBzaG91bGQgbm90IG9jY3VyCiAJICovCkBAIC00NjUzLDggKzQ2NDYsOCBAQCBzdGF0aWMgaW50
IHNtYWNrX3dhdGNoX2tleShzdHJ1Y3Qga2V5ICprZXkpCiAJYWQuYS51LmtleV9zdHJ1Y3Qua2V5
ID0ga2V5LT5zZXJpYWw7CiAJYWQuYS51LmtleV9zdHJ1Y3Qua2V5X2Rlc2MgPSBrZXktPmRlc2Ny
aXB0aW9uOwogI2VuZGlmCi0JcmMgPSBzbWtfYWNjZXNzKHRrcCwga2V5LT5zZWN1cml0eSwgTUFZ
X1JFQUQsICZhZCk7Ci0JcmMgPSBzbWtfYnVfbm90ZSgia2V5IHdhdGNoIiwgdGtwLCBrZXktPnNl
Y3VyaXR5LCBNQVlfUkVBRCwgcmMpOworCXJjID0gc21rX2FjY2Vzcyh0a3AsICpibG9iLCBNQVlf
UkVBRCwgJmFkKTsKKwlyYyA9IHNta19idV9ub3RlKCJrZXkgd2F0Y2giLCB0a3AsICpibG9iLCBN
QVlfUkVBRCwgcmMpOwogCXJldHVybiByYzsKIH0KICNlbmRpZiAvKiBDT05GSUdfS0VZX05PVElG
SUNBVElPTlMgKi8K
--00000000000017a5ae06227b1880--
