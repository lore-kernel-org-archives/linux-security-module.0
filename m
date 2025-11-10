Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0644267B15
	for <linux-security-module@vger.kernel.org>; Mon, 10 Nov 2025 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769345; cv=none; b=LmXWae8OmnwCDXKq9Mo4ILU9APdGVL3gA1SIBfR46JUxgpWAkR2aR2XqLAksNyHDzCyLQVysUy45KFUoV7sGHCHBa3QVHO9aB3SS8fOrrjQikG1SzQihgVhX7cHifmuE6k+ThvhsVi8RaHVVH3oBBt++xoBo6+zuWqV2/BsGUCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769345; c=relaxed/simple;
	bh=zFAcacTaxgVY+nkDsQEaiKvwk5rOtVVTi/qxNz978hY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M0tY3FddpZoIeZh9wD9lqC3zKtTqUQsdTDNnoNkF68zkzFH/74rVbe/XPHT6XNgQRMyf3NgrJpSqSebw618mb89WWC9gcJBdBQvh60N9MXg7H5ROTMrj50jiig+GfNmFBSwbx226XbivZfFn9zpNK1YQxWfsrlCEMgZ3u8gxm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-433689014feso18033975ab.1
        for <linux-security-module@vger.kernel.org>; Mon, 10 Nov 2025 02:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769343; x=1763374143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uY+EM8i3DZwvN2wGbaARDs/Dgvk4ylCN2HCgZAGvvk=;
        b=uGMt5JtUYO1bqB+APu8Js/j4Mnj+VQWZMZ2GeJzTPiZbBZ41tyCog2Bt3qZAtKEBwk
         JQ6LcGf/nXSc18xeisCpO7+XuXB/HUwT0WIwiJbILUdyPGtMdclh/kmPPCRgaDn6STEf
         67qML2I9C3BISp0y2KkPbrfGk4spJi3LdiRI5119ofQBTq9NtfytiKV+2gqy0/ZL1DGC
         AM7qLxul0N8EbRP89QRtWn4gbN46ZreEbvjtwmOPiBGvNtnGtiUqGoGEW4Casw9lVe5s
         V2+PP6Xe2u7fNieYtZxGZE1GP4Z4bl0aFtS/vFysRe32krGp/ie6Rte9OoE/iGVQKNNb
         0a/w==
X-Forwarded-Encrypted: i=1; AJvYcCWIVrSD9zQNmOBg8eDqAv7HbdvgZJFwI4/1sCcrEvPuhePpGzdlr/SXUqaPcHCLoUaXItNqJ9WCSjoiZ9iJgvRq+FH+lko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0AcFiCSmqOR8pSCcpy0f+3PIaq4oqfwDpVfi814gfG7b0ZU0X
	65sjoKH2GjpWOpwshwEi9hyiNXQ6hJYfF8OjNLu/d7Z33OiUGYPKZexmiuOrQFv4lCC1fJFRmGx
	DhJrb5Rdn410Tg5klbvFfZSKlSPDnFYYC/igv+yGMwrHEo2nAuNotyv/rv7w=
X-Google-Smtp-Source: AGHT+IEC5+mGY0Xr1vqRvkCTPSHWrdzVoW0gyIb+l1PlDK52bcDj3mJeKthrwCwcyT9+HpfbFYmRyBqlkI40h/19RzmapLzIzguH
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a41:b0:433:7ec4:4b7b with SMTP id
 e9e14a558f8ab-4337ec45086mr42790115ab.22.1762769343095; Mon, 10 Nov 2025
 02:09:03 -0800 (PST)
Date: Mon, 10 Nov 2025 02:09:03 -0800
In-Reply-To: <20251110-hufen-klang-9cf8ec9dda59@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911b9bf.a70a0220.22f260.00de.GAE@google.com>
Subject: Re: [syzbot] [lsm?] WARNING in put_cred_rcu
From: syzbot <syzbot+553c4078ab14e3cf3358@syzkaller.appspotmail.com>
To: brauner@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+553c4078ab14e3cf3358@syzkaller.appspotmail.com
Tested-by: syzbot+553c4078ab14e3cf3358@syzkaller.appspotmail.com

Tested on:

commit:         80156be0 ns: fixes for namespace iteration and active ..
git tree:       https://github.com/brauner/linux.git work.namespace-6.19.fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=17fc5412580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e31f5f45f87b6763
dashboard link: https://syzkaller.appspot.com/bug?extid=553c4078ab14e3cf3358
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
