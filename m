Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7C83CB2
	for <linux-security-module@vger.kernel.org>; Thu,  7 Mar 2024 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803624; cv=none; b=LGKvHdFKepcN7D/aoyQZ8kq+zbD004DtOxgMWhckMsa0hRwIpdVe1cYP3BWTpQB3F3TcjI0TTiD/wkeI1S7pZZEdldvY5w4rOelp5rKJKg7t+mkfCwnlFYtDVlSlPVs/J2a+2E96/OzgHzM6t9nY2y1/tSb0WjYJW4k16Emg/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803624; c=relaxed/simple;
	bh=zUFafqTJeGxcmc/hlLS6N7jomBCs1Nv+oR8cEWaOQho=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kanl7nKNtcDZJqUrY/sdYMngG6DTGRijJoz+05m/ubFnhE1zbD99cammBPhYzD6RwtOuYHz2/vaO8D3XTVYp9xtnVPwYQy6jq2lVDaVg0grc9f/ZNhJOPWM8B9POfBjcKsqCnPW/y+qoTnHfFQectJNO+2isA4qis+boKsxCGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7c9831579so90294939f.0
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2024 01:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803622; x=1710408422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NB9RZnkYPt4n1WS3RCfCtIlEr1JDKFgDjIZaAQfJpFs=;
        b=qXfemCTs315kij78ZSrVuhFkDKMFwDa0OvO+TxaPvrZbSPmcYqMR3RGxAiD3Mkw/Xa
         fVDUtOxOI/aj6IjgPQeR2YBvZDS65xmi1sEF123kIS/nFXlFok9CnQtPCqPKqYKr7W+L
         vV/ls1JZ4uAsWH/SxSEJqBbCJVN/wSD+PU1YbL1MAW1UJGfYO4wKjJ1IK2OFeTNwALFk
         605kymU7xWuk+Af3+8bgf1Z5UYxQlhR5XK7H8qVn/xMYyUPGjQCCH4f3M9gUW7necIsT
         Md+bFRbdibrGjpvs8l++uW2TKFj1s7Hfjr4EBHbZjGkpllZVpzNSDIaVYlPcYjHvmg5K
         ib6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVGw8VjfbzdxtVeHQRzFOnHgePIHSBTU84//jKcQa+M5treOcH8luHnLizpFrFy1eoMUa+fYZIX9UO/zEbG7Gg90Q8P1NaGk/xt2gmeyUfcI0zIzSa
X-Gm-Message-State: AOJu0Yz8IiD4+5fHQu+RvzTNAADjUIYYbr35uTjlR583rNMYQCIflvmU
	jBpIPivb4yU9TF8nkPkw6yv4inqRy44OmgP2FgVHHK5D3PO9LAy1wDgFf21Vtk99JyhuF2I9Fsk
	xBkaem6LCZFH29AAvkh1pWLxC5ILqt4LK4EpgyTZ7B5Oqc6Qnpgyy7lw=
X-Google-Smtp-Source: AGHT+IGOUknSfs/AHY6R3/Cjy4fOCegkxgrx3co2CQHYN42ngoneFYTa92ongzEBgALOXl5ekZ3ITbZDiyeZlEubwImv5mzWt38e
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6289:b0:476:b3d1:323e with SMTP id
 fh9-20020a056638628900b00476b3d1323emr41882jab.6.1709803622009; Thu, 07 Mar
 2024 01:27:02 -0800 (PST)
Date: Thu, 07 Mar 2024 01:27:01 -0800
In-Reply-To: <000000000000be039005fc540ed7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000869cc706130ead1b@google.com>
Subject: Re: [syzbot] [reiserfs?] INFO: task hung in flush_old_commits
From: syzbot <syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, jeffm@suse.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com, 
	roberto.sassu@huaweicloud.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152ff3f2180000
start commit:   421ca22e3138 Merge tag 'nfs-for-6.4-2' of git://git.linux-..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8067683055e3f5
dashboard link: https://syzkaller.appspot.com/bug?extid=0a684c061589dcc30e51
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14312791280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12da8605280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
