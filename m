Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F2224249
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763630811; cv=none; b=oHgMQoWCd0Gvaycb9myn1xzM48DJn+xmN0VU8g0REoij0f6V5WXHeMr7b+WIOsxw6/keoSGgVpMqB2FVkem6ZIA6St5zCpcZyqPiSPyhQRHzG/uyIct8Yv5fjIjxw2mpvxDlPT6MmJX/j7AOg3su5uf/XPqR8/Llun52yEM3F0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763630811; c=relaxed/simple;
	bh=FGbe2QJ35IWC87sUETNWg6RlVC1TZZq96naSHX+aXm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rT7iQvW9ofIhB8vAztReYpRP9l2dWl4+9uFlsIzwXO0zNSrSjDAB3yYZ8VBz0kZl2uf9mK7glS/JpQgYxwTsC08OBrKJkMl+4hT0Fdz0T3AUIqz7hVUr+fqfMzOeU7qFrtTJGQi89RDc7cb+8dIWAQDLKCHkNEGkF5tWWFYocl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqvvyLJD; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqvvyLJD"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-880499b2bc7so5593166d6.3
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 01:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763630809; x=1764235609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rNfEEw4vHnSGPrrOqGBlUEcYjNEIn+vm1yCxi49VeY=;
        b=nqvvyLJDLW0qQ5AVPBd5aPNl6w+dvbzoam2rRdhW/5YMaM30PkjHOn3r46xXjXcnDn
         TXdNSiEIANVJhEuwCHEee2VNw77kTiSy7snpP3paqh+acUZga0ZHr5ZpJcB9Xc4l1+ef
         I5b38RJjxb1giKsZvCcUB2qXeT78Zq+EqvU1RUuzam7x30BjDY0eGp/o9QADxqYSZ5lQ
         BZEGaVNCxu6Rz5IOe1FQW4vRFMNIYsy32rynCsjfo5QVziAn86sltsVEzYJq4XnDGRN3
         MWGu5k3lYJeJ97jmW99MPQQl8tPOeDCLGRMSvUgnBLixhBlJVx8cUlkK46YXXHpDr3y6
         4dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763630809; x=1764235609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5rNfEEw4vHnSGPrrOqGBlUEcYjNEIn+vm1yCxi49VeY=;
        b=Cj/bnbChrdZr7T4Aw7f1jeoisrG8wHwSYuKkh36/TisYAWRJJaQ4kmzyvi+tu5fzu9
         EsoG4jPopGvaUGYC034bfX25ps1yC6p7VRHJAh1TP2Jk5cWA4oNQW9fQxJjxw7ElC+8D
         5fTHzchQMvIfeyvsE04er++8JTQqDdReXTHfJYJXziMIF+/M4lYsSqrJ7AJ9sIqdilvB
         p4jg68mtn8YRtt/KY6oUyTcRSJGUHAJ3rxFcsDjD9OrMjkUtRVVITcrIhVowUEQD7SbR
         qMTtDPHw4Off+mKnX7l8LhOpvIF5k/EfPLzBXvtpRK7quZL580j9zAyW7cj7dj6nYrQa
         g+aw==
X-Gm-Message-State: AOJu0Yz6X3cLwm6eAbxzgWbBDwqGeTaIZ1PFnt5bAES1pwxUeAIgu00O
	NcbmPhFzh/xpxCFV9MqlkzZ4hxLh9fM+rLrZTZJDBnR85RTLLOabjqtv
X-Gm-Gg: ASbGncuxC2NngDis4TBd/V2WRyQCVoPoLT2dLKm/lBn+3lFu66D4aVX8hiWWHNa9IW/
	orp0fwobwVGhfgatHOloCPOcbY9ztz5FVHxqTba2NQbgIo0irnM1WGiUQAbWSnfwz/agK4gNMsE
	3SXvsaY7KYOn0Lp5ZNSaol+ug9DPLOg9Sbm5crGUb6hJDRsJOVgOXui/3r4Qh+BWLxD/UPNSWf0
	OYOESzuo9+1LQT73JKOPC/bwbSNtY09VCoqKLTCn8ETSZ5WgG1sa8mST2RfnHoXszk6CpW2ot6m
	zKKTI+TaIFIbgvxTUzbj8pjsh7XKbyTuOHpddmmryXAbk/XHerx0PO0Qw2B3UHI630HxdAtIcve
	lR1zgcZpWOMCQs52fhWbfv9mAJG27WOfQPN3ELEP5+BcNY9LHNWT0joqw+Yfj6QMqXSeQecd360
	LYnx6LbtA8K1XdjhLF6NvyeR7dYLODWxWYdZtKE2lHNw==
