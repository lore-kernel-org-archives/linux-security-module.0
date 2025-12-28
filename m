Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC34258CCC
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766903344; cv=none; b=C4P3ae9hS4g8AV+xGg3P4BA47UW819TOs8U4m9aYB7zI1yJA2hqW3dm0Jzb+YcGsEDUaKlnLWVluCpJ22ti7NFWojDJT5n6zR7R36XAMQ0MoFQUVkFOlmzUA4TDUlQX2EyFIo+8Layu5R2bn70mg31EnWkIhFq2PoJg91teUoXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766903344; c=relaxed/simple;
	bh=Inljx6UOoK9th0Yw9ul8xLEL3W4o8tpjYeNnAkDOmxk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NwKCelxWTa5eEkzBsT1cZifEZDt4Akogwvd4DwX522imLZ3vhSJeLqbP3Xw0BupQsKV2OWbtM7oSWta7sl8wbk+QE7kHGUzZAwNCTkAGfdeof5GRr66l2KrT11lv9Zgl/yUyqfu/LLBvY1lX1+rQvEZMGxHhlmGSKAHKDYTNImk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65703b66ebfso14902551eaf.0
        for <linux-security-module@vger.kernel.org>; Sat, 27 Dec 2025 22:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766903341; x=1767508141;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqWaYjXGpL0SCXHVfAwZczGoXfLd9iZju3rBMa/XlsI=;
        b=Obwsov6WH0XH1+JmwyHRcxF0buajML3GZuwxq5pPbflmqpUnPjB9Ei3gIM7w7cgnT5
         iioL/jII/53lDRtyCi6ZXN69wP/KG9jsPQMzD25iqi6EtdAHcA06ffLRADZrVaLLx1zN
         HJhLZ8BEnz6pjZ/fGe2q3RDdSZP9QAoMLIRRzrjTkrCYZXYGo4czZWif80SNrPBbdNy7
         LBUgVFDGBNMwUHfZG1K6Y8Cd3JPGZgEBHc3evELM2zZUR67D4YB8Yw1rStnXbdbv5mRv
         ZRJ/o+vUWQk6eumFahq8aY73TkKEF64YGhjXN3v+l2x64J1xz1LXKzNdD+KpBBUwQdXZ
         10Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXbMXGweZmudTzLvlicaT0RKkG14wVHIhSjQromi1IkoPuG/sYlc6zCgQIUhqAC1n19Ma8Wr4Q9rCuupzbHrJamQQsfF3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBjXPpl8lc7SwaWV93Wg/obG9lRpBldRIytR1i/w0cIE74cSE/
	133QbahndmDE0JtDziJd9EBTk8wS2cM1mqrzO9mMCfWBIH2/fqJNsESIF9RqIonHFP9Ylzm0KoM
	rfGlO+Ic3kwjdHuhFj+wX5UvFuUE6/9/5KZnpyXxMbwI54YNJpCwoTR0MSgE=
X-Google-Smtp-Source: AGHT+IEoS0rAjcG/+fGcGmjafzr1ie5EibCfjAHuWQ1bamSqVqpqVq5pUPYA4JV9/ivc0D0yU9QEcaQ+4125sqT5bkop/MWm91yt
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:d744:0:b0:65c:f062:bdde with SMTP id
 006d021491bc7-65cfe799322mr10615394eaf.36.1766903341612; Sat, 27 Dec 2025
 22:29:01 -0800 (PST)
Date: Sat, 27 Dec 2025 22:29:01 -0800
In-Reply-To: <682e11b1.050a0220.ade60.09e5.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6950ce2d.a70a0220.c527.0006.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [integrity?] INFO: task hung in
 process_measurement (3)
From: syzbot <syzbot+cb9e66807bcb882cd0c5@syzkaller.appspotmail.com>
To: bfoster@redhat.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit f2c61db29f277b9c80de92102fc532cc247495cd
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Sep 29 20:43:52 2025 +0000

    Remove bcachefs core code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10499e2a580000
start commit:   172a9d94339c Merge tag '6.15-rc6-smb3-client-fixes' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea35e429f965296e
dashboard link: https://syzkaller.appspot.com/bug?extid=cb9e66807bcb882cd0c5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16836e70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1617a2d4580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Remove bcachefs core code

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
