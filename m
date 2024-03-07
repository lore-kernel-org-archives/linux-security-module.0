Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD476C8D
	for <linux-security-module@vger.kernel.org>; Thu,  7 Mar 2024 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803324; cv=none; b=lWZiUpFDIHokobxasZBNjPEqFE9YgXb6qzEKLSCytVRLeQ3VYgA4CaBXomFk37oSbzqwtPhAF4qCPhdOIszSBdiXXlrZOwYKmPeZMTetHo18AClGTHVJnY4Kvzz8vOgKe5tB3wpvKAqAjAMjDSLbkjw02+/ozauFqVLOSPLkCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803324; c=relaxed/simple;
	bh=k6Z8Dy08v8JjctZT+zEqRAI+iDKakEThNIneji3WUs8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iLmFx0po5Wk788rQfimvDTc8lYii7xjafIq8uXr6VwO2vat3PlyXhYlOcKq2FDkYxrrHaSk53IP6UCbTnYnlE4P/lcc0AocUpj3RLYxLpbCIaK11LnOyF6DKvXlhbljjIcrQzblrseDijjV06i71fjfQYAJK79M/2XM2ETj4dI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c75dee76c0so55396739f.1
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2024 01:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803322; x=1710408122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4cB4mfgxxhOdGVz1qSSrC2aE19EtM0xTHQYqGcCbdk=;
        b=A0UVDCy702ay50tGTHPS+GTAiph4iYOA27Fl2FbSmc4VhtDYWhoZ+FW4xTvg8gvQDK
         fxdjWc3nx1HkVD9w4QKExIt0hj8Zctv/dcEqQ/ED/mQ/ypvRb8GMgIafXwVCRJrGoqLj
         QE2HYJQ7m5FglddXzzrbBewm5f8l8ny7qptCnu8mLRtLcwUCq6ib0tvvNryKm4SM8uwL
         FuknJPt8OuoIZ45U3aeNO9tr5HZF5RbD7i9Wr8Y1WdZB3G/a3gbWyw+1RizsIK+hdsiF
         Ej3eQopE8ovwRsdpXHSHJmmkSAeWiPtXdRWKMVHSb6HFOaDFRi1d+bOqDt5Fxwgr5vqG
         WcVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIe0cXttDhyl2RSuiaK9NsRArU9yFyg1WCOcx/gG0TdG7nQvqdhKWS3uizH+c3mgmiY0DEsUYD/oacEfAO37lr7o3jxTlYESwdTAPs7DrZ+v1C6NUV
X-Gm-Message-State: AOJu0Yxv5MU7bcsU5BrG2gsyt/rOyT/SqEPdWvkFK1Y5NgNVwiIk4QfG
	4++lFflftQtFrBli4NQyFRiI7FZwSL4UTlnme4kEg4uKYIQ2dIjsC1awqOAFUAA+rDIPJhYrizV
	9mg4gHhpm5diF1Ibw8XXRakimTV3GraGUkOBFF8VXCtPbD8M+aKAffvQ=
X-Google-Smtp-Source: AGHT+IEMTxQCdUA6Dv7Lv6y16wV0knL7dKArp17Um7aS/ApI3W+O/xlDfqd9xlZ9X3uv+mg+dW+z3XFCb+N79t1rzwFiFjeKNebx
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b18:b0:476:b3e5:4392 with SMTP id
 fm24-20020a0566382b1800b00476b3e54392mr44985jab.2.1709803321994; Thu, 07 Mar
 2024 01:22:01 -0800 (PST)
Date: Thu, 07 Mar 2024 01:22:01 -0800
In-Reply-To: <0000000000009752a005fdc2d114@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4bb3506130e9bc5@google.com>
Subject: Re: [syzbot] [usb] INFO: rcu detected stall in newfstatat (3)
From: syzbot <syzbot+96127c74434e19e4609d@syzkaller.appspotmail.com>
To: brauner@kernel.org, davem@davemloft.net, edumazet@google.com, 
	gregkh@linuxfoundation.org, jack@suse.cz, jiri@nvidia.com, jmorris@namei.org, 
	kuba@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-usb@vger.kernel.org, mchehab@kernel.org, netdev@vger.kernel.org, 
	oneukum@suse.com, pabeni@redhat.com, paul@paul-moore.com, 
	penguin-kernel@i-love.sakura.ne.jp, sean@mess.org, serge@hallyn.com, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com, 
	takedakn@nttdata.co.jp, tomoyo-dev-en-owner@lists.osdn.me, 
	tomoyo-dev-en@lists.osdn.me, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c2368b19807affd7621f7c4638cd2e17fec13021
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:35 2022 +0000

    net: devlink: introduce "unregistering" mark and use it during devlinks iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14dc6736180000
start commit:   29cd507cbec2 Merge tag 'integrity-v6.8-fix' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16dc6736180000
console output: https://syzkaller.appspot.com/x/log.txt?x=12dc6736180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70429b75d4a1a401
dashboard link: https://syzkaller.appspot.com/bug?extid=96127c74434e19e4609d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11767d61180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f691a6180000

Reported-by: syzbot+96127c74434e19e4609d@syzkaller.appspotmail.com
Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
