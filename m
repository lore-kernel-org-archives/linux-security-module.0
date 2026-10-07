Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020A49158D
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791386599; cv=none; b=EcxnsShJnZqndJe73l6fyoQm24N5SJOWKwIclhnr2UPuUqu1tIBBybgGQEl8f7bLjr8iiheKqrjMOubPRbCLT+dx0ttGpjhOXLVMAOo7rjc08JMv2nvCpOMDhJo8r1ov61Anex8ikbQyWyGpQxHE/ycOanhTJGL8tMS4T7abUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791386599; c=relaxed/simple;
	bh=GFKQAZKlyiSGFkpFpEpvWJ0JU6emZfe4uUabjYweHdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=FF+TJZf8XihA1bxyJCAU1j14OJ6CeAHQi6uOaxWYMDsPcQYiH1igXl7h0XX1hBBXLWbTsEBWjOri7Jf7mXT8+eBx3eYLXl4IsnJ9lJWKlNa++eNUMZnjssK5mqJXNyxQ/4p1GqiuA5tnJGMr0K7cvc0cit0dMJEg4nGGe5jUYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 697FMVdv042115;
	Thu, 8 Oct 2026 00:22:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 697FMURA042078
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 8 Oct 2026 00:22:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <100e7540-6918-4b48-99ba-9e96ab7706c4@I-love.SAKURA.ne.jp>
Date: Thu, 8 Oct 2026 00:22:27 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [lsm?] general protection fault in
 smack_inode_permission (4)
To: syzbot <syzbot+fc1d5d9a7ebabbc27458@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, jfs-discussion@lists.sourceforge.net
References: <6ac1be3e.9ad129c8.3858c0.0025.GAE@google.com>
Content-Language: en-US
Cc: casey@schaufler-ca.com, jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        serge@hallyn.com
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <6ac1be3e.9ad129c8.3858c0.0025.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav114.rs.sakura.ne.jp

C repro is at https://syzkaller.appspot.com/ai_job?id=35b0b5a6-7e19-40a7-af3b-871da805fc98

#syz set subsystems: jfs

On 2026/10/04 11:47, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ce1e0223d8ad Merge tag 'devicetree-fixes-for-7.3-2' of git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12555b15580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=718e346eb0b8f38
> dashboard link: https://syzkaller.appspot.com/bug?extid=fc1d5d9a7ebabbc27458
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4167e1ad25c1/disk-ce1e0223.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a0a74c8dec59/vmlinux-ce1e0223.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f6caa72edd70/bzImage-ce1e0223.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fc1d5d9a7ebabbc27458@syzkaller.appspotmail.com
> 
> ERROR: (device loop4): jfs_readdir: JFS:Dtree error: ino = 2, bn=0, index = 3
> ERROR: (device loop4): jfs_readdir: JFS:Dtree error: ino = 2, bn=0, index = 5
> ERROR: (device loop4): jfs_readdir: JFS:Dtree error: ino = 2, bn=0, index = 6
> Oops: general protection fault, probably for non-canonical address 0xdffffc018bd1a30b: 0000 [#1] SMP KASAN PTI
> KASAN: probably user-memory-access in range [0x0000000c5e8d1858-0x0000000c5e8d185f]
> CPU: 1 UID: 0 PID: 5607 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
