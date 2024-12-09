Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512961C5CD5
	for <linux-security-module@vger.kernel.org>; Mon,  9 Dec 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756525; cv=none; b=ccGIcHGM/3ZR6EvpuGYdhHIG0w9Rv4g40UMzwSdHern91aS91QzwwAH6y2N2uupY2xtsp5uXuqIkxdk8x5QQKje5OBeI5Wi+Z6yWMS7kafEa+5p4/n0RTO46VUEnUbKlDtFbo4bodhMMS6Qcqlu1DbO+7tBACOZqZEa+zOyodak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756525; c=relaxed/simple;
	bh=B9vCo6F2T9+u26g8w2gYtFYxPMZXNfMUdvNWm9sd/3s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iLeM45ym376lz7eYCHGaUdskwfQV0GFSec2mBXpvyw3Mni4xdP7lAoo4n+Mva3DGm2JwtVXzhkITJkIsHLEWTf/S0cFN9bp36m4PUZxvQ8PRl7sVUW+JNo2NFsqKl4VyIxlMP2fcW5gEZMtmE17DiyJsVRj7J7GaMzPwcqZ2I6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-843eb4505e7so812376339f.0
        for <linux-security-module@vger.kernel.org>; Mon, 09 Dec 2024 07:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756523; x=1734361323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7dxMIMKDt3gcnaZaUT4OJRPNLlt1pmTTMSZqablmuo=;
        b=EE6ulBM9omi8yQ2ny40x0mwQ3qN4YwffM3JsLab5f2ensRETEsWaK+NDK7utbRPN57
         DIFg82VpZSsL42n7MwCrjRXPVzcaJNQbZODo2egVjZb/+jkA8UbdhLVUagEv7K5hdUJQ
         J0CeD6sarcolH0oNSNyows9ZupSvyCCtW5P4KgD87hJPJ3wV+NlE4l7i6U/a+YTl5u81
         aS5FIxkTCaGjKgB4q+3vhIN1efkRmQ3w1VVuKyhUdhSgORPoB8KRHGEmxQUjPqVBrqpZ
         qCji1/BflU0VLSIQsU600zs3ptwZpiBcldFT0RESchkBew29SPgeyMrz7VgwurZ7Qpt1
         Up5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaPSdBz+GLKCTZ9Gb8O3RcMsl5Ur15xPgRFmlT0jKcNKiGukfGAkl7sruMqZHX6jfPMPWa5TLKixA+u52UwaIG9765mJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRw9TODwzhQpGFBKwSt9I2wNZ3OayRShRLzks+Ap6CiO+cCYl
	5uBewP089G6GlgxUajpSc862YhWqvhwyUNlQSUljGpSxlNv/RW9eBhqu0X+AzS4wL8krg+RGdR/
	hQ2JE8UJafz1yPXugJaqjpES2lQj/PSwINyDtHbyKNcR9mjGeBR8ZEiE=
X-Google-Smtp-Source: AGHT+IG5EZZkKQl19WgC0D4C2LkJ6p6XjW5sCN2xk5PuMegB5QYhkucX1Ulr+XYUmcB3kitlouArvVWSFe0dfVvl6kteP9HNI4Vr
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6001:b0:843:eaee:287a with SMTP id
 ca18e2360f4ac-8447e3e4383mr1406808039f.15.1733756523454; Mon, 09 Dec 2024
 07:02:03 -0800 (PST)
Date: Mon, 09 Dec 2024 07:02:03 -0800
In-Reply-To: <00000000000065deef0604e8fe03@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6757066b.050a0220.a30f1.01a5.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] INFO: task hung in
 process_measurement (2)
From: syzbot <syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, andy.wu@sony.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, hpa@zytor.com, jmorris@namei.org, 
	linkinjeon@kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	mingo@redhat.com, paul@paul-moore.com, roberto.sassu@huawei.com, 
	serge@hallyn.com, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, wataru.aoyama@sony.com, x86@kernel.org, 
	yuezhang.mo@sony.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f55c096f62f100aa9f5f48d86e1b6846ecbd67e7
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Tue May 30 09:35:00 2023 +0000

    exfat: do not zero the extended part

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15275944580000
start commit:   b5f217084ab3 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17275944580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13275944580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=335e39020523e2ed
dashboard link: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126a8820580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153e70f8580000

Reported-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com
Fixes: f55c096f62f1 ("exfat: do not zero the extended part")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
