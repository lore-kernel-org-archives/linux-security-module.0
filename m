Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282D1E105C
	for <linux-security-module@vger.kernel.org>; Wed,  9 Oct 2024 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500706; cv=none; b=ns/Gv/aj2Dob0zh4EVEIovFZSH1sfCubbqnqvh1TmdBuZiMfhQMdM83T1O72TuaEUVJXO029Ns+phB6Q7ABVhbAPJ0oR0Ka1GLUvXqvYCzXmWCc2wBMe7MaLW5Y4uNp1LEl4t9rwMgbYaUflpt35VzWSHk/aufl5VZiymSW0k8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500706; c=relaxed/simple;
	bh=gvl753cmd6Kx9Rt2yRzrebyZBHezlGiPW3rpihqJy7I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tw4cCWWwQPEGsKk+IXM7IXVoC3d4LNf0xhzQwDeEPz1q2e34Qv38Ri9tkSX/DHWVcOMp5gKvP9npXGgtKeUi7K5MX7UrHy+XL4kZj217Rx2B3OxniDczEJxuznwRrucMaF9zaHtyFV4hQm1uN4Zq4uYrr4R9R/deKPzhbVHM+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a392e9a8a4so2334065ab.3
        for <linux-security-module@vger.kernel.org>; Wed, 09 Oct 2024 12:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728500704; x=1729105504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u95iXJ49Igp9OpSFm4zZV4sLy87CGukgyLqm7BVOA1s=;
        b=G6DYdrB+YRdxsVVx4M+oqzyqf7NV64iOak4ksOE+eulofvWF49kDPzlmxzLD5isI7H
         AxborMvVejP4zclGJA83N/fss5MxgFLQWbRWp2rc9UsQBjwhuJyjtVGndJY5ML0j0UuM
         QN4cUb14u1GxI4Z9Cr9HLb4Dd9INihkRIuXF6u94Tf8e4cXgjBkyGJ9w4P7fuWYBtz1o
         U4wpAL16BzmW6B6eb23N2t2+g4D1pltnmt2E10cX/z99KAfZFKoxZB0gJ/n1TKCy/Px1
         Ow2Qe8/8ULw/ngr/K9VtM37tMPl5hnhBo0KBx62Va9uPjz9z735BhDMg//zG8Il+37Uf
         Cwtg==
X-Forwarded-Encrypted: i=1; AJvYcCWOb1/EcXQHzwPhV4RkdVrkh3JIFdPsj1UVr+auS35fd56u2hrHk9uhcuA29T4qoxcVJ/h2G0qMrmk4gaLhqZ299i1nsAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6C8peSPk4kOFm/L29LKGvViBJi75FpaOPGO0g1cH9NzEmWrh7
	7vfVGkFTgdrVAJW45zmdgtJKCa0hND1ndJELetNAsS7ZUOwgyYKfU7qHdm0oAqoENTR1gh0z7M1
	o9+SlqJOXZ6+awtNRGPO0eTvzD6sVzD5M6StQksKo19XYuIFhB7c5aQo=
X-Google-Smtp-Source: AGHT+IFCPf66BkaFYbH2fymxFQd+vTQzRMgzpdKXDeJtc+D0Seb1RxcQ7Yx9MemFqc+6V2V4zIZssVNRJ7q4oSGwgJPuJ44k0O9q
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2166:b0:3a2:f7b1:2f70 with SMTP id
 e9e14a558f8ab-3a397d2b458mr35000385ab.21.1728500703772; Wed, 09 Oct 2024
 12:05:03 -0700 (PDT)
Date: Wed, 09 Oct 2024 12:05:03 -0700
In-Reply-To: <1a1d106ea8bba8abc1d3f3cd6fdd71d03edcf764.camel@huaweicloud.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706d3df.050a0220.67064.0051.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
From: syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dmitry.kasatkin@gmail.com, 
	ebpqwerty472123@gmail.com, eric.snowberg@oracle.com, hughd@google.com, 
	jmorris@namei.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, roberto.sassu@huaweicloud.com, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
Tested-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com

Tested on:

commit:         0438fbb6 ima: Mark concurrent accesses to the iint poi..
git tree:       https://github.com/robertosassu/linux.git ima-remove-inode-lock-v1
console output: https://syzkaller.appspot.com/x/log.txt?x=15ead780580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74c522fa0761706b
dashboard link: https://syzkaller.appspot.com/bug?extid=1cd571a672400ef3a930
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
