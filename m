Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AF63E0228
	for <linux-security-module@vger.kernel.org>; Tue, 14 Apr 2026 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175348; cv=pass; b=HA041wvdaJGveH3vY+K0g3iMkcfYdSM2h6KkovfBgWAewPKUvIE8ctWdHZxhfhhS2sz/esf98GuptEND2HdqBGHSkTCQo5s7H7MrWfhk7qUVMUAZNh8zyk/EXOv4xyzwCrihq0HQLDw6G5lLT7FDe/ga3U0ur2HoV11+zPUqhTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175348; c=relaxed/simple;
	bh=L84takidCv+V/Gw1IpLh4wAGyE6P7H4NIILiS1OyyAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKfXHF5vmfWZ+EqeOFeRIxgmyC3K9K8qImw7HHdUoIh2T+M1Qs97X7RmDi14jVfAKqdy6aoQn9sOJDhq/pfDbw1rfq0sFEuvedsnLunM3ccGKgYKjQQ958GBfKqrlWy2cTxErTCaly9imyWLfS7iosThc5XDUtMmAL9Z7hCCWdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RQYzqTVR; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RQYzqTVR"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c79467f128cso582495a12.3
        for <linux-security-module@vger.kernel.org>; Tue, 14 Apr 2026 07:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776175347; cv=none;
        d=google.com; s=arc-20240605;
        b=X++6mo/dqGYpia9ML5bmJY6zH58wiPNw/VqpehRHjYxByLR8Go3VD7JGrkytStLaKA
         AMSVTI18wGd5We84/khIqEWBlpV3s2AJg5e366S5rG94XnxC2n/miCHhRR1JTySS/Luf
         l1ZeL6KElOIIHzp9prqLei9VgHY7+hUSdYsYx0Hh0aw9rd2PuLDb4nsc8qfeqYWFVb2K
         EvjftPJGwrt5TYObjmpnBRl/dBBih3WsFN9mATfgFm9zm2X6yz5IaFb5YVlunDGI4T20
         1Jp6oCigGrzKWMvApGWOdDvFZsC9z+AOIMwIHtVOWH4hoo/fu0Mi4rfH+O3l1uqeysbH
         XETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YdltTviph/YfMgYwTWWe5u/9crIHVESUSxwPKRSZFvI=;
        fh=a+EaGCjxelytYu3EZG3ipCKNxfOmdel3CKh6jkY4kgk=;
        b=UEatPO+z9ihn8DMPwft1cno5mJkNsWLdKZ5ewqAKV0rPb3m+rsv3WZ2rV9uSzyWe/C
         DCEZak0i19bb4B4/WaBytN5lFHIKGfP9ZLYBNhq+N7LE42w9bJP3t2nIKkiM2PfPWXQn
         VFxoPRHNvRiYhIY7pltlobODZn1jff6YGLdMIJBSBVGAUuyb3iks/Etq59fjD6Abs1O5
         k4yp/sTAqQxzKHqZ/BkdFwNKmZ4hUQZfckvj99qfQkKVi5aj1vmTQuIYVBikZwTqrh+A
         xgdZzUXzufQU+Or3fbNyW0yIZCwkPrH+Wk40uQtuHtL0YnPEKVBl1YWyb/jS2u/pfrL/
         /PfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776175347; x=1776780147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdltTviph/YfMgYwTWWe5u/9crIHVESUSxwPKRSZFvI=;
        b=RQYzqTVRCgnj6mFimk0eEFMwQBwlrWWOtWJmGRpNSwyAPEROTVrnCCnsQnWQurr1HR
         cqOSbVYptqQQ09WS56Z/g7yMlbJ8a5lmoAdJwaXnpY7a25ehk01eFFHcWmxovSJq8EXB
         Jv0E3MVqW/y2Y1E+jO2moTcpVCEvXFIfJyJxVeo7vP/4DwSEODVKjphtE/PpZ6grKaTl
         o9WveMEjM5Icez0A67gVETHJ1zCnfJuIvAOqPrNpGTBcOFcWm7InbrWaXs9dFrcICbXc
         A8oD+4lEBepHX4flgvGFRmJxAHGwDsItwkwIz1VFvUk96A2t1R/+EhovFOS4GFMF9tZ/
         HPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175347; x=1776780147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YdltTviph/YfMgYwTWWe5u/9crIHVESUSxwPKRSZFvI=;
        b=WnlWels2hFOaUAn5AZ1J2MGPlsps0NEH9PnBhCKE9qQK495ii6BfC670rqpvuTMO6T
         VbEiNJ4wSI+dJHwOoV3Qugn9TFPMIGCZqFAyh6d41epF6sUkyKUM6RE/qmjf64KfivkQ
         TQ0K7QVmAgMmDAJeatGEt9IQmHVe9U61u9Yol/g7dS3jmtWvS1KUFxSlxCvkC2DvJcZC
         JXo7ybBPsO56IpxGMMPyN2u336pHYY0GhcZnGCv7cDBa+3cktCswCqeTr3t4GH+uuZb6
         jNz7dzV9hA+cqHqFqVd/fghufo0Y1rvdn72cVrTFcEm/loWyXcTi3GqqJhKS0hcHuQk7
         N5Jg==
