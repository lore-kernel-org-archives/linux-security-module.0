Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738017;
	b=DST89pV7bg4DyaqcEdUxUsWsYdPaLv8OzHlEOG1cR/snI/2fkcXrX30DqLzGVNoGZE4r
	 JbkUM2A0VZT4TOQjiDJBBJ2y+J2FE97MK2LS9/5cA/O1qeIwkbqQi6FWQPKaQvpSep+8L
	 P+cEqgbpvUSTXDullJ38XJngeGdhVOgMrJHVM3dKcnYGs+8WjnJQiXdNeXkAPeTU3fNZv
	 BY9gf7qwlrkIqrvZi1YY1uq5d971v0Hx2LV99cFiPKSZdlbosKDgZFy3qBg7RKD88rr7n
	 7SGxYR6jFmh+RMKyiPYBIthTRpkkWukUTs+m32D34lJN08jt+As7foSrX5LMq2fXxGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738017;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=OXDc5ezpSoR7IfOkdZK6JrzmX2iAs+aVI0tl0bUgJvc=;
	b=NZf0DjW+pLb8iFD8R9yDxKTQsIOllzf14QYe5qKrsu1nWLrF/SLtv/BFpXEaFXAjuBg7
	 IG9HrkGkTsq1etI1aINCsxQqeIPnmpSRhLq68KEwQfRkX7SPYL95T6dCN9B2XLLmSCtX7
	 STjUHnLFqqo3Qkw2A54sRPrltwJgc8hJF1lQqRlFVg38dxGPEasiK0rlqjQ1yU9fugSLt
	 GO5fD0ouRhZAp4qw5j2HQL+tUFrC31nOtD2LdLapq6kyTzNUuzFBgDdG9Bki7/UIk4a7h
	 R7q+5tiQc5fdq2Ugb55oiGWEhmT/gHOdGTCtXVL9GlebWyrqegIuFUbJDmVfE1tyvHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D484606A324
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 20:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D484606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-5641cd2cc13so26767b6e.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Nov 2026 12:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738016; x=1794342816;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OXDc5ezpSoR7IfOkdZK6JrzmX2iAs+aVI0tl0bUgJvc=;
        b=O2gvbYhftlONpaHgnWouh58AfkygNvF48Rrvpbq9NSad/HFwfJtn6JQt6fBNOhKfTF
         ImC6OJ9TciALoM+FXlFZ1WGmT4Ed5kx8Rpi4HQmyTvG/Ty9FWNdJ/78PM0lpcNFaXmbp
         L9gQBZ8uDauNakUjWZyXoCsBBYTwnZXaePON4gNO095wSA6oE9tkoaIAaOOjDL9Hun3v
         qHImXcKUkkYsp2ldRAB6ts4u9+dwgPeCW50Y3JTW1YqkY88bgZvij3wdVKSMUSCi8+kJ
         KFYbvdSLVHILM1sHi2CAElqOsyxhc+JV0nXHk124zOHs1BLuUab+pje1/YqB5YCLzmLw
         HIYg==
X-Forwarded-Encrypted: i=1; AKwUvByqx0xl9qWo8UAACZ6IaXBoSfv55lscIZ2JTzOZEu+rX6mu2oKF56s04NxS0PlrigYwCTFeA/1WDf6wdmfVuyxBZXgtbXQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ol5QcAZ53ZANg+A+PmVe5mOJvVREP96MVLydhCUf+/7qiDr6p
	n1C1icq9UGciYXWSstRyXLKwU6QS2wkw9JL6w0lPwv0n/HOPKbFojRTsPnGVmSZFtR/Kawft3wY
	4BQ2NBPAuKgeI2jRlHAvxqeQ7PHJyJGLMVvUaPcJ6b6++8kyH9xTGmIVVs9E=
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1527:b0:4c4:28a5:1885 with SMTP id
 5614622812f47-5640d9278d9mr9644492b6e.9.1793738016233; Tue, 03 Nov 2026
 12:33:36 -0800 (PST)
Date: Tue, 03 Nov 2026 12:33:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aea4520.26d36f6c.15fe18.000d.GAE@google.com>
Subject: [syzbot] Monthly lsm report (Nov 2026)
From: syzbot <syzbot+list9b459ecc7623bd2224e4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello lsm maintainers/developers,

This is a 31-day syzbot report for the lsm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/lsm

During the period, 1 new issues were detected and 1 were fixed.
In total, 6 issues are still open and 47 have already been fixed.
There are also 2 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 121     Yes   INFO: task hung in process_measurement (3)
                  https://syzkaller.appspot.com/bug?extid=cb9e66807bcb882cd0c5
<2> 54      Yes   INFO: task hung in ima_file_free (4)
                  https://syzkaller.appspot.com/bug?extid=8036326eebe7d0140944
<3> 4       Yes   memory leak in prepare_creds (7)
                  https://syzkaller.appspot.com/bug?extid=53515d23498d641e21ea

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
