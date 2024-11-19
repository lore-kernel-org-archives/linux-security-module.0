Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8561AA1C2
	for <linux-security-module@vger.kernel.org>; Tue, 19 Nov 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732012564; cv=none; b=Tq58x0VZpv5DM8uUgYKG7ZsL8RpaKndEiiWVnaHEE1SOqC1pQDqm6s1sKnozjFXMfHdd+pntJRc8eKPac4h5N5uTdzorQaIolhYTKjBFlBIwlyDmjOJM0En73BpEyyoymyOoWF0Ga2cYP5ig3JeMy+qABJgHz4T/d2iTgAJuRqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732012564; c=relaxed/simple;
	bh=xUwo3wZZYVQWLtQgSzxfVN3DRvFAYHr7FOk4PHNEuEg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BJb5plbhfsC5qMl53QWwMEb3L/3gXXeNOklv/U14DLX+bPZx1xbSFyYqvJSTBNj+Q/6xbl5qZz7k2cRga4k7zTImc+mK2HLjQ34lpsYlvXwsPuLvqD+Wpn6MtKbtEpwvRXZ5vhpeGpQBEJtzP5t9KY71SklvwEL83dgofJDJW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83e5dc9f6a4so493507339f.0
        for <linux-security-module@vger.kernel.org>; Tue, 19 Nov 2024 02:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732012562; x=1732617362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amgwMc6OTFsPhBoe0UDa+e6OjKCPctPlX9BP3lpk4Tw=;
        b=RpVP/3X8B/lr5NV7+n6Gz4nLqiXkUsflPe29IUVMes2lYL+PWYo54u+7Fgr6kR2Wns
         cAwjVVJaYUE714W6Rnj518OD0JRq8j86IcvynxOPwjXz/62M3XTGp9M859j/gdp+CoYm
         JHkuHo9nd6VVNRSvuI5v9L9Zwqce+CwZ3HOJM/8LqAifTwh5x1z+QKhJSrAqaKnfkwJB
         2BHgEHC/cBAqfihJlv7vUeFhMkWHfxALOz40xxeT6VNpuQKpCMX0Lfic89FSpserKAoP
         VbTlIBGbFVP/2Mchx/ONF4Mw/DVuC7IrpunZRftIBHpCFbYqvOpJtWTXkHZD1tgp4tn2
         k+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeOxwu2o/JkStV7fGi4/GiWDfKyDo53JmMeVtzQk/Ar0qQojBIJ0JxWIdK9gZjUw3YGUSn6eUTiJ7qPoC3TVFp8lCP0dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGO65hDd7cLtVN+vzC7/PYX9lmzNrQP92a1n1CRxtx7r9kIJkk
	+1nUDDWys3uYHbc9X7iUmbpMhs/2oZX9wDgt3lhUYJ1VF2WzmZUl29/xP0s0x8aybfTO0O3lfZQ
	YpSWffyF4OnIcxO+Dk9/LMoP7vx7FxHqu0jnNAWEKnGBSBa4JJ8RNs1M=
X-Google-Smtp-Source: AGHT+IH4JLOB68J0WVaAms5rG1fSqmbBp652LVCd0s1VSCK1MCwu0N8T0U23tdmatWrAyYwbPaOyDlt2vvijnxc840hCL2uU9PNO
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a65:b0:3a7:4382:668e with SMTP id
 e9e14a558f8ab-3a77738fb96mr20777805ab.2.1732012562296; Tue, 19 Nov 2024
 02:36:02 -0800 (PST)
Date: Tue, 19 Nov 2024 02:36:02 -0800
In-Reply-To: <673b6aec.050a0220.87769.004a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673c6a12.050a0220.87769.006b.GAE@google.com>
Subject: Re: [syzbot] [keyrings?] [lsm?] KASAN: slab-use-after-free Read in key_put
From: syzbot <syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jarkko.sakkinen@kernel.org, jarkko@kernel.org, 
	jmorris@namei.org, keyrings@vger.kernel.org, lhenriques@suse.de, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, serge@hallyn.com, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9578e327b2b4935a25d49e3891b8fcca9b6c10c6
Author: Luis Henriques <lhenriques@suse.de>
Date:   Tue Jan 30 10:13:44 2024 +0000

    keys: update key quotas in key_put()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10821bf7980000
start commit:   adc218676eef Linux 6.12
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12821bf7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=14821bf7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=55f8591b98dd132
dashboard link: https://syzkaller.appspot.com/bug?extid=6105ffc1ded71d194d6d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dbbb5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c672e8580000

Reported-by: syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com
Fixes: 9578e327b2b4 ("keys: update key quotas in key_put()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