X-Forwarded-Encrypted: i=1; AFNElJ81jSdoyPYrwrpupcIMd/KSvcXdEAUzXbDAKhY1ZbY4spCTskHAGAzKZNUwXWYhWEFUmgwaL2itQVkISAp8zAxvji19kn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLE1Ye0K17Y2UA/ErUMRE16p/7SWUXns+rDxebRpluyL4KMByO
	PeiAtDGDwC3YD9wX+myORZXLjxkp+E4feQFAXMjavpl3FCUUBiwemEee+8nbxhKj3aCXEV4PG/9
	2StWU72tS3L5On6WS4iTRnFqAQp0PoPPgFRFxGQ0X
X-Gm-Gg: AeBDieu7NbxyYR9vFgOzL2mTePh5EfmHI4gDkltvceVXDGSlVyiWj/afL4jKkdqrmXD
	OjU+YuL8hacwkfGPwt0tObC/dkCZI9r1UAph0RhkqNEVsph86r7Vhi5XXgLjU+h/XNAQks8IWv8
	1ojnqMHpCQ3GqFSzwsRCk2L+IL3ktv27r1Cuwog9nR99k+BSzmbDU47MR8cRGR/7fPCZ/d6e/ws
	u+RmJsbRdDeK3CbQvifsRchEHwpg45Qr6/NM7unApxg9WVHBSAQ34OSNkll4Eo1MAbRl2aQnSvn
	Q9Bhtbw=
X-Received: by 2002:a05:6a20:9194:b0:39b:dea7:5626 with SMTP id
 adf61e73a8af0-39fe3f3cb9dmr18627594637.35.1776175346542; Tue, 14 Apr 2026
 07:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69dde155.050a0220.3030df.004d.GAE@google.com>
In-Reply-To: <69dde155.050a0220.3030df.004d.GAE@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Apr 2026 10:02:13 -0400
X-Gm-Features: AQROBzAbDxzescNTRSJ_qHWY8o9CX_djo5j-kVjZK0sZMR2pgYiL6DtYc8KbVX8
Message-ID: <CAHC9VhS2AaRwAQw1hNcpuGdFSOL7Li9PavKtU7eW-w8eMOFuKA@mail.gmail.com>
Subject: Re: [syzbot] Monthly lsm report (Apr 2026)
To: Jarkko Sakkinen <jarkko@kernel.org>, David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+liste5004e02dae137bbd339@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 2:48=E2=80=AFAM syzbot
<syzbot+liste5004e02dae137bbd339@syzkaller.appspotmail.com> wrote:
>
> Hello lsm maintainers/developers,
>
> This is a 31-day syzbot report for the lsm subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/lsm
>
> During the period, 0 new issues were detected and 0 were fixed.
> In total, 3 issues are still open and 45 have already been fixed.
>
> Some of the still happening issues:
>
> Ref Crashes Repro Title
> <1> 95      Yes   INFO: task hung in process_measurement (3)
>                   https://syzkaller.appspot.com/bug?extid=3Dcb9e66807bcb8=
82cd0c5
> <2> 68      Yes   possible deadlock in keyring_clear (3)
>                   https://syzkaller.appspot.com/bug?extid=3Df55b043dacf43=
776b50c

Jarkko, David,

Do we have a fix for the keyring_clear() issue, or is it not a real problem=
?

> <3> 31      Yes   INFO: task hung in ima_file_free (4)
>                   https://syzkaller.appspot.com/bug?extid=3D8036326eebe7d=
0140944
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> To disable reminders for individual bugs, reply with the following comman=
d:
> #syz set <Ref> no-reminders
>
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
>
> You may send multiple commands in a single email message.

--=20
paul-moore.com
