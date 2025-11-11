Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D17736A02E
	for <linux-security-module@vger.kernel.org>; Tue, 11 Nov 2025 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877647; cv=none; b=mH+mFybTQG3GMIggut+OWCskGhOx1kuTIR5gwJEbHdFm8M1PECDhgS6dgdCuiZ32/wBn2N/88e34Kf3AI1bCM6M3jvnCz/h81MX9H+g0qM/ZL9hYjuxNjO7l8GBw2rgQLrl07XC6niXx8IIea8SB+KEvp9KM3VL49hwx7dPN6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877647; c=relaxed/simple;
	bh=e1fItR7xlkF6B1r7PiNpZoKCLM2TIxoBsNzdDzi03Ps=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sG9MGiSSMCGpl+fZqius4WhD2YdCJbfFLZerI2D5LyKr6nL1/TuE1ukSRQzJHWiE2C/O2TczZmBTTMtvPwVaAYq2vhJ7AdckQu2/RH4tKV6J3r7ljkNQ0eaPlDt9RYVuo4E/Pvw3tfjKENdnYkQXAlCmxlX53/mAIioctOt9b3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-94895e290f3so317801839f.3
        for <linux-security-module@vger.kernel.org>; Tue, 11 Nov 2025 08:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762877644; x=1763482444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsIzj5zeRN34MODne/Dex4pJnbVaec6z/SJRkF/VqmY=;
        b=WsHHk5FHMNf8skTaz9l2PGk1GDErUT4qOg1r/p/X/jFmjOXCMc0rRQJzesSjLhc0jt
         AgiZrtiOGdZ/hvwPc8BptCwvEQxKMAo+CvNTSPMhxX0zmni07+00zjVyVDFC46gDr/I0
         kRmHtA2r6VW7od0RV2o3KOz8XSNLMCeHEOoySFuMD1QJnR0LmO61qLBkVa1CpYFZqoSC
         IwdrS/z+F1FcQXaUR1sUlkSFW16152F8QGG6pg9PU66VZLg2CFGkiBAuCv4ydJGh1rEy
         mx+l5aTWSLn7zhOcDbKG2hsHb3LQAgY0yi2TAZxCSf2jOZBZJX0OFb4TUNrRHHvXw3Hc
         OPMA==
X-Forwarded-Encrypted: i=1; AJvYcCXI+HGsv7R/aFXBrL1VrzWGBDFd7guV8cJ3xPbYzAy+uCHaezyDGb0WwWMXkFTEVCTXZ+IXH1+JbVo0NdZPS/RPe74Zf3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfqXOWauNJbIpVHhNBb0DGebkO8+NDWW1o0GBlSsPQQq6iYR/J
	+okk4gITEd4YvY27aJsadsgAdDZ7rZq5A+HVcFqEBw5W9iEtjacOERL4OnbRYSlfcWZ1aTUUZeW
	9QrkDog0qhqrm4gApvy+Eq53/qyzs9jAXaO/9KBL1Gy/nROye1bvFNf8yU0g=
X-Google-Smtp-Source: AGHT+IGhd1YIu4TmAb300ER5ywQ/phsKtardGYlr/w81752isCeFiUXjr5Li77UIL+5T2x/Jd6onzK9n8xsWrbfW3lALSN73fnOL
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4914:b0:433:767e:8f47 with SMTP id
 e9e14a558f8ab-433767ec96fmr150345295ab.29.1762877644204; Tue, 11 Nov 2025
 08:14:04 -0800 (PST)
Date: Tue, 11 Nov 2025 08:14:04 -0800
In-Reply-To: <20251111-gaspipeline-getippt-9b19b62f89d2@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691360cc.a70a0220.22f260.013e.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_put
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bpf@vger.kernel.org, brauner@kernel.org, 
	bsegall@google.com, david@redhat.com, dietmar.eggemann@arm.com, jack@suse.cz, 
	jsavitz@redhat.com, juri.lelli@redhat.com, kartikey406@gmail.com, 
	kees@kernel.org, liam.howlett@oracle.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, mjguzik@gmail.com, 
	oleg@redhat.com, paul@paul-moore.com, peterz@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, vincent.guittot@linaro.org, 
	viro@zeniv.linux.org.uk, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
Tested-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com

Tested on:

commit:         d2bab7f2 nsproxy: fix free_nsproxy() and simplify crea..
git tree:       https://github.com/brauner/linux.git namespace-6.19
console output: https://syzkaller.appspot.com/x/log.txt?x=123a8658580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59952e73920025e4
dashboard link: https://syzkaller.appspot.com/bug?extid=0b2e79f91ff6579bfa5b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
