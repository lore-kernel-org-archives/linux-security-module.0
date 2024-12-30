Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A121487FA
	for <linux-security-module@vger.kernel.org>; Mon, 30 Dec 2024 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735537684; cv=none; b=gLHF9qJSVuv+I46IJ381uV6tc9jfdwHEKE/t4im6u+ReAUBQAfvlNLw1uxHMeQTQ7nUI7QorW3fTq1y5u2VQOUzzsla67IRoMAclxqdFv2vcN47IltT8k34d3l6KPBGtAbijyMTW4VT5ssFPEaqshCBhOBqQeLZj9PwlhoKaK50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735537684; c=relaxed/simple;
	bh=X/pTaxeY9uxzixcgUNMI8spaGnMaud+VI8PLVKwD3QU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RHdaiuX/afG2E6ajDy1WWnq1116byk4+JUl9/ARZXeS9FfGXAgCteFzL1ME+ZM02YiQFvDqBDoyMFx0DMOM7IOFuyJNXUNxJZEOjW2P2ED0nKNyx6zG/Gjj9HNsUay8RQIlG18cQw8CUWFZh0ORZFY1+mnET3nIheJe4KCJ//Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-844db107601so737628439f.2
        for <linux-security-module@vger.kernel.org>; Sun, 29 Dec 2024 21:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735537682; x=1736142482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEn0TNgC+Egj9+u1OPA67mOeXDAmTFT/Bzf3azKUXZE=;
        b=oseH7iDlwFHq6THqmgwe3gDOyhwFYhjy/VzIlfr1nEHO86H03eVaVxMaCaP/dRnQal
         dT2Vhdp4Y7JsZ8+TqPHHvC+Q+aFB+57sFHvxaOvqhSzc4VuYKFPWLwTwr4JqM6v52MjV
         337TXz5ixJTc5emKubkqjN2+AgFO2lSZ3Hc+ToOyplUpd5J+gGgioQgrc7RIWjqs7ZJt
         4UGwalU7jSFZmgmYBqWPwbD0AIMSOvV07430NMIPZrh57cqUJwNPBffiR0+UeSBJlk2N
         BJuqmAZjQ7pi+6gI0JHoKQ3gV/2L2bdyfmlIfI22QDWWLDL6N87cKLpP74/ANHtT1+Gi
         KCFg==
X-Forwarded-Encrypted: i=1; AJvYcCXy4+a8CrDgB96r1svAl9j2GHsKK2cyOdXAOWfq99+FunZpzW4CpHY2HIAsEKcMfcR86bmg/UcC2CF8kubEgV4MTBnN6WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybWq5HE5fP3B0ix3zE5gIWnd1vCY7vVpu6dOTEZ0L8nJ9LMwqC
	GQtsDIXcXYYJwS+/657iNCGM5EvAs3h2mHjqiLqra5IKerjFqDsH+519gzMRqlUWp24VIksysGX
	RLiK8nzotUX7DVXs8wga8il7fz7+OBIJv5dcw6+O5CdejfH/uqH3bpXY=
X-Google-Smtp-Source: AGHT+IHNSi+yiedUS+vS8rNLSbjMlJ+TTOLzwjGT3CV4B+A5XArc7fz0pVC+9I6xjxqhhAqh1llINQUlH7F7e8BJC+NA3MUyrTVG
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6004:b0:844:caac:ad61 with SMTP id
 ca18e2360f4ac-8499e6c4d75mr2967592739f.13.1735537682521; Sun, 29 Dec 2024
 21:48:02 -0800 (PST)
Date: Sun, 29 Dec 2024 21:48:02 -0800
In-Reply-To: <PUZPR04MB6316D814E4CF26B2A62EB24381092@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67723412.050a0220.226966.00cf.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] INFO: task hung in
 process_measurement (2)
From: syzbot <syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com
Tested-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com

Tested on:

commit:         fc033cf2 Linux 6.13-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155a6818580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba7cde9482d6bb6
dashboard link: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162126df980000

Note: testing is done by a robot and is best-effort only.
