Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1054F211475
	for <linux-security-module@vger.kernel.org>; Thu, 12 Dec 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734002465; cv=none; b=Y96Z2o3KVuKW9fBH6hNzFCeq7mUIXiToyzVjvp4ZdnlUZiSBhHRIVkWYCmCloZ/fVzfX+/NSCgEYDfj+G71WWncgU+5RFO1ju5rbpVN1CJGM2zP1MAbh73g0DrHM3TsYG5aWKyN9of4LGpI7BNgXkspSBzGRlc6RPbQGDoNxQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734002465; c=relaxed/simple;
	bh=Y4XI4Ells3mnYGRwVSRKFnxFRULix5bUEreIKmF5zqE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EK5adTV7ye7iyLYjUWdqZMXGltMvPWs2AMtlnmozOsHNnOUeeNb61HFMGyYwDeAD0k7/A/NsFmpxTDwrpoo7Ca3+buEXVnDwnNUcjhHMnmx6bcVO/gY7pbVHW8klZSq5FRxGn0sE3uasHrV18u3PNZ1ugCcDbh45Rg3W7sthsbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-844d38b44ebso34992139f.3
        for <linux-security-module@vger.kernel.org>; Thu, 12 Dec 2024 03:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734002463; x=1734607263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efoVXz7q0jZIiG+6cenIdyRJUBuEPqT6nO/eaTRVO+A=;
        b=WjoUb8FvnBf0QeQexyj/6GpkrVNDwmsO8Uk9aI0jUI8N0VINDdMjgz9+midLpKnpLF
         FuCW4jOBNPstLwffanmcyaDtL9A+5hri6X8oK79iK+vzlLJoxyIRD5wH4YJHvw6RC6vj
         JWf2pXZ3V8V23HWfVmZ1KPQXDL/YA6jxtElm0+FGrkx0Nreif6DCvowksqrXMQstMvRj
         FmXgpoI56gC79oXQMZeWzEVGSx1TroiIuC5gltE1CHTxuTMDCeR8jZ3LzAA5DCiDCNW2
         n9MyoKYZRxwd1HNnc04caebMm6jRIJJb5+BnPHxAqcQBupu3p8EgWR7ve7r8kH+ChTM5
         bftg==
X-Forwarded-Encrypted: i=1; AJvYcCVtJt1o9880gsgXYq9MLI1w6JSZx1IwKuhxUpnyNw4OeCvsT6WAat5xRqjE+WNmoU3JU5UZJJf/bS001GeBa+41fh36Xn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVQWMXHH7HHDqR0m9bwO7IcWPhzEaDkjDE7R7Lc+ykhZOGDdeJ
	LEQTZ5ciqyCLfLFgpSUbVYk4Lgl7I7IRs/FMKnhJEseTP5x3R4LgdOPly62rXG75JomwBg9xBxR
	YlmPQtwJMPRYt/DmsZ+Gn2/IF4Op2nDVN1K3XLynn3HRQUk9fdUFDG9c=
X-Google-Smtp-Source: AGHT+IGaaDO3YVXqZI6iELV8/LOtGxjLYb6+FlxKhT4QZJSL0KbR4UQseJ8xjs+4CBrXQw0L7MIhbZIugmVDrByK6corfJLZHVNH
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8f:b0:3a7:a553:72f with SMTP id
 e9e14a558f8ab-3ac4b436698mr22783755ab.18.1734002463268; Thu, 12 Dec 2024
 03:21:03 -0800 (PST)
Date: Thu, 12 Dec 2024 03:21:03 -0800
In-Reply-To: <PUZPR04MB631619A22F03DDBDC97905DD813F2@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675ac71f.050a0220.20c8bc.0002.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [integrity?] KMSAN: uninit-value in
 ima_add_template_entry (2)
From: syzbot <syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, roberto.sassu@huaweicloud.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org, yuezhang.mo@sony.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com
Tested-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com

Tested on:

commit:         231825b2 Revert "unicode: Don't special case ignorable..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b56cdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d5bd2f63a4859d
dashboard link: https://syzkaller.appspot.com/bug?extid=91ae49e1c1a2634d20c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133e6cdf980000

Note: testing is done by a robot and is best-effort only.
