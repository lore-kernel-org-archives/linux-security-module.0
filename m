Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A835BF9D6
	for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734330665; cv=none; b=azJrfvaJ1A215WOtP/m9o3H4aztXSJQ7jK2sYuVicEy/YQpdJ3cV5nhzNfpg+UrqGG2OdoxwYtV7caz4tIrFEJfJ/d8tjJ4Ay60Q1eff8z4MmXg1/GlMYKPhGlpO3M4i496gkL8F8RrANe1cB7iB0XtOR2IvYlQChinQ3MeqTtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734330665; c=relaxed/simple;
	bh=3E2pDLSWpHz+qKRsyOCvMIVk3xBO/le3IAkheabOoFY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nadFhiYCPPafablJSb9eWzgcHitUitj//lh4rP37NxOGYpu02RSIfKGKQha+oEJsCb8VKjOfqTXIV7/5UMIrd8vtCdeDgxUhQgsPP1jP2r4QJjo54TB4WfPa4CZVtguehPDjL8pXfMawi4NLtf1rYw5huMsdbCcfK+l/KDVGQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7d85ab308so35428825ab.3
        for <linux-security-module@vger.kernel.org>; Sun, 15 Dec 2024 22:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734330663; x=1734935463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGgwY9doc2BDYdLeq+Akm53OqV4dukJ6miTwWudPyro=;
        b=EmDlz/KmlFk+dC8rvBk0xFWmbn2BnxW1zszWrIAcx7jK/qLuSDg2zyf61ZLJrQOTTN
         6VHtaa8Mn+APZD5dXd2pz0Ay1Z5izw2dPiNcs/JOakR2qejENVclcWt+Dl90v8oKn3sh
         VqnN/vo+cr2leJWnaI/d5AbV2tdBDQMfrrG9ZvISlasADFyY3u+dpiKubCML0dE+AQnn
         R3KmCasWq0RfNn5kBLt4WW6HrbUAE1N0h7EM4xFtANkaIYYumZP4EWykJ4ynUhapDFFT
         rcYT9PuooNUpAdfEZU5Q6fF0TXHpt35N41m3CSNoQ/nc4en7I4hIkIttxIMkB6Rwsv/r
         s/dA==
X-Forwarded-Encrypted: i=1; AJvYcCXJtTAnvSY+g4ZKpj8HADipxaBerCEDcX51SEVx62TX2mFTeyxawBmv64XtNRc5P+ljnSy9YDS4jFXOGzGNvrYPqDLLigw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0gBzNk6ovehXj9FQnZXD9ZsgTdzqkyLpZvvw+o/d11VBBmIQk
	cf/DbK5ojXJM8A428w36DIRfIAMCBODyNE+jAExKnuK8cbylX5Wl+L3tQCk4m/IdOJ3pejlboyV
	mEl0mKlVo/5EXNUs7m/J/tGg+lhTzIZriMf2uCtu/QA8fcrrwg4YMTvg=
X-Google-Smtp-Source: AGHT+IHqyW8xz9AMDJraQb4QIo+grq8CirvIaFyaiu/OxyxIYJNdfxD/b3iOyQaCcqMOivRLvs+i9Vhs3cxNSZWzH/wAGnEz188Q
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cd:b0:3a7:e592:55cd with SMTP id
 e9e14a558f8ab-3aff086d9admr103467895ab.14.1734330662864; Sun, 15 Dec 2024
 22:31:02 -0800 (PST)
Date: Sun, 15 Dec 2024 22:31:02 -0800
In-Reply-To: <PUZPR04MB6316F684BF023564B7DDD812813B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675fc926.050a0220.37aaf.0116.GAE@google.com>
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

commit:         78d4f34e Linux 6.13-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11259ed7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fe704d2356374ad
dashboard link: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105d1730580000

Note: testing is done by a robot and is best-effort only.