X-Google-Smtp-Source: AGHT+IErijzjvVB6QHM2SddkkZKIVjIoxlhrkbOqhzMQX/h3ZCJn9AHYFiv/1s4Xuegx61VoNALOKw==
X-Received: by 2002:a05:6214:4903:b0:880:5279:98e9 with SMTP id 6a1803df08f44-8846e131c85mr33483786d6.40.1763630808772;
        Thu, 20 Nov 2025 01:26:48 -0800 (PST)
Received: from daniel-desktop3.localnet ([204.48.92.24])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54c9b9sm13611896d6.28.2025.11.20.01.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 01:26:48 -0800 (PST)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>, Paul Moore <paul@paul-moore.com>,
 Xiujianfeng <xiujianfeng@huaweicloud.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nathan Lynch <nathanl@linux.ibm.com>, Matthew Garrett <mjg59@google.com>,
 Kees Cook <keescook@chromium.org>, David Howells <dhowells@redhat.com>,
 James Morris <jmorris@namei.org>
Subject: Re: [PATCH v2] lockdown: Only log restrictions once
Date: Thu, 20 Nov 2025 04:26:45 -0500
Message-ID: <7645139.4DdEvYhyI6@daniel-desktop3>
In-Reply-To: <2f4a1af8-adc6-4cbc-813f-4cc8e9bc75ae@huaweicloud.com>
References:
 <3641397.L58v44csPz@daniel-desktop3> <1961790.USuA9gRusQ@daniel-desktop3>
 <2f4a1af8-adc6-4cbc-813f-4cc8e9bc75ae@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, 20 November 2025, 02:37:56 EST Xiujianfeng <xiujianfeng@huawei=
cloud.com> wrote:
> Is it possible to adjust the printk_ratelimit & printk_ratelimit_burst
> in /proc/sys/kernel/ to reduce the logs in your scenario?

It's not working. Watching the console after setting the sysctl and
repeatedly clicking org.freedesktop.login1.Manager.CanSuspend in
qdbusviewer (simulating what the lockscreen does), I see:

```console
root@daniel-desktop3:~# uname -a
Linux daniel-desktop3 6.17.0-6-generic #6-Ubuntu SMP PREEMPT_DYNAMIC Tue Oc=
t  7 13:34:17 UTC 2025 x86_64 GNU/Linux
root@daniel-desktop3:~# sysctl kernel.printk_ratelimit_burst=3D1
kernel.printk_ratelimit_burst =3D 1
root@daniel-desktop3:~# sysctl kernel.printk_ratelimit=3D999999
kernel.printk_ratelimit =3D 999999
root@daniel-desktop3:~# dmesg -W
[14385.334698] lockdown_is_locked_down: 3 callbacks suppressed
[14385.334701] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14385.614738] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14385.878857] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14386.166744] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14386.454771] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14386.750900] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14387.038795] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14387.334770] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14387.622696] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14387.926763] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14390.366582] lockdown_is_locked_down: 7 callbacks suppressed
[14390.366585] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14390.798744] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14391.118802] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14391.422728] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14391.742754] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14392.046735] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14392.350745] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14392.654992] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14392.974797] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
[14393.270741] Lockdown: systemd-logind: hibernation is restricted; see man=
 kernel_lockdown.7
```

At my desk, I lock my screen every 5 hours. In public, I might lock my
screen every 1 minute, 5 minute, or 15 *minutes*. printk_ratelimit
seems to be targeted towards things that happen every N *seconds*.

> logs here serve a purpose similar to auditing. Based on this, I think
> this change will meaningfully degrade the quality of the logs, making it
> hard for users to find out what happens when lockdown is active=EF=BC=8C
> especially after a long time running.

=46or v3 in December, I'm thinking of adding a code path to special-case
*reads* from /sys/power/state. What do you think?


